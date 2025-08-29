#!/bin/bash
# Daily Marketplace Update Script
# Generated: 2025-08-28T22:38:37.211838

echo "🚀 Starting daily marketplace update..."

# Navigate to marketplace tracker directory
cd "$(dirname "$0")"

# Run the pipeline
python3 one_click_pipeline.py

# Optional: Commit results to git
# git add -A
# git commit -m "Daily marketplace update $(date +%Y%m%d_%H%M%S)"

echo "✅ Daily update complete!"
