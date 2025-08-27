# Notebook 2: Exploring Your Graph Data

## Learning Objectives

By the end of this notebook, you will be able to:
1. Navigate your graph data using both Harbor and Navigator patterns
2. Understand how to search for specific entities in your graph
3. Interpret node and relationship visualizations in the interface
4. Recognize patterns and structures in your graph data
5. Use Ocean Explorer to answer specific questions about your data

## 1. The Ocean Explorer Interface

Before diving into exploration patterns, let's familiarize ourselves with the Ocean Explorer interface. After logging in, you're presented with the dashboard, which serves as your entry point for exploration.

### 1.1 The Dashboard

The dashboard provides an overview of your graph data and entry points for exploration. Let's look at the code that generates this dashboard:

```python
# From ocean_explorer.py
@app.route('/')
@login_required
def index():
    """
    Main dashboard that serves as the entry point for both Harbor and Navigator approaches.
    """
    log_activity('view_dashboard')
    
    # Get the schema information for the Harbor approach
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

The dashboard is divided into several sections:

1. **About This Explorer**: An introduction to Ocean Explorer and its exploration patterns
2. **Anchor Exploration**: Entry points for schema-based exploration
3. **Navigator Exploration**: Entry points for entity-based exploration
4. **Search**: A form for finding specific entities

The template for this dashboard is in `dashboard.html`:

```html
<!-- From dashboard.html -->
<div style="display: flex; gap: 20px;">
    <!-- Anchor (Schema-First) Section -->
    <div style="flex: 1;">
        <h3>Anchor Exploration</h3>
        <p>Start by exploring the schema structure:</p>
        
        <div class="card">
            <h4>Node Labels</h4>
            <ul>
                {% for label in node_labels %}
                <li><a href="{{ url_for('list_nodes', label=label) }}">{{ label }}</a></li>
                {% endfor %}
            </ul>
            
            <a href="{{ url_for('schema_overview') }}">View full schema</a>
        </div>
    </div>
    
    <!-- Navigator (Entity-First) Section -->
    <div style="flex: 1;">
        <h3>Navigator Exploration</h3>
        <p>Start by exploring specific entities:</p>
        
        <div class="card">
            <h4>Featured Movies</h4>
            <ul>
                {% for movie in featured_movies %}
                <li>
                    <a href="{{ url_for('view_node', label='Movie', node_id=movie.uuid) }}">
                        {{ get_node_display_name(movie) }}
                    </a>
                </li>
                {% endfor %}
            </ul>
        </div>
        
        <div class="card">
            <h4>Featured People</h4>
            <ul>
                {% for person in featured_people %}
                <li>
                    <a href="{{ url_for('view_node', label='Person', node_id=person.uuid) }}">
                        {{ get_node_display_name(person) }}
                    </a>
                </li>
                {% endfor %}
            </ul>
        </div>
    </div>
</div>
```

This template creates a two-column layout with Anchor exploration on the left and Navigator exploration on the right, providing clear entry points for both patterns.

### 1.2 Navigation Elements

The navigation bar at the top of the page provides quick access to key sections of the application:

```html
<!-- From base.html -->
<div class="navigation">
    <a href="{{ url_for('index') }}">Dashboard</a> |
    <a href="{{ url_for('schema_overview') }}">Schema</a> |
    <a href="{{ url_for('search') }}">Search</a>
</div>
```

These links allow you to:
- Return to the dashboard at any time
- View the overall schema of your graph
- Search for specific entities

Additionally, most pages include contextual navigation. For example, when viewing a specific node, you'll see links to return to the list of nodes or the dashboard:

```html
<!-- From node_detail.html -->
<div class="navigation">
    <a href="{{ url_for('list_nodes', label=label) }}">&larr; Back to {{ label }} Nodes</a> |
    <a href="{{ url_for('index') }}">&larr; Back to Dashboard</a>
</div>
```

These contextual links help you maintain your orientation as you explore the graph.

## 2. Understanding the Exploration Patterns

Ocean Explorer implements two complementary patterns for navigating your graph data:

### 2.1 The Anchor Pattern: Schema-First Navigation

The Anchor pattern starts with the database schema and drills down to specific instances. Like an anchor providing stable grounding, this approach offers structured entry points into your data.

**When to use the Anchor pattern:**
- You want to understand the structure of your data
- You're looking for all instances of a particular type
- You need a systematic approach to exploration
- You're new to the dataset

**Example Anchor navigation:**
1. Start at the schema overview (`/schema`)
2. Choose a node label (e.g., "Movie")
3. View all movies in the database
4. Select a specific movie to explore further

### 2.2 The Navigator Pattern: Entity-First Navigation

The Navigator pattern starts with specific entities and "navigates" between connected entities. Like a navigator charting courses between ports, this approach explores connections and relationships.

**When to use the Navigator pattern:**
- You know a specific entity you want to explore
- You want to discover connections and relationships
- You're looking for unexpected associations
- You prefer a more exploratory approach

**Example Navigator navigation:**
1. Start with a specific movie (e.g., "The Matrix")
2. View its connections (actors, directors, genres)
3. Navigate to connected entities (e.g., Keanu Reeves)
4. Explore that entity's connections
5. Continue navigating through the graph

## 3. Using the Dashboard

The main dashboard (`/`) provides entry points for both patterns:

### 3.1 Anchor Section
The left side of the dashboard shows the Anchor approach:
- Lists all available node labels
- Provides a link to the full schema overview
- Offers structured entry points into your data

### 3.2 Navigator Section
The right side of the dashboard shows the Navigator approach:
- Displays featured movies and people
- Provides curated starting points for exploration
- Enables immediate entity-based navigation

## 4. Practical Exploration Examples

Let's walk through some real exploration scenarios:

### 4.1 Scenario 1: Understanding Your Data Structure (Anchor Pattern)

**Goal**: Understand what types of data are in your graph

**Steps**:
1. Visit the schema overview (`/schema`)
2. Review the node labels and their counts
3. Choose a label to explore (e.g., "Movie")
4. View all movies in the database
5. Examine the properties of different movies

**Code Example**:
```python
# This is what happens when you visit /schema
@app.route('/schema')
@login_required
def schema_overview():
    """
    Provide an overview of the database schema (Anchor entry point).
    """
    log_activity('view_schema')
    
    try:
        node_labels = middleware.get_node_labels()
        relationship_types = middleware.get_relationship_types()
        
        return render_template(
            'schema.html',
            node_labels=node_labels,
            relationship_types=relationship_types
        )
    except Exception as e:
        flash(f"Error loading schema: {str(e)}", "error")
        return redirect(url_for('index'))
```

### 4.2 Scenario 2: Exploring Connections (Navigator Pattern)

**Goal**: Discover relationships between entities

**Steps**:
1. Start with a specific movie (e.g., from the featured movies)
2. View the movie's details and connections
3. Navigate to connected actors
4. Explore the actor's other movies
5. Continue navigating through the graph

**Code Example**:
```python
# This is what happens when you view a node's details
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

## 5. Combining Both Patterns

The most effective exploration often combines both patterns:

1. **Start with Anchor**: Use the schema to understand what's available
2. **Switch to Navigator**: Choose interesting entities and explore their connections
3. **Return to Anchor**: When you discover new entity types, use Anchor to explore all instances
4. **Continue Navigating**: Use Navigator to explore the relationships you've discovered

This hybrid approach gives you both structure and discovery, making your exploration both systematic and serendipitous.

## 6. Searching Your Graph

In addition to structured exploration, Ocean Explorer includes a search feature to help you find specific entities. Let's examine the code that handles search:

```python
# From ocean_explorer.py
@app.route('/search', methods=['GET'])
@login_required
def search():
    """
    Simple search functionality to find nodes by property values.
    """
    query = request.args.get('query', '').strip()
    
    if not query:
        return render_template('search.html', results=None, query=None)
    
    log_activity('search', {'query': query})
    
    results = {}
    
    try:
        # Search across all node labels
        for label in middleware.get_node_labels():
            nodes = middleware.get_nodes_by_label(label)
            
            # Simple client-side filtering - in a real application, this would use a proper search query
            label_results = []
            for node in nodes:
                for prop, value in node['props'].items():
                    if isinstance(value, str) and query.lower() in value.lower():
                        label_results.append(node)
                        break
            
            if label_results:
                results[label] = label_results
        
        return render_template(
            'search.html',
            results=results,
            query=query,
            get_node_display_name=get_node_display_name
        )
    
    except Exception as e:
        flash(f"Error performing search: {str(e)}", "error")
        return render_template('search.html', results=None, query=query)
```

This function:
1. Gets the search query from the request parameters
2. Searches for the query string in all string properties of all nodes
3. Organizes the results by node label
4. Renders the search template with the results

The template for this view is in `search.html`:

```html
<!-- From search.html -->
<h2>Search</h2>

<form action="{{ url_for('search') }}" method="get" class="search-box">
    <input type="text" name="query" placeholder="Enter search term" value="{{ query or '' }}">
    <button type="submit">Search</button>
</form>

{% if query %}
<h3>Search Results for "{{ query }}"</h3>

{% if not results or results|length == 0 %}
<p>No results found.</p>
{% else %}
{% for label, nodes in results.items() %}
<div class="card">
    <h4>{{ label }} ({{ nodes|length }})</h4>
    <ul>
        {% for node in nodes %}
        <li>
            <a href="{{ url_for('view_node', label=label, node_id=node.uuid) }}">
                {{ get_node_display_name(node) }}
            </a>
        </li>
        {% endfor %}
    </ul>
</div>
{% endfor %}
{% endif %}
{% endif %}
```

This template presents:
1. A search form at the top
2. Search results organized by node label
3. Links to view the details of each matching node

The search feature provides a quick way to find specific entities when you know what you're looking for.

## 7. Understanding Formatting and Display Helpers

Ocean Explorer includes several helper functions to format and display data in a user-friendly way. Let's examine some of these helpers:

### 7.1 Displaying Node Names

Nodes in a graph database may have different properties that represent their "name" or primary identifier. Ocean Explorer includes a helper function to find the most appropriate property to display:

```python
# From ocean_explorer.py
def get_node_display_name(node):
    """
    Gets a human-readable display name for a node based on common properties.
    This helps create more user-friendly links and titles.
    """
    props = node['props']
    
    # Try common name properties in order of preference
    for prop in ['title', 'name', 'fullName', 'displayName']:
        if prop in props and props[prop]:
            return props[prop]
    
    # Fall back to UUID if no name property is found
    return f"Node {node['uuid'][:8]}..."
```

This function tries several common name properties in order of preference:
1. `title` (common for movies, articles, etc.)
2. `name` (common for people, organizations, etc.)
3. `fullName` (common for people)
4. `displayName` (a generic display name)

If none of these properties exist, it falls back to a truncated UUID.

### 7.2 Formatting Property Values

Property values in a graph database can be of various types and lengths. Ocean Explorer includes a helper function to format these values for display:

```python
# From ocean_explorer.py
def format_property_value(value, max_length=100):
    """
    Format a property value for display, handling different types appropriately.
    """
    if value is None:
        return "<empty>"
    
    # For lists, format each item
    if isinstance(value, list):
        if len(value) > 3:
            return f"List with {len(value)} items"
        return ", ".join(str(item) for item in value)
    
    # For dictionaries, summarize content
    if isinstance(value, dict):
        return f"Object with {len(value)} properties"
    
    # For strings, truncate if too long
    value_str = str(value)
    if len(value_str) > max_length:
        return value_str[:max_length] + "..."
    
    return value_str
```

This function handles different types of values:
- Lists: Shows the first few items or a summary if the list is long
- Dictionaries: Shows a summary of the object's properties
- Strings: Truncates long strings to a manageable length
- Other types: Converts to a string representation

These formatting helpers ensure that the data is presented in a user-friendly way, even when it's complex or verbose.

## 8. Exploring Common Graph Patterns

As you explore your graph data, you'll likely encounter common patterns that represent important relationships in your domain. Let's examine how Ocean Explorer helps you identify and understand these patterns.

### 8.1 One-to-Many Relationships

One-to-many relationships are common in graph databases, such as a director who has directed multiple movies. When viewing a node with many outgoing relationships of the same type, Ocean Explorer groups them together:

```html
<!-- From node_detail.html -->
<div class="card">
    <h3>Outgoing Relationships ({{ outgoing_relationships|length }})</h3>
    <table>
        <thead>
            <tr>
                <th>Relationship</th>
                <th>To</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            {% for relationship in outgoing_relationships %}
            <tr>
                <td>{{ get_relationship_display(relationship) }}</td>
                <td>
                    {{ get_node_display_name(relationship.target) }}
                </td>
                <td>
                    <a href="{{ url_for('view_node', label=relationship.target.labels[0], node_id=relationship.target.uuid) }}">View</a>
                </td>
            </tr>
            {% endfor %}
        </tbody>
    </table>
</div>
```

This view makes it easy to see all the entities connected to the current node, helping you identify one-to-many relationships.

### 8.2 Many-to-Many Relationships

Many-to-many relationships, such as actors appearing in multiple movies and movies having multiple actors, are visible when you see the same relationship type with different targets. The bidirectional navigation allows you to explore both sides of these relationships:

```html
<!-- From node_detail.html (partial) -->
<!-- Incoming Relationships -->
{% if incoming_relationships %}
<div class="card">
    <h3>Incoming Relationships ({{ incoming_relationships|length }})</h3>
    <table>
        <thead>
            <tr>
                <th>From</th>
                <th>Relationship</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            {% for relationship in incoming_relationships %}
            <tr>
                <td>
                    {{ get_node_display_name(relationship.source) }}
                </td>
                <td>{{ get_relationship_display(relationship) }}</td>
                <td>
                    <a href="{{ url_for('view_node', label=relationship.source.labels[0], node_id=relationship.source.uuid) }}">View</a>
                </td>
            </tr>
            {% endfor %}
        </tbody>
    </table>
</div>
{% endif %}
```

By showing both incoming and outgoing relationships, Ocean Explorer helps you understand the full context of an entity in the graph.

### 8.3 Hierarchical Relationships

Hierarchical relationships, such as categories and subcategories, are visible when you see self-referential relationships (relationships between nodes of the same type). Ocean Explorer's navigation makes it easy to traverse these hierarchies:

1. Start at a parent node
2. Click on a relationship to a child node of the same type
3. Repeat to navigate down the hierarchy
4. Use the "Back" links to navigate up the hierarchy

This exploration pattern allows you to understand and navigate hierarchical structures in your data.

## 9. Sample Exploration Scenarios

Let's walk through some specific exploration scenarios to demonstrate how Ocean Explorer can help you answer questions about your data.

### 9.1 Finding All Movies by a Director

To find all movies directed by a specific director:

1. Use the search feature to find the director by name
2. Click on the director in the search results
3. In the director's detail view, look for outgoing relationships of type "DIRECTED"
4. Each relationship will point to a movie directed by this person
5. Click on a movie to view its details

This exploration path shows how you can use the Navigator pattern to navigate from a person to their related movies.

### 9.2 Discovering Common Actors Between Movies

To find actors who have appeared in multiple specific movies:

1. Use the search feature to find the first movie
2. In the movie's detail view, look for incoming relationships of type "ACTED_IN"
3. Make note of the actors who appeared in this movie
4. Use the search feature to find the second movie
5. Compare the actors in the second movie with your list from the first movie
6. Actors who appear in both lists have appeared in both movies

This scenario demonstrates how you can use Ocean Explorer to compare entities and find common relationships.

### 9.3 Exploring a Movie's Production Network

To explore the full production network of a movie:

1. Find the movie using search or Anchor navigation
2. In the movie's detail view, look at all incoming relationships
3. These relationships will show actors, directors, producers, etc.
4. Click on each person to view their details
5. For each person, look at their outgoing relationships to find other movies they've worked on
6. Continue this exploration to map out the broader production network

This scenario shows how you can use Ocean Explorer for more complex exploration tasks, discovering indirect relationships and broader patterns in your data.

## 10. Summary

In this notebook, we've explored how to use Ocean Explorer to navigate and understand your graph data. We've covered:

1. The Ocean Explorer interface and its key components
2. Anchor exploration: starting with the schema and drilling down to instances
3. Navigator exploration: starting with specific entities and navigating connections
4. Searching for specific entities in your graph
5. Helper functions for formatting and displaying data
6. Common graph patterns and how to identify them
7. Sample exploration scenarios for answering specific questions

Ocean Explorer provides a flexible, intuitive interface for exploring graph data, whether you're new to the dataset or looking for specific information. By combining both Anchor and Navigator patterns, you can develop a comprehensive understanding of your data's structure and connections.

## 11. Further Reading

- [Neo4j Cypher Query Language](https://neo4j.com/docs/cypher-manual/current/) - If you want to learn the underlying query language
- [Graph Data Modeling](https://neo4j.com/developer/data-modeling/) - Understanding common patterns in graph databases
- [Graph Algorithms](https://neo4j.com/docs/graph-data-science/current/algorithms/) - For more advanced graph analysis
- [Data Visualization Techniques](https://neo4j.com/developer/graph-visualization/) - For exploring alternative ways to visualize graph data
