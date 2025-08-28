#!/usr/bin/env python3
import json
import csv
import re

# Load listings data
with open('enhanced_286_complete_20250824_142413.json') as f:
    listings_data = json.load(f)

print(f"Loaded {len(listings_data['data'])} listings")

# Check CSV structure first
with open('20-reference/jet_ski_specs_main.csv') as f:
    reader = csv.reader(f)
    header = next(reader)
    print(f"CSV columns: {header[:5]}...")  # Show first 5 columns
    
    # Build specs dictionary
    specs = {}
    for row_data in reader:
        if len(row_data) > 1:
            spec_name = row_data[0]  # First column is specification name
            
            # Process each model column (skip first column)
            for i, value in enumerate(row_data[1:], 1):
                if i < len(header) and value.strip():
                    model_name = header[i]
                    
                    # Parse model name (e.g., "Kawasaki_2010_800SXR")
                    parts = model_name.split('_')
                    if len(parts) >= 3:
                        make = parts[0]
                        year = parts[1]
                        model = '_'.join(parts[2:])
                        
                        key = f"{make}_{year}_{model}"
                        if key not in specs:
                            specs[key] = {'make': make, 'year': year, 'model': model}
                        specs[key][spec_name] = value

print(f"Loaded {len(specs)} reference models")

# Show some example specs
for i, (key, spec) in enumerate(specs.items()):
    if i < 3:  # Show first 3
        print(f"Example: {key} -> {spec.get('Horsepower', 'N/A')} HP")

# Match listings to specs
matched_count = 0
for listing in listings_data['data'][:5]:  # Test with first 5 listings
    title = listing.get('title', '').lower()
    make = listing.get('make', '').lower().replace('sea-doo', 'seadoo')
    
    print(f"\nTrying to match: {title} (make: {make})")
    
    # Try to extract year
    year_match = re.search(r'\b(20\d{2})\b', title)
    year = year_match.group(1) if year_match else ''
    
    # Find best match
    best_match = None
    best_score = 0
    
    for spec_key, spec_data in specs.items():
        score = 0
        spec_make = spec_data['make'].lower()
        
        if make and spec_make in make:
            score += 3
        if year and spec_data['year'] == year:
            score += 2
            
        if score > best_score:
            best_score = score
            best_match = spec_data
    
    if best_match and best_score >= 2:
        print(f"  -> Matched to {best_match['make']} {best_match['year']} {best_match['model']} (score: {best_score})")
        matched_count += 1

print(f"\nMatched {matched_count} of 5 test listings")
