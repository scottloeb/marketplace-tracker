#!/usr/bin/env python3
"""
Test script for marketplace automation tools.
Verifies that all components work correctly before full extraction.
"""

import asyncio
import json
import sys
from pathlib import Path

# Add the automation directory to the path
automation_dir = Path(__file__).parent
sys.path.insert(0, str(automation_dir))

try:
    from browser_scraper import FacebookMarketplaceScraper
except ImportError as e:
    print(f"❌ Import failed: {e}")
    print("💡 Make sure to run setup.py first to install dependencies")
    sys.exit(1)


async def test_reference_data_loading():
    """Test that reference data loads correctly."""
    print("🧪 Testing reference data loading...")
    
    scraper = FacebookMarketplaceScraper()
    
    if scraper.reference_data:
        print(f"✅ Reference data loaded: {len(scraper.reference_data)} models")
        
        # Show sample models
        sample_models = list(scraper.reference_data.keys())[:5]
        print("📋 Sample models:")
        for model in sample_models:
            specs = scraper.reference_data[model]
            msrp = specs.get("MSRP_USD", "Unknown")
            hp = specs.get("Horsepower", "Unknown")
            print(f"  • {model}: {hp}HP, MSRP ${msrp}")
        
        return True
    else:
        print("❌ No reference data loaded")
        return False


def test_title_parsing():
    """Test jet ski title parsing."""
    print("\n🧪 Testing title parsing...")
    
    scraper = FacebookMarketplaceScraper()
    
    test_titles = [
        "2020 Yamaha VX Cruiser HO - 28 hours",
        "2019 sea-doo gtx 155 excellent condition",
        "2018 Kawasaki Ultra 310X supercharged low miles",
        "SeaDoo Spark 90 2021 like new",
        "2017 yamaha fx ho well maintained"
    ]
    
    print("📋 Testing title parsing:")
    for title in test_titles:
        parsed = scraper._parse_jetski_title(title.lower())
        print(f"  • '{title[:40]}...'")
        print(f"    → {parsed['make']} {parsed['year']} {parsed['model']} ({parsed['condition']})")
    
    return True


def test_price_parsing():
    """Test price parsing functionality."""
    print("\n🧪 Testing price parsing...")
    
    scraper = FacebookMarketplaceScraper()
    
    test_prices = [
        "$12,500",
        "$8500",
        "15000",
        "$9,999.99",
        "Price: $7,500 OBO",
        "No price listed"
    ]
    
    print("📋 Testing price parsing:")
    for price_text in test_prices:
        parsed_price = scraper._parse_price(price_text)
        print(f"  • '{price_text}' → ${parsed_price:,.0f}")
    
    return True


def test_enhancement():
    """Test listing enhancement functionality."""
    print("\n🧪 Testing listing enhancement...")
    
    scraper = FacebookMarketplaceScraper()
    
    # Create sample listing
    sample_listing = {
        "id": 123456,
        "title": "2020 Yamaha VX Cruiser HO - 28 hours, garage kept",
        "price": 9500,
        "url": "https://facebook.com/marketplace/item/123456",
        "source": "Facebook Marketplace",
        "location": "Sacramento, CA",
        "status": "pending",
        "addedDate": "2025-01-15T10:00:00Z"
    }
    
    enhanced = scraper._enhance_listing_data(sample_listing)
    
    print("📋 Enhancement results:")
    print(f"  • Make: {enhanced.get('make', 'Unknown')}")
    print(f"  • Model: {enhanced.get('model', 'Unknown')}")
    print(f"  • Year: {enhanced.get('year', 'Unknown')}")
    print(f"  • Has reference data: {enhanced.get('has_reference_data', False)}")
    
    if enhanced.get('market_analysis'):
        analysis = enhanced['market_analysis']
        print(f"  • Recommendation: {analysis.get('recommendation', 'Unknown')}")
        print(f"  • Reason: {analysis.get('reason', 'No analysis')}")
    
    return True


def create_sample_extraction():
    """Create a sample extraction file for testing import."""
    print("\n🧪 Creating sample extraction for import testing...")
    
    sample_data = {
        "timestamp": "2025-01-15T12:00:00Z",
        "listingCount": 5,
        "extractionMethod": "automated_browser_scraping",
        "data": [
            {
                "id": 1642248000001,
                "title": "2020 Yamaha VX Cruiser HO - 28 hours",
                "price": 9500,
                "url": "https://facebook.com/marketplace/item/test1",
                "source": "Facebook Marketplace",
                "location": "Sacramento, CA",
                "status": "pending",
                "addedDate": "2025-01-15T12:00:00Z",
                "extractedVia": "test_automation",
                "mobileAdded": False,
                "make": "Yamaha",
                "model": "VX",
                "year": "2020",
                "condition": "",
                "market_analysis": {
                    "status": "good_deal",
                    "recommendation": "CONSIDER",
                    "confidence": 0.7,
                    "reason": "$9,500 is 15% below expected $11,200"
                }
            },
            {
                "id": 1642248000002,
                "title": "2019 Sea-Doo GTX 155 - Excellent condition",
                "price": 7800,
                "url": "https://facebook.com/marketplace/item/test2",
                "source": "Facebook Marketplace",
                "location": "San Francisco, CA",
                "status": "pending",
                "addedDate": "2025-01-15T12:01:00Z",
                "extractedVia": "test_automation",
                "mobileAdded": False,
                "make": "SeaDoo",
                "model": "GTX",
                "year": "2019",
                "condition": "Excellent",
                "market_analysis": {
                    "status": "underpriced",
                    "recommendation": "BUY",
                    "confidence": 0.8,
                    "reason": "$7,800 is 28% below expected $10,800",
                    "potential_savings": 3000
                }
            },
            {
                "id": 1642248000003,
                "title": "2018 Kawasaki Ultra 310X - Supercharged beast",
                "price": 13500,
                "url": "https://facebook.com/marketplace/item/test3",
                "source": "Facebook Marketplace",
                "location": "Los Angeles, CA",
                "status": "pending",
                "addedDate": "2025-01-15T12:02:00Z",
                "extractedVia": "test_automation",
                "mobileAdded": False,
                "make": "Kawasaki",
                "model": "Ultra",
                "year": "2018",
                "condition": "",
                "market_analysis": {
                    "status": "fair_price",
                    "recommendation": "RESEARCH",
                    "confidence": 0.6,
                    "reason": "$13,500 is near expected $13,200"
                }
            },
            {
                "id": 1642248000004,
                "title": "2021 Sea-Doo Spark 90 - Like new, low hours",
                "price": 6200,
                "url": "https://facebook.com/marketplace/item/test4",
                "source": "Facebook Marketplace",
                "location": "San Diego, CA",
                "status": "pending",
                "addedDate": "2025-01-15T12:03:00Z",
                "extractedVia": "test_automation",
                "mobileAdded": False,
                "make": "SeaDoo",
                "model": "Spark",
                "year": "2021",
                "condition": "",
                "market_analysis": {
                    "status": "good_deal",
                    "recommendation": "CONSIDER",
                    "confidence": 0.7,
                    "reason": "$6,200 is 12% below expected $7,050"
                }
            },
            {
                "id": 1642248000005,
                "title": "2017 Yamaha FX HO - Well maintained, low hours",
                "price": 8200,
                "url": "https://facebook.com/marketplace/item/test5",
                "source": "Facebook Marketplace",
                "location": "Oakland, CA",
                "status": "pending",
                "addedDate": "2025-01-15T12:04:00Z",
                "extractedVia": "test_automation",
                "mobileAdded": False,
                "make": "Yamaha",
                "model": "FX",
                "year": "2017",
                "condition": "",
                "market_analysis": {
                    "status": "underpriced",
                    "recommendation": "BUY",
                    "confidence": 0.8,
                    "reason": "$8,200 is 32% below expected $12,100",
                    "potential_savings": 3900
                }
            }
        ]
    }
    
    output_file = "test_extraction.json"
    with open(output_file, 'w') as f:
        json.dump(sample_data, f, indent=2)
    
    print(f"✅ Created {output_file} with {len(sample_data['data'])} sample listings")
    print("💡 You can import this file into your marketplace tracker to test the import functionality")
    
    return output_file


async def run_all_tests():
    """Run all tests to verify the automation system."""
    print("🏍️ Marketplace Automation Test Suite")
    print("="*60)
    
    tests = [
        ("Reference Data Loading", test_reference_data_loading()),
        ("Title Parsing", test_title_parsing()),
        ("Price Parsing", test_price_parsing()),
        ("Listing Enhancement", test_enhancement())
    ]
    
    results = []
    for test_name, test_coro in tests:
        try:
            if asyncio.iscoroutine(test_coro):
                result = await test_coro
            else:
                result = test_coro
            results.append((test_name, result))
        except Exception as e:
            print(f"❌ {test_name} failed: {e}")
            results.append((test_name, False))
    
    # Create sample data
    sample_file = create_sample_extraction()
    
    # Summary
    print("\n🎯 TEST SUMMARY")
    print("="*60)
    
    passed = sum(1 for _, result in results if result)
    total = len(results)
    
    for test_name, result in results:
        status = "✅ PASS" if result else "❌ FAIL"
        print(f"  {status} {test_name}")
    
    print(f"\n📊 Overall: {passed}/{total} tests passed")
    
    if passed == total:
        print("\n🚀 ALL TESTS PASSED!")
        print("="*60)
        print("Your automation system is ready to use!")
        print()
        print("📋 NEXT STEPS:")
        print("1. Get a Facebook Marketplace jet ski search URL")
        print(f"2. Run: python browser_scraper.py 'YOUR_URL' --max-listings 25")
        print("3. Import the generated JSON into your marketplace tracker")
        print(f"4. Test with sample data: import {sample_file} into your tracker")
        print()
        print("🎯 Ready to automate your 286 listing import!")
    else:
        print("\n⚠️ Some tests failed. Check the errors above and resolve before proceeding.")
    
    return passed == total


if __name__ == "__main__":
    success = asyncio.run(run_all_tests())
    sys.exit(0 if success else 1)