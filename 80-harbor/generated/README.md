# Neo4j Module Generator

## Welcome!

Hey there! 👋 Ready to make graph databases a whole lot easier? This Neo4j Module Generator is designed to help developers of all experience levels work with graph data without getting bogged down in database-specific syntax. Even if you're just starting out with Python or have never used a graph database before, this tool will help you hit the ground running!

## About This Project

This project bridges the gap between Neo4j graph databases and Python development by automatically creating an intuitive API layer. Instead of learning complex Cypher queries, you can use familiar Python syntax to access your graph data. Think of it as your friendly translator between Python and Neo4j!

### Development Process

This project came together through a blend of human creativity and AI assistance:

1. The initial concept and starter code (`modulegenerator.py`) was created by a human developer who wanted to make graph databases more accessible
2. The code was enhanced and completed with the assistance of Claude AI (Anthropic) to implement comprehensive metadata collection, type validation, and developer-friendly API generation
3. The resulting code (`modulegenerator-claude.py`) serves both as a practical tool and as an educational resource to help new developers learn graph database concepts

This human-AI collaboration demonstrates how we can combine human creativity with AI capabilities to create tools that make technology more accessible to everyone.

## What Can It Do For You?

- **Turn Database Labels into Python Functions**: Every node label and relationship type in your Neo4j graph becomes a simple Python function you can call
- **Handle Types Automatically**: No need to worry about type conversions between Neo4j and Python
- **Skip the Cypher Learning Curve**: Use familiar Python syntax instead of learning a new query language
- **Focus on Your Data, Not the Database**: Spend time working with your data, not figuring out how to access it
- **Learn by Example**: Generated code provides excellent examples of how to work with Neo4j

## Getting Started is Easy!

### What You'll Need

- Python 3.6 or newer
- A Neo4j 4.x database (works great with Neo4j 4.4.26)
- Neo4j Python driver (just run `pip install neo4j`)

That's it! No complex dependencies or configuration needed.

### Setting Up

1. Download or clone this repository
2. Install the Neo4j driver:

```
pip install neo4j
```

And you're ready to go!

## Using the Module Generator

### Option 1: Run as a Script (Super Simple!)

```bash
python modulegenerator-claude.py -u "bolt://localhost:7687" -n "neo4j" -p "your_password" -g "mygraph"
```

This will create a new file called `mygraph.py` in your current directory.

### Option 2: Use it in Your Python Code

```python
from modulegenerator_claude import generate_module

# Generate a custom module for your graph
module_path = generate_module(
    uri="bolt://localhost:7687",
    username="neo4j",
    password="your_password",
    graph="mygraph"
)

print(f"Success! Your module is ready at: {module_path}")
```

## Start Using Your Generated Module

Once your module is generated, using it is a breeze:

```python
import mygraph

# Find all Person nodes with name "Sarah"
people = mygraph.nodes.person(name="Sarah")

# Get all WORKS_AT relationships created in 2023
work_relationships = mygraph.edges.works_at(since=2023)

# See what you found!
for person in people:
    print(f"Found {person['props']['name']} who is {person['props'].get('age', 'age unknown')} years old")

# See how entities are connected
for employee, relationship, company in work_relationships:
    print(f"{employee['props']['name']} works at {company['props']['name']} as a {relationship['props'].get('role', 'employee')}")
```

Notice how intuitive and readable this is? No complex queries, just simple Python.

## Command Line Options

Here are all the ways you can customize the module generation:

- `-u, --uri`: Where's your Neo4j database? (e.g., "bolt://localhost:7687")
- `-n, --name`: What's your Neo4j username?
- `-p, --password`: What's your Neo4j password?
- `-d, --database`: Which Neo4j database to use (defaults to "neo4j")
- `-g, --graph`: What do you want to name your module? (e.g., "mygraph" creates "mygraph.py")
- `-o, --output`: Where do you want to save the module? (defaults to current directory)

## Under the Hood: How the Module Generator Works

The module generator follows a sophisticated algorithm to create a seamless Python interface to your Neo4j database. Let's look at how it transforms a Neo4j database into Python code:

### 1. Discovery Phase: Metadata Collection

First, the generator explores your Neo4j database to understand its structure:

```python
def _collect_metadata(driver):
    """
    Collects comprehensive metadata about the Neo4j graph database.
    """
    metadata = {
        'node_labels': [],
        'node_properties': {},
        'edge_types': [],
        'edge_properties': {},
        'edge_endpoints': {}
    }
    
    # Get all node labels
    metadata['node_labels'] = _get_node_labels()
    
    # Get properties for each node label
    for label in metadata['node_labels']:
        metadata['node_properties'][label] = _get_node_properties(label)
    
    # Get all edge types
    metadata['edge_types'] = _get_edge_types()
    
    # Get properties and endpoints for each edge type
    for edge_type in metadata['edge_types']:
        metadata['edge_properties'][edge_type] = _get_edge_properties(edge_type)
        metadata['edge_endpoints'][edge_type] = _get_edge_endpoints(edge_type)
    
    return metadata
```

This creates a comprehensive map of:
- All node labels in the database
- All properties that can appear on each node label
- All relationship types in the database
- All properties that can appear on each relationship type
- Which node labels can be connected by each relationship type

### 2. Type Mapping: Creating Type Safety

The generator maps Neo4j types to Python types to ensure type safety:

```python
# Map Neo4j types to Python types
type_mapping = {
    'STRING': 'str',
    'INTEGER': 'int',
    'FLOAT': 'float',
    'BOOLEAN': 'bool',
    'DATE': 'datetime.date',
    'DATETIME': 'datetime.datetime',
    'LIST': 'list',
    'MAP': 'dict'
}
```

For each property, it generates type checking code:

```python
def _generate_type_checking_code(property_name, property_type):
    """
    Generates code for type checking a property value.
    """
    # Get the Python type
    python_type = type_mapping.get(property_type, 'object')
    
    # Generate the type checking code with helpful error messages
    return f"""
        # Type check {property_name} (expected {python_type})
        if "{property_name}" in props and props["{property_name}"] is not None:
            if not isinstance(props["{property_name}"], {python_type}):
                try:
                    # Attempt to convert
                    props["{property_name}"] = {python_type}(props["{property_name}"])
                except:
                    raise TypeError(f"Property {property_name} must be of type {python_type}, got {{type(props['{property_name}']).__name__}}")
    """
```

This makes your code more robust by:
1. Trying to convert values to the correct type when possible
2. Providing clear error messages when conversion isn't possible
3. Only checking types for properties that are actually provided

### 3. Function Generation: Creating Your API

For each node label and relationship type, the generator creates a custom Python function:

```python
def _generate_node_interface_functions(metadata):
    """
    Generates interface functions for each node label.
    """
    functions = []
    
    for label in metadata['node_labels']:
        properties = metadata['node_properties'].get(label, {})
        function_name = label.lower().replace(':', '_').replace('-', '_')
        
        function_code = f"""
    def {function_name}(uuid=None, **props):
        \"\"\"
        Find nodes with label {label} matching the given properties.
        
        Parameters
        ----------
        uuid: str, optional
            The UUID of the node to find
        **props: Dict
            Additional properties to search for
            
        Returns
        -------
        List[Dict]:
            A list of matching nodes as dictionaries
        \"\"\"
        search_props = props.copy()
        if uuid is not None:
            search_props['uuid'] = uuid
            
        # Type checking for known properties
"""
        
        # Add type checking for each property
        for prop_name, prop_type in properties.items():
            function_code += _generate_type_checking_code(prop_name, prop_type)
        
        function_code += f"""
        # Construct and execute the query
        query, params = Queries.node(label="{label}", **search_props)
        results = _query(query, params)
        return [_neo4j_node_to_dict(result['n']) for result in results]
"""
        
        functions.append(function_code)
    
    return "\n".join(functions)
```

A similar function creates the edge interfaces. The result is a set of Python functions that:
1. Accept parameters matching your database properties
2. Validate those parameters against expected types
3. Convert the parameters into a Cypher query
4. Execute the query against Neo4j
5. Convert the results back into plain Python dictionaries

### 4. Result Transformation: Working with Pure Python Objects

When you get results back, they're converted from Neo4j types to pure Python dictionaries:

```python
def _neo4j_node_to_dict(node):
    """
    Convert a neo4j Node to a plain Python dictionary.
    """
    # Create a dictionary from the node
    props = dict(node.items())
    # Get the uuid (if it exists)
    uuid = props.get('uuid', None)
    # Get the labels
    labels = list(node.labels)
    
    return {
        'uuid': uuid,
        'labels': labels,
        'props': props
    }
```

This consistent format makes working with the results simple and intuitive.

### 5. Module Assembly: Putting It All Together

Finally, the generator assembles all the components into a cohesive module:

1. Imports and dependencies
2. Connection details
3. Utility functions
4. Metadata as a JSON object
5. Node interface class with methods for each node label
6. Edge interface class with methods for each relationship type
7. Global interface instances and helper functions

The result is a self-contained Python module that provides a complete interface to your Neo4j database.

## Advanced Usage (But Still Easy!)

### Running Custom Cypher Queries

Sometimes you might want to run a specific query. That's easy too:

```python
# Find who follows who
results = mygraph.execute_query(
    "MATCH (follower:Person)-[r:FOLLOWS]->(celebrity:Person) RETURN follower.name, celebrity.name, r.since",
    params=None
)

for result in results:
    print(f"{result['follower.name']} has been following {result['celebrity.name']} since {result['r.since']}")
```

### Creating a New Database Connection

Need a fresh connection? No problem:

```python
driver = mygraph.connect()
with driver.session() as session:
    # Use the session directly
    result = session.run("MATCH (n) RETURN count(n)")
    print(f"Your database has {result.single()[0]} nodes!")
```

## Real-World Example: Managing a Social Network

Let's see how easy it is to work with a social network graph:

```python
import socialnetwork as sn

# Find a specific user
users = sn.nodes.user(username="alex92")
if users:
    user = users[0]
    print(f"Found user: {user['props']['username']}")
    
    # Find their friends
    friendships = sn.edges.friend_of(user_uuid=user['uuid'])
    print(f"{user['props']['username']} has {len(friendships)} friends:")
    
    for _, relationship, friend in friendships:
        friendship_date = relationship['props'].get('since', 'unknown date')
        print(f"- {friend['props']['username']} (friends since {friendship_date})")
        
    # Find posts they've created
    posts = sn.execute_query(
        "MATCH (u:User {username: $username})-[:CREATED]->(p:Post) RETURN p ORDER BY p.timestamp DESC LIMIT 5",
        params={"username": user['props']['username']}
    )
    
    print(f"\nRecent posts by {user['props']['username']}:")
    for post in posts:
        post_data = post['p']
        print(f"- {post_data['content']} ({post_data['timestamp']})")
else:
    print("User not found!")
```

Look at how readable and intuitive that is! No complex Cypher knowledge required.

## License

This project is a commercial product developed by NeurOasis. All rights reserved.

This software and its documentation are proprietary to NeurOasis and are protected by copyright laws and international treaties.

## Join the Journey!

This project demonstrates the potential of human-AI collaboration in making technology more accessible. We'd love to hear about how you're using it and any ideas you have for making it even better!

If you're new to graph databases or Python, don't hesitate to give this a try. It's designed specifically to help you get started without getting overwhelmed. And if you have questions, feel free to open an issue in the repository.

Happy coding! 🚀

# NOTE FROM DAN HALES: 

The full interaction with claude.ai is public. I enjoyed this, and I hope you will, too.

 https://claude.ai/share/b8ee67e9-5949-4cc8-a01d-3725fb8ef811