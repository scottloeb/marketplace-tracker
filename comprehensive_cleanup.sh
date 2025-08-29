#!/bin/bash

# Comprehensive Marketplace Tracker Cleanup
echo "🧹 Starting comprehensive cleanup..."

# Create proper directory structure
mkdir -p 10-src/{components,styles,utils,config}
mkdir -p 20-reference/{specs,market-data}
mkdir -p 30-docs/{api,guides}
mkdir -p 40-automation/{scripts,data}
mkdir -p 50-scripts
mkdir -p 60-assets/{images,icons}
mkdir -p 90-archive/{current-data,processed-data}

# Move automation scripts to proper locations
echo "📁 Organizing automation files..."
if [ -f "enhanced_screenshot_collector.py" ]; then
    mv enhanced_screenshot_collector.py 40-automation/scripts/
fi
if [ -f "quick_market_analysis.py" ]; then
    mv quick_market_analysis.py 40-automation/scripts/
fi
if [ -f "filtered_market_analysis.py" ]; then
    mv filtered_market_analysis.py 40-automation/scripts/
fi
if [ -f "mobile_integration_server.py" ]; then
    mv mobile_integration_server.py 40-automation/scripts/
fi

# Move data files to archive
echo "📊 Organizing data files..."
mv *_20250829_*.json 90-archive/current-data/ 2>/dev/null
mv *_20250828_*.json 90-archive/processed-data/ 2>/dev/null

# Remove temporary/duplicate files
echo "🗑️ Removing temporary files..."
rm -f *.log
rm -f temp_*.py
rm -f test_*.py
rm -f *_backup.*
rm -f .DS_Store

# Move any remaining Python scripts to scripts directory
echo "🐍 Organizing Python scripts..."
for script in *.py; do
    if [[ "$script" != "index.py" ]] && [[ "$script" != "app.py" ]] && [[ -f "$script" ]]; then
        mv "$script" 50-scripts/
    fi
done

# Create lean README structure
echo "📝 Updating README structure..."
if [ -f "50-scripts/update-readmes.py" ]; then
    python3 50-scripts/update-readmes.py
fi

echo "✅ Cleanup complete!"
echo "📊 Repository is now lean and organized"
