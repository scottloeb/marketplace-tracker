# Compass

## Overview

Compass is a **pattern discovery and guidance tool** within the H.A.R.B.O.R. ecosystem. It helps users discover patterns in their graph data through systematic exploration and provides automated guidance for data navigation, like a compass pointing the way to hidden treasures.

## Purpose

Compass is designed for:
- **Pattern Discovery** - Systematically identify patterns in graph data
- **Guided Exploration** - Provide automated guidance for data navigation
- **Learning Support** - Help users understand complex datasets
- **Direction Finding** - Point users toward interesting data patterns
- **Systematic Analysis** - Structured approach to data exploration

## Key Features

### Pattern Discovery
- **Automatic Pattern Recognition** - Identify common patterns in graph data
- **Hub Detection** - Find nodes with many connections
- **Relationship Analysis** - Analyze connection patterns between entities
- **Frequency Analysis** - Identify most common node types and relationships
- **Structural Patterns** - Discover organizational patterns in the data

### Guidance Features
- **Exploration Paths** - Suggested routes for data exploration
- **Pattern-Based Guidance** - Recommendations based on discovered patterns
- **Navigation Assistance** - Help users choose exploration strategies
- **Learning Support** - Educational guidance for data exploration
- **Progressive Discovery** - Step-by-step exploration guidance

### Integration with Navigation Patterns
Compass works with both navigation patterns:

- **Anchor Pattern** ⚓ - Schema-first navigation
  - Start with database structure
  - Drill down to specific instances
  - Systematic, predictable exploration

- **Beacon Pattern** 🔦 - Entity-first navigation
  - Start with specific entities
  - Illuminate connections between entities
  - Exploratory, discovery-focused navigation

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Web Interface │    │  Pattern         │    │   Neo4j         │
│   (Flask App)   │◄──►│  Discovery       │◄──►│   Database      │
│                 │    │  Engine          │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

- **Flask Web Application** - User interface and guidance system
- **Pattern Discovery Engine** - Algorithms for pattern recognition
- **Neo4j Database** - Graph data source for pattern analysis

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
   python compass.py
   ```

4. **Access the Interface**
   - Open your browser to `http://localhost:5000`
   - Start discovering patterns and getting guidance

## Usage

### Getting Started
1. **Dashboard** - Overview of discovered patterns and exploration paths
2. **Pattern Discovery** - Detailed view of all discovered patterns
3. **Exploration Paths** - Guided routes for data exploration
4. **Guidance** - Educational content and navigation tips

### Pattern Types Discovered
- **Node Label Patterns** - Common node types and their frequencies
- **Relationship Patterns** - Common connection types
- **Hub Patterns** - Nodes with many connections
- **Structural Patterns** - Organizational patterns in the data
- **Frequency Patterns** - Most common data structures

### Exploration Workflows
- **Guided Discovery**: Follow suggested exploration paths
- **Pattern-Based Navigation**: Use discovered patterns to guide exploration
- **Systematic Analysis**: Work through data systematically
- **Learning Journey**: Use educational guidance for learning

## Configuration

### Pattern Discovery Settings
- `pattern_threshold` - Minimum frequency for pattern detection
- `hub_threshold` - Minimum connections for hub detection
- `max_patterns` - Maximum number of patterns to display
- `analysis_depth` - Depth of pattern analysis

### Environment Variables
- `NEO4J_URI` - Neo4j connection string
- `NEO4J_USER` - Database username
- `NEO4J_PASSWORD` - Database password
- `FLASK_SECRET_KEY` - Flask session security

## Relationship to H.A.R.B.O.R.

Compass is one of the core **tools** in the H.A.R.B.O.R. ecosystem:

- **Ocean Explorer** - Deep water graph navigation
- **Coastal Explorer** - Shallow water graph navigation
- **Beacon** - Pattern detection and highlighting
- **Compass** - Pattern discovery and guidance (this tool)

Compass works alongside the **Anchor and Beacon patterns** (navigation approaches) to provide guided discovery and learning support.

## Integration with Other Tools

### With Ocean Explorer
- Compass can guide Ocean Explorer users to interesting patterns
- Pattern discoveries can inform exploration strategies
- Integration provides guided deep exploration

### With Coastal Explorer
- Compass can provide learning guidance for Coastal Explorer users
- Pattern discovery can help validate data structure
- Integration enhances educational experiences

### With Beacon
- Compass discovers patterns that Beacon can highlight
- Pattern guidance can inform Beacon's highlighting strategies
- Integration provides comprehensive pattern support

## When to Use Compass

### Choose Compass when:
- You're new to graph databases and need guidance
- You want to understand patterns in your data systematically
- You need help choosing exploration strategies
- You're learning about graph data exploration
- You want guided discovery rather than random exploration

### Pattern Discovery Use Cases
- **Learning Graph Databases** - Educational guidance for beginners
- **Data Structure Analysis** - Understanding organizational patterns
- **Exploration Strategy** - Choosing the best approach for your data
- **Pattern Recognition** - Identifying common structures
- **Guided Discovery** - Systematic exploration with assistance

## Key Differences from Other Tools

| Feature | Compass | Ocean Explorer | Coastal Explorer | Beacon |
|---------|---------|----------------|------------------|---------|
| **Primary Focus** | Guidance & Learning | Deep Exploration | Simple Navigation | Pattern Detection |
| **User Experience** | Educational | Advanced | Basic | Analytical |
| **Pattern Role** | Discovery | Application | Basic | Highlighting |
| **Navigation** | Guided | Self-directed | Simple | Pattern-based |
| **Use Case** | Learning & Guidance | Research | Validation | Analysis |

## Contributing

See the main [CONTRIBUTING.md](../CONTRIBUTING.md) file for guidelines on contributing to the H.A.R.B.O.R. project.

## License

This project is proprietary to NeurOasis. See the main [README.md](../README.md) for licensing information. 