# inspect_db.py
from neo4j import GraphDatabase

uri = "bolt://localhost:7687"
username = "neo4j"
password = "neo4j-dev"  # Replace with your actual password

def inspect_database():
    with GraphDatabase.driver(uri, auth=(username, password)) as driver:
        with driver.session() as session:
            # Check node labels
            labels = session.run("CALL db.labels() YIELD label RETURN collect(label) AS labels").single()["labels"]
            print(f"Node labels: {labels}")
            
            # Check relationship types
            rel_types = session.run("CALL db.relationshipTypes() YIELD relationshipType RETURN collect(relationshipType) AS types").single()["types"]
            print(f"Relationship types: {rel_types}")
            
            # Check property keys
            prop_keys = session.run("CALL db.propertyKeys() YIELD propertyKey RETURN collect(propertyKey) AS keys").single()["keys"]
            print(f"Property keys: {prop_keys}")
            
            # If no data exists, create sample data
            count = session.run("MATCH (n) RETURN count(n) as count").single()["count"]
            if count == 0:
                print("Database is empty. Creating sample data...")
                session.run("""
                    CREATE (p1:Person {name: 'Alice', age: 30, uuid: 'p1'})
                    CREATE (p2:Person {name: 'Bob', age: 40, uuid: 'p2'})
                    CREATE (c:Company {name: 'Acme', founded: 2010, uuid: 'c1'})
                    CREATE (p1)-[:WORKS_AT {since: 2018, role: 'Developer', uuid: 'r1'}]->(c)
                    CREATE (p2)-[:WORKS_AT {since: 2015, role: 'Manager', uuid: 'r2'}]->(c)
                    CREATE (p1)-[:KNOWS {since: 2019, uuid: 'r3'}]->(p2)
                """)
                print("Sample data created.")

if __name__ == "__main__":
    inspect_database()