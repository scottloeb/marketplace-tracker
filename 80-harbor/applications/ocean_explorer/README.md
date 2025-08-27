# Ocean Explorer

## Overview

Ocean Explorer is a **deep water graph navigation tool** within the H.A.R.B.O.R. ecosystem. It provides comprehensive exploration capabilities for large-scale, complex graph databases through a web-based interface.

## Purpose

Ocean Explorer is designed for:
- **Deep exploration** of complex graph structures
- **Large-scale data** navigation and analysis
- **Advanced pattern discovery** in graph databases
- **Research and analysis** workflows

## Key Features

### Navigation Patterns
Ocean Explorer implements both navigation patterns:

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
- **Node Exploration** - Browse and search nodes by type
- **Relationship Analysis** - Examine connections between entities
- **Pattern Detection** - Identify common patterns in your data
- **Search Capabilities** - Find specific entities quickly

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Web Interface │    │  Generated       │    │   Neo4j         │
│   (Flask App)   │◄──►│  Middleware      │◄──►│   Database      │
│                 │    │  (Python Module) │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

- **Flask Web Application** - User interface and routing
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
   python ocean_explorer.py
   ```

4. **Access the Interface**
   - Open your browser to `http://localhost:5000`
   - Use the dashboard to start exploring your graph data

## Usage

### Getting Started
1. **Dashboard** - Overview of available data types and featured entities
2. **Schema** - Explore the structure of your database
3. **Search** - Find specific entities quickly
4. **Node Details** - Examine individual entities and their connections

### Navigation Workflows
- **Anchor Workflow**: Schema → Node Types → Instances → Details
- **Beacon Workflow**: Entity → Connections → Related Entities → Further Exploration

## Configuration

### Environment Variables
- `NEO4J_URI` - Neo4j connection string
- `NEO4J_USER` - Database username
- `NEO4J_PASSWORD` - Database password
- `FLASK_SECRET_KEY` - Flask session security

### Customization
- Modify templates in `/templates/` for UI changes
- Update middleware functions for custom queries
- Add new routes for specialized functionality

## Documentation

- **Getting Started**: `docs/notebook-0-introduction.md`
- **Environment Setup**: `docs/notebook-1-environment.md`
- **Exploration Guide**: `docs/notebook-2-exploring.md`
- **Flask Architecture**: `docs/notebook-3-flask.md`
- **Middleware Integration**: `docs/notebook-4-middleware.md`
- **Customization**: `docs/notebook-5-customizing.md`
- **Deployment**: `docs/notebook-6-deployment.md`
- **Troubleshooting**: `docs/notebook-7-troubleshooting.md`
- **Reference**: `docs/notebook-8-reference.md`
- **Conclusion**: `docs/notebook-9-conclusion.md`

## Relationship to H.A.R.B.O.R.

Ocean Explorer is one of the core **tools** in the H.A.R.B.O.R. ecosystem:

- **Ocean Explorer** - Deep water graph navigation (this tool)
- **Coastal Explorer** - Shallow water graph navigation
- **Beacon** - Pattern detection and highlighting
- **Compass** - Pattern discovery and guidance

The **Anchor and Beacon patterns** are navigation approaches that can be implemented by any of these tools.

## Contributing

See the main [CONTRIBUTING.md](../CONTRIBUTING.md) file for guidelines on contributing to the H.A.R.B.O.R. project.

## License

This project is proprietary to NeurOasis. See the main [README.md](../README.md) for licensing information. 