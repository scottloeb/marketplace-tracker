#!/usr/bin/env python3
"""
Complete CSV Processor - Simple and Direct
Process the FB Marketplace CSV to extract ALL listings
"""

import json
import csv
import re
from datetime import datetime

def extract_make(title):
    """Extract make from title"""
    title_lower = title.lower()
    if 'yamaha' in title_lower:
        return 'Yamaha'
    elif any(x in title_lower for x in ['sea-doo', 'seadoo', 'sea doo']):
        return 'Sea-Doo'
    elif 'kawasaki' in title_lower:
        return 'Kawasaki'
    elif 'polaris' in title_lower:
        return 'Polaris'
    return 'Unknown'

def extract_year(title):
    """Extract year from title"""
    years = re.findall(r'\b(20[0-2][0-9])\b', title)
    return years[0] if years else ''

def process_csv():
    """Process the CSV file"""
    filename = "FB Marketplace Listings 20250828 - Sheet1.csv"
    
    print(f"🔍 Processing {filename}...")
    
    listings = []
    current_time = datetime.now().isoformat()
    base_timestamp = int(datetime.now().timestamp() * 1000)
    
    with open(filename, 'r', encoding='utf-8') as file:
        lines = [line.strip() for line in file.readlines() if line.strip()]
    
    # Process in pairs: title, url, title, url, etc.
    for i in range(0, len(lines) - 1, 2):
        title = lines[i].strip()
        url = lines[i + 1].strip() if i + 1 < len(lines) else ""
        
        # Validate this is a marketplace listing
        if (title and url and 
            'facebook.com/marketplace' in url and
            not title.lower().startswith('title')):
            
            listing = {
                "id": base_timestamp + len(listings),
                "title": title,
                "url": url,
                "price": 0,
                "make": extract_make(title),
                "year": extract_year(title),
                "location": "",
                "seller": "",
                "source": f"Complete CSV Import (Row {i//2 + 1})",
                "status": "pending",
                "addedDate": current_time,
                "mobileAdded": False,
                "notes": f"Complete CSV import - needs enhancement",
                "photos": [],
                "enhanced": False,
                "enhancement_status": "pending"
            }
            listings.append(listing)
    
    # Create import file
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    output_file = f"complete_csv_import_{timestamp}.json"
    
    import_data = {
        "timestamp": current_time,
        "listingCount": len(listings),
        "source": "Complete CSV Import - All Listings",
        "processing_notes": f"All {len(listings)} listings from CSV",
        "data": listings
    }
    
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(import_data, f, indent=2, ensure_ascii=False)
    
    # Show statistics
    makes = {}
    for listing in listings:
        make = listing['make']
        makes[make] = makes.get(make, 0) + 1
    
    print(f"✅ Successfully processed {len(listings)} listings!")
    print(f"📊 By Make: {makes}")
    print(f"📄 Import file: {output_file}")
    
    return output_file, len(listings)

if __name__ == "__main__":
    process_csv()
