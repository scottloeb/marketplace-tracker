#!/usr/bin/env python3
"""
Quick Import All 181 Listings
Processes your CSV and creates a clean import file
"""

import json
from datetime import datetime

def main():
    print("🌊 Importing All 181 Marketplace Listings")
    print("=" * 50)
    
    # Check if complete file exists
    try:
        with open('COMPLETE_import_all_181_listings.json', 'r') as f:
            data = json.load(f)
            print(f"✅ Found complete import file with {len(data.get('data', []))} listings")
            
            # Create a simpler import format
            simple_import = {
                "import_date": datetime.now().isoformat(),
                "total_listings": len(data.get('data', [])),
                "source": "Complete CSV Import - All 181 Listings",
                "listings": data.get('data', [])
            }
            
            # Save simplified version
            filename = f"SIMPLE_IMPORT_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
            with open(filename, 'w') as f:
                json.dump(simple_import, f, indent=2)
            
            print(f"📥 Created {filename}")
            print("🎯 Next Steps:")
            print("1. Open your Marketplace Tracker in browser")
            print("2. Go to 'Data Sync' tab")
            print("3. Click 'Import Data'")
            print(f"4. Copy the contents of {filename}")
            print("5. Paste and click 'Import'")
            print(f"6. You should see all {len(data.get('data', []))} listings!")
            
            return filename
            
    except FileNotFoundError:
        print("❌ Complete import file not found")
        print("🔄 Run the CSV processor first")
        return None

if __name__ == "__main__":
    main()
