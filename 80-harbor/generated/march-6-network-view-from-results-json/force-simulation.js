/**
 * force-simulation.js - v0.2
 * Force-directed physics simulation for graph layout
 */

class ForceSimulation {
  constructor(config = {}) {
    // Default configuration with improved parameters
    this.config = {
      k: config.k || 0.02,             // Spring constant (reduced from 0.05)
      repulsion: config.repulsion || 1500, // Repulsion force (increased from 500)
      damping: config.damping || 0.85,     // Damping factor (reduced from 0.95)
      centerForce: config.centerForce || 0.005, // Center gravity (reduced from 0.01)
      simulationSteps: config.simulationSteps || 800, // Increased from 300
      ...config
    };
    
    // Use underscore prefix for private backing fields
    this._nodes = [];
    this._links = [];
    this.width = 0;
    this.height = 0;
    
    console.log("ForceSimulation created with config:", this.config);
  }

  // Public getter for nodes - THIS IS THE KEY FIX
  get nodes() {
    return this._nodes;
  }

  // Public getter for links - THIS IS THE KEY FIX
  get links() {
    return this._links;
  }

  initialize(graphData, width, height) {
    this.width = width;
    this.height = height;
    
    console.log("Initializing simulation with data:", 
                graphData.nodes.length, "nodes,", 
                graphData.relationships.length, "relationships");
    
    // Create nodes with position and velocity
    this._nodes = graphData.nodes.map(node => ({
      ...node,
      x: Math.random() * width,
      y: Math.random() * height,
      vx: 0,
      vy: 0
    }));
    
    // Create links with references to the actual node objects
    this._links = graphData.relationships.map(rel => {
      const source = this._nodes.find(n => n.id === rel.source);
      const target = this._nodes.find(n => n.id === rel.target);
      if (source && target) {
        return { ...rel, source, target };
      }
      return null;
    }).filter(link => link !== null);
    
    console.log("Simulation initialized with", 
                this._nodes.length, "nodes and", 
                this._links.length, "links");
    
    return this;
  }

  runSimulation(progressCallback = null) {
    console.log("Running simulation for", this.config.simulationSteps, "steps");
    
    // Run the simulation for the specified number of steps
    for (let i = 0; i < this.config.simulationSteps; i++) {
      if (progressCallback && i % 30 === 0) {
        progressCallback(Math.round(i/this.config.simulationSteps*100));
      }
      this.tick();
    }
    
    console.log("Simulation complete with", this._nodes.length, "nodes positioned");
    return this;
  }

  tick() {
    // Constants for forces already set in config
    const { k, repulsion, damping, centerForce } = this.config;
    
    // Apply forces
    
    // 1. Apply repulsive forces between all nodes
    for (let i = 0; i < this._nodes.length; i++) {
      const node1 = this._nodes[i];
      
      for (let j = i + 1; j < this._nodes.length; j++) {
        const node2 = this._nodes[j];
        
        // Calculate distance and direction
        const dx = node2.x - node1.x;
        const dy = node2.y - node1.y;
        const distance = Math.sqrt(dx * dx + dy * dy) || 1; // Avoid division by zero
        
        // Calculate repulsive force (inverse square law)
        const force = repulsion / (distance * distance);
        
        // Apply force to both nodes in opposite directions
        const forceX = (dx / distance) * force;
        const forceY = (dy / distance) * force;
        
        node1.vx -= forceX;
        node1.vy -= forceY;
        node2.vx += forceX;
        node2.vy += forceY;
      }
    }
    
    // 2. Apply attractive forces along links
    for (const link of this._links) {
      const dx = link.target.x - link.source.x;
      const dy = link.target.y - link.source.y;
      const distance = Math.sqrt(dx * dx + dy * dy) || 1;
      
      // Calculate attractive force (Hooke's law: F = -kx)
      const force = k * distance;
      
      // Apply force to both nodes
      const forceX = (dx / distance) * force;
      const forceY = (dy / distance) * force;
      
      link.source.vx += forceX;
      link.source.vy += forceY;
      link.target.vx -= forceX;
      link.target.vy -= forceY;
    }
    
    // 3. Apply force toward center to prevent nodes from drifting too far
    for (const node of this._nodes) {
      // Vector from node to center
      const dx = this.width/2 - node.x;
      const dy = this.height/2 - node.y;
      
      // Apply gentle force toward center
      node.vx += dx * centerForce;
      node.vy += dy * centerForce;
    }
    
    // Update positions based on velocities
    for (const node of this._nodes) {
      node.x += node.vx;
      node.y += node.vy;
      
      // Apply damping to the velocity
      node.vx *= damping;
      node.vy *= damping;
    }
    
    return this;
  }

  scaleToFit(width, height, padding) {
    if (this._nodes.length === 0) {
      console.warn("Cannot scale - no nodes to fit");
      return this;
    }
    
    console.log("Scaling layout to fit canvas:", width, "×", height);
    
    // Find the bounding box of the layout
    let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;
    
    for (const node of this._nodes) {
      minX = Math.min(minX, node.x);
      minY = Math.min(minY, node.y);
      maxX = Math.max(maxX, node.x);
      maxY = Math.max(maxY, node.y);
    }
    
    // Calculate scale and translation
    const currentWidth = maxX - minX;
    const currentHeight = maxY - minY;
    
    if (currentWidth === 0 || currentHeight === 0) {
      console.warn("Cannot scale - layout has zero width or height");
      return this;
    }
    
    const scaleX = (width - 2 * padding) / currentWidth;
    const scaleY = (height - 2 * padding) / currentHeight;
    const scale = Math.min(scaleX, scaleY);
    
    console.log("Scaling with factor:", scale);
    
    // Apply scale and translation to center the layout
    for (const node of this._nodes) {
      node.x = padding + (node.x - minX) * scale;
      node.y = padding + (node.y - minY) * scale;
    }
    
    return this;
  }
}

// Export the ForceSimulation class
export default ForceSimulation;