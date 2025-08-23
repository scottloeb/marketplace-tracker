#!/usr/bin/env python3
"""
Create Real Test Data
Generate realistic test data that matches your mobile tracker export format.
"""

import json
from datetime import datetime, timedelta


def create_realistic_tracker_export():
    """Create realistic tracker export data that simulates your 286+ listings."""
    
    # Sample of what your tracker data might look like
    # Mix of complete listings (your existing 286) and new URL-only captures
    
    # Existing complete listings (simulating part of your 286)
    existing_listings = [
        {
            "id": 1640995200000,
            "title": "2019 Sea-Doo GTX 155 - Excellent condition",
            "price": 8500,
            "url": "https://www.facebook.com/marketplace/item/existing1",
            "source": "Facebook Marketplace",
            "status": "pending",
            "addedDate": "2025-01-10T10:00:00Z",
            "mobileAdded": True,
            "location": "Sacramento, CA",
            "seller": "John's Watercraft"
        },
        {
            "id": 1640995300000,
            "title": "2020 Yamaha VX Cruiser HO - 45 hours",
            "price": 11200,
            "url": "https://www.facebook.com/marketplace/item/existing2",
            "source": "Facebook Marketplace",
            "status": "pending",
            "addedDate": "2025-01-10T11:30:00Z",
            "mobileAdded": True,
            "location": "San Francisco, CA"
        },
        {
            "id": 1640995400000,
            "title": "2018 Kawasaki Ultra 310X - Supercharged",
            "price": 13800,
            "url": "https://www.facebook.com/marketplace/item/existing3",
            "source": "Facebook Marketplace",
            "status": "pending",
            "addedDate": "2025-01-10T14:15:00Z",
            "mobileAdded": True,
            "location": "Los Angeles, CA"
        }
    ]
    
    # New URL-only captures (what you'd add on mobile today)
    url_only_captures = [
        {
            "id": int(datetime.now().timestamp() * 1000),
            "title": "",  # Empty - just captured URL
            "price": None,
            "url": "https://www.facebook.com/marketplace/item/placeholder1",  # You'd replace with real URL
            "source": "Facebook Marketplace",
            "status": "url_only",
            "addedDate": datetime.now().isoformat(),
            "mobileAdded": True,
            "urlOnly": True,
            "enhancementNeeded": True,
            "notes": "Quick capture - needs laptop enhancement"
        },
        {
            "id": int(datetime.now().timestamp() * 1000) + 1,
            "title": "Yamaha FX",  # Minimal title from quick mobile entry
            "price": None,
            "url": "https://www.facebook.com/marketplace/item/placeholder2",  # You'd replace with real URL
            "source": "Facebook Marketplace",
            "status": "url_only", 
            "addedDate": datetime.now().isoformat(),
            "mobileAdded": True,
            "urlOnly": True,
            "enhancementNeeded": True,
            "notes": "Partial info - needs laptop enhancement"
        },
        {
            "id": int(datetime.now().timestamp() * 1000) + 2,
            "title": "",  # Empty - URL only
            "price": None,
            "url": "https://www.facebook.com/marketplace/item/placeholder3",  # You'd replace with real URL
            "source": "Facebook Marketplace",
            "status": "url_only",
            "addedDate": datetime.now().isoformat(),
            "mobileAdded": True,
            "urlOnly": True,
            "enhancementNeeded": True,
            "notes": "URL capture - full enhancement needed"
        }
    ]
    
    # Combine all data (simulating your real tracker state)
    all_listings = existing_listings + url_only_captures
    
    # Create tracker export format
    tracker_export = {
        "timestamp": datetime.now().isoformat(),
        "listingCount": len(all_listings),
        "exportedFrom": "mobile_tracker_simulation",
        "data": all_listings
    }
    
    return tracker_export


def save_test_files():
    """Save realistic test files for production workflow testing."""
    
    # Create the realistic export
    tracker_export = create_realistic_tracker_export()
    
    # Save as the expected filename
    with open("tracker_export.json", 'w') as f:
        json.dump(tracker_export, f, indent=2)
    
    # Also save as alternative names for testing
    with open("mobile_export.json", 'w') as f:
        json.dump(tracker_export, f, indent=2)
    
    print("📁 Created realistic test data files:")
    print(f"✅ tracker_export.json - {tracker_export['listingCount']} listings")
    print(f"✅ mobile_export.json - Copy for testing")
    
    # Show breakdown
    url_only_count = sum(1 for l in tracker_export['data'] 
                        if l.get('urlOnly') or l.get('status') == 'url_only')
    complete_count = tracker_export['listingCount'] - url_only_count
    
    print(f"\n📊 Data breakdown:")
    print(f"  • {complete_count} complete listings (simulating your 286)")
    print(f"  • {url_only_count} URL-only captures (need enhancement)")
    
    print(f"\n🎯 PRODUCTION USAGE:")
    print("1. Replace placeholder URLs with real Facebook Marketplace URLs")
    print("2. Run: python3 detail_enhancer.py --source file --input-file tracker_export.json")
    print("3. Import enhanced results back to tracker")
    
    return tracker_export


def create_real_url_template():
    """Create template for real Facebook URLs."""
    
    template = {
        "instructions": "Replace placeholder URLs with real Facebook Marketplace URLs",
        "url_format": "https://www.facebook.com/marketplace/item/[ITEM_ID]",
        "examples": [
            "https://www.facebook.com/marketplace/item/1234567890123456",
            "https://www.facebook.com/marketplace/item/6543210987654321"
        ],
        "how_to_get_urls": [
            "1. Go to Facebook Marketplace",
            "2. Search for 'jet ski' or 'personal watercraft'",
            "3. Click on a listing",
            "4. Copy the URL from your browser",
            "5. Replace placeholder URLs in tracker_export.json"
        ],
        "placeholder_urls_to_replace": [
            "https://www.facebook.com/marketplace/item/placeholder1",
            "https://www.facebook.com/marketplace/item/placeholder2",
            "https://www.facebook.com/marketplace/item/placeholder3"
        ]
    }
    
    with open("real_url_template.json", 'w') as f:
        json.dump(template, f, indent=2)
    
    print("📋 Created real URL template: real_url_template.json")
    return template


if __name__ == "__main__":
    print("🏍️ Creating Real Test Data for Production Workflow")
    print("="*60)
    
    # Create realistic test data
    tracker_data = save_test_files()
    
    # Create URL template
    url_template = create_real_url_template()
    
    print("\n✅ REAL TEST DATA READY!")
    print("="*60)
    print("📂 Files created:")
    print("  • tracker_export.json - Realistic tracker data")
    print("  • mobile_export.json - Copy for testing")
    print("  • real_url_template.json - Instructions for real URLs")
    
    print("\n🎯 TO USE WITH REAL DATA:")
    print("1. Edit tracker_export.json")
    print("2. Replace placeholder URLs with real Facebook Marketplace URLs")
    print("3. Run: python3 detail_enhancer.py --source file --input-file tracker_export.json")
    print("4. Watch as it auto-fills all missing details from real Facebook pages!")
    
    print("\n🚀 Ready for production workflow with your actual 286+ listings!")
