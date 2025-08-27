import os
import re
import networkx as nx
from neo4j import GraphDatabase
from typing import List, Dict, Tuple, Set, Optional
import json
import logging

class Neo4jIngestor:
    """
    A tool for managing and ingesting CQL files into Neo4j in the correct order.
    Handles dependency resolution, schema tracking, and execution.
    """
    
    def __init__(self, uri="bolt://localhost:7687", username="neo4j", password="password"):
        """Initialize with Neo4j connection details and prepare for processing."""
        self.uri = uri
        self.username = username
        self.password = password
        self.driver = None
        self.dependency_graph = nx.DiGraph()
        self.executed_files = set()
        
        # Initialize schema tracking
        self.schema = {
            "nodes": {},       # label -> properties
            "relationships": {},  # type -> properties
            "indexes": {},     # label -> indexed properties
            "constraints": {}  # label -> constrained properties
        }
        
        # Set up logging
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler("neo4j_ingestor.log"),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger("Neo4jIngestor")
    
    def connect(self):
        """Establish connection to the Neo4j database."""
        self.logger.info(f"Connecting to Neo4j at {self.uri}")
        self.driver = GraphDatabase.driver(self.uri, auth=(self.username, self.password))
        return self
    
    def close(self):
        """Close the Neo4j connection."""
        if self.driver:
            self.logger.info("Closing Neo4j connection")
            self.driver.close()
    
    def scan_directory(self, directory: str) -> List[str]:
        """Scan a directory for .cql files and return their paths."""
        self.logger.info(f"Scanning directory: {directory}")
        cql_files = []
        for root, _, files in os.walk(directory):
            for file in files:
                if file.endswith('.cql'):
                    cql_files.append(os.path.join(root, file))
        
        self.logger.info(f"Found {len(cql_files)} CQL files")
        return cql_files
    
    def analyze_file_content(self, filepath: str) -> Dict:
        """
        Analyze the content of a CQL file to extract:
        - Dependencies (what it needs)
        - Provisions (what it creates)
        - Schema modifications
        """
        self.logger.info(f"Analyzing file: {filepath}")
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract creation timestamps from comments if available
        # Format: // Created: YYYY-MM-DD HH:MM:SS
        timestamp_match = re.search(r'// Created: (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})', content)
        timestamp = timestamp_match.group(1) if timestamp_match else None
        
        # Extract node labels created
        created_nodes = set(re.findall(r'CREATE\s+\(.*?:([\w`]+)', content, re.IGNORECASE))
        created_nodes.update(re.findall(r'MERGE\s+\(.*?:([\w`]+)', content, re.IGNORECASE))
        
        # Extract node labels matched/required
        matched_nodes = set(re.findall(r'MATCH\s+\(.*?:([\w`]+)', content, re.IGNORECASE))
        required_nodes = matched_nodes - created_nodes
        
        # Extract relationship types created
        created_rels = set(re.findall(r'\[.*?:([\w`]+)', content, re.IGNORECASE))
        
        # Extract properties and their types (more comprehensive)
        properties = self._extract_properties(content)
        
        # Look for indexes and constraints
        indexes = re.findall(r'CREATE\s+INDEX\s+.*?\(([\w`]+)\.([\w`]+)\)', content, re.IGNORECASE)
        constraints = re.findall(r'CREATE\s+CONSTRAINT\s+.*?\(([\w`]+)\.([\w`]+)\)', content, re.IGNORECASE)
        
        analysis = {
            "filepath": filepath,
            "timestamp": timestamp,
            "created_nodes": created_nodes,
            "required_nodes": required_nodes,
            "created_relationships": created_rels,
            "properties": properties,
            "indexes": indexes,
            "constraints": constraints
        }
        
        self.logger.debug(f"File analysis: {json.dumps(analysis, default=str)}")
        return analysis
    
    def _extract_properties(self, content: str) -> Dict[str, str]:
        """
        Extract property names and infer their types from CQL content.
        More comprehensive than the simple regex approach.
        """
        properties = {}
        
        # Look for property assignments in CREATE, MATCH, SET statements
        # This captures properties in curly braces
        property_blocks = re.findall(r'\{(.*?)\}', content, re.DOTALL)
        
        for block in property_blocks:
            # Split by commas, but be careful with nested structures
            # This is a simplified approach and may need refinement for complex property values
            prop_assignments = re.findall(r'`?([\w]+)`?\s*:\s*([^,]+)', block)
            
            for prop, value in prop_assignments:
                # Clean the value (remove trailing commas, whitespace)
                value = value.strip().rstrip(',')
                
                # Infer type from the value
                if value.startswith('"') or value.startswith("'"):
                    prop_type = "string"
                elif value.lower() in ('true', 'false'):
                    prop_type = "boolean"
                elif re.match(r'^-?\d+\.\d+$', value):
                    prop_type = "float"
                elif re.match(r'^-?\d+$', value):
                    prop_type = "integer"
                elif value.lower() in ('null'):
                    prop_type = "null"
                elif value.startswith('[') and value.endswith(']'):
                    prop_type = "array"
                else:
                    prop_type = "unknown"
                
                # Only update if we don't already have a type for this property
                # or if the current type is more specific
                if prop not in properties or properties[prop] == "unknown":
                    properties[prop] = prop_type
        
        return properties
    
    def build_dependency_graph(self, files: List[str]):
        """
        Build a directed graph representing dependencies between CQL files.
        Files that create nodes required by other files must be executed first.
        """
        self.logger.info("Building dependency graph")
        file_analyses = {}
        
        # First pass: analyze all files
        for file in files:
            analysis = self.analyze_file_content(file)
            file_analyses[file] = analysis
            
            # Add the file as a node in the dependency graph
            self.dependency_graph.add_node(file, timestamp=analysis["timestamp"])
        
        # Second pass: establish dependencies
        for file, analysis in file_analyses.items():
            # If this file requires nodes that are created by another file,
            # add a dependency edge from that file to this one
            for required_node in analysis["required_nodes"]:
                providers = []
                
                for other_file, other_analysis in file_analyses.items():
                    if required_node in other_analysis["created_nodes"] and other_file != file:
                        providers.append((other_file, other_analysis["timestamp"]))
                
                # If multiple files provide the same node, prefer the one with the earliest timestamp
                # If no timestamps available, create dependencies to all providers
                if providers:
                    if all(p[1] is not None for p in providers):
                        # Sort by timestamp and pick the earliest
                        providers.sort(key=lambda p: p[1])
                        self.dependency_graph.add_edge(providers[0][0], file)
                    else:
                        # No reliable timestamps, add dependencies to all providers
                        for provider, _ in providers:
                            self.dependency_graph.add_edge(provider, file)
        
        # Check for cycles in the dependency graph
        if not nx.is_directed_acyclic_graph(self.dependency_graph):
            cycles = list(nx.simple_cycles(self.dependency_graph))
            self.logger.error(f"Circular dependencies detected in CQL files: {cycles}")
            raise ValueError(f"Circular dependencies detected in CQL files: {cycles}")
        
        self.logger.info(f"Dependency graph built with {self.dependency_graph.number_of_nodes()} nodes and {self.dependency_graph.number_of_edges()} edges")
    
    def get_execution_order(self) -> List[str]:
        """
        Determine the order in which CQL files should be executed
        based on their dependencies.
        """
        self.logger.info("Determining execution order")
        try:
            # Topological sort gives an execution order that respects dependencies
            execution_order = list(nx.topological_sort(self.dependency_graph))
            self.logger.info(f"Execution order determined: {len(execution_order)} files")
            return execution_order
        except nx.NetworkXUnfeasible:
            self.logger.error("Could not determine execution order due to circular dependencies")
            raise ValueError("Could not determine execution order due to circular dependencies")
    
    def execute_cql_file(self, filepath: str):
        """
        Execute a CQL file against the Neo4j database and update the schema.
        """
        if filepath in self.executed_files:
            self.logger.info(f"Skipping already executed file: {filepath}")
            return
        
        self.logger.info(f"Executing: {filepath}")
        with open(filepath, 'r', encoding='utf-8') as f:
            cql = f.read()
        
        # Execute the CQL against the Neo4j database
        with self.driver.session() as session:
            try:
                # Split the CQL by semicolons to execute multiple statements
                # But be careful with semicolons in strings
                statements = self._split_cql_statements(cql)
                
                for statement in statements:
                    if statement.strip():
                        self.logger.debug(f"Executing statement: {statement[:100]}...")
                        result = session.run(statement)
                        summary = result.consume()
                
                self.logger.info(f"Successfully executed: {filepath}")
                
                # Mark as executed
                self.executed_files.add(filepath)
                
                # Update our schema understanding based on the analysis
                analysis = self.analyze_file_content(filepath)
                self._update_schema(analysis)
                
            except Exception as e:
                self.logger.error(f"Error executing {filepath}: {e}")
                raise
    
    def _split_cql_statements(self, cql: str) -> List[str]:
        """
        Split a CQL script into individual statements, handling semicolons in strings.
        """
        statements = []
        current_statement = ""
        in_string = False
        string_char = None
        escaped = False
        
        for char in cql:
            if escaped:
                # Previous character was a backslash, so this character is escaped
                current_statement += char
                escaped = False
            elif char == '\\':
                # Backslash - next character will be escaped
                current_statement += char
                escaped = True
            elif in_string:
                # We're inside a string
                current_statement += char
                if char == string_char and not escaped:
                    # End of string
                    in_string = False
                    string_char = None
            elif char in ('"', "'"):
                # Start of a string
                current_statement += char
                in_string = True
                string_char = char
            elif char == ';' and current_statement.strip():
                # End of statement
                statements.append(current_statement.strip())
                current_statement = ""
            else:
                # Regular character
                current_statement += char
        
        # Add the last statement if it's not empty
        if current_statement.strip():
            statements.append(current_statement.strip())
        
        return statements
    
    def _update_schema(self, analysis: Dict):
        """
        Update the internal schema representation based on file analysis.
        """
        # Update node labels and their properties
        for node_label in analysis["created_nodes"]:
            if node_label not in self.schema["nodes"]:
                self.schema["nodes"][node_label] = {}
            
            # Update properties for this node label
            for prop, prop_type in analysis["properties"].items():
                self.schema["nodes"][node_label][prop] = prop_type
        
        # Update relationship types
        for rel_type in analysis["created_relationships"]:
            if rel_type not in self.schema["relationships"]:
                self.schema["relationships"][rel_type] = {}
            
            # Relationships can also have properties
            for prop, prop_type in analysis["properties"].items():
                self.schema["relationships"][rel_type][prop] = prop_type
        
        # Update indexes
        for label, prop in analysis["indexes"]:
            if label not in self.schema["indexes"]:
                self.schema["indexes"][label] = []
            if prop not in self.schema["indexes"][label]:
                self.schema["indexes"][label].append(prop)
        
        # Update constraints
        for label, prop in analysis["constraints"]:
            if label not in self.schema["constraints"]:
                self.schema["constraints"][label] = []
            if prop not in self.schema["constraints"][label]:
                self.schema["constraints"][label].append(prop)
    
    def generate_schema_summary(self, format="md") -> str:
        """
        Generate a summary of the current schema in the specified format.
        """
        self.logger.info(f"Generating schema summary in {format} format")
        
        if format == "md":
            summary = "# Neo4j Schema Summary\n\n"
            
            # Node labels and properties
            summary += "## Node Labels\n\n"
            for label, props in self.schema["nodes"].items():
                summary += f"### :{label}\n\n"
                if props:
                    summary += "Properties:\n\n"
                    for prop, prop_type in props.items():
                        summary += f"- `{prop}`: {prop_type}\n"
                else:
                    summary += "No properties defined.\n"
                
                # Add indexes for this label
                if label in self.schema["indexes"]:
                    summary += "\nIndexes:\n\n"
                    for prop in self.schema["indexes"][label]:
                        summary += f"- `{prop}`\n"
                
                # Add constraints for this label
                if label in self.schema["constraints"]:
                    summary += "\nConstraints:\n\n"
                    for prop in self.schema["constraints"][label]:
                        summary += f"- `{prop}` (unique)\n"
                
                summary += "\n"
            
            # Relationship types
            summary += "## Relationship Types\n\n"
            for rel_type, props in self.schema["relationships"].items():
                summary += f"### :{rel_type}\n\n"
                if props:
                    summary += "Properties:\n\n"
                    for prop, prop_type in props.items():
                        summary += f"- `{prop}`: {prop_type}\n"
                else:
                    summary += "No properties defined.\n"
                
                summary += "\n"
            
            return summary
        elif format == "compact":
            return self.generate_compact_schema()
        elif format == "json":
            return json.dumps(self.schema, indent=2)
        else:
            # Could add other formats like YAML, etc.
            self.logger.error(f"Unsupported format: {format}")
            raise ValueError(f"Unsupported format: {format}")
    
    def execute_all(self, directory: str):
        """
        Process all .cql files in the given directory in the correct order.
        """
        self.logger.info(f"Processing all CQL files in {directory}")
        files = self.scan_directory(directory)
        self.build_dependency_graph(files)
        execution_order = self.get_execution_order()
        
        for filepath in execution_order:
            self.execute_cql_file(filepath)
        
        self.logger.info("All files executed successfully")
        schema_summary = self.generate_schema_summary()
        self.logger.info(f"Schema summary:\n{schema_summary}")
        
        return schema_summary
    
    def export_schema_fragments(self, directory: str, max_size: int = 5000) -> List[str]:
        """
        Export the schema in fragments small enough to fit within message limits.
        Returns a list of files created.
        """
        self.logger.info(f"Exporting schema fragments to {directory}")
        os.makedirs(directory, exist_ok=True)
        
        # Generate the full schema
        full_schema = self.generate_schema_summary()
        
        # Split into chunks
        chunks = []
        current_chunk = ""
        
        for line in full_schema.split("\n"):
            # If adding this line would exceed max_size, start a new chunk
            if len(current_chunk) + len(line) + 1 > max_size and current_chunk:
                chunks.append(current_chunk)
                current_chunk = line
            else:
                if current_chunk:
                    current_chunk += "\n" + line
                else:
                    current_chunk = line
        
        # Add the last chunk if it's not empty
        if current_chunk:
            chunks.append(current_chunk)
        
        # Write chunks to files
        files_created = []
        for i, chunk in enumerate(chunks):
            filename = f"schema_fragment_{i+1}.md"
            filepath = os.path.join(directory, filename)
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(chunk)
            files_created.append(filepath)
        
        self.logger.info(f"Created {len(files_created)} schema fragment files")
        return files_created
    
    def generate_compact_schema(self, max_length: int = 2000) -> str:
        """
        Generate a compressed version of the schema that fits within message limits.
        Uses a more compact notation.
        """
        self.logger.info("Generating compact schema representation")
        
        # Create a compact representation
        compact = []
        
        # Add nodes
        for label, props in self.schema["nodes"].items():
            node_str = f"(:{label} "
            
            # Add props with types
            if props:
                props_list = [f"{p}:{t}" for p, t in props.items()]
                node_str += "{" + ", ".join(props_list) + "}"
            
            # Add indexes and constraints
            indexes = self.schema["indexes"].get(label, [])
            constraints = self.schema["constraints"].get(label, [])
            
            if indexes or constraints:
                node_str += " ["
                if indexes:
                    node_str += "IDX:" + ",".join(indexes)
                if constraints:
                    if indexes:
                        node_str += "; "
                    node_str += "CONST:" + ",".join(constraints)
                node_str += "]"
            
            node_str += ")"
            compact.append(node_str)
        
        # Add relationships
        for rel_type, props in self.schema["relationships"].items():
            rel_str = f"-[:{rel_type}"
            
            # Add props with types
            if props:
                props_list = [f"{p}:{t}" for p, t in props.items()]
                rel_str += " {" + ", ".join(props_list) + "}"
            
            rel_str += "]->"
            compact.append(rel_str)
        
        result = "\n".join(compact)
        
        # If still too long, further reduce by omitting property types
        if len(result) > max_length:
            self.logger.warning(f"Compact schema too long ({len(result)} chars), reducing further")
            compact = []
            
            # Add nodes with just property names
            for label, props in self.schema["nodes"].items():
                node_str = f"(:{label}"
                
                if props:
                    node_str += " {" + ", ".join(props.keys()) + "}"
                
                # Add indexes and constraints with minimal notation
                indexes = self.schema["indexes"].get(label, [])
                constraints = self.schema["constraints"].get(label, [])
                
                if indexes or constraints:
                    node_str += " ["
                    if indexes:
                        node_str += "i:" + ",".join(indexes)
                    if constraints:
                        if indexes:
                            node_str += ";"
                        node_str += "c:" + ",".join(constraints)
                    node_str += "]"
                
                node_str += ")"
                compact.append(node_str)
            
            # Add relationships with just property names
            for rel_type, props in self.schema["relationships"].items():
                rel_str = f"-[:{rel_type}"
                
                if props:
                    rel_str += " {" + ", ".join(props.keys()) + "}"
                
                rel_str += "]->"
                compact.append(rel_str)
            
            result = "\n".join(compact)
        
        self.logger.info(f"Compact schema generated ({len(result)} chars)")
        return result
    
    def generate_schema_diff(self, old_schema: Dict, formatted: bool = True) -> str:
        """
        Generate a diff between the current schema and a previous version.
        Returns a string representation of the changes.
        """
        self.logger.info("Generating schema diff")
        
        # Initialize diff structure
        diff = {
            "nodes": {
                "added": {},
                "removed": {},
                "modified": {}
            },
            "relationships": {
                "added": {},
                "removed": {},
                "modified": {}
            },
            "indexes": {
                "added": {},
                "removed": {}
            },
            "constraints": {
                "added": {},
                "removed": {}
            }
        }
        
        # Check nodes
        current_nodes = set(self.schema["nodes"].keys())
        old_nodes = set(old_schema.get("nodes", {}).keys())
        
        # Added and removed nodes
        for node in current_nodes - old_nodes:
            diff["nodes"]["added"][node] = self.schema["nodes"][node]
        
        for node in old_nodes - current_nodes:
            diff["nodes"]["removed"][node] = old_schema["nodes"][node]
        
        # Modified nodes (property changes)
        for node in current_nodes & old_nodes:
            current_props = self.schema["nodes"][node]
            old_props = old_schema["nodes"][node]
            
            prop_changes = {}
            
            # Added properties
            for prop, type_val in current_props.items():
                if prop not in old_props:
                    if "added" not in prop_changes:
                        prop_changes["added"] = {}
                    prop_changes["added"][prop] = type_val
            
            # Removed properties
            for prop, type_val in old_props.items():
                if prop not in current_props:
                    if "removed" not in prop_changes:
                        prop_changes["removed"] = {}
                    prop_changes["removed"][prop] = type_val
            
            # Changed property types
            for prop, type_val in current_props.items():
                if prop in old_props and old_props[prop] != type_val:
                    if "type_changed" not in prop_changes:
                        prop_changes["type_changed"] = {}
                    prop_changes["type_changed"][prop] = {
                        "old": old_props[prop],
                        "new": type_val
                    }
            
            if prop_changes:
                diff["nodes"]["modified"][node] = prop_changes
        
        # Similar logic for relationships, indexes, and constraints...
        # (Code omitted for brevity - would follow same pattern as nodes)
        
        # Format the diff for readability if requested
        if formatted:
            result = "# Schema Changes\n\n"
            
            # Nodes
            if diff["nodes"]["added"] or diff["nodes"]["removed"] or diff["nodes"]["modified"]:
                result += "## Node Changes\n\n"
                
                if diff["nodes"]["added"]:
                    result += "### Added Nodes\n\n"
                    for node, props in diff["nodes"]["added"].items():
                        result += f"- :{node}\n"
                        if props:
                            result += "  Properties:\n"
                            for prop, type_val in props.items():
                                result += f"  - `{prop}`: {type_val}\n"
                    result += "\n"
                
                if diff["nodes"]["removed"]:
                    result += "### Removed Nodes\n\n"
                    for node, props in diff["nodes"]["removed"].items():
                        result += f"- :{node}\n"
                    result += "\n"
                
                if diff["nodes"]["modified"]:
                    result += "### Modified Nodes\n\n"
                    for node, changes in diff["nodes"]["modified"].items():
                        result += f"- :{node}\n"
                        
                        for change_type, props in changes.items():
                            if change_type == "added":
                                result += "  Added properties:\n"
                                for prop, type_val in props.items():
                                    result += f"  - `{prop}`: {type_val}\n"
                            
                            elif change_type == "removed":
                                result += "  Removed properties:\n"
                                for prop, type_val in props.items():
                                    result += f"  - `{prop}`\n"
                            
                            elif change_type == "type_changed":
                                result += "  Changed property types:\n"
                                for prop, type_info in props.items():
                                    result += f"  - `{prop}`: {type_info['old']} → {type_info['new']}\n"
                    result += "\n"
            
            # Additional sections for relationships, indexes, and constraints would follow
            
            return result
        else:
            # Return the raw diff structure as JSON
            return json.dumps(diff, indent=2)

    def export_cypher_schema(self, filepath: str):
        """
        Export the current schema as a CQL script that could recreate it.
        """
        self.logger.info(f"Exporting schema as Cypher to {filepath}")
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write("// Schema generated by Neo4jIngestor\n")
            f.write(f"// Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
            
            # Create node constraints and indexes first
            for label, constrained_props in self.schema["constraints"].items():
                for prop in constrained_props:
                    f.write(f"CREATE CONSTRAINT ON (n:{label}) ASSERT n.{prop} IS UNIQUE;\n")
            
            f.write("\n")
            
            for label, indexed_props in self.schema["indexes"].items():
                for prop in indexed_props:
                    # Skip if this property already has a constraint
                    if label in self.schema["constraints"] and prop in self.schema["constraints"][label]:
                        continue
                    f.write(f"CREATE INDEX ON :{label}({prop});\n")
            
            f.write("\n// Schema definition complete\n")
        
        self.logger.info(f"Schema exported to {filepath}")

# Command-line interface
if __name__ == "__main__":
    import argparse
    from datetime import datetime
    
    parser = argparse.ArgumentParser(description="Neo4j CQL File Ingestor")
    parser.add_argument("--uri", default="bolt://localhost:7687", help="Neo4j URI")
    parser.add_argument("--username", default="neo4j", help="Neo4j username")
    parser.add_argument("--password", default="password", help="Neo4j password")
    parser.add_argument("--directory", required=True, help="Directory containing CQL files")
    parser.add_argument("--export-schema", help="Export schema to specified directory")
    parser.add_argument("--compact", action="store_true", help="Generate compact schema representation")
    parser.add_argument("--dry-run", action="store_true", help="Analyze files but don't execute them")
    parser.add_argument("--verbose", action="store_true", help="Enable verbose logging")
    
    args = parser.parse_args()
    
    # Configure logging level
    if args.verbose:
        logging.getLogger("Neo4jIngestor").setLevel(logging.DEBUG)
    
    ingestor = Neo4jIngestor(
        uri=args.uri,
        username=args.username,
        password=args.password
    )
    
    try:
        ingestor.connect()
        
        if args.dry_run:
            print("Performing dry run (analysis only)")
            files = ingestor.scan_directory(args.directory)
            ingestor.build_dependency_graph(files)
            execution_order = ingestor.get_execution_order()
            
            print("\nExecution order:")
            for i, filepath in enumerate(execution_order):
                print(f"{i+1}. {filepath}")
        else:
            ingestor.execute_all(args.directory)
        
        if args.export_schema:
            os.makedirs(args.export_schema, exist_ok=True)
            
            # Export full schema
            with open(os.path.join(args.export_schema, "schema_full.md"), "w", encoding="utf-8") as f:
                f.write(ingestor.generate_schema_summary())
            
            # Export as Cypher
            ingestor.export_cypher_schema(os.path.join(args.export_schema, "schema.cql"))
            
            # Export fragments if requested
            ingestor.export_schema_fragments(args.export_schema)
        
        if args.compact:
            compact_schema = ingestor.generate_compact_schema()
            print("\nCompact schema:")
            print(compact_schema)
    
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
    
    finally:
        ingestor.close()