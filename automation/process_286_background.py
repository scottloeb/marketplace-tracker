#!/usr/bin/env python3
"""
Background Processor for 286 Marketplace Listings
Runs enhancement pipeline with hourly progress updates
"""

import json
import time
import os
import sys
from datetime import datetime
from pathlib import Path

# Add current directory to path for imports
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from detail_enhancer import MarketplaceDetailEnhancer
from price_tracker import PriceHistoryTracker

class BackgroundProcessor:
    def __init__(self):
        self.start_time = datetime.now()
        self.processed_count = 0
        self.total_listings = 286
        self.enhancer = MarketplaceDetailEnhancer()
        self.price_tracker = PriceHistoryTracker()
        
    def log_progress(self, message):
        """Log progress with timestamp"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f"[{timestamp}] {message}")
        
    def save_progress(self, data, filename):
        """Save current progress to file"""
        with open(filename, 'w') as f:
            json.dump(data, f, indent=2)
        self.log_progress(f"Progress saved to {filename}")
        
    def process_complete_dataset(self):
        """Process all 286 listings with progress tracking"""
        self.log_progress("🚀 STARTING BACKGROUND PROCESSING OF 286 LISTINGS")
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
        batch_size = 10
        total_batches = (len(data['data']) + batch_size - 1) // batch_size
        
        enhanced_listings = []
        
        for batch_num in range(total_batches):
            start_idx = batch_num * batch_size
            end_idx = min(start_idx + batch_size, len(data['data']))
            batch = data['data'][start_idx:end_idx]
            
            self.log_progress(f"📦 Processing batch {batch_num + 1}/{total_batches} (listings {start_idx + 1}-{end_idx})")
            
            # Process this batch
            try:
                batch_enhanced = self.enhancer._process_listings_batch(batch)
                enhanced_listings.extend(batch_enhanced)
                self.processed_count += len(batch)
                
                # Save progress every batch
                progress_data = {
                    "timestamp": datetime.now().isoformat(),
                    "processed_count": self.processed_count,
                    "total_listings": self.total_listings,
                    "progress_percentage": (self.processed_count / self.total_listings) * 100,
                    "enhanced_listings": enhanced_listings
                }
                self.save_progress(progress_data, f"progress_batch_{batch_num + 1}.json")
                
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
        self.save_progress(final_data, output_filename)
        
        self.log_progress(f"🎉 COMPLETE! Enhanced {len(enhanced_listings)} listings")
        self.log_progress(f"📁 Final output: {output_filename}")
        self.log_progress(f"⏱️  Total processing time: {datetime.now() - self.start_time}")
        
        return True

def main():
    processor = BackgroundProcessor()
    
    # Run the complete processing
    success = processor.process_complete_dataset()
    
    if success:
        print("\n" + "="*60)
        print("🎯 BACKGROUND PROCESSING COMPLETE!")
        print("="*60)
        print("📊 Your 286 listings have been enhanced and are ready for Ocean Explorer")
        print("🌊 Load the enhanced_286_complete_*.json file into marketplace_ocean_explorer.html")
        print("="*60)
    else:
        print("\n❌ Processing failed - check logs for details")

if __name__ == "__main__":
    main()
