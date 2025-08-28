#!/usr/bin/env python3
"""
Manual Enhancement Helper
Guides user through manual data entry with intelligent parsing.
"""

import json
from datetime import datetime

def manual_enhance_listings(input_file: str):
    """Guide user through manual enhancement of listings."""
    
    with open(input_file, 'r') as f:
        listings = json.load(f)
    
    enhanced_listings = []
    
    for i, listing in enumerate(listings):
        print(f"\n--- Listing {i+1}/{len(listings)} ---")
        print(f"URL: {listing.get('url', 'No URL')}")
        
        # Guide user to extract data
        print("\nPlease open this URL in your browser and provide:")
        
        title = input("Title: ").strip()
        price_str = input("Price (just the number, e.g. 8999): ").strip()
        location = input("Location (e.g. North Beach, MD): ").strip()
        
        # Parse price
        try:
            price = float(price_str) if price_str else 0
        except ValueError:
            price = 0
        
        # Update listing
        enhanced = listing.copy()
        if title:
            enhanced['title'] = title
            enhanced['status'] = 'enhanced'
        if price > 0:
            enhanced['price'] = price
        if location:
            enhanced['location'] = location
        
        # Parse jet ski info
        if title:
            jetski_info = parse_jetski_info(title)
            enhanced.update(jetski_info)
        
        enhanced_listings.append(enhanced)
        
        print(f"✅ Enhanced: {title} - ${price}")
    
    # Save results
    output_file = f"enhanced_tracker_data_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    
    output_data = {
        "timestamp": datetime.now().isoformat(),
        "listingCount": len(enhanced_listings),
        "enhancementMethod": "manual_assisted",
        "data": enhanced_listings
    }
    
    with open(output_file, 'w') as f:
        json.dump(output_data, f, indent=2)
    
    print(f"\nEnhanced data saved: {output_file}")
    print("Ready to import into your tracker!")

def parse_jetski_info(title: str):
    """Parse jet ski info from title."""
    import re
    
    title_lower = title.lower()
    info = {"make": "", "model": "", "year": "", "type": "Jet Ski"}
    
    # Extract year
    year_match = re.search(r'\b(19|20)\d{2}\b', title)
    if year_match:
        info["year"] = year_match.group()
    
    # Extract make
    if "seadoo" in title_lower or "sea-doo" in title_lower:
        info["make"] = "Sea-Doo"
    elif "yamaha" in title_lower:
        info["make"] = "Yamaha"
    elif "kawasaki" in title_lower:
        info["make"] = "Kawasaki"
    
    return info

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python3 manual_helper.py <input_file.json>")
        sys.exit(1)
    
    manual_enhance_listings(sys.argv[1])
