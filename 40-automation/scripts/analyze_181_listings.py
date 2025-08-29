#!/usr/bin/env python3
"""
Direct Analysis of Complete 181 Listings Dataset
"""

import json
import os
from datetime import datetime

def analyze_complete_dataset():
    """Analyze the complete 181 listing dataset"""
    
    print("🚀 Analyzing Complete 181 Listings Dataset...")
    
    # Load the complete dataset
    filename = "complete_csv_import_20250828_222849.json"
    
    try:
        with open(filename, 'r') as f:
            data = json.load(f)
        
        listings = data['data'] if 'data' in data else data
        
        print(f"📊 Total listings found: {len(listings)}")
        
        # Analyze by make
        makes = {}
        years = {}
        price_ranges = {
            'under_5k': 0,
            '5k_10k': 0, 
            '10k_15k': 0,
            '15k_20k': 0,
            'over_20k': 0,
            'no_price': 0
        }
        
        for listing in listings:
            # Extract make from title
            title = listing.get('title', '').lower()
            
            if 'yamaha' in title:
                make = 'Yamaha'
            elif 'sea-doo' in title or 'seadoo' in title:
                make = 'Sea-Doo'
            elif 'kawasaki' in title:
                make = 'Kawasaki'
            elif 'polaris' in title:
                make = 'Polaris'
            elif 'honda' in title:
                make = 'Honda'
            else:
                make = 'Unknown'
            
            makes[make] = makes.get(make, 0) + 1
            
            # Extract year (look for 4-digit number 20xx or 19xx)
            import re
            year_match = re.search(r'(20\d{2}|19\d{2})', title)
            if year_match:
                year = year_match.group(1)
                years[year] = years.get(year, 0) + 1
            
            # Analyze price if available
            price = listing.get('price')
            if price and isinstance(price, (int, float)):
                if price < 5000:
                    price_ranges['under_5k'] += 1
                elif price < 10000:
                    price_ranges['5k_10k'] += 1
                elif price < 15000:
                    price_ranges['10k_15k'] += 1
                elif price < 20000:
                    price_ranges['15k_20k'] += 1
                else:
                    price_ranges['over_20k'] += 1
            else:
                price_ranges['no_price'] += 1
        
        # Create analysis report
        analysis = {
            "timestamp": datetime.now().isoformat(),
            "total_listings": len(listings),
            "by_make": makes,
            "by_year": dict(sorted(years.items(), reverse=True)),
            "price_ranges": price_ranges,
            "sample_listings": listings[:5]  # First 5 for reference
        }
        
        # Save analysis
        output_file = f"complete_181_analysis_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        with open(output_file, 'w') as f:
            json.dump(analysis, f, indent=2)
        
        # Print summary
        print("\n📊 ANALYSIS RESULTS:")
        print(f"📈 Total Listings: {len(listings)}")
        print("\n🏭 By Make:")
        for make, count in sorted(makes.items(), key=lambda x: x[1], reverse=True):
            percentage = (count / len(listings)) * 100
            print(f"  {make}: {count} ({percentage:.1f}%)")
        
        print("\n📅 Top Years:")
        for year, count in list(sorted(years.items(), reverse=True))[:10]:
            percentage = (count / len(listings)) * 100
            print(f"  {year}: {count} ({percentage:.1f}%)")
        
        print("\n💰 Price Distribution:")
        for range_name, count in price_ranges.items():
            percentage = (count / len(listings)) * 100
            print(f"  {range_name}: {count} ({percentage:.1f}%)")
        
        print(f"\n✅ Analysis saved to: {output_file}")
        print("\n🎯 Key Insights:")
        
        top_make = max(makes.items(), key=lambda x: x[1])
        print(f"• {top_make[0]} is the most common make ({top_make[1]} listings)")
        
        if price_ranges['no_price'] > len(listings) * 0.8:
            print("• Most listings need price extraction (opportunity for automation!)")
        
        recent_years = sum(count for year, count in years.items() if int(year) >= 2020)
        if recent_years > 0:
            percentage = (recent_years / len(listings)) * 100
            print(f"• {recent_years} listings are 2020+ models ({percentage:.1f}%)")
        
        return output_file
        
    except Exception as e:
        print(f"❌ Error analyzing dataset: {e}")
        return None

if __name__ == "__main__":
    analyze_complete_dataset()
