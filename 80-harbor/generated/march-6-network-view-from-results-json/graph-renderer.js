/**
 * graph-renderer.js - v0.1
 * Graph visualization rendering module
 * Handles drawing nodes and relationships on the canvas
 */

class GraphRenderer {
  constructor(canvas, colorConfig = {}) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.width = canvas.width;
    this.height = canvas.height;
    this.nodeColors = new Map();
    this.relationshipColors = new Map();
    this.colorConfig = colorConfig;
    
    console.log("GraphRenderer initialized with canvas:", 
                canvas.width + "×" + canvas.height);
  }

  assignColors(nodeTypes, relationshipTypes) {
    // Sort types by frequency to assign colors to most common types first
    const nodeTypesSorted = [...nodeTypes.entries()]
        .sort((a, b) => b[1] - a[1])
        .map(entry => entry[0]);
        
    const relationshipTypesSorted = [...relationshipTypes.entries()]
        .sort((a, b) => b[1] - a[1])
        .map(entry => entry[0]);
    
    // Assign colors to node types
    const nodePalette = [
        '#3498db', // Blue
        '#e74c3c', // Red
        '#2ecc71', // Green
        '#f39c12', // Orange
        '#9b59b6', // Purple
        '#1abc9c', // Turquoise
        '#d35400', // Pumpkin
        '#34495e', // Dark Blue Gray
        '#16a085', // Green Sea
        '#c0392b', // Pomegranate
        '#8e44ad', // Wisteria
        '#27ae60'  // Nephritis
    ];
    
    nodeTypesSorted.forEach((type, index) => {
        this.nodeColors.set(type, nodePalette[index % nodePalette.length]);
    });
    
    // Assign colors to relationship types
    const relationshipPalette = [
        '#e74c3c', // Red
        '#3498db', // Blue
        '#2ecc71', // Green
        '#f39c12', // Orange
        '#9b59b6', // Purple
        '#e67e22', // Carrot
        '#16a085', // Green Sea
        '#d35400', // Pumpkin
        '#8e44ad', // Wisteria
        '#2c3e50', // Midnight Blue
        '#c0392b', // Pomegranate
        '#27ae60', // Nephritis
        '#7f8c8d', // Asbestos
        '#2980b9', // Belize Hole
        '#f1c40f'  // Beacon
    ];
    
    relationshipTypesSorted.forEach((type, index) => {
        this.relationshipColors.set(type, relationshipPalette[index % relationshipPalette.length]);
    });
    
    console.log("Colors assigned:", 
                this.nodeColors.size, "node types,", 
                this.relationshipColors.size, "relationship types");
    
    return this;
  }

  render(simulation) {
    console.log("Starting rendering with", 
                simulation.nodes.length, "nodes and", 
                simulation.links.length, "links");
    
    // Test drawing to verify canvas is working
    this.ctx.fillStyle = 'red';
    this.ctx.fillRect(10, 10, 100, 100);
    console.log("Test rectangle drawn");
    
    // Clear canvas
    this.ctx.fillStyle = '#FFFFFF';
    this.ctx.fillRect(0, 0, this.width, this.height);
    
    // Draw relationships
    this.ctx.globalAlpha = 0.7;
    for (const link of simulation.links) {
        const color = this.relationshipColors.get(link.type) || '#999999';
        
        // Get strength factor from relationship properties if available
        let strength = 1;
        if (link.properties.association_strength) {
            strength = link.properties.association_strength;
        } else if (link.properties.dissonance_level) {
            strength = link.properties.dissonance_level;
        } else if (link.properties.strength) {
            strength = link.properties.strength;
        } else if (link.properties.reliability) {
            strength = link.properties.reliability;
        }
        
        // Draw the link
        this.ctx.beginPath();
        this.ctx.moveTo(link.source.x, link.source.y);
        this.ctx.lineTo(link.target.x, link.target.y);
        this.ctx.strokeStyle = color;
        this.ctx.lineWidth = 1 + strength * 3; // Scale line width based on strength
        this.ctx.stroke();
        
        // Draw arrow for relationship direction
        this.drawArrow(link.source.x, link.source.y, link.target.x, link.target.y, color);
    }
    
    // Draw nodes
    this.ctx.globalAlpha = 1.0;
    for (const node of simulation.nodes) {
        // Determine node color based on its first label
        const label = node.labels[0] || 'Unknown';
        const color = this.nodeColors.get(label) || '#CCCCCC';
        
        // Determine node size based on properties
        let size = 5; // Default size
        if (node.properties.importance) {
            size += node.properties.importance * 10;
        } else if (node.properties.encoding_strength) {
            size += (node.properties.encoding_strength === 'High' ? 8 : 
                     node.properties.encoding_strength === 'Medium' ? 5 : 2);
        }
        
        // Draw the node
        this.ctx.beginPath();
        this.ctx.arc(node.x, node.y, size, 0, Math.PI * 2);
        this.ctx.fillStyle = color;
        this.ctx.fill();
        this.ctx.strokeStyle = '#FFFFFF';
        this.ctx.lineWidth = 1.5;
        this.ctx.stroke();
        
        // Draw a shadow for better visibility
        this.ctx.shadowColor = 'rgba(0, 0, 0, 0.2)';
        this.ctx.shadowBlur = 4;
        this.ctx.shadowOffsetX = 0;
        this.ctx.shadowOffsetY = 2;
    }
    
    // Reset shadow
    this.ctx.shadowColor = 'transparent';
    this.ctx.shadowBlur = 0;
    this.ctx.shadowOffsetX = 0;
    this.ctx.shadowOffsetY = 0;
    
    console.log("Rendering complete");
    
    return this;
  }

  drawArrow(fromX, fromY, toX, toY, color) {
    const headLength = 10; // Length of arrow head
    const headWidth = 6;   // Width of arrow head
    
    // Calculate angle of the line
    const angle = Math.atan2(toY - fromY, toX - fromX);
    
    // Calculate the endpoint of the line (before the arrowhead)
    // We pull it back a bit to avoid overlapping with the target node
    const nodeOffset = 12; // Adjust based on target node size
    const lineEndX = toX - Math.cos(angle) * nodeOffset;
    const lineEndY = toY - Math.sin(angle) * nodeOffset;
    
    // Calculate the points for the arrowhead
    const arrowPoint1X = lineEndX - headLength * Math.cos(angle - Math.PI/6);
    const arrowPoint1Y = lineEndY - headLength * Math.sin(angle - Math.PI/6);
    const arrowPoint2X = lineEndX - headLength * Math.cos(angle + Math.PI/6);
    const arrowPoint2Y = lineEndY - headLength * Math.sin(angle + Math.PI/6);
    
    // Draw the arrowhead
    this.ctx.beginPath();
    this.ctx.moveTo(lineEndX, lineEndY);
    this.ctx.lineTo(arrowPoint1X, arrowPoint1Y);
    this.ctx.lineTo(arrowPoint2X, arrowPoint2Y);
    this.ctx.closePath();
    this.ctx.fillStyle = color;
    this.ctx.fill();
  }
}

// Export the GraphRenderer class
export default GraphRenderer;