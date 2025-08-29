# 🌊 Unified Marketplace Tracker

A responsive web application for capturing, analyzing, and tracking marketplace listings across all devices with real-time cloud synchronization.

## 📁 **Repository Structure**

Folders use semantic numbering for logical organization:
- **10-19**: Core application code
- **20-29**: Data and content  
- **30-39**: Documentation
- **40-49**: Tools and automation
- **50-59**: Scripts and utilities
- **60-69**: Static assets
- **70-79**: User guides
- **80-89**: External references

<!--FOLDER_STRUCTURE_START-->
| Folder | Purpose | Dependencies |
|--------|---------|--------------|
| [`10-src/`](10-src/README.md) | Zero-dependency application code using semantic numbering system. Components, utilities, and styles. | None |
| [`20-reference/`](20-reference/README.md) | Jet ski specifications and reference information for data enhancement. | None (static CSV files) |
| [`30-docs/`](30-docs/README.md) | Setup guides, implementation docs, and workflow instructions. | None (markdown files) |
| [`40-automation/`](40-automation/README.md) | Backend automation scripts and data processing tools. | Python 3.x |
| [`50-scripts/`](50-scripts/README.md) | Automation scripts for repository maintenance and README management. | Python 3.x |
| [`60-assets/`](60-assets/README.md) | Images, icons, and other static files for the application. | None (static files) |
| [`70-guides/`](70-guides/README.md) | Step-by-step workflow guides and user instructions. | None (markdown files) |
| [`80-harbor/`](80-harbor/README.md) | Complete Harbor repository mirror for Ocean Explorer components. Synced one-way from main Harbor repo. | None (reference) |
<!--FOLDER_STRUCTURE_END-->

## 🎯 **Quick Start**

1. **Setup Supabase**: Follow [`docs/SUPABASE_SETUP_GUIDE.md`](docs/SUPABASE_SETUP_GUIDE.md)
2. **Configure**: Update credentials in `src/utils/database.js`
3. **Deploy**: Upload to Vercel/GitHub Pages or run locally
4. **Use**: Access via mobile/desktop for real-time tracking

## 🚀 **Features**

- **📱 Mobile capture** with URL-only entry
- **📊 Advanced analytics** with interactive charts  
- **🔥 Deal detection** with urgency scoring
- **☁️ Real-time sync** across all devices
- **🤖 Automated enhancement** of listing data

## 🌐 **Deployment**

- **Entry Point**: `index.html` (Vercel/GitHub Pages ready)
- **Dependencies**: None (uses CDNs for external libraries)
- **Requirements**: Modern web browser, internet connection

---
*Last updated: Auto-generated from folder structure*
