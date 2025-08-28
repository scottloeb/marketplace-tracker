#!/usr/bin/env python3
import json
import csv

# Load listings and specs
with open('enhanced_286_complete_20250824_142413.json') as f:
    listings_data = json.load(f)

# Load stock images data  
images = {}
with open('20-reference/jet_ski_images_reference.csv') as f:
    reader = csv.DictReader(f)
    for row in reader:
        key = f"{row['Make']}_{row['Year']}_{row['Model']}_{row['Trim']}"
        images[key] = {
            'url_pattern': row['Image_URL_Pattern'],
            'colors': row['Color_Variants'].split(',')
        }

# Create Ocean Explorer format
ocean_data = {
    "metadata": {
        "dataset_name": "Jet Ski Marketplace Analysis",
        "total_listings": len(listings_data['data']),
        "data_sources": ["Facebook Marketplace", "Reference Specs"],
        "analysis_date": "2025-08-28"
    },
    "nodes": [],
    "edges": [],
    "categories": {"make": {}, "price_range": {}, "market_analysis": {}}
}

# Process listings for visualization
for i, listing in enumerate(listings_data['data']):
    price = listing.get('price', 0)
    make = listing.get('make', 'Unknown')
    analysis = listing.get('market_analysis', 'No analysis')
    
    # Categorize price ranges
    if price < 8000:
        price_cat = "Under $8K"
    elif price < 15000:
        price_cat = "$8K-15K" 
    elif price < 25000:
        price_cat = "$15K-25K"
    else:
        price_cat = "Over $25K"
    
    # Create node for Ocean Explorer
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

# Save Ocean Explorer data
with open('ocean_explorer_marketplace_data.json', 'w') as f:
    json.dump(ocean_data, f, indent=2)

print(f"Created Ocean Explorer dataset with {len(ocean_data['nodes'])} nodes")
print(f"Categories: {len(ocean_data['categories']['make'])} makes, {len(ocean_data['categories']['price_range'])} price ranges")
print("Ready for Harbor Ocean Explorer visualization")
