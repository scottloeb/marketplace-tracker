#!/bin/bash
# Repository Cleanup Script - Following CIT and Semantic Numbering

echo "🧹 Starting marketplace-tracker repository cleanup..."

# Step 1: DELETE duplicate and temporary files
echo "🗑️ Removing duplicate and temporary files..."

# Remove duplicate timestamped files (keep only latest)
rm -f enhanced_basic_20250828_223532.json
rm -f enhanced_basic_20250828_223629.json
rm -f ocean_explorer_export_20250828_223532.json
rm -f ocean_explorer_export_20250828_223629.json
rm -f market_analysis_20250828_223532.json
rm -f market_analysis_20250828_223629.json
rm -f google_sheet_import_20250828_124040.json
rm -f pending_enhancement_queue_20250828_124040.json
rm -f pending_enhancement_queue_20250828_205743.json

# Remove processed source file (data preserved in JSON)
rm -f "FB Marketplace Listings 20250828 - Sheet1.csv"

# Remove temporary processing scripts
rm -f complete_google_sheet_importer.py
rm -f google_sheet_importer.py
rm -f manual_sheet_processor.py
rm -f process_complete_csv.py
rm -f fixed_match_listings.py
rm -f create_ocean_explorer_data.py
rm -f match_listings_to_specs.py
rm -f simplified_ocean_data.py
rm -f import_all_181.py
rm -f find_and_process_csv.py

# Remove tiny/empty files
rm -f COMPLETE_import_all_181_listings.json
rm -f sample_export.json
rm -f background_processing.log

# Remove system files
rm -f .DS_Store

# Step 2: MOVE files to proper semantic directories
echo "📂 Moving files to proper semantic directories..."

# Move automation scripts to 40-automation/scripts/
mv enhanced_screenshot_collector.py 40-automation/scripts/
mv mobile_integration.py 40-automation/scripts/
mv advanced_duplicate_manager.py 40-automation/scripts/
mv market_intelligence_engine.py 40-automation/scripts/

# Move data files to 90-archive/current_data/
mkdir -p 90-archive/current_data
mv enhanced_286_complete_20250824_142413.json 90-archive/current_data/
mv complete_csv_import_20250828_222849.json 90-archive/current_data/
mv google_sheet_import_complete_181_listings.json 90-archive/current_data/
mv enhanced_basic_20250828_223837.json 90-archive/current_data/
mv google_sheet_import_20250828_205743.json 90-archive/current_data/
mv ocean_explorer_marketplace_data.json 90-archive/current_data/
mv ocean_explorer_export_20250828_223837.json 90-archive/current_data/
mv market_analysis_20250828_223837.json 90-archive/current_data/
mv complete_181_analysis_20250828_223854.json 90-archive/current_data/

# Move documentation to 30-docs/
mv SUPABASE_SETUP_GUIDE.md 30-docs/
mv REPO_ORGANIZATION.md 30-docs/
mv SEMANTIC_NUMBERING_IMPLEMENTATION.md 30-docs/
mv COMMIT_COMMANDS.md 30-docs/

# Move utility files to 50-scripts/
mv one_click_pipeline.py 50-scripts/
mv setup_automation.sh 50-scripts/
mv setup-commit.sh 50-scripts/
mv daily_update.sh 50-scripts/

# Move config files to appropriate locations
mv database_config.json 10-src/config/
mv requirements.txt 40-automation/
mv import_helper.html 10-src/utils/

# Remove empty js and quick_import directories if empty
rmdir js 2>/dev/null || true
rmdir quick_import 2>/dev/null || true

# Step 3: Update directory READMEs
echo "📝 Updating directory READMEs..."
python3 50-scripts/update-readmes.py

echo "✅ Repository cleanup complete!"
echo ""
echo "📊 Remaining structure:"
find . -name "*.py" -o -name "*.json" -o -name "*.md" | head -20
echo ""
echo "🎯 Clean file organization following semantic numbering:"
echo "  10-src/     → Core application"
echo "  30-docs/    → All documentation" 
echo "  40-automation/ → Python automation tools"
echo "  50-scripts/ → Repository maintenance"
echo "  90-archive/ → Data files"
