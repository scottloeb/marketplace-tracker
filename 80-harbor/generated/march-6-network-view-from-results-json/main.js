// main.js
import GraphDataProcessor from './data-processor.js';
import ForceSimulation from './force-simulation.js';
import GraphRenderer from './graph-renderer.js';
import UIComponents from './ui-components.js';

// Main application class
class GraphVisualization {
  constructor() {
    this.canvas = document.getElementById('graphCanvas');
    this.ui = new UIComponents();
    this.dataProcessor = new GraphDataProcessor();
    this.simulation = null;
    this.renderer = new GraphRenderer(this.canvas);
  }

  async initialize() {
    try {
      console.log("App initialization started");
      // Load and process data
      this.ui.updateStatus("Loading data...");
      const response = await fetch('records.json');
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const records = await response.json();
      console.log("Data loaded:", records.length, "records");
      
      this.ui.updateStatus("Processing data...");
      const graphData = this.dataProcessor.processRecords(records);
      console.log("Processed graph data:", graphData);
      
      // Set up simulation
      this.ui.updateStatus("Creating visualization...");
      this.simulation = new ForceSimulation()
        .initialize(graphData, this.canvas.width, this.canvas.height);

      console.log("Starting simulation", graphData.nodes.length, "nodes");
      
      // Run simulation with progress updates
      this.simulation.runSimulation(progress => {
        this.ui.updateStatus(`Calculating layout... ${progress}%`);
      });

      console.log("Simulation complete", this.simulation.nodes.length, "nodes positioned");
      
      // Scale to fit canvas
      this.simulation.scaleToFit(this.canvas.width, this.canvas.height, 40);
      
      // Assign colors
      this.renderer.assignColors(
        graphData.nodeTypes, 
        graphData.relationshipTypes
      );
      
      // Render the visualization
      this.ui.updateStatus("Rendering graph...");
      this.renderer.render(this.simulation);
      
      // Create legends
      this.ui.createLegends(
        graphData.nodeTypes,
        this.renderer.nodeColors,
        graphData.relationshipTypes,
        this.renderer.relationshipColors
      );
      
      this.ui.updateStatus("");
    } catch (error) {
      console.error('Error:', error);
      this.ui.updateStatus(`Error: ${error.message}`);
    }
  }
}

// Initialize the application when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  const app = new GraphVisualization();
  app.initialize();
});