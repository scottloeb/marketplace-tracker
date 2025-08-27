"""
Database Manager Utility for Beacon

Handles Neo4j database connections and module loading.
"""

import os
import sys
import importlib.util
import json
from datetime import datetime
from typing import Dict, List, Optional, Any
from neo4j import GraphDatabase

class DatabaseManager:
    """Manages database connections and generated modules."""
    
    def __init__(self, connections_file: str = "utils/connections.json"):
        """Initialize the database manager."""
        self.connections_file = connections_file
        self.connections = self._load_connections()
        self.current_connection = None
        self.current_module = None
        
        # Load saved connections if available
        self.load_connections()
    
    def _load_connections(self) -> Dict:
        """Load connection configurations from file"""
        if os.path.exists(self.connections_file):
            try:
                with open(self.connections_file, 'r') as f:
                    return json.load(f)
            except Exception as e:
                print(f"Error loading connections: {e}")
                return {}
        return {}
    
    def _save_connections(self) -> None:
        """Save connection configurations to file"""
        try:
            os.makedirs(os.path.dirname(self.connections_file), exist_ok=True)
            with open(self.connections_file, 'w') as f:
                json.dump(self.connections, f, indent=2)
        except Exception as e:
            print(f"Error saving connections: {e}")
    
    def load_connections(self):
        """Load saved database connections."""
        try:
            if os.path.exists(self.connections_file):
                with open(self.connections_file, 'r') as f:
                    self.connections = json.load(f)
                print(f"Loaded {len(self.connections)} saved connections")
            else:
                print("No saved connections found")
        except Exception as e:
            print(f"Error loading connections: {e}")
    
    def save_connections(self):
        """Save database connections for future use."""
        try:
            with open(self.connections_file, 'w') as f:
                # Don't save passwords in plaintext for security
                safe_connections = {}
                for name, conn in self.connections.items():
                    safe_conn = conn.copy()
                    if 'password' in safe_conn:
                        safe_conn['password'] = '********'  # Mask password
                    safe_connections[name] = safe_conn
                
                json.dump(safe_connections, f, indent=4)
            print("Connections saved successfully")
        except Exception as e:
            print(f"Error saving connections: {e}")
    
    def connect(self, uri, username, password, name=None, module_generator=None):
        """
        Connect to a Neo4j database and generate a module.
        
        Parameters:
        -----------
        uri : str
            The URI for the Neo4j database
        username : str
            Username for authentication
        password : str
            Password for authentication
        name : str, optional
            Name for this connection
        module_generator : function, optional
            The generate_module function from the module generator
            
        Returns:
        --------
        dict
            Result with success status and message
        """
        try:
            if module_generator is None:
                return {
                    'success': False,
                    'message': 'Module Generator not available'
                }
            
            # Use a default name if none provided
            if name is None:
                name = f"connection_{len(self.connections) + 1}"
            
            # Create the module
            module_path = module_generator(
                uri=uri,
                username=username,
                password=password,
                graph=f"beacon_{name.replace(' ', '_').lower()}"
            )
            
            # Store connection info
            self.connections[name] = {
                'uri': uri,
                'username': username,
                'password': password,  # In a production app, encrypt this!
                'module_path': module_path,
                'created': os.path.getmtime(module_path) if os.path.exists(module_path) else None
            }
            
            # Save connections
            self._save_connections()
            
            # Set as current connection
            self.current_connection = name
            
            return {
                'success': True,
                'message': f'Connected to database as "{name}"',
                'module_path': module_path
            }
        except Exception as e:
            return {
                'success': False,
                'message': f'Connection failed: {str(e)}'
            }
    
    def load_module(self, connection_name=None):
        """
        Load a generated module for a connection.
        
        Parameters:
        -----------
        connection_name : str, optional
            Name of the connection to load. If None, uses current connection.
            
        Returns:
        --------
        module or None
            The loaded module if successful, None otherwise
        """
        if connection_name is None:
            connection_name = self.current_connection
        
        if connection_name is None or connection_name not in self.connections:
            print(f"Connection {connection_name} not found")
            return None
        
        conn = self.connections[connection_name]
        if 'module_path' not in conn or not os.path.exists(conn['module_path']):
            print(f"Module not found for connection {connection_name}")
            return None
        
        try:
            # Import the module dynamically
            module_name = os.path.basename(conn['module_path'])[:-3]  # Remove .py extension
            spec = importlib.util.spec_from_file_location(module_name, conn['module_path'])
            module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(module)
            
            # Store as current module
            self.current_module = module
            return module
        except Exception as e:
            print(f"Error loading module: {e}")
            return None
    
    def get_database_info(self, connection_name=None):
        """Get information about the database schema."""
        module = self.load_module(connection_name)
        if not module:
            return None
        
        try:
            # Extract information from the module's metadata
            info = {
                'node_labels': module.METADATA.get('node_labels', []),
                'relationship_types': module.METADATA.get('edge_types', []),
                'node_count': {},
                'relationship_count': {}
            }
            
            # Get node counts
            nodes = module.nodes
            for label in info['node_labels']:
                try:
                    # This will depend on how the generated module works
                    method_name = label.lower().replace(':', '_').replace('-', '_')
                    if hasattr(nodes, method_name):
                        method = getattr(nodes, method_name)
                        count = len(method())
                        info['node_count'][label] = count
                except Exception as e:
                    print(f"Error getting count for {label}: {e}")
                    info['node_count'][label] = -1
            
            return info
        except Exception as e:
            print(f"Error getting database info: {e}")
            return None

    def test_connection(self, uri: str, username: str, password: str, database: str = "neo4j") -> bool:
        """Test a database connection"""
        try:
            driver = GraphDatabase.driver(uri, auth=(username, password))
            with driver.session(database=database) as session:
                result = session.run("RETURN 1 as test")
                result.single()
            driver.close()
            return True
        except Exception as e:
            print(f"Connection test failed: {e}")
            return False
    
    def add_connection(self, name: str, uri: str, username: str, password: str, database: str = "neo4j") -> bool:
        """Add a new database connection"""
        try:
            self.connections[name] = {
                "uri": uri,
                "username": username,
                "password": password,
                "database": database,
                "created": datetime.now().isoformat(),
                "module_path": f"beacon_connection_{name.replace(' ', '_').lower()}.py"
            }
            self._save_connections()
            return True
        except Exception as e:
            print(f"Error adding connection: {e}")
            return False
    
    def get_connection(self, name: str) -> Optional[Dict]:
        """Get connection details by name"""
        return self.connections.get(name)
    
    def list_connections(self) -> List[str]:
        """List all available connections"""
        return list(self.connections.keys())
    
    def remove_connection(self, name: str) -> bool:
        """Remove a connection"""
        try:
            if name in self.connections:
                del self.connections[name]
                self._save_connections()
                return True
            return False
        except Exception as e:
            print(f"Error removing connection: {e}")
            return False
    
    def generate_middleware(self, uri: str, username: str, password: str, database: str, name: str) -> Optional[str]:
        """Generate middleware module for database connection"""
        try:
            # Create middleware content
            middleware_content = self._create_middleware_content(uri, username, password, database, name)
            
            # Write to file
            module_path = f"beacon_connection_{name.replace(' ', '_').lower()}.py"
            with open(module_path, 'w') as f:
                f.write(middleware_content)
            
            # Log generation
            self._log_generation(module_path)
            
            return module_path
        except Exception as e:
            print(f"Error generating middleware: {e}")
            return None
    
    def _create_middleware_content(self, uri: str, username: str, password: str, database: str, name: str) -> str:
        """Create middleware module content"""
        return f'''# Beacon Connection Module for {name} Database
# Generated by Beacon Graph Explorer
# Part of the H.A.R.B.O.R. (Human Analytics, Research, Business Operations, Research) ecosystem

from neo4j import GraphDatabase
import json
from datetime import datetime

class BeaconConnection{name.replace(' ', '').replace('-', '').replace('_', '')}:
    """Connection wrapper for {name} database"""
    
    def __init__(self, uri="{uri}", username="{username}", password="{password}"):
        self.uri = uri
        self.username = username
        self.password = password
        self.driver = None
        
    def connect(self):
        """Establish connection to the database"""
        try:
            self.driver = GraphDatabase.driver(self.uri, auth=(username, password))
            # Test connection
            with self.driver.session() as session:
                session.run("RETURN 1")
            return True
        except Exception as e:
            print(f"Connection failed: {{e}}")
            return False
    
    def close(self):
        """Close the database connection"""
        if self.driver:
            self.driver.close()
    
    def get_database_info(self):
        """Get basic database information"""
        try:
            with self.driver.session() as session:
                # Get node count
                node_result = session.run("MATCH (n) RETURN count(n) as node_count")
                node_count = node_result.single()["node_count"]
                
                # Get relationship count
                rel_result = session.run("MATCH ()-[r]->() RETURN count(r) as rel_count")
                rel_count = rel_result.single()["rel_count"]
                
                # Get node labels
                label_result = session.run("CALL db.labels() YIELD label RETURN collect(label) as labels")
                labels = label_result.single()["labels"]
                
                # Get relationship types
                type_result = session.run("CALL db.relationshipTypes() YIELD relationshipType RETURN collect(relationshipType) as types")
                types = type_result.single()["types"]
                
                return {{
                    "node_count": node_count,
                    "relationship_count": rel_count,
                    "node_labels": labels,
                    "relationship_types": types,
                    "database_name": "{name}",
                    "connection_time": datetime.now().isoformat()
                }}
        except Exception as e:
            return {{"error": str(e)}}
    
    def execute_query(self, query, parameters=None):
        """Execute a Cypher query"""
        try:
            with self.driver.session() as session:
                result = session.run(query, parameters or {{}})
                return [dict(record) for record in result]
        except Exception as e:
            return {{"error": str(e)}}
    
    def get_graph_data(self, limit=100, node_labels=None):
        """Get graph data for visualization"""
        try:
            with self.driver.session() as session:
                # Build query based on parameters
                where_clause = ""
                if node_labels:
                    where_clause = "WHERE " + " OR ".join([f"n:{{label}}" for label in node_labels])
                
                query = f"""
                MATCH (n)
                {{where_clause}}
                WITH n LIMIT {{limit}}
                MATCH (n)-[r]-(m)
                RETURN n, r, m
                LIMIT {{limit * 3}}
                """
                
                result = session.run(query)
                
                # Process results
                nodes = {{}}
                links = []
                
                for record in result:
                    # Process source node
                    source_node = record["n"]
                    source_id = str(source_node.id)
                    
                    if source_id not in nodes:
                        nodes[source_id] = {{
                            "id": source_id,
                            "labels": list(source_node.labels),
                            "properties": dict(source_node)
                        }}
                    
                    # Process target node
                    target_node = record["m"]
                    target_id = str(target_node.id)
                    
                    if target_id not in nodes:
                        nodes[target_id] = {{
                            "id": target_id,
                            "labels": list(target_node.labels),
                            "properties": dict(target_node)
                        }}
                    
                    # Process relationship
                    rel = record["r"]
                    links.append({{
                        "source": source_id,
                        "target": target_id,
                        "type": rel.type,
                        "properties": dict(rel)
                    }})
                
                return {{
                    "nodes": list(nodes.values()),
                    "links": links
                }}
                
        except Exception as e:
            return {{"error": str(e)}}

    def _log_generation(self, module_path: str) -> None:
        """Log middleware generation"""
        log_entry = f"{datetime.now().isoformat()}: Generating module: {module_path}\n"
        try:
            with open("modulegenerator.out", "a") as f:
                f.write(log_entry)
        except Exception as e:
            print(f"Error logging generation: {e}")
    
    def get_database_stats(self, middleware) -> Dict[str, Any]:
        """Get database statistics using middleware"""
        try:
            return middleware.get_database_info()
        except Exception as e:
            return {"error": str(e)}

# Create a singleton instance
db_manager = DatabaseManager()
