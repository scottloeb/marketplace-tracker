#!/usr/bin/env python3
"""
Manual Google Sheet Processor
Paste your complete Google Sheet data to create full import
"""

import json
import csv
import io
from datetime import datetime
from typing import List, Dict

def process_pasted_data():
    """Process manually pasted Google Sheet data"""
    print("🌊 Manual Google Sheet Data Processor")
    print("=" * 60)
    print("📋 Instructions:")
    print("1. Go to your Google Sheet")
    print("2. Select ALL data (Ctrl+A or Cmd+A)")
    print("3. Copy it (Ctrl+C or Cmd+C)")
    print("4. Paste it below and press Enter twice when done")
    print("=" * 60)
    
    # Collect pasted data
    lines = []
    print("\n📝 Paste your data here (press Enter twice when done):")
    
    empty_lines = 0
    while True:
        try:
            line = input()
            if not line.strip():
                empty_lines += 1
                if empty_lines >= 2:
                    break
            else:
                lines.append(line)
                empty_lines = 0
        except KeyboardInterrupt:
            print("\n👋 Input cancelled")
            return []
    
    print(f"\n📊 Processing {len(lines)} lines of data...")
    
    # Parse the data
    listings = []
    for i, line in enumerate(lines):
        if not line.strip():
            continue
            
        # Try tab-separated first, then comma-separated
        if '\t' in line:
            parts = line.split('\t')
        else:
            parts = line.split(',')
        
        if len(parts) >= 2:
            title = parts[0].strip().strip('"')
            url = parts[1].strip().strip('"')
            
            # Validate
            if (title and url and 
                'facebook.com/marketplace' in url and
                not title.lower().startswith('title')):
                
                listings.append({
                    "title": title,
                    "url": url,
                    "row_number": i + 1
                })
    
    print(f"✅ Found {len(listings)} valid marketplace listings")
    return listings

def extract_make(title: str) -> str:
    """Extract the make from the title"""
    makes = {
        'yamaha': 'Yamaha',
        'sea-doo': 'Sea-Doo', 
        'seadoo': 'Sea-Doo',
        'sea doo': 'Sea-Doo',
        'kawasaki': 'Kawasaki',
        'polaris': 'Polaris'
    }
    
    title_lower = title.lower()
    for make_key, make_proper in makes.items():
        if make_key in title_lower:
            return make_proper
    return 'Unknown'

def extract_year(title: str) -> str:
    """Extract year from title"""
    import re
    years = re.findall(r'\b(20[0-2][0-9])\b', title)
    return years[0] if years else ''

def create_complete_import_file(raw_listings: List[Dict]):
    """Create complete import file"""
    current_time = datetime.now().isoformat()
    base_timestamp = int(datetime.now().timestamp() * 1000)
    
    processed_listings = []
    for i, raw in enumerate(raw_listings):
        listing = {
            "id": base_timestamp + i,
            "title": raw["title"],
            "url": raw["url"],
            "price": 0,
            "make": extract_make(raw["title"]),
            "year": extract_year(raw["title"]),
            "location": "",
            "seller": "",
            "source": f"Complete Google Sheet Import (Row {raw['row_number']})",
            "status": "pending",
            "addedDate": current_time,
            "mobileAdded": False,
            "notes": f"Complete import - Row {raw['row_number']} - needs enhancement",
            "photos": [],
            "enhanced": False,
            "enhancement_status": "pending"
        }
        processed_listings.append(listing)
    
    # Create import file
    filename = f"complete_import_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    import_data = {
        "timestamp": current_time,
        "listingCount": len(processed_listings),
        "source": "Complete Google Sheet Manual Import",
        "processing_notes": f"All {len(processed_listings)} listings from Google Sheet",
        "data": processed_listings
    }
    
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(import_data, f, indent=2, ensure_ascii=False)
    
    # Print statistics
    makes = {}
    years = {}
    for listing in processed_listings:
        make = listing['make']
        makes[make] = makes.get(make, 0) + 1
        year = listing.get('year', 'Unknown')
        years[year] = years.get(year, 0) + 1
    
    print(f"\n🎯 Complete Import Statistics:")
    print(f"📊 Total Listings: {len(processed_listings)}")
    print(f"🏭 By Make: {dict(sorted(makes.items(), key=lambda x: x[1], reverse=True))}")
    print(f"📅 Recent Years: {dict(sorted(years.items(), key=lambda x: x[0], reverse=True))}")
    print(f"✅ Import file created: {filename}")
    
    return filename

def main():
    """Main function"""
    raw_listings = process_pasted_data()
    if not raw_listings:
        print("❌ No valid listings found")
        return
    
    filename = create_complete_import_file(raw_listings)
    
    print(f"\n📋 Next Steps:")
    print(f"1. Import {filename} into your Marketplace Tracker")
    print(f"2. This should give you ALL {len(raw_listings)} listings!")
    
    return filename

if __name__ == "__main__":
    main()
