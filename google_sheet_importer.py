#!/usr/bin/env python3
"""
Google Sheet to Marketplace Tracker Importer
Processes your Google Sheet data and prepares it for enhancement
"""

import json
import re
from datetime import datetime
from typing import List, Dict

def extract_listings_from_sheet_data() -> List[Dict]:
    """Extract and process listings from your Google Sheet"""
    
    # Raw data extracted from your Google Sheet
    sheet_listings = [
        {
            "title": "2022 Kawasaki SXR stand-up Jet Ski with trailer",
            "url": "https://www.facebook.com/marketplace/item/1016910590439853/"
        },
        {
            "title": "2019 Yamaha vxc",
            "url": "https://www.facebook.com/marketplace/item/992982412784679/"
        },
        {
            "title": "Seadoo rxtx 260 (brand new motor)",
            "url": "https://www.facebook.com/marketplace/item/1106057990957133/"
        },
        {
            "title": "2016 Yamaha VX Cruiser HO 1.8l 4cyl",
            "url": "https://www.facebook.com/marketplace/item/3758152204483726/"
        },
        {
            "title": "2020 seadoo gti 130",
            "url": "https://www.facebook.com/marketplace/item/768335708935768/"
        },
        {
            "title": "2018 Sea-doo Rxt-x 300",
            "url": "https://www.facebook.com/marketplace/item/1096637385987626/"
        },
        {
            "title": "2022 Yamaha vx cruiser 1.8 ho",
            "url": "https://www.facebook.com/marketplace/item/674113911647806/"
        },
        {
            "title": "2019 Yamaha 1800R supercharged",
            "url": "https://www.facebook.com/marketplace/item/798097699460306/"
        },
        {
            "title": "2017 YAMAHA GP1800 with Dual Ski Trailer",
            "url": "https://www.facebook.com/marketplace/item/1001203502131292/"
        },
        {
            "title": "2 (two) 2011 Sea Doo Jet Ski GTI SE 130 low Hours plus trailer",
            "url": "https://www.facebook.com/marketplace/item/1073754688270905/"
        },
        {
            "title": "Yamaha Waverunners",
            "url": "https://www.facebook.com/marketplace/item/4165715407083876/"
        },
        {
            "title": "2022 SVHO Yamaha Supercharged",
            "url": "https://www.facebook.com/marketplace/item/1221137949709126/"
        },
        {
            "title": "Sea doo ski",
            "url": "https://www.facebook.com/marketplace/item/1906752880162975/"
        },
        {
            "title": "2021 Seadoo RXT-x 300",
            "url": "https://www.facebook.com/marketplace/item/1261181461901741/"
        },
        {
            "title": "2025 YAMAHA SUPERJET",
            "url": "https://www.facebook.com/marketplace/item/1226883821768759/"
        },
        {
            "title": "Single boat trailer",
            "url": "https://www.facebook.com/marketplace/item/1135801991645489/"
        },
        {
            "title": "2025 Yamaha GP HO Audio WaveRunner",
            "url": "https://www.facebook.com/marketplace/item/1461715755023643/"
        },
        {
            "title": "2021 Sea-Doo GTR 230, 69 Hours, Loaded w/ Upgrades & Trailer, Great Condition!",
            "url": "https://www.facebook.com/marketplace/item/761456160160313/"
        },
        {
            "title": "2020 Yamaha ex deluxe",
            "url": "https://www.facebook.com/marketplace/item/1491179245382125/"
        },
        {
            "title": "2018 Seadoo 300 RXTX",
            "url": "https://www.facebook.com/marketplace/item/1348543196648872/"
        },
        {
            "title": "2025 Yamaha VX Cruiser",
            "url": "https://www.facebook.com/marketplace/item/609847648480736/"
        },
        {
            "title": "Jet ski dock",
            "url": "https://www.facebook.com/marketplace/item/1452898082718598/"
        },
        {
            "title": "2014 YAMAHA FX CRUISER HO & 2015 yamaha fx svho",
            "url": "https://www.facebook.com/marketplace/item/1055067110012881/"
        },
        {
            "title": "2020 SEADOO gti se 130",
            "url": "https://www.facebook.com/marketplace/item/4040437759510890/"
        },
        {
            "title": "2021 SeaDoo GTR 230",
            "url": "https://www.facebook.com/marketplace/item/1425705332051830/"
        },
        {
            "title": "2021 Yamaha fx cruiser svho (like new)",
            "url": "https://www.facebook.com/marketplace/item/739378742266765/"
        },
        {
            "title": "Two Yamaha Waverunners FX Cruiser HO and Double Trailer",
            "url": "https://www.facebook.com/marketplace/item/1119919453332860/"
        },
        {
            "title": "2013 Seadoo wake pro 215",
            "url": "https://www.facebook.com/marketplace/item/2269276903578889/"
        },
        {
            "title": "2009 Seadoo gti 155",
            "url": "https://www.facebook.com/marketplace/item/1020844200120390/"
        },
        {
            "title": "Sea Doo GTI 155 se",
            "url": "https://www.facebook.com/marketplace/item/1957816877955571/"
        },
        {
            "title": "2019 Yamaha GP1800R SVHO",
            "url": "https://www.facebook.com/marketplace/item/1817760762431855/"
        },
        {
            "title": "2024 Yamaha Jet Ski GP Ho with 14 hours in new condition with aluminum trailer",
            "url": "https://www.facebook.com/marketplace/item/1128499472487254/"
        },
        {
            "title": "Yamaha FX Cruiser in great condition!",
            "url": "https://www.facebook.com/marketplace/item/2781829271986497/"
        },
        {
            "title": "2023 Kawasaki STX160 w sound",
            "url": "https://www.facebook.com/marketplace/item/1055067110012881/"  # Note: This needs the correct URL
        }
    ]
    
    # Process each listing
    processed_listings = []
    current_time = datetime.now().isoformat()
    
    for i, listing in enumerate(sheet_listings):
        processed_listing = {
            "id": int(datetime.now().timestamp() * 1000) + i,
            "title": clean_title(listing["title"]),
            "url": listing["url"],
            "price": 0,  # Will be enhanced
            "make": extract_make(listing["title"]),
            "location": "",  # Will be enhanced
            "seller": "",
            "source": "Google Sheet Import",
            "status": "pending",
            "addedDate": current_time,
            "mobileAdded": False,
            "notes": "Imported from Google Sheet - needs price enhancement",
            "photos": [],
            "enhanced": False,
            "enhancement_status": "pending"
        }
        processed_listings.append(processed_listing)
    
    return processed_listings

def clean_title(title: str) -> str:
    """Clean up the title text"""
    # Remove Facebook Marketplace prefix
    title = re.sub(r'^\(\d+\)\s*Marketplace\s*-\s*', '', title)
    
    # Clean up extra spaces and characters
    title = re.sub(r'\s+', ' ', title).strip()
    
    return title

def extract_make(title: str) -> str:
    """Extract the make from the title"""
    makes = ['Yamaha', 'Sea-Doo', 'Seadoo', 'Sea Doo', 'Kawasaki', 'Kawaski']
    title_lower = title.lower()
    
    for make in makes:
        if make.lower() in title_lower:
            # Normalize Sea-Doo variants
            if make.lower() in ['seadoo', 'sea doo']:
                return 'Sea-Doo'
            elif make.lower() == 'kawaski':  # Fix typo
                return 'Kawasaki'
            return make
    
    return 'Unknown'

def create_marketplace_import_file(listings: List[Dict], filename: str = None):
    """Create the import file for marketplace tracker"""
    if filename is None:
        filename = f"google_sheet_import_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    
    import_data = {
        "timestamp": datetime.now().isoformat(),
        "listingCount": len(listings),
        "source": "Google Sheet Import",
        "processing_notes": "Imported from Google Sheet - requires price enhancement",
        "data": listings
    }
    
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(import_data, f, indent=2, ensure_ascii=False)
    
    return filename

def create_enhancement_queue(listings: List[Dict], filename: str = None):
    """Create a queue file for your enhancement scripts"""
    if filename is None:
        filename = f"pending_enhancement_queue_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    
    # Create simplified format for enhancement
    enhancement_queue = []
    for listing in listings:
        enhancement_queue.append({
            "id": listing["id"],
            "url": listing["url"],
            "title": listing["title"],
            "make": listing["make"],
            "status": "pending"
        })
    
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(enhancement_queue, f, indent=2, ensure_ascii=False)
    
    return filename

def print_stats(listings: List[Dict]):
    """Print processing statistics"""
    total = len(listings)
    makes = {}
    
    for listing in listings:
        make = listing['make']
        makes[make] = makes.get(make, 0) + 1
    
    print(f"\n🌊 Google Sheet Import Statistics")
    print(f"=" * 50)
    print(f"Total Listings: {total}")
    print(f"Makes Distribution:")
    for make, count in sorted(makes.items(), key=lambda x: x[1], reverse=True):
        print(f"  {make}: {count}")
    print(f"=" * 50)

def main():
    """Main processing function"""
    print("🌊 Processing Google Sheet data for Marketplace Tracker...")
    
    # Extract and process listings
    listings = extract_listings_from_sheet_data()
    
    # Print statistics
    print_stats(listings)
    
    # Create import file
    import_file = create_marketplace_import_file(listings)
    print(f"✅ Created import file: {import_file}")
    
    # Create enhancement queue
    queue_file = create_enhancement_queue(listings)
    print(f"✅ Created enhancement queue: {queue_file}")
    
    print(f"\n📋 Next Steps:")
    print(f"1. Import {import_file} into your Marketplace Tracker")
    print(f"2. Use {queue_file} with your enhancement scripts to get prices")
    print(f"3. Run your Ocean Explorer analysis on the enhanced data")
    
    return listings

if __name__ == "__main__":
    main()
