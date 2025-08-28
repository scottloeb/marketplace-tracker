#!/usr/bin/env python3
import json
import csv
import re

# Load listings data
with open('enhanced_286_complete_20250824_142413.json') as f:
    listings_data = json.load(f)

# Load reference specs
specs = {}
with open('20-reference/jet_ski_specs_main.csv') as f:
    reader = csv.DictReader(f)
    for row in reader:
        # Parse each model column
        for col_name, value in row.items():
            if col_name != 'Specification' and value.strip():
                # Extract make, year, model from column name
                parts = col_name.split('_')
                if len(parts) >= 3:
                    make = parts[0]
                    year = parts[1] 
                    model = '_'.join(parts[2:])
                    
                    key = f"{make}_{year}_{model}"
                    if key not in specs:
                        specs[key] = {'make': make, 'year': year, 'model': model}
                    specs[key][row['Specification']] = value

print(f"Loaded {len(specs)} reference models")
print(f"Loaded {len(listings_data['data'])} listings")

# Match listings to specs
matched_count = 0
for listing in listings_data['data']:
    title = listing.get('title', '').lower()
    make = listing.get('make', '').lower()
    
    # Try to extract year from title
    year_match = re.search(r'\b(20\d{2}|19\d{2})\b', title)
    year = year_match.group(1) if year_match else ''
    
    # Find best matching spec
    best_match = None
    best_score = 0
    
    for spec_key, spec_data in specs.items():
        score = 0
        spec_make = spec_data['make'].lower()
        spec_year = spec_data['year']
        
        # Score matching
        if make and spec_make in make:
            score += 3
        if year and spec_year == year:
            score += 2
        if any(word in title for word in spec_data['model'].lower().split('_')):
            score += 1
            
        if score > best_score:
            best_score = score
            best_match = spec_data
    
    if best_match and best_score >= 3:
        listing['reference_specs'] = best_match
        listing['spec_match_score'] = best_score
        matched_count += 1
        print(f"Matched: {listing['title']} -> {best_match['make']} {best_match['year']} {best_match['model']}")

print(f"\nMatched {matched_count} listings to reference specs")

# Save enhanced data
output_file = 'listings_with_specs.json'
with open(output_file, 'w') as f:
    json.dump(listings_data, f, indent=2)

print(f"Enhanced data saved: {output_file}")
