# Beacon

## Overview

Beacon is a **pattern detection and highlighting tool** within the H.A.R.B.O.R. ecosystem. It automatically identifies, analyzes, and visualizes patterns in graph data to guide users through complex data structures.

## Purpose

Beacon is designed for:
- **Pattern Detection** - Automatically identify common patterns in graph data
- **Data Analysis** - Provide insights into data structure and relationships
- **Visualization** - Create visual representations of data patterns
- **Guidance** - Help users navigate complex datasets by highlighting important patterns

## Key Features

### Pattern Detection
- **Automatic Pattern Recognition** - Identify common graph patterns
- **Relationship Analysis** - Analyze connection patterns between entities
- **Frequency Analysis** - Identify most common node types and relationships
- **Anomaly Detection** - Find unusual patterns or outliers

### Visualization
- **Pattern Visualization** - Visual representations of detected patterns
- **Interactive Charts** - Explore patterns through interactive interfaces
- **Network Graphs** - Visualize relationship networks
- **Pattern Dashboards** - Comprehensive pattern overview

### Guidance Features
- **Pattern Recommendations** - Suggest exploration paths based on patterns
- **Insight Generation** - Provide automated insights about data structure
- **Navigation Assistance** - Guide users to interesting patterns
- **Trend Analysis** - Identify trends and changes in data patterns

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Web Interface │    │  Pattern         │    │   Neo4j         │
│   (Flask App)   │◄──►│  Detection       │◄──►│   Database      │
│                 │    │  Engine          │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

- **Flask Web Application** - User interface and pattern visualization
- **Pattern Detection Engine** - Algorithms for pattern recognition
- **Neo4j Database** - Graph data source for pattern analysis

## Installation & Setup

1. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Configure Pattern Detection**
   ```bash
   # Configure pattern detection parameters
   python pattern_detector.py --config patterns.json
   ```

3. **Run the Application**
   ```bash
   python app.py
   ```

4. **Access the Interface**
   - Open your browser to `http://localhost:5000`
   - View detected patterns and insights

## Usage

### Getting Started
1. **Pattern Dashboard** - Overview of all detected patterns
2. **Pattern Details** - Detailed analysis of specific patterns
3. **Visualization** - Interactive pattern visualizations
4. **Insights** - Automated insights and recommendations

### Pattern Types Detected
- **Connection Patterns** - Common relationship structures
- **Node Patterns** - Frequent node types and properties
- **Path Patterns** - Common traversal paths through the graph
- **Cluster Patterns** - Groups of closely connected nodes
- **Anomaly Patterns** - Unusual or unexpected structures

## Configuration

### Pattern Detection Settings
- `pattern_threshold` - Minimum frequency for pattern detection
- `max_patterns` - Maximum number of patterns to display
- `visualization_type` - Type of pattern visualization
- `analysis_depth` - Depth of pattern analysis

### Environment Variables
- `NEO4J_URI` - Neo4j connection string
- `NEO4J_USER` - Database username
- `NEO4J_PASSWORD` - Database password
- `FLASK_SECRET_KEY` - Flask session security

## Relationship to H.A.R.B.O.R.

Beacon is one of the core **tools** in the H.A.R.B.O.R. ecosystem:

- **Ocean Explorer** - Deep water graph navigation
- **Coastal Explorer** - Shallow water graph navigation
- **Beacon** - Pattern detection and highlighting (this tool)
- **Compass** - Pattern discovery and guidance

Beacon works alongside the **Anchor and Beacon patterns** (navigation approaches) to provide pattern-based guidance for data exploration.

## Integration with Other Tools

### With Ocean Explorer
- Beacon can highlight patterns for Ocean Explorer users
- Pattern insights can guide navigation decisions
- Integration provides pattern-aware exploration

### With Coastal Explorer
- Beacon can provide pattern insights for simpler datasets
- Pattern detection can help validate data structure
- Integration enhances learning and training scenarios

## When to Use Beacon

### Choose Beacon when:
- You need to understand patterns in your data
- You want automated insights about data structure
- You're looking for guidance in data exploration
- You need to identify anomalies or unusual patterns
- You want to visualize complex relationship patterns

### Pattern Detection Use Cases
- **Data Quality Assessment** - Identify data quality issues
- **Schema Analysis** - Understand data structure patterns
- **Relationship Discovery** - Find hidden connections
- **Anomaly Detection** - Identify unusual data patterns
- **Trend Analysis** - Track changes in data patterns over time

## Contributing

See the main [CONTRIBUTING.md](../CONTRIBUTING.md) file for guidelines on contributing to the H.A.R.B.O.R. project.

## License

This project is proprietary to NeurOasis. See the main [README.md](../README.md) for licensing information. 