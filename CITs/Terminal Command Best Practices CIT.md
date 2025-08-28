# Terminal Command Best Practices CIT
**Created:** August 27, 2025  
**Issue:** Claude commands with # comments break zsh shell

## Critical Discovery
Your `unified-marketplace-tracker.html` (33,433 bytes) is a COMPLETE working application with:
- Embedded JavaScript starting at line 533
- Supabase, Chart.js, D3.js integration  
- Full marketplace functionality

## Immediate Solution
Replace your basic index.html with the working unified tracker:

```bash
cp 10-src/components/unified-marketplace-tracker.html index.html
python3 -m http.server 8080