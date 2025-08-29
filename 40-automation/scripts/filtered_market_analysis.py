#!/usr/bin/env python3
"""
Enhanced Market Analysis with Sold Listing Detection
Properly categorizes and filters sold vs active listings
"""

import json
import re
from collections import defaultdict, Counter
import statistics
from datetime import datetime

def analyze_with_sold_detection():
    """Analyze listings with proper sold/active categorization"""
    
    print("Analyzing marketplace data with sold listing detection...")
    
    # Load extracted data
    with open("enhanced_extraction_20250829_001201.json", 'r') as f:
        extraction_data = json.load(f)
    
    listings = extraction_data['data']
    
    # Categorize listings
    active_listings = []
    sold_listings = []
    invalid_listings = []
    
    for listing in listings:
        title = listing.get('title', '').lower()
        price = float(listing.get('price', 0)) if listing.get('price') else 0
        
        # Detect sold listings
        if 'sold' in title or price == 0:
            sold_listings.append(listing)
        elif price > 0:
            active_listings.append(listing)
        else:
            invalid_listings.append(listing)
    
    print(f"\nListing Categorization:")
    print(f"   Active listings: {len(active_listings)}")
    print(f"   Sold listings: {len(sold_listings)}")
    print(f"   Invalid/unparsed: {len(invalid_listings)}")
    
    # Analyze active listings for deals
    if active_listings:
        print(f"\nActive Market Analysis ({len(active_listings)} listings):")
        
        # Price statistics for active listings only
        active_prices = [float(l.get('price', 0)) for l in active_listings if l.get('price')]
        
        if active_prices:
            avg_price = statistics.mean(active_prices)
            median_price = statistics.median(active_prices)
            
            print(f"   Average price: ${avg_price:,.0f}")
            print(f"   Median price: ${median_price:,.0f}")
            print(f"   Price range: ${min(active_prices):,.0f} - ${max(active_prices):,.0f}")
            
            # Make analysis for active listings
            make_analysis = defaultdict(list)
            
            for listing in active_listings:
                title = listing.get('title', '').lower()
                price = float(listing.get('price', 0))
                
                make = 'unknown'
                if 'yamaha' in title:
                    make = 'yamaha'
                elif 'sea-doo' in title or 'seadoo' in title:
                    make = 'sea-doo'
                elif 'kawasaki' in title:
                    make = 'kawasaki'
                
                make_analysis[make].append({
                    'price': price,
                    'title': listing.get('title'),
                    'listing_id': listing.get('listing_id'),
                    'url': listing.get('url')
                })
            
            print(f"\nActive Listings by Make:")
            for make, listings_by_make in sorted(make_analysis.items(), key=lambda x: len(x[1]), reverse=True):
                if len(listings_by_make) >= 3:
                    prices = [l['price'] for l in listings_by_make]
                    avg_make_price = statistics.mean(prices)
                    count = len(listings_by_make)
                    
                    print(f"   {make.title()}: {count} active listings - Avg: ${avg_make_price:,.0f}")
                    
                    # Find genuinely underpriced listings
                    make_std = statistics.stdev(prices) if len(prices) > 1 else 0
                    
                    if make_std > 0:
                        for listing in listings_by_make:
                            z_score = (listing['price'] - avg_make_price) / make_std
                            if z_score < -1.5:  # Significantly below average
                                discount_pct = ((avg_make_price - listing['price']) / avg_make_price) * 100
                                print(f"      Potential deal: {listing['title']} - ${listing['price']:,} ({discount_pct:.1f}% below avg)")
    
    # Analyze sold listings for market intelligence
    if sold_listings:
        print(f"\nSold Listings Analysis ({len(sold_listings)} listings):")
        
        sold_with_prices = [l for l in sold_listings if l.get('price') and float(l.get('price', 0)) > 0]
        
        if sold_with_prices:
            sold_prices = [float(l.get('price')) for l in sold_with_prices]
            avg_sold_price = statistics.mean(sold_prices)
            
            print(f"   Average sold price: ${avg_sold_price:,.0f}")
            print(f"   Sold listings with pricing data: {len(sold_with_prices)}")
            
            # Recent sold listings (potential re-list candidates)
            print(f"\nRecent sold listings to monitor:")
            for i, listing in enumerate(sold_listings[:5], 1):
                title = listing.get('title', 'Unknown title')
                price = listing.get('price', 'Unknown price')
                print(f"      {i}. {title} - ${price}")
        
        else:
            print("   No pricing data available for sold listings")
    
    # Create filtered datasets for export
    results = {
        'analysis_timestamp': datetime.now().isoformat(),
        'summary': {
            'total_processed': len(listings),
            'active_count': len(active_listings),
            'sold_count': len(sold_listings),
            'invalid_count': len(invalid_listings)
        },
        'active_listings': active_listings,
        'sold_listings': sold_listings,
        'market_intelligence': {
            'active_avg_price': statistics.mean([float(l.get('price', 0)) for l in active_listings if l.get('price')]) if active_listings else 0,
            'sold_avg_price': statistics.mean([float(l.get('price', 0)) for l in sold_with_prices if l.get('price')]) if sold_with_prices else 0
        }
    }
    
    # Save filtered datasets
    output_file = f"filtered_market_analysis_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    with open(output_file, 'w') as f:
        json.dump(results, f, indent=2)
    
    print(f"\nFiltered analysis saved to: {output_file}")
    
    return {
        'active_listings': active_listings,
        'sold_listings': sold_listings,
        'invalid_listings': invalid_listings
    }

if __name__ == "__main__":
    analyze_with_sold_detection()
