#!/usr/bin/env python3
"""
Complete Google Sheet Importer for Marketplace Tracker
Fetches ALL data from your Google Sheet, not just the first few entries
"""

import json
import re
import requests
import csv
from datetime import datetime
from typing import List, Dict
import io

def fetch_complete_google_sheet(sheet_id: str) -> List[Dict]:
    """Fetch complete data from Google Sheet using CSV export"""
    
    # Construct CSV export URL
    csv_url = f"https://docs.google.com/spreadsheets/d/{sheet_id}/export?format=csv&gid=0"
    
    print(f"🔄 Fetching complete Google Sheet data...")
    print(f"📊 URL: {csv_url}")
    
    try:
        # Fetch CSV data
        response = requests.get(csv_url)
        response.raise_for_status()
        
        # Parse CSV
        csv_data = csv.reader(io.StringIO(response.text))
        rows = list(csv_data)
        
        print(f"📋 Raw CSV rows: {len(rows)}")
        
        # Extract listings (assuming Title in column A, URL in column B)
        listings = []
        for i, row in enumerate(rows):
            if len(row) >= 2 and row[0] and row[1]:
                title = row[0].strip()
                url = row[1].strip()
                
                # Skip header row and empty entries
                if not title or not url or 'title' in title.lower() or 'url' in url.lower():
                    continue
                
                # Basic validation for Facebook Marketplace URLs
                if 'facebook.com/marketplace' in url:
                    listings.append({
                        "title": title,
                        "url": url,
                        "row_number": i + 1
                    })
        
        print(f"✅ Extracted {len(listings)} valid listings from sheet")
        return listings
        
    except requests.RequestException as e:
        print(f"❌ Error fetching sheet: {e}")
        print("🔄 Falling back to manual entry method...")
        return get_manual_listings()
    except Exception as e:
        print(f"❌ Error processing sheet: {e}")
        return get_manual_listings()

def get_manual_listings():
    """Fallback: Prompt user to paste data manually"""
    print("\n📝 Manual Input Mode")
    print("=" * 50)
    print("Please copy the Title and URL columns from your Google Sheet and paste them here.")
    print("Format should be: Title<TAB>URL (one per line)")
    print("Press Enter on empty line when done.")
    print("=" * 50)
    
    listings = []
    row_num = 1
    
    while True:
        try:
            line = input(f"Row {row_num}: ").strip()
            if not line:
                break
                
            # Try to parse tab-separated values
            if '\t' in line:
                parts = line.split('\t', 1)
                if len(parts) == 2:
                    title, url = parts[0].strip(), parts[1].strip()
                    if title and url and 'facebook.com/marketplace' in url:
                        listings.append({
                            "title": title,
                            "url": url,
                            "row_number": row_num
                        })
                        row_num += 1
                    else:
                        print("⚠️  Invalid format - skipping")
                else:
                    print("⚠️  Please use TAB-separated format")
            else:
                print("⚠️  Please separate title and URL with TAB")
                
        except KeyboardInterrupt:
            print("\n👋 Manual input cancelled")
            break
    
    print(f"✅ Collected {len(listings)} listings manually")
    return listings

def process_listings(raw_listings: List[Dict]) -> List[Dict]:
    """Process raw listings into marketplace tracker format"""
    processed_listings = []
    current_time = datetime.now().isoformat()
    base_timestamp = int(datetime.now().timestamp() * 1000)
    
    for i, listing in enumerate(raw_listings):
        processed_listing = {
            "id": base_timestamp + i,
            "title": clean_title(listing["title"]),
            "url": listing["url"],
            "price": 0,  # Will be enhanced
            "make": extract_make(listing["title"]),
            "model": extract_model(listing["title"]),
            "year": extract_year(listing["title"]),
            "location": "",  # Will be enhanced
            "seller": "",
            "source": f"Google Sheet Import (Row {listing.get('row_number', i+1)})",
            "status": "pending",
            "addedDate": current_time,
            "mobileAdded": False,
            "notes": f"Imported from Google Sheet row {listing.get('row_number', i+1)} - needs price enhancement",
            "photos": [],
            "enhanced": False,
            "enhancement_status": "pending"
        }
        processed_listings.append(processed_listing)
    
    return processed_listings

def clean_title(title: str) -> str:
    """Clean up the title text"""
    # Remove Facebook Marketplace prefix patterns
    title = re.sub(r'^\(\d+\)\s*Marketplace\s*-\s*', '', title)
    title = re.sub(r'^Marketplace\s*-\s*', '', title)
    
    # Clean up extra spaces and characters
    title = re.sub(r'\s+', ' ', title).strip()
    
    return title

def extract_make(title: str) -> str:
    """Extract the make from the title"""
    makes = {
        'yamaha': 'Yamaha',
        'sea-doo': 'Sea-Doo', 
        'seadoo': 'Sea-Doo',
        'sea doo': 'Sea-Doo',
        'kawasaki': 'Kawasaki',
        'kawaski': 'Kawasaki',  # Fix common typo
        'polaris': 'Polaris'
    }
    
    title_lower = title.lower()
    
    for make_key, make_proper in makes.items():
        if make_key in title_lower:
            return make_proper
    
    return 'Unknown'

def extract_model(title: str) -> str:
    """Extract model from title"""
    title_lower = title.lower()
    
    # Yamaha models
    yamaha_models = ['gp1800', 'gp1800r', 'fx cruiser', 'fx svho', 'vx cruiser', 'vx deluxe', 'ex deluxe', 'superjet']
    for model in yamaha_models:
        if model in title_lower:
            return model.upper()
    
    # Sea-Doo models  
    seadoo_models = ['gti', 'gtr', 'rxt-x', 'rxtx', 'wake pro', 'gtx']
    for model in seadoo_models:
        if model in title_lower:
            return model.upper()
    
    # Kawasaki models
    kawasaki_models = ['sxr', 'stx160', 'ultra']
    for model in kawasaki_models:
        if model in title_lower:
            return model.upper()
    
    return ''

def extract_year(title: str) -> str:
    """Extract year from title"""
    years = re.findall(r'\b(20[0-2][0-9])\b', title)
    if years:
        return years[0]
    return ''

def create_marketplace_import_file(listings: List[Dict], filename: str = None):
    """Create the import file for marketplace tracker"""
    if filename is None:
        filename = f"google_sheet_complete_import_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    
    import_data = {
        "timestamp": datetime.now().isoformat(),
        "listingCount": len(listings),
        "source": "Complete Google Sheet Import",
        "processing_notes": "Complete import from Google Sheet - all listings included",
        "data": listings
    }
    
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(import_data, f, indent=2, ensure_ascii=False)
    
    return filename

def create_enhancement_queue(listings: List[Dict], filename: str = None):
    """Create a queue file for your enhancement scripts"""
    if filename is None:
        filename = f"complete_enhancement_queue_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    
    enhancement_queue = []
    for listing in listings:
        enhancement_queue.append({
            "id": listing["id"],
            "url": listing["url"],
            "title": listing["title"],
            "make": listing["make"],
            "model": listing["model"],
            "year": listing["year"],
            "status": "pending",
            "priority": get_listing_priority(listing)
        })
    
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(enhancement_queue, f, indent=2, ensure_ascii=False)
    
    return filename

def get_listing_priority(listing: Dict) -> str:
    """Assign priority based on title indicators"""
    title_lower = listing["title"].lower()
    
    # High priority indicators
    high_indicators = ['low hours', 'like new', 'brand new', 'great condition', 'loaded', 'svho', 'rxt-x', '300']
    if any(indicator in title_lower for indicator in high_indicators):
        return 'high'
    
    # Recent years get medium priority
    year = listing.get('year')
    if year and int(year) >= 2020:
        return 'medium'
    
    return 'normal'

def print_comprehensive_stats(listings: List[Dict]):
    """Print detailed processing statistics"""
    total = len(listings)
    makes = {}
    years = {}
    models = {}
    priorities = {}
    
    for listing in listings:
        # Count makes
        make = listing['make']
        makes[make] = makes.get(make, 0) + 1
        
        # Count years
        year = listing.get('year', 'Unknown')
        years[year] = years.get(year, 0) + 1
        
        # Count models
        model = listing.get('model', 'Unknown')
        models[model] = models.get(model, 0) + 1
        
        # Count priorities
        priority = get_listing_priority(listing)
        priorities[priority] = priorities.get(priority, 0) + 1
    
    print(f"\n🌊 Complete Google Sheet Import Statistics")
    print(f"=" * 60)
    print(f"📊 Total Listings: {total}")
    print(f"")
    print(f"🏭 By Make:")
    for make, count in sorted(makes.items(), key=lambda x: x[1], reverse=True):
        print(f"  {make}: {count}")
    print(f"")
    print(f"📅 By Year:")
    for year, count in sorted(years.items(), key=lambda x: x[0], reverse=True):
        print(f"  {year}: {count}")
    print(f"")
    print(f"🚀 Priority Distribution:")
    for priority, count in priorities.items():
        print(f"  {priority.title()}: {count}")
    print(f"=" * 60)

def main():
    """Main processing function"""
    print("🌊 Complete Google Sheet Importer for Marketplace Tracker")
    print("=" * 60)
    
    # Your Google Sheet ID
    sheet_id = "1rCVwrc2p4anBeRutRPTuNyb6v6UKhpDPI_Y5WVQNENk"
    
    # Fetch complete data
    raw_listings = fetch_complete_google_sheet(sheet_id)
    
    if not raw_listings:
        print("❌ No listings found")
        return []
    
    # Process listings
    processed_listings = process_listings(raw_listings)
    
    # Print comprehensive statistics
    print_comprehensive_stats(processed_listings)
    
    # Create import file
    import_file = create_marketplace_import_file(processed_listings)
    print(f"✅ Created complete import file: {import_file}")
    
    # Create enhancement queue
    queue_file = create_enhancement_queue(processed_listings)
    print(f"✅ Created enhancement queue: {queue_file}")
    
    print(f"\n📋 Next Steps:")
    print(f"1. Import {import_file} into your Marketplace Tracker")
    print(f"2. Use {queue_file} with enhancement scripts to get prices")
    print(f"3. Run screenshot collection on ALL listings")
    print(f"4. Analyze with Ocean Explorer")
    
    # Show sample URLs for verification
    print(f"\n🔍 Sample URLs (first 5):")
    for i, listing in enumerate(processed_listings[:5]):
        print(f"  {i+1}. {listing['title'][:50]}...")
        print(f"     {listing['url']}")
    
    return processed_listings

if __name__ == "__main__":
    main()
