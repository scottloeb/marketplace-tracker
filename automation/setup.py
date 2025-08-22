#!/usr/bin/env python3
"""
Setup script for Marketplace Tracker Automation Tools
Installs dependencies and prepares the environment for automated data extraction.
"""

import subprocess
import sys
import os
from pathlib import Path


def run_command(command: str, description: str):
    """Run a shell command with error handling."""
    print(f"🔧 {description}...")
    try:
        result = subprocess.run(command, shell=True, check=True, capture_output=True, text=True)
        print(f"✅ {description} completed successfully")
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"❌ {description} failed: {e.stderr}")
        return None


def setup_environment():
    """Set up the automation environment."""
    print("🏍️ Marketplace Tracker Automation Setup")
    print("="*50)
    
    # Check Python version
    if sys.version_info < (3, 8):
        print("❌ Python 3.8+ required. Current version:", sys.version)
        return False
    
    print(f"✅ Python {sys.version.split()[0]} detected")
    
    # Install requirements
    requirements_path = Path(__file__).parent / "requirements.txt"
    if requirements_path.exists():
        run_command(f"pip install -r {requirements_path}", "Installing Python dependencies")
    else:
        print("⚠️ requirements.txt not found, installing core dependencies...")
        run_command("pip install playwright aiohttp pandas mcp beautifulsoup4 lxml requests python-dotenv", "Installing core dependencies")
    
    # Install Playwright browsers
    run_command("playwright install chromium", "Installing Playwright Chromium browser")
    
    # Create output directory
    output_dir = Path(__file__).parent / "output"
    output_dir.mkdir(exist_ok=True)
    print(f"✅ Created output directory: {output_dir}")
    
    # Create logs directory
    logs_dir = Path(__file__).parent / "logs"
    logs_dir.mkdir(exist_ok=True)
    print(f"✅ Created logs directory: {logs_dir}")
    
    print("\n🎯 SETUP COMPLETE!")
    print("="*50)
    print("Your automation tools are ready to use:")
    print()
    print("📋 QUICK START:")
    print("  1. Get a Facebook Marketplace jet ski search URL")
    print("  2. Run: python browser_scraper.py 'https://facebook.com/marketplace/...'")
    print("  3. Import the generated JSON into your marketplace tracker")
    print()
    print("🔧 AVAILABLE TOOLS:")
    print("  • browser_scraper.py - Standalone browser automation")
    print("  • marketplace_mcp_server.py - Full MCP server integration")
    print("  • web_interface.html - Web-based extraction interface")
    print()
    print("📖 For detailed usage instructions, see automation/README.md")
    
    return True


if __name__ == "__main__":
    success = setup_environment()
    sys.exit(0 if success else 1)