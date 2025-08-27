# H.A.R.B.O.R. Applications

This folder contains the core applications that make up the H.A.R.B.O.R. ecosystem. Each application serves a specific purpose in the maritime data exploration framework.

## 🚢 Core Applications

### **Beacon** 🔦
*Graph Database Visualization and Pattern Detection*
- **Purpose**: Interactive graph visualization and pattern discovery
- **Location**: `beacon/`
- **Main File**: `app.py`
- **Port**: http://localhost:5000
- **Navigation Pattern**: Beacon Pattern (entity-first, connection-focused)

### **Coastal Explorer** 🧭
*Shallow Water Graph Navigation*
- **Purpose**: Structured, schema-driven exploration
- **Location**: `coastal_explorer/`
- **Main File**: `coastal_explorer.py`
- **Port**: http://localhost:5001
- **Navigation Pattern**: Anchor Pattern (schema-first, structure-focused)

### **Ocean Explorer** 🌊
*Deep Water Graph Navigation*
- **Purpose**: Open-ended, large-scale exploration
- **Location**: `ocean_explorer/`
- **Main File**: `ocean_explorer.py`
- **Port**: http://localhost:5002
- **Navigation Pattern**: Beacon Pattern (entity-first, discovery-focused)

### **Compass** 🧭
*Navigation and Guidance System*
- **Purpose**: Provides navigation and guidance for the Harbor ecosystem
- **Location**: `compass/`
- **Main File**: `compass.py`
- **Navigation Pattern**: Guidance and direction

### **Module Generator a.k.a. Shipwright** ⚙️
*Code Generation and Analysis Framework*
- **Purpose**: Intelligent code generation and pattern recognition
- **Location**: `module-generator/`
- **Components**:
  - `neo4j/` - Neo4j module generation
  - `postgresql/` - PostgreSQL module generation
- **Navigation Pattern**: Code generation and analysis
- **Maritime Metaphor**: Builds vessels (interfaces) that connect different ports (systems)

### **NodePad a.k.a. Star Chart** 📝
*Multidimensional Thought Mapping*
- **Purpose**: Multidimensional thought organization and AI collaboration
- **Features**: 9-dimensional thought mapping (main + 8 colors), persistent save functionality
- **Location**: `/applications/nodepad.html`
- **Maritime Metaphor**: Like a star chart for celestial navigation, NodePad maps thoughts across multiple dimensions

## 🔗 Application Integration

### **Cross-Application Workflows**:
1. **Discovery → Analysis**: Ocean Explorer → Beacon
2. **Structure → Visualization**: Coastal Explorer → Beacon
3. **Guidance → Navigation**: Compass → Any Explorer
4. **Code → Data**: Module Generator → Any Explorer
5. **Visualization → Analysis**: Beacon → Any Explorer

### **Integration Points**:
- Shared database connections (Neo4j)
- Common data formats and protocols
- Consistent navigation patterns (Anchor vs Beacon)
- Unified user experience across applications
- Cross-tool data flow and communication

## 🧭 Navigation Patterns

### **Anchor Pattern** ⚓
*Schema-First Navigation*
- Used by: Coastal Explorer
- Approach: Start with database schema, drill down to instances
- Best for: Structured, familiar data environments

### **Beacon Pattern** 🔦
*Entity-First Navigation*
- Used by: Beacon, Ocean Explorer
- Approach: Start with specific entities, illuminate connections
- Best for: Discovery, unknown data, relationship mapping

## 🚀 Quick Start

### **Start All Applications**:
```bash
# From the harbor root directory
cd applications

# Start Beacon
cd beacon && python app.py &
cd ..

# Start Coastal Explorer
cd coastal_explorer && python coastal_explorer.py &
cd ..

# Start Ocean Explorer
cd ocean_explorer && python ocean_explorer.py &
cd ..

# Start Compass
cd compass && python compass.py &
cd ..
```

### **Access Applications**:
- **Beacon**: http://localhost:5000
- **Coastal Explorer**: http://localhost:5001
- **Ocean Explorer**: http://localhost:5002
- **Compass**: Check compass.py for port configuration

## 🎯 Application Selection Guide

### **For Graph Database Work**:
- Start with **Coastal Explorer** for familiar data
- Use **Ocean Explorer** for discovery
- Visualize with **Beacon**
- Generate code with **Module Generator**

### **For Data Analysis**:
- Begin with structured exploration (**Coastal Explorer**)
- Move to discovery (**Ocean Explorer**)
- Visualize patterns (**Beacon**)
- Get guidance (**Compass**)

### **For Development**:
- Use **Module Generator** for code generation
- Test with sample data
- Navigate with **Compass**
- Integrate with existing tools

## 🔧 Configuration

Each application maintains its own configuration:
- Database connections (Neo4j)
- Port assignments
- Environment variables
- Application-specific settings

See individual application directories for detailed configuration instructions.

## 📊 Application Relationships

```
Compass (Guidance)
    ↓
Coastal Explorer (Structure) ←→ Beacon (Visualization)
    ↓
Ocean Explorer (Discovery) ←→ Beacon (Visualization)
    ↓
Module Generator (Code) ←→ All Applications
```

## 🎯 Mission

The Harbor applications work together to provide a comprehensive data exploration ecosystem that:
- **Adapts to Human Patterns**: Technology that works with natural thinking processes
- **Provides Safe Navigation**: Structured entry points and guided exploration
- **Enables Discovery**: Tools for finding unexpected connections and patterns
- **Supports Innovation**: Code generation and analysis capabilities
- **Maintains Balance**: Cognitive-friendly interfaces and workflows

---

*Each application in the Harbor ecosystem contributes to the overall mission of making powerful data exploration accessible to everyone while preserving human cognitive patterns and fostering innovation.* 