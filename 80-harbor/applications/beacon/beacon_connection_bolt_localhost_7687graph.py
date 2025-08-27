# Date generated: 2025-03-10T14:28:54.439000000+00:00

# Generated with modulegenerator version (0, 0, 0)
# Generated with neo4j driver version 5.28.1
import neo4j
import neo4j
from neo4j import GraphDatabase
import json
from datetime import datetime

class Queries:
    def server_timestamp():
        text = 'RETURN datetime() AS timestamp;'
        params = None
        return text, params
    
    def node(label, **props):
        """
        Node interface cypher -- given a neo4j label (can be a multi-
        label separated by colons, e.g., Label1:Label2) and a dictionary
        of propNames and propValues, construct a parameterized Cypher query 
        to return a list of nodes with that label matching those properties.
        As of this version (3/3/25), there is no type checking -- all
        properties are converted to Strings for ease of development.
        We will use the metadata object to validate search terms.
        """
        # Unpack individual props
        print(props)
        
        text = f"""MATCH 
            (n:{label} 
            {'' if props is None else '{'} 
            {','.join(f"{prop}: ${prop}" for prop in props)}
            {'}' if props is None else '}'}) 
            RETURN n;"""

        return text, props
    
    def node_labels():
        text = 'CALL db.labels() YIELD label RETURN collect(label) AS labels;'
        params = None
        return text, params
    
    def node_type_properties():
        text = f"""
        CALL db.schema.nodeTypeProperties() YIELD nodeLabels, propertyName, propertyTypes
        UNWIND nodeLabels AS nodeLabel
        UNWIND propertyTypes AS propertyType
        RETURN
            DISTINCT nodeLabel,
            propertyName,
            collect(propertyType) AS propertyTypes;
        """
        params = None 
        return text, params
    
    def rel_type_properties():
        text = f"""
        CALL db.schema.relTypeProperties() YIELD relType, propertyName, propertyTypes
        UNWIND propertyTypes AS propertyType
        RETURN
            DISTINCT relType,
            propertyName,
            collect(propertyType) AS propertyTypes;"""
        params = None
        return text, params
    
    def node_properties(label, limit=None):
        text = f"""
            MATCH 
                (n:{label}) 
            WITH n 
            {f"LIMIT {limit}" if limit is not None else ""}
            UNWIND apoc.meta.cypher.types(n) AS props
            RETURN collect(DISTINCT props) AS props;
        """
        params = None
        return text, params
    
    def edge_types():
        text = 'CALL db.relationshipTypes() YIELD relationshipType RETURN collect(relationshipType) AS relationshipTypes;'
        params = None
        return text, params
    
    def edge_properties(type, limit=1000):
        text = f"""
            MATCH (a)-[e:{type}]->(b)
            WITH a, e, b
            {f"LIMIT {limit}" if limit is not None else ""}
            UNWIND apoc.meta.cypher.types(e) AS props
            RETURN collect(DISTINCT props) as props;
        """
        params = None 
        return text, params
    
    def edge_endpoints(type, limit=1000):
        text = f"""
            MATCH (a)-[e:{type}]->(b)
            WITH a, e, b
            {f"LIMIT {limit}" if limit is not None else ""}
            RETURN DISTINCT labels(a) AS startLabels, labels(b) AS endLabels;
        """
        params = None 
        return text, params

class BeaconConnectionBoltLocalhost7687graph:
    """Connection wrapper for bolt://localhost:7687 database"""
    
    def __init__(self, uri="bolt://localhost:7687", username="neo4j", password="beacon"):
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
            print(f"Connection failed: {e}")
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
                
                return {
                    "node_count": node_count,
                    "relationship_count": rel_count,
                    "node_labels": labels,
                    "relationship_types": types,
                    "database_name": "bolt://localhost:7687",
                    "connection_time": datetime.now().isoformat()
                }
        except Exception as e:
            return {"error": str(e)}
    
    def execute_query(self, query, parameters=None):
        """Execute a Cypher query"""
        try:
            with self.driver.session() as session:
                result = session.run(query, parameters or {})
                return [dict(record) for record in result]
        except Exception as e:
            return {"error": str(e)}
    
    def get_graph_data(self, limit=100, node_labels=None):
        """Get graph data for visualization"""
        try:
            with self.driver.session() as session:
                # Build query based on parameters
                where_clause = ""
                if node_labels:
                    where_clause = "WHERE " + " OR ".join([f"n:{label}" for label in node_labels])
                
                query = f"""
                MATCH (n)
                {where_clause}
                WITH n LIMIT {limit}
                MATCH (n)-[r]-(m)
                RETURN n, r, m
                LIMIT {limit * 3}
                """
                
                result = session.run(query)
                
                # Process results
                nodes = {}
                links = []
                
                for record in result:
                    # Process source node
                    source_node = record["n"]
                    source_id = str(source_node.id)
                    
                    if source_id not in nodes:
                        nodes[source_id] = {
                            "id": source_id,
                            "labels": list(source_node.labels),
                            "properties": dict(source_node)
                        }
                    
                    # Process target node
                    target_node = record["m"]
                    target_id = str(target_node.id)
                    
                    if target_id not in nodes:
                        nodes[target_id] = {
                            "id": target_id,
                            "labels": list(target_node.labels),
                            "properties": dict(target_node)
                        }
                    
                    # Process relationship
                    rel = record["r"]
                    links.append({
                        "source": source_id,
                        "target": target_id,
                        "type": rel.type,
                        "properties": dict(rel)
                    })
                
                return {
                    "nodes": list(nodes.values()),
                    "links": links
                }
                
        except Exception as e:
            return {"error": str(e)}

# Example usage
if __name__ == "__main__":
    # Create connection
    conn = BeaconConnectionBoltLocalhost7687graph()
    
    # Connect to database
    if conn.connect():
        print("Connected to bolt://localhost:7687 database")
        
        # Get database info
        info = conn.get_database_info()
        print(f"Database info: {json.dumps(info, indent=2)}")
        
        # Close connection
        conn.close()
    else:
        print("Failed to connect to database")

def _authenticated_driver(uri=profile['uri'], username=profile['username'], password=profile['password']):
    """
    Internal method to set up an authenticated driver.

    Parameters
    ----------
    uri: str
        neo4j connection string
    usernname: str
        username for the neo4j account
    password: str
        password for the neo4j account
    
    Returns
    -------
    neo4j.GraphDatabase.Driver instance to connect to the database.
    """
    return GraphDatabase.driver(uri, auth=(username, password))

def _query(query_text=None, query_params=None):
    """
    Submits a parameterized Cypher query to Neo4j.

    Parameters
    ----------
    query_text: str
        A valid Cypher query string.
    query_params: list(str)
        A list of parameters to be passed along with the query_text.

    Returns
    -------
    A tuple of dictionaries, representing entities returned by the query.
    """
    with _authenticated_driver().session() as session:
        return session.run(query_text, query_params).data()

def _server_timestamp():
    """
    Retrieves a timestamp from the neo4j isntance and prints a message 
    to the screen. 

    Parameters
    ----------
    None

    Returns
    -------
    str:
        Timestamp from server.
    """
    text, params = Queries.server_timestamp()

    return _query(query_text=text, query_params=params)[0]['timestamp'].iso_format()

