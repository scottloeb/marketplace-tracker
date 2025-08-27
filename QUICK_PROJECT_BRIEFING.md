# 🚀 Quick Project Briefing for Claude/Cursor

## **CRITICAL: Read Local Files First**

Before doing ANYTHING, read these files in this exact order:

1. **`CITs/SEMANTIC_NUMBERING_COMPLETE_CIT.md`** ← Complete current state
2. **`README.md`** ← Repository structure overview  
3. **`SEMANTIC_NUMBERING_IMPLEMENTATION.md`** ← Implementation details

## **Project Type**
Unified Marketplace Tracker - Single-page web app with automation backend

## **Key Architecture Points**
- ✅ **Semantic numbering system**: `10-src/`, `20-reference/`, `30-docs/`, etc.
- ✅ **Zero dependencies** in core app (`10-src/`)
- ✅ **Harbor mirror**: Complete read-only copy in `80-harbor/`
- ✅ **Supabase backend**: Real-time sync between mobile/desktop
- ✅ **Ocean Explorer**: Integrated analytics from Harbor components

## **Essential Files**
- `index.html` ← Entry point (Vercel compatible)
- `10-src/components/app.js` ← Main application logic
- `10-src/utils/database.js` ← Supabase integration
- `50-scripts/update-readmes.py` ← README auto-generation
- `50-scripts/sync-harbor.py` ← Harbor mirror tool

## **Development Rules**
1. **Always check CIT first** for current state
2. **Never modify** `80-harbor/` (read-only Harbor reference)
3. **Keep core app** dependency-free (CDNs only)
4. **Folder READMEs** must be ≤50 words
5. **Use numbered folders** for organization

## **Quick Validation**
```bash
python3 50-scripts/update-readmes.py  # Should validate all READMEs
python3 -m http.server 8080           # App should load at localhost:8080
ls -la 80-harbor/harbor-git-info.json # Harbor mirror should exist
```

## **If Context Overloaded**
Read the local files listed above. They contain the complete project state and implementation details.

---
**🎯 This project is ready for continued development with semantic numbering and full Harbor integration!**
