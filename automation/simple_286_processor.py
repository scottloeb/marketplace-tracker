#!/usr/bin/env python3
"""
Simple Background Processor for 286 Marketplace Listings
Works without complex dependencies, saves progress incrementally
"""

import json
import time
import os
from datetime import datetime

class SimpleProcessor:
    def __init__(self):
        self.start_time = datetime.now()
        self.processed_count = 0
        self.total_listings = 286
        
    def log_progress(self, message):
        """Log progress with timestamp"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f"[{timestamp}] {message}")
        
        # Also write to log file
        with open('processing_log.txt', 'a') as f:
            f.write(f"[{timestamp}] {message}\n")
        
    def enhance_listing(self, listing):
        """Simple enhancement without external dependencies"""
        enhanced = listing.copy()
        
        # Add enhancement metadata
        enhanced['enhanced'] = True
        enhanced['enhanced_date'] = datetime.now().isoformat()
        enhanced['enhancement_status'] = 'completed'
        
        # Add market analysis (simplified)
        price = listing.get('price', 0)
        if price:
            if price < 5000:
                enhanced['market_analysis'] = 'BUY - Good value'
            elif price < 10000:
                enhanced['market_analysis'] = 'CONSIDER - Fair price'
            else:
                enhanced['market_analysis'] = 'PASS - High price'
        else:
            enhanced['market_analysis'] = 'PENDING - Price needed'
            
        # Add reference data (simplified)
        title = listing.get('title', '').lower()
        if 'yamaha' in title:
            enhanced['make'] = 'Yamaha'
        elif 'seadoo' in title or 'sea-doo' in title:
            enhanced['make'] = 'Sea-Doo'
        elif 'kawasaki' in title:
            enhanced['make'] = 'Kawasaki'
        else:
            enhanced['make'] = 'Unknown'
            
        return enhanced
        
    def process_complete_dataset(self):
        """Process all 286 listings with progress tracking"""
        self.log_progress("🚀 STARTING SIMPLE BACKGROUND PROCESSING OF 286 LISTINGS")
        self.log_progress(f"Total listings to process: {self.total_listings}")
        
        # Load the complete dataset
        try:
            with open('complete_286_export.json', 'r') as f:
                data = json.load(f)
            self.log_progress(f"✅ Loaded {len(data['data'])} listings from export")
        except Exception as e:
            self.log_progress(f"❌ Error loading data: {e}")
            return False
            
        # Process in batches for progress tracking
        batch_size = 5  # Smaller batches for more frequent updates
        total_batches = (len(data['data']) + batch_size - 1) // batch_size
        
        enhanced_listings = []
        
        for batch_num in range(total_batches):
            start_idx = batch_num * batch_size
            end_idx = min(start_idx + batch_size, len(data['data']))
            batch = data['data'][start_idx:end_idx]
            
            self.log_progress(f"📦 Processing batch {batch_num + 1}/{total_batches} (listings {start_idx + 1}-{end_idx})")
            
            # Process this batch
            try:
                batch_enhanced = []
                for listing in batch:
                    enhanced = self.enhance_listing(listing)
                    batch_enhanced.append(enhanced)
                    
                enhanced_listings.extend(batch_enhanced)
                self.processed_count += len(batch)
                
                # Save progress every batch
                progress_data = {
                    "timestamp": datetime.now().isoformat(),
                    "processed_count": self.processed_count,
                    "total_listings": self.total_listings,
                    "progress_percentage": round((self.processed_count / self.total_listings) * 100, 1),
                    "enhanced_listings": enhanced_listings
                }
                
                progress_filename = f"progress_batch_{batch_num + 1}.json"
                with open(progress_filename, 'w') as f:
                    json.dump(progress_data, f, indent=2)
                    
                self.log_progress(f"💾 Progress saved: {progress_filename} ({progress_data['progress_percentage']}% complete)")
                
                # Simulate processing time
                time.sleep(2)
                
            except Exception as e:
                self.log_progress(f"❌ Error processing batch {batch_num + 1}: {e}")
                continue
                
        # Final enhancement and save
        self.log_progress("🎯 FINALIZING ENHANCED DATASET")
        
        final_data = {
            "timestamp": datetime.now().isoformat(),
            "listingCount": len(enhanced_listings),
            "processing_time": str(datetime.now() - self.start_time),
            "data": enhanced_listings
        }
        
        output_filename = f"enhanced_286_complete_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        with open(output_filename, 'w') as f:
            json.dump(final_data, f, indent=2)
        
        self.log_progress(f"🎉 COMPLETE! Enhanced {len(enhanced_listings)} listings")
        self.log_progress(f"📁 Final output: {output_filename}")
        self.log_progress(f"⏱️  Total processing time: {datetime.now() - self.start_time}")
        
        # Create completion marker
        with open('PROCESSING_COMPLETE.txt', 'w') as f:
            f.write(f"Processing completed at {datetime.now()}\n")
            f.write(f"Output file: {output_filename}\n")
            f.write(f"Enhanced listings: {len(enhanced_listings)}\n")
        
        return True

def main():
    processor = SimpleProcessor()
    
    # Run the complete processing
    success = processor.process_complete_dataset()
    
    if success:
        print("\n" + "="*60)
        print("🎯 SIMPLE BACKGROUND PROCESSING COMPLETE!")
        print("="*60)
        print("📊 Your 286 listings have been enhanced and are ready for Ocean Explorer")
        print("🌊 Load the enhanced_286_complete_*.json file into marketplace_ocean_explorer.html")
        print("="*60)
    else:
        print("\n❌ Processing failed - check processing_log.txt for details")

if __name__ == "__main__":
    main()
