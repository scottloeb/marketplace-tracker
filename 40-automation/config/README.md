# ⚙️ Configuration

Configuration files and processed data exports.

**Contents**: Essential configs (large data moved to 90-archive)  
**Purpose**: Data storage and script configuration  
**Dependencies**: None (static JSON files)

## 📊 Data Optimization
Large marketplace data files moved to `90-archive/marketplace-data/` to optimize Claude's project knowledge:
- **58 progress batch files** → `90-archive/marketplace-data/progress-batches/`
- **3 large export files** → `90-archive/marketplace-data/`
- **Size reduction**: 5.2MB → 44KB (99% smaller)
