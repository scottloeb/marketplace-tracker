#!/bin/bash
# Setup script for marketplace tracker automation

echo "🚀 Setting up Marketplace Tracker automation..."

# Install Python dependencies
echo "📦 Installing Python packages..."
pip3 install playwright

# Install Playwright browsers
echo "🌐 Installing Playwright browsers..."
playwright install chromium

# Make scripts executable
chmod +x one_click_pipeline.py
chmod +x 40-automation/screenshot_collector.py

echo "✅ Setup complete!"
echo ""
echo "🎯 Available Commands:"
echo "1. Take screenshots:     python3 40-automation/screenshot_collector.py"
echo "2. Run full pipeline:    python3 one_click_pipeline.py"
echo "3. Daily auto-update:    ./daily_update.sh"
