# Coastal Explorer

## Overview

Coastal Explorer is a **shallow water graph navigation tool** within the H.A.R.B.O.R. ecosystem. It provides simple, accessible exploration capabilities for structured, familiar graph databases through a lightweight web interface.

## Purpose

Coastal Explorer is designed for:
- **Simple exploration** of well-structured graph data
- **Learning and training** scenarios
- **Quick data validation** and verification
- **Structured, predictable** navigation workflows

## Key Features

### Navigation Patterns
Coastal Explorer implements both navigation patterns:

- **Anchor Pattern** ⚓ - Schema-first navigation
  - Start with database structure
  - Drill down to specific instances
  - Systematic, predictable exploration

- **Beacon Pattern** 🔦 - Entity-first navigation
  - Start with specific entities
  - Illuminate connections between entities
  - Exploratory, discovery-focused navigation

### Core Functionality
- **Schema Overview** - View all node labels and relationship types
- **Node Browsing** - Simple list views of nodes by type
- **Relationship Display** - Basic relationship visualization
- **Search Interface** - Find entities by name or properties
- **Simple Navigation** - Easy-to-use interface for beginners

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Web Interface │    │  Generated       │    │   Neo4j         │
│   (Flask App)   │◄──►│  Middleware      │◄──►│   Database      │
│   (Simple)      │    │  (Python Module) │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

- **Simple Flask App** - Basic user interface with inline templates
- **Generated Middleware** - Database access layer
- **Neo4j Database** - Graph data storage

## Installation & Setup

1. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Generate Middleware**
   ```bash
   python modulegenerator-claude.py -u 'bolt://localhost:7687' -n 'neo4j' -p 'password' -g 'newgraph'
   ```

3. **Run the Application**
   ```bash
   python coastal_explorer.py
   ```

4. **Access the Interface**
   - Open your browser to `http://localhost:5000`
   - Use the simple dashboard to start exploring

## Usage

### Getting Started
1. **Dashboard** - Overview with clear entry points
2. **Schema** - Simple view of database structure
3. **Node Lists** - Browse nodes by type
4. **Entity Details** - View individual entities and connections

### Navigation Workflows
- **Anchor Workflow**: Schema → Node Types → Instances → Details
- **Beacon Workflow**: Entity → Connections → Related Entities → Further Exploration

## Key Differences from Ocean Explorer

| Feature | Coastal Explorer | Ocean Explorer |
|---------|------------------|----------------|
| **Complexity** | Simple, lightweight | Comprehensive, feature-rich |
| **Templates** | Inline HTML | Separate template files |
| **Styling** | Basic CSS | Advanced styling |
| **Use Case** | Learning, validation | Research, analysis |
| **Data Scale** | Small to medium | Large, complex |
| **User Experience** | Straightforward | Advanced features |

## Configuration

### Environment Variables
- `NEO4J_URI` - Neo4j connection string
- `NEO4J_USER` - Database username
- `NEO4J_PASSWORD` - Database password
- `FLASK_SECRET_KEY` - Flask session security

### Customization
- Modify inline templates in the Python file
- Update middleware functions for custom queries
- Add new routes for specialized functionality

## Relationship to H.A.R.B.O.R.

Coastal Explorer is one of the core **tools** in the H.A.R.B.O.R. ecosystem:

- **Ocean Explorer** - Deep water graph navigation
- **Coastal Explorer** - Shallow water graph navigation (this tool)
- **Beacon** - Pattern detection and highlighting
- **Compass** - Pattern discovery and guidance

The **Anchor and Beacon patterns** are navigation approaches that can be implemented by any of these tools.

## When to Use Coastal Explorer

### Choose Coastal Explorer when:
- You're new to graph databases
- You need a simple, lightweight interface
- You're working with well-structured, familiar data
- You want to quickly validate data relationships
- You're teaching or learning graph concepts

### Choose Ocean Explorer when:
- You need advanced features and capabilities
- You're working with large, complex datasets
- You need sophisticated pattern detection
- You're doing research or analysis
- You need customizable templates and styling

## Contributing

See the main [CONTRIBUTING.md](../CONTRIBUTING.md) file for guidelines on contributing to the H.A.R.B.O.R. project.

## License

This project is proprietary to NeurOasis. See the main [README.md](../README.md) for licensing information. 