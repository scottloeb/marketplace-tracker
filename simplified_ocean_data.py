#!/usr/bin/env python3
import json

# Load listings data
with open('enhanced_286_complete_20250824_142413.json') as f:
    listings_data = json.load(f)

# Create Ocean Explorer format
ocean_data = {
    "metadata": {
        "dataset_name": "Jet Ski Marketplace Analysis",
        "total_listings": len(listings_data['data']),
        "data_sources": ["Facebook Marketplace"],
        "analysis_date": "2025-08-28"
    },
    "nodes": [],
    "categories": {"make": {}, "price_range": {}, "market_analysis": {}}
}

# Process listings
for i, listing in enumerate(listings_data['data']):
    price = listing.get('price', 0)
    make = listing.get('make', 'Unknown')
    analysis = listing.get('market_analysis', 'No analysis')
    
    # Categorize prices
    if price < 8000:
        price_cat = "Under $8K"
    elif price < 15000:
        price_cat = "$8K-15K" 
    elif price < 25000:
        price_cat = "$15K-25K"
    else:
        price_cat = "Over $25K"
    
    # Create node
    node = {
        "id": f"listing_{i}",
        "title": listing.get('title', 'Untitled'),
        "price": price,
        "make": make,
        "price_category": price_cat,
        "market_analysis": analysis,
        "url": listing.get('url', ''),
        "date_added": listing.get('addedDate', ''),
        "type": "marketplace_listing"
    }
    
    ocean_data["nodes"].append(node)
    
    # Update category counts
    ocean_data["categories"]["make"][make] = ocean_data["categories"]["make"].get(make, 0) + 1
    ocean_data["categories"]["price_range"][price_cat] = ocean_data["categories"]["price_range"].get(price_cat, 0) + 1
    ocean_data["categories"]["market_analysis"][analysis] = ocean_data["categories"]["market_analysis"].get(analysis, 0) + 1

# Save for Ocean Explorer
with open('ocean_explorer_marketplace_data.json', 'w') as f:
    json.dump(ocean_data, f, indent=2)

print(f"Created Ocean Explorer dataset:")
print(f"- {len(ocean_data['nodes'])} listings")
print(f"- {len(ocean_data['categories']['make'])} makes: {list(ocean_data['categories']['make'].keys())}")
print(f"- Price distribution: {ocean_data['categories']['price_range']}")
print(f"- Market analysis: {ocean_data['categories']['market_analysis']}")
print("\nFile saved: ocean_explorer_marketplace_data.json")
