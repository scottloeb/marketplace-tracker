# 🤖 Claude Project Instructions for Marketplace Tracker

> **📋 Single Source of Truth**: This is THE file to give Claude when starting work on this project.

## 🎯 **Critical: Always Start Here**

When working on this project, **ALWAYS** begin by reading these files in order:

### **1. Context Initialization Template (CIT)**
```
📖 READ FIRST: CITs/SEMANTIC_NUMBERING_COMPLETE_CIT.md
```
This contains the complete current state, recent changes, and resumption instructions.

### **2. Repository Structure Guide**
```
📖 READ SECOND: README.md (root)
```
This shows the semantic numbering system and dynamic folder structure.

### **3. Implementation Documentation**
```
📖 READ THIRD: SEMANTIC_NUMBERING_IMPLEMENTATION.md
```
This explains the numbering convention and management tools.

---

## 🏗️ **Project Architecture Overview**

### **Repository Type**: Web application with automation backend
### **Architecture**: Single-page app with cloud database and real-time sync
### **Dependencies**: Zero in core app (external CDNs only)
### **Deployment**: Vercel-ready with `index.html` in root

### **Semantic Numbering System** 🔢
```
10-src/      → Core application code (zero dependencies)
20-reference/ → Data and specifications  
30-docs/     → Documentation and guides
40-automation/ → Python tools and scripts (large data archived)
50-scripts/  → Repository maintenance tools
60-assets/   → Static files and images
70-guides/   → User workflow instructions
80-harbor/   → Harbor project mirror (read-only reference)
90-archive/  → Large data files (excluded from project knowledge)
```

---

## 📋 **Essential Knowledge Sources**

### **Current State Files** (Read These First)
1. `CITs/SEMANTIC_NUMBERING_COMPLETE_CIT.md` - **Complete project state**
2. `README.md` - **Dynamic folder structure overview**
3. `SEMANTIC_NUMBERING_IMPLEMENTATION.md` - **Implementation details**
4. `30-docs/UNIFIED_IMPLEMENTATION_SUMMARY.md` - **System architecture**
5. `30-docs/SUPABASE_SETUP_GUIDE.md` - **Database configuration**

### **Core Application Files**
1. `index.html` - **Entry point** (Vercel compatible)
2. `10-src/components/app.js` - **Main application logic**
3. `10-src/styles/main.css` - **Consolidated styles**
4. `10-src/utils/database.js` - **Supabase integration**

### **Maintenance Tools**
1. `50-scripts/update-readmes.py` - **README auto-generation**
2. `50-scripts/sync-harbor.py` - **Harbor mirror management**

### **Reference Data**
1. `80-harbor/` - **Complete Harbor project mirror** (read-only)
2. `20-reference/` - **Jet ski specifications and data**
3. `40-automation/enhanced_286_complete_20250824_142413.json` - **Sample data**

---

## ⚡ **Quick Start Commands**

### **Verify Repository State**
```bash
# Check folder structure
ls -la  # Should show numbered folders

# Validate README system
python3 50-scripts/update-readmes.py

# Check Harbor mirror status
ls -la 80-harbor/
cat 80-harbor/harbor-git-info.json
```

### **Test Application**
```bash
# Start development server
python3 -m http.server 8080

# Test URL: http://localhost:8080
# Should load unified marketplace tracker
```

### **Update Harbor Reference**
```bash
# One-way sync: Harbor → marketplace-tracker/80-harbor
python3 50-scripts/sync-harbor.py
```

---

## 🎯 **Development Guidelines**

### **File Organization Rules**
1. **Core app files**: Always in `10-src/`
2. **New documentation**: Always in `30-docs/`
3. **New automation**: Always in `40-automation/`
4. **Maintenance scripts**: Always in `50-scripts/`
5. **Never modify**: `80-harbor/` (read-only Harbor mirror)

### **Dependencies Policy**
- **Core application** (`10-src/`): **ZERO dependencies**
- **External libraries**: Use CDN links only (Supabase, Chart.js, D3.js)
- **Python scripts**: Minimal dependencies (standard library preferred)
- **Harbor reference**: Static files only (no modifications)

### **README Management**
- **All folder READMEs**: Must be ≤50 words
- **Auto-generation**: Run `python3 50-scripts/update-readmes.py` after changes
- **Dynamic linking**: Main README auto-updates from folder structure

---

## 🚨 **Critical Project Context**

### **Harbor Integration Approach**
- **Status**: Complete repository mirror in `80-harbor/`
- **Sync Type**: One-way only (Harbor → marketplace-tracker)
- **Purpose**: Reference for Ocean Explorer components
- **Rule**: NEVER modify Harbor files, only read/reference them

### **📂 When to Use Which Harbor Location**
```
Use Local Mirror (80-harbor/):
✅ For normal development and reference
✅ When working within marketplace-tracker context
✅ For automated scripts and builds

Use Absolute Paths (/Users/scottloeb/Documents/NeurOasis/GitHub/harbor/):
✅ When Claude needs fresh/current Harbor files
✅ When project knowledge is overloaded
✅ For debugging Harbor integration issues
✅ When mirror sync is behind
```

### **📦 Archive Directory (90-archive/)**
```
Large Data Storage (excluded from project knowledge):
📊 Marketplace Data: /Users/scottloeb/Documents/NeurOasis/GitHub/marketplace-tracker/90-archive/marketplace-data/
- 58 progress batch files (progress_batch_1.json through progress_batch_58.json)
- Enhanced complete dataset (enhanced_286_complete_20250824_142413.json)
- Complete and full export files

🎯 Performance Optimization:
- Reduced 40-automation/config from 5.2MB to 44KB (99% reduction)
- Prevents Claude project knowledge bloat
- Access via absolute paths when needed
```

### **Supabase Database**
- **Status**: Configured and integrated
- **Purpose**: Real-time sync between mobile and desktop
- **Tables**: `listings`, `price_history`, `enhancement_queue`
- **Setup**: See `30-docs/SUPABASE_SETUP_GUIDE.md`

### **Ocean Explorer Integration**
- **Status**: Merged into unified `index.html`
- **Source**: Harbor toolshed components (in `80-harbor/toolshed/`)
- **Purpose**: Data visualization and marketplace analysis

### **Marketplace Tracker Features**
- **Mobile capture**: Add listings via URL
- **Price tracking**: Manual updates trigger price history
- **Market analysis**: BUY/CONSIDER/PASS recommendations
- **Real-time sync**: Cross-device data synchronization

---

## 🔍 **When Project Knowledge Is Overloaded**

### **🚨 Critical: Local File Paths for Claude**
```
🏠 ABSOLUTE PATHS (Harbor files too large for project knowledge):

Primary Repositories:
- Harbor Repository: /Users/scottloeb/Documents/NeurOasis/GitHub/harbor/
- Marketplace Tracker: /Users/scottloeb/Documents/NeurOasis/GitHub/marketplace-tracker/

Key Harbor Files for Reference:
- Ocean Explorer: /Users/scottloeb/Documents/NeurOasis/GitHub/harbor/applications/ocean_explorer/
- Toolshed Components: /Users/scottloeb/Documents/NeurOasis/GitHub/harbor/toolshed/
- Sample Data: /Users/scottloeb/Documents/NeurOasis/GitHub/harbor/neo4j-sample-data/

Marketplace Mirror (Local Copy):
- Local Harbor Mirror: /Users/scottloeb/Documents/NeurOasis/GitHub/marketplace-tracker/80-harbor/
```

### **Step 1: Reset Context with Local Files**
```
🔄 ALWAYS start by reading these local files:
1. CITs/SEMANTIC_NUMBERING_COMPLETE_CIT.md
2. README.md
3. SEMANTIC_NUMBERING_IMPLEMENTATION.md
```

### **Step 2: Check Current Implementation**
```
📁 Examine these key files:
1. index.html (application entry point)
2. 10-src/components/app.js (main logic)
3. 30-docs/UNIFIED_IMPLEMENTATION_SUMMARY.md (architecture)
```

### **Step 3: Verify System State**
```bash
# Run validation commands:
python3 50-scripts/update-readmes.py
ls -la 80-harbor/harbor-git-info.json
```

### **Step 4: Reference Architecture Documents**
```
📖 Deep dive into these files:
1. 30-docs/SUPABASE_SETUP_GUIDE.md (database)
2. 80-harbor/toolshed/ (Ocean Explorer components)
3. 40-automation/ (data processing scripts)
```

---

## 🎯 **Common Development Tasks**

### **Adding New Features**
1. **Read CIT** to understand current state
2. **Edit files** in appropriate numbered folders
3. **Update READMEs** if needed (auto-generated)
4. **Test locally** with development server
5. **Commit changes** with descriptive messages

### **Database Changes**
1. **Reference**: `30-docs/SUPABASE_SETUP_GUIDE.md`
2. **Test connection**: Check `10-src/utils/database.js`
3. **Verify schema**: Ensure tables match current structure

### **Harbor Updates**
1. **Never modify** `80-harbor/` files directly
2. **Sync updates**: Run `python3 50-scripts/sync-harbor.py`
3. **Reference components**: Use files in `80-harbor/toolshed/`

### **Documentation Updates**
1. **Folder READMEs**: Keep ≤50 words
2. **Main README**: Auto-generated (don't edit manually)
3. **New docs**: Add to `30-docs/`
4. **Regenerate**: Run `python3 50-scripts/update-readmes.py`

---

## 🚀 **Deployment Information**

### **Vercel Configuration**
- **Entry point**: `index.html` (root level)
- **Build process**: None (zero build step)
- **Dependencies**: External CDNs only
- **Environment**: Supabase keys needed

### **Local Development**
```bash
# Simple HTTP server
python3 -m http.server 8080

# Test URL
http://localhost:8080
```

### **Production URLs**
- **Frontend**: Deployed via Vercel
- **Database**: Supabase cloud
- **Analytics**: Integrated Ocean Explorer

---

## ⚠️ **Important Constraints**

### **What NOT to Do**
- ❌ Don't modify files in `80-harbor/` (Harbor mirror is read-only)
- ❌ Don't add dependencies to `10-src/` (zero dependency rule)
- ❌ Don't manually edit main `README.md` (auto-generated)
- ❌ Don't create folder READMEs >50 words

### **What TO Do**
- ✅ Always read CIT before starting work
- ✅ Use semantic numbering for new folders
- ✅ Maintain zero dependencies in core app
- ✅ Run README validation after changes
- ✅ Reference Harbor components (don't copy)
- ✅ Test with local development server

---

## 🎯 **Success Metrics**

### **System Health Checks**
```bash
# All should pass:
python3 50-scripts/update-readmes.py  # All READMEs validated
python3 -m http.server 8080           # App loads successfully
ls -la 80-harbor/harbor-git-info.json # Harbor mirror current
```

### **Architecture Compliance**
- ✅ Core app has zero dependencies
- ✅ All folders follow semantic numbering
- ✅ Harbor reference is complete and current
- ✅ READMEs are ≤50 words and auto-linked
- ✅ Supabase integration works for real-time sync

---

## 📞 **When You Need Help**

### **Debugging Steps**
1. **Check CIT**: `CITs/SEMANTIC_NUMBERING_COMPLETE_CIT.md`
2. **Verify structure**: Ensure numbered folders exist
3. **Test scripts**: Run maintenance tools
4. **Check logs**: Look for error messages
5. **Reference docs**: Use `30-docs/` folder

### **Key Questions to Ask**
- "What does the current CIT say about this feature?"
- "Are all READMEs under 50 words?"
- "Is the Harbor mirror current?"
- "Does the app load without dependencies?"
- "Are file paths using numbered folders?"

---

**🎯 Remember: This project uses semantic numbering, zero dependencies, and one-way Harbor mirroring. Always start with the CIT!** 🚀
