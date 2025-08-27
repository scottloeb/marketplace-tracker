# Notebook 0: Introduction to Ocean Explorer

## Welcome to Your Data Ocean! 🌊

Ocean Explorer (**O**pen **C**omplex **E**xploration **A**nd **N**avigation) is a lightweight web application designed to make exploring Neo4j graph databases accessible and intuitive. Whether you're new to graph databases or a seasoned professional, this tool provides a clear path to understanding your data.

This notebook serves as an introduction to Ocean Explorer, explaining its philosophy, architecture, and how to get started.

## Learning Objectives

By the end of this notebook, you will be able to:
1. Understand the Ocean Explorer philosophy and approach to graph exploration
2. Identify the key components of the Ocean Explorer architecture
3. Recognize the distinction between the Module Generator and the generated middleware
4. Understand the "Anchor" and "Navigator" exploration patterns
5. Set up a basic Ocean Explorer instance

## 1. The Ocean Explorer Philosophy

The Ocean Explorer approach is built on several key principles:

### 1.1 Accessibility

Graph databases are powerful tools for working with connected data, but they can be intimidating for newcomers. Ocean Explorer aims to make graph data accessible to users of all technical backgrounds through an intuitive, web-based interface.

```python
# From ocean_explorer.py - A clear, simple route that requires no knowledge of graph databases
@app.route('/')
@login_required
def index():
    """
    Main dashboard that serves as the entry point for both Anchor and Navigator approaches.
    """
    log_activity('view_dashboard')
    
    # Get the schema information for the Anchor approach
    node_labels = middleware.get_node_labels()
    
    # For the Navigator approach, we'll prepare curated entry points
    # These are examples from the movie graph
    featured_movies = []
    featured_people = []
    
    try:
        # Get some featured movies
        movies = middleware.get_nodes_by_label('Movie')
        if movies:
            featured_movies = movies[:5]  # First 5 movies
        
        # Get some featured people
        people = middleware.get_nodes_by_label('Person')
        if people:
            featured_people = people[:5]  # First 5 people
    except Exception as e:
        flash(f"Error loading featured content: {str(e)}", "error")
    
    return render_template(
        'dashboard.html',
        node_labels=node_labels,
        featured_movies=featured_movies,
        featured_people=featured_people,
        get_node_display_name=get_node_display_name
    )
```

This route demonstrates Ocean Explorer's commitment to accessibility:
- No complex configuration required
- Clear, descriptive function names
- Comprehensive error handling
- Intuitive data presentation

### 1.2 Cognitive Alignment

Ocean Explorer is designed to work with how humans naturally think about and explore data. Instead of forcing users to learn complex query languages or understand database internals, Ocean Explorer provides interfaces that feel natural and intuitive.

### 1.3 Progressive Revelation

Information is revealed progressively as users need it. The interface starts simple and becomes more detailed as users explore deeper into the data.

## 2. Ocean Explorer Architecture

Ocean Explorer follows a clean, modular architecture that separates concerns and makes the system easy to understand and extend.

### 2.1 Core Components

```
Ocean Explorer
├── Flask Web Application (ocean_explorer.py)
├── Generated Middleware (newgraph.py)
├── Templates (templates/)
├── Static Assets (static/)
└── Configuration (config.py)
```

### 2.2 The Module Generator

The Module Generator is a separate tool that analyzes your Neo4j database and generates a Python middleware module tailored to your specific schema.

The Module Generator:
- Connects to your Neo4j database
- Analyzes the schema (labels, relationships, properties)
- Generates a Python module tailored to your specific schema
- Contains no actual data, only metadata and code

### 2.3 The Generated Middleware

The middleware is the Python module created by the Module Generator, which you'll use in your Ocean Explorer application.

```python
# From ocean_explorer.py - Using the generated middleware
# Import the middleware - normally this would be generated with the Module Generator
import newgraph as graph_db
    
# Create a middleware adapter to handle different middleware structures
from middleware_adapter import create_middleware_adapter
middleware = create_middleware_adapter(graph_db)
```

The generated middleware:
- Contains metadata about your database schema
- Provides typed functions for accessing your data
- Abstracts away Cypher queries behind a Python API
- Is specific to your database structure
- Contains no actual data, only code to access it

## 4. Exploration Patterns: Anchor and Navigator

Ocean Explorer implements two complementary patterns for navigating your graph data.

### 4.1 The Anchor Pattern: Schema-First Navigation

The Anchor pattern starts with the database schema and drills down to specific instances.

```python
# From ocean_explorer.py - Implementing the Anchor pattern
@app.route('/labels/<label>')
@login_required
def list_nodes(label):
    """
    List all nodes with a specific label (Anchor navigation).
    """
    log_activity('list_nodes', {'label': label})
    
    try:
        nodes = middleware.get_nodes_by_label(label)
        
        # Get properties for display
        if nodes:
            # Use the first node to determine which properties to show
            display_properties = list(nodes[0]['props'].keys())[:5]  # First 5 properties
        else:
            display_properties = []
        
        return render_template(
            'nodes_list.html',
            label=label,
            nodes=nodes,
            display_properties=display_properties,
            get_node_display_name=get_node_display_name,
            format_property_value=format_property_value
        )
    except Exception as e:
        flash(f"Error listing nodes: {str(e)}", "error")
        return redirect(url_for('index'))
```

The Anchor pattern:
- Starts by examining the structure of your data
- Lists all available node types (labels)
- Allows drilling down into specific node types
- Shows instances of each type

### 4.2 The Navigator Pattern: Entity-First Navigation

The Navigator pattern starts with specific entities and "navigates" between connected entities.

```python
# From ocean_explorer.py - Implementing the Navigator pattern
@app.route('/nodes/<label>/<node_id>')
@login_required
def view_node(label, node_id):
    """
    View details of a specific node and its relationships (Navigator navigation).
    This is the heart of the "navigating" navigation pattern.
    """
    log_activity('view_node', {'label': label, 'node_id': node_id})
    
    try:
        # Find the specific node by ID
        node = middleware.get_node_by_id(label, node_id)
        
        if not node:
            flash(f"Node not found: {node_id}", "error")
            return redirect(url_for('index'))
        
        # Find all relationships connected to this node
        incoming_relationships = middleware.get_incoming_relationships(node_id)
        outgoing_relationships = middleware.get_outgoing_relationships(node_id)
        
        return render_template(
            'node_detail.html',
            node=node,
            label=label,
            incoming_relationships=incoming_relationships,
            outgoing_relationships=outgoing_relationships,
            get_node_display_name=get_node_display_name,
            format_property_value=format_property_value
        )
    
    except Exception as e:
        flash(f"Error viewing node: {str(e)}", "error")
        return redirect(url_for('index'))
```

The Navigator pattern:
- Focuses on a specific entity and its connections
- Shows both incoming and outgoing relationships
- Allows "navigating" to connected entities
- Provides a graph-like navigation experience

### 4.3 Combining the Patterns

Ocean Explorer combines these patterns to provide a comprehensive exploration experience, as seen in the dashboard implementation:

```python
# From ocean_explorer.py - Combining both patterns on the dashboard
@app.route('/')
@login_required
def index():
    """
    Main dashboard that serves as the entry point for both Anchor and Navigator approaches.
    """
    log_activity('view_dashboard')
    
    # Get the schema information for the Anchor approach
    node_labels = middleware.get_node_labels()
    
    # For the Navigator approach, we'll prepare curated entry points
    # These are examples from the movie graph
    featured_movies = []
    featured_people = []
    
    try:
        # Get some featured movies
        movies = middleware.get_nodes_by_label('Movie')
        if movies:
            featured_movies = movies[:5]  # First 5 movies
        
        # Get some featured people
        people = middleware.get_nodes_by_label('Person')
        if people:
            featured_people = people[:5]  # First 5 people
    except Exception as e:
        flash(f"Error loading featured content: {str(e)}", "error")
    
    return render_template(
        'dashboard.html',
        node_labels=node_labels,
        featured_movies=featured_movies,
        featured_people=featured_people,
        get_node_display_name=get_node_display_name
    )
```

This dashboard provides entry points for both patterns:
- **Anchor Section**: Lists all available node labels for schema-based exploration
- **Navigator Section**: Shows featured entities for entity-based exploration

## 5. Setting Up Ocean Explorer

### 5.1 Prerequisites

Before you can use Ocean Explorer, you'll need:

1. **Python 3.8 or higher**
2. **Neo4j database** with some data
3. **Module Generator** to create the middleware
4. **Flask** and other Python dependencies

### 5.2 Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd harbor/ocean_explorer
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Generate the middleware**
   ```bash
   python modulegenerator-claude.py -u 'bolt://localhost:7687' -n 'neo4j' -p 'password' -g 'newgraph'
   ```

4. **Start the application**
   ```bash
   python ocean_explorer.py
   ```

5. **Access the application**
   Open your browser and navigate to `http://localhost:5000`

### 5.3 Configuration

Ocean Explorer uses a simple configuration system that can be customized for your needs:

```python
# Configuration options in ocean_explorer.py
app.config.update(
    SECRET_KEY='your-secret-key-here',
    MAX_CONTENT_LENGTH=16 * 1024 * 1024,  # 16MB max file size
    UPLOAD_FOLDER='uploads/',
    ALLOWED_EXTENSIONS={'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}
)
```

## 6. Summary

In this notebook, we've introduced Ocean Explorer and its core concepts:

1. **Philosophy**: Accessibility, cognitive alignment, and progressive revelation
2. **Architecture**: Clean separation between web application and database middleware
3. **Module Generator**: Tool for creating schema-specific middleware
4. **Exploration Patterns**: Anchor (schema-first) and Navigator (entity-first) approaches
5. **Setup**: Simple installation and configuration process

Ocean Explorer is designed to make graph database exploration accessible to everyone, regardless of their technical background. By providing intuitive interfaces and clear navigation patterns, it helps users understand and explore their data naturally.

In the next notebook, we'll dive deeper into the technical architecture and learn how to customize Ocean Explorer for your specific needs.

## 7. Next Steps

- **Notebook 1**: Environment setup and configuration
- **Notebook 2**: Exploring your graph data with Anchor and Navigator patterns
- **Notebook 3**: Understanding the Flask application structure
- **Notebook 4**: Working with the generated middleware
- **Notebook 5**: Customizing Ocean Explorer for your needs

## 8. Further Reading

- [Neo4j Documentation](https://neo4j.com/docs/) - Learn more about Neo4j graph databases
- [Flask Documentation](https://flask.palletsprojects.com/) - Understand the web framework
- [Graph Data Modeling](https://neo4j.com/developer/data-modeling/) - Best practices for graph data
- [H.A.R.B.O.R. Project](https://github.com/NeurOasis/harbor) - The broader ecosystem
