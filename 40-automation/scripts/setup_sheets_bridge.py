#!/usr/bin/env python3
"""
Setup script for Google Sheets Bridge
Installs dependencies and creates configuration files.
"""

import json
import subprocess
import sys
from pathlib import Path

def install_requirements():
    """Install required Python packages."""
    packages = [
        'gspread',
        'google-auth',
        'google-auth-oauthlib',
        'google-auth-httplib2'
    ]
    
    print("📦 Installing Google Sheets integration packages...")
    for package in packages:
        try:
            subprocess.run([sys.executable, '-m', 'pip', 'install', package], check=True)
            print(f"✅ Installed {package}")
        except subprocess.CalledProcessError:
            print(f"❌ Failed to install {package}")
            return False
    
    return True

def create_config():
    """Create default configuration file."""
    config = {
        "google_sheets": {
            "sheet_id": "1_d4d01IACg0kSDzsAaCWUFiTEgkMjOPsii_GOSGgsv0",
            "credentials_file": None,
            "status_column": 7,
            "error_column": 8
        },
        "processing": {
            "max_listings_per_run": 50,
            "enable_enhancement": True,
            "enable_database": True,
            "delay_between_listings": 2
        },
        "automation": {
            "continuous_mode": False,
            "check_interval_seconds": 300,
            "auto_export": True,
            "notification_webhook": None
        }
    }
    
    config_file = Path("../config/sheets_bridge_config.json")
    config_file.parent.mkdir(exist_ok=True)
    
    with open(config_file, 'w') as f:
        json.dump(config, f, indent=2)
    
    print(f"📋 Created configuration file: {config_file}")
    return str(config_file)

def main():
    """Main setup process."""
    print("🔧 Setting up Google Sheets Bridge...")
    
    # Install dependencies
    if not install_requirements():
        print("❌ Failed to install dependencies")
        return False
    
    # Create configuration
    config_file = create_config()
    
    print(f"""
✅ Setup complete!

Next steps:
1. Edit the configuration file: {config_file}
2. Set up Google Sheets authentication (see instructions below)
3. Run the bridge script

Google Sheets Authentication:
Option 1 (Simple): Use default Google credentials
   - Run: gcloud auth application-default login
   
Option 2 (Service Account): Create service account
   - Go to Google Cloud Console
   - Create service account and download JSON key
   - Update config with key file path

Test the bridge:
   cd /Users/scottloeb/Desktop/marketplace-tracker/40-automation/scripts
   python google_sheets_bridge.py --sheet-id 1_d4d01IACg0kSDzsAaCWUFiTEgkMjOPsii_GOSGgsv0

Run continuously:
   python google_sheets_bridge.py --sheet-id 1_d4d01IACg0kSDzsAaCWUFiTEgkMjOPsii_GOSGgsv0 --continuous
""")

if __name__ == "__main__":
    main()
