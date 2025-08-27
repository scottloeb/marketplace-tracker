#!/usr/bin/env python3
"""
Migration script to move existing marketplace listings to Supabase
"""

import json
import asyncio
import os
from datetime import datetime
from supabase import create_client, Client

# Supabase configuration
SUPABASE_URL = os.getenv('SUPABASE_URL', 'YOUR_SUPABASE_URL')
SUPABASE_KEY = os.getenv('SUPABASE_KEY', 'YOUR_SUPABASE_ANON_KEY')

def load_existing_data(file_path):
    """Load existing listings from JSON file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # Handle different data formats
        if isinstance(data, dict) and 'data' in data:
            return data['data']
        elif isinstance(data, list):
            return data
        else:
            print(f"Unexpected data format in {file_path}")
            return []
            
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return []
    except json.JSONDecodeError as e:
        print(f"JSON decode error in {file_path}: {e}")
        return []

def transform_listing_data(listing):
    """Transform listing data to match Supabase schema"""
    return {
        'title': listing.get('title'),
        'price': listing.get('price'),
        'url': listing.get('url'),
        'location': listing.get('location'),
        'seller': listing.get('seller'),
        'photos': listing.get('photos'),
        'make': listing.get('make'),
        'model': listing.get('model'),
        'year': listing.get('year'),
        'engine_hours': listing.get('engine_hours'),
        'condition': listing.get('condition'),
        'description': listing.get('description'),
        'market_analysis': listing.get('market_analysis'),
        'status': 'active'
    }

async def migrate_to_supabase(listings_data):
    """Migrate listings to Supabase"""
    if not SUPABASE_URL or SUPABASE_URL == 'YOUR_SUPABASE_URL':
        print("❌ Please set SUPABASE_URL and SUPABASE_KEY environment variables")
        print("   Or update the script with your actual Supabase credentials")
        return False
    
    try:
        # Initialize Supabase client
        supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
        
        print(f"🔄 Migrating {len(listings_data)} listings to Supabase...")
        
        # Process listings in batches
        batch_size = 50
        total_processed = 0
        total_errors = 0
        
        for i in range(0, len(listings_data), batch_size):
            batch = listings_data[i:i + batch_size]
            transformed_batch = [transform_listing_data(listing) for listing in batch]
            
            try:
                # Insert batch into Supabase
                result = supabase.table('listings').insert(transformed_batch).execute()
                
                processed = len(result.data) if result.data else 0
                total_processed += processed
                
                print(f"✅ Processed batch {i//batch_size + 1}: {processed} listings")
                
            except Exception as e:
                print(f"❌ Error processing batch {i//batch_size + 1}: {e}")
                total_errors += len(batch)
        
        print(f"\n🎉 Migration completed!")
        print(f"   ✅ Successfully migrated: {total_processed} listings")
        print(f"   ❌ Errors: {total_errors} listings")
        
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        return False

def main():
    """Main migration function"""
    print("🚀 Marketplace Tracker - Supabase Migration")
    print("=" * 50)
    
    # Look for existing data files
    possible_files = [
        'automation/enhanced_286_complete_20250824_142413.json',
        'automation/complete_286_export.json',
        'tracker_export.json',
        'mobile_export.json'
    ]
    
    data_file = None
    for file_path in possible_files:
        if os.path.exists(file_path):
            data_file = file_path
            break
    
    if not data_file:
        print("❌ No existing data files found!")
        print("   Please ensure one of these files exists:")
        for file_path in possible_files:
            print(f"   - {file_path}")
        return
    
    print(f"📁 Found data file: {data_file}")
    
    # Load existing data
    listings_data = load_existing_data(data_file)
    
    if not listings_data:
        print("❌ No listings found in data file")
        return
    
    print(f"📊 Found {len(listings_data)} listings to migrate")
    
    # Confirm migration
    response = input("\n🤔 Proceed with migration? (y/N): ").strip().lower()
    if response != 'y':
        print("❌ Migration cancelled")
        return
    
    # Run migration
    success = asyncio.run(migrate_to_supabase(listings_data))
    
    if success:
        print("\n🎯 Next steps:")
        print("   1. Update your Supabase credentials in js/supabase-client.js")
        print("   2. Open unified-marketplace-tracker.html")
        print("   3. Test the real-time sync functionality")
        print("   4. Add new listings from your phone/laptop")

if __name__ == "__main__":
    main()
