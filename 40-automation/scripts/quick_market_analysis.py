#!/usr/bin/env python3
"""
Quick Market Analysis for Enhanced Extracted Data
Analyzes the 166 extracted listings with real pricing data
"""

import json
import re
from collections import defaultdict, Counter
import statistics
from datetime import datetime

def analyze_extracted_data():
    """Analyze the enhanced extraction data"""
    
    print("🧠 Analyzing Enhanced Marketplace Data...")
    
    # Load extracted data
    with open("enhanced_extraction_20250829_001201.json", 'r') as f:
        extraction_data = json.load(f)
    
    listings = extraction_data['data']
    total_processed = extraction_data['total_processed']
    
    print(f"📊 Analyzing {total_processed} extracted listings with real pricing data...")
    
    # Analysis containers
    price_data = []
    make_analysis = defaultdict(list)
    year_analysis = defaultdict(list)
    geographic_data = defaultdict(list)
    
    # Process each listing
    for listing in listings:
        try:
            price = float(listing.get('price', 0)) if listing.get('price') else 0
            title = listing.get('title', '').lower()
            
            if price > 0:  # Only analyze listings with valid prices
                price_data.append(price)
                
                # Extract make
                make = 'unknown'
                if 'yamaha' in title:
                    make = 'yamaha'
                elif 'sea-doo' in title or 'seadoo' in title:
                    make = 'sea-doo'
                elif 'kawasaki' in title:
                    make = 'kawasaki'
                elif 'honda' in title:
                    make = 'honda'
                
                make_analysis[make].append({
                    'price': price,
                    'title': listing.get('title'),
                    'listing_id': listing.get('listing_id'),
                    'url': listing.get('url')
                })
                
                # Extract year
                year_match = re.search(r'(20\d{2}|19\d{2})', title)
                if year_match:
                    year = year_match.group(1)
                    year_analysis[year].append({
                        'price': price,
                        'title': listing.get('title'),
                        'make': make
                    })
        
        except Exception as e:
            print(f"Error processing listing: {e}")
            continue
    
    # Generate analysis report
    print("\n" + "="*60)
    print("🎯 MARKET INTELLIGENCE ANALYSIS COMPLETE")
    print("="*60)
    
    if not price_data:
        print("❌ No pricing data found to analyze")
        return
    
    # Overall pricing statistics
    avg_price = statistics.mean(price_data)
    median_price = statistics.median(price_data)
    min_price = min(price_data)
    max_price = max(price_data)
    std_dev = statistics.stdev(price_data) if len(price_data) > 1 else 0
    
    print(f"\n📈 OVERALL MARKET STATISTICS:")
    print(f"   Total listings with prices: {len(price_data)}")
    print(f"   Average price: ${avg_price:,.0f}")
    print(f"   Median price: ${median_price:,.0f}")
    print(f"   Price range: ${min_price:,.0f} - ${max_price:,.0f}")
    print(f"   Standard deviation: ${std_dev:,.0f}")
    
    # Price distribution analysis
    price_ranges = {
        'Under $5K': len([p for p in price_data if p < 5000]),
        '$5K-$10K': len([p for p in price_data if 5000 <= p < 10000]),
        '$10K-$15K': len([p for p in price_data if 10000 <= p < 15000]),
        '$15K-$20K': len([p for p in price_data if 15000 <= p < 20000]),
        '$20K+': len([p for p in price_data if p >= 20000])
    }
    
    print(f"\n💰 PRICE DISTRIBUTION:")
    for range_name, count in price_ranges.items():
        percentage = (count / len(price_data)) * 100
        print(f"   {range_name}: {count} listings ({percentage:.1f}%)")
    
    # Make analysis
    print(f"\n🏭 ANALYSIS BY MAKE:")
    for make, make_listings in sorted(make_analysis.items(), key=lambda x: len(x[1]), reverse=True):
        if len(make_listings) >= 3:  # Only show makes with sufficient data
            prices = [l['price'] for l in make_listings]
            avg_make_price = statistics.mean(prices)
            count = len(make_listings)
            percentage = (count / len(price_data)) * 100
            
            print(f"   {make.title()}: {count} listings ({percentage:.1f}%) - Avg: ${avg_make_price:,.0f}")
            
            # Find best deals for this make
            sorted_by_price = sorted(make_listings, key=lambda x: x['price'])
            cheapest = sorted_by_price[0]
            print(f"      🔥 Best Deal: {cheapest['title']} - ${cheapest['price']:,}")
    
    # Year analysis
    print(f"\n📅 ANALYSIS BY YEAR:")
    for year, year_listings in sorted(year_analysis.items(), reverse=True):
        if len(year_listings) >= 2:  # Only show years with multiple listings
            prices = [l['price'] for l in year_listings]
            avg_year_price = statistics.mean(prices)
            count = len(year_listings)
            
            print(f"   {year}: {count} listings - Avg: ${avg_year_price:,.0f}")
    
    # Deal detection (statistical outliers)
    print(f"\n💎 POTENTIAL DEALS (Statistical Analysis):")
    
    # Calculate z-scores for outlier detection
    deals_found = []
    
    for make, make_listings in make_analysis.items():
        if len(make_listings) >= 5:  # Need sufficient data for statistical analysis
            prices = [l['price'] for l in make_listings]
            make_mean = statistics.mean(prices)
            make_std = statistics.stdev(prices) if len(prices) > 1 else 0
            
            if make_std > 0:
                for listing in make_listings:
                    z_score = (listing['price'] - make_mean) / make_std
                    
                    if z_score < -1.5:  # Significantly below average
                        discount_pct = ((make_mean - listing['price']) / make_mean) * 100
                        deals_found.append({
                            'listing': listing,
                            'discount_pct': discount_pct,
                            'savings': make_mean - listing['price'],
                            'make': make,
                            'z_score': z_score
                        })
    
    # Sort deals by discount percentage
    deals_found.sort(key=lambda x: x['discount_pct'], reverse=True)
    
    if deals_found:
        print(f"   Found {len(deals_found)} potential deals:")
        
        for i, deal in enumerate(deals_found[:10], 1):  # Show top 10 deals
            listing = deal['listing']
            print(f"\n   {i}. 🔥 {deal['make'].title()} Deal:")
            print(f"      Title: {listing['title']}")
            print(f"      Price: ${listing['price']:,}")
            print(f"      Discount: {deal['discount_pct']:.1f}% below {deal['make'].title()} average")
            print(f"      Potential Savings: ${deal['savings']:,.0f}")
            print(f"      URL: {listing['url']}")
    else:
        print("   No significant statistical outliers detected")
    
    # Value recommendations
    print(f"\n🎯 INVESTMENT RECOMMENDATIONS:")
    
    # Find sweet spot years (best value retention)
    current_year = 2025
    value_analysis = []
    
    for year, year_listings in year_analysis.items():
        if len(year_listings) >= 2:
            year_int = int(year)
            age = current_year - year_int
            
            if 1 <= age <= 10:  # Focus on recent models
                avg_price = statistics.mean([l['price'] for l in year_listings])
                depreciation_per_year = (25000 - avg_price) / age if age > 0 else 0  # Rough MSRP estimate
                
                value_analysis.append({
                    'year': year,
                    'age': age,
                    'avg_price': avg_price,
                    'count': len(year_listings),
                    'depreciation_per_year': depreciation_per_year
                })
    
    if value_analysis:
        # Find years with best value (lowest depreciation rate relative to age)
        value_analysis.sort(key=lambda x: x['depreciation_per_year'])
        
        print(f"   💡 Best Value Years (lowest depreciation):")
        for i, analysis in enumerate(value_analysis[:3], 1):
            print(f"      {i}. {analysis['year']} models ({analysis['age']} years old)")
            print(f"         Average price: ${analysis['avg_price']:,.0f}")
            print(f"         Count: {analysis['count']} listings")
    
    # Summary and next steps
    print(f"\n🚀 SUMMARY & NEXT STEPS:")
    print(f"   ✅ Successfully analyzed {len(price_data)} listings with pricing data")
    print(f"   💰 Price range spans ${min_price:,} to ${max_price:,}")
    print(f"   🔥 Found {len(deals_found)} potential deals with statistical discounts")
    print(f"   📊 Most active segment: ${price_ranges['$5K-$10K']} listings in $5K-$10K range")
    
    if deals_found:
        top_deal = deals_found[0]
        print(f"   🎯 Top opportunity: {top_deal['listing']['title']} - {top_deal['discount_pct']:.1f}% discount")
    
    print(f"\n💡 STRATEGIC INSIGHTS:")
    print(f"   • Focus on {max(make_analysis.items(), key=lambda x: len(x[1]))[0].title()} models (most inventory)")
    print(f"   • Target sub-${median_price:,.0f} listings for below-market opportunities")
    print(f"   • Consider geographic analysis for price arbitrage")
    
    # Save analysis results
    analysis_results = {
        'timestamp': datetime.now().isoformat(),
        'total_listings_analyzed': len(price_data),
        'price_statistics': {
            'average': avg_price,
            'median': median_price,
            'min': min_price,
            'max': max_price,
            'std_dev': std_dev
        },
        'deals_found': deals_found,
        'make_analysis': {make: len(listings) for make, listings in make_analysis.items()},
        'price_distribution': price_ranges
    }
    
    output_file = f"market_intelligence_analysis_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    with open(output_file, 'w') as f:
        json.dump(analysis_results, f, indent=2)
    
    print(f"\n📁 Analysis saved to: {output_file}")
    print("="*60)

if __name__ == "__main__":
    analyze_extracted_data()
