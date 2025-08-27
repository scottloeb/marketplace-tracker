// ui-components.js
class UIComponents {
    constructor() {
      this.components = {
        statusDisplay: document.getElementById('statusDisplay'),
        nodeLegend: document.getElementById('nodeLegend'),
        relationshipLegend: document.getElementById('relationshipLegend')
      };
    }
  
    updateStatus(message) {
      this.components.statusDisplay.textContent = message;
      return this;
    }
  
    createLegends(nodeTypes, nodeColors, relationshipTypes, relationshipColors) {
      // Your existing createLegend logic
      // ...
      
      return this;
    }
  }
  
  export default UIComponents;