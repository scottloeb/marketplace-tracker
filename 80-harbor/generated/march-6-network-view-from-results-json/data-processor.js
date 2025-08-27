/**
 * data-processor.js - v0.1
 * Graph data processing module
 * Transforms raw Neo4j records into structured graph data
 */

class GraphDataProcessor {
    constructor() {
      this.nodes = new Map();
      this.relationships = [];
      this.nodeTypes = new Map();
      this.relationshipTypes = new Map();
    }
  
    processRecords(records) {
      // Process each record
      records.forEach(record => {
        // Extract nodes from both 'n' and 'm' fields
        if (record.n && record.n.identity !== undefined) {
          if (!this.nodes.has(record.n.identity)) {
            this.nodes.set(record.n.identity, {
              id: record.n.identity,
              labels: record.n.labels || [],
              properties: record.n.properties || {}
            });
            
            // Count node types
            const primaryLabel = record.n.labels[0] || 'Unknown';
            this.nodeTypes.set(primaryLabel, (this.nodeTypes.get(primaryLabel) || 0) + 1);
          }
        }
        
        if (record.m && record.m.identity !== undefined) {
          if (!this.nodes.has(record.m.identity)) {
            this.nodes.set(record.m.identity, {
              id: record.m.identity,
              labels: record.m.labels || [],
              properties: record.m.properties || {}
            });
            
            // Count node types
            const primaryLabel = record.m.labels[0] || 'Unknown';
            this.nodeTypes.set(primaryLabel, (this.nodeTypes.get(primaryLabel) || 0) + 1);
          }
        }
        
        // Extract relationship
        if (record.r && record.r.start !== undefined && record.r.end !== undefined) {
          this.relationships.push({
            id: record.r.identity,
            source: record.r.start,
            target: record.r.end,
            type: record.r.type,
            properties: record.r.properties || {}
          });
          
          // Count relationship types
          this.relationshipTypes.set(record.r.type, (this.relationshipTypes.get(record.r.type) || 0) + 1);
        }
      });
      
      return {
        nodes: Array.from(this.nodes.values()),
        relationships: this.relationships,
        nodeTypes: this.nodeTypes,
        relationshipTypes: this.relationshipTypes
      };
    }
  }
  
  // This is the critical line that was likely missing
  export default GraphDataProcessor;