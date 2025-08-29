#!/usr/bin/env python3
"""
Screenshot Collector for Facebook Marketplace Listings
Captures screenshots of all listing URLs to fill in the gaps
"""

import json
import asyncio
import os
from datetime import datetime
from playwright.async_api import async_playwright
import logging

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class ScreenshotCollector:
    def __init__(self, input_file, output_dir="screenshots"):
        self.input_file = input_file
        self.output_dir = output_dir
        self.screenshot_count = 0
        self.failed_count = 0
        
        # Create output directory
        os.makedirs(output_dir, exist_ok=True)
        
    async def load_listings(self):
        """Load listings from JSON file"""
        try:
            with open(self.input_file, 'r') as f:
                data = json.load(f)
                
            # Handle both direct array and wrapper object
            if isinstance(data, dict) and 'data' in data:
                return data['data']
            elif isinstance(data, list):
                return data
            else:
                logger.error(f"Invalid JSON structure in {self.input_file}")
                return []
                
        except Exception as e:
            logger.error(f"Error loading listings: {e}")
            return []
    
    async def screenshot_listing(self, browser, listing):
        """Take screenshot of a single listing"""
        url = listing.get('url', '')
        title = listing.get('title', 'Unknown')
        listing_id = listing.get('id', 'unknown')
        
        if not url:
            logger.warning(f"No URL for listing: {title}")
            return False
            
        try:
            # Create new page
            page = await browser.new_page()
            
            # Set viewport for consistent screenshots
            await page.set_viewport_size({"width": 1200, "height": 800})
            
            # Navigate to URL with timeout
            logger.info(f"📸 Capturing: {title[:60]}...")
            await page.goto(url, wait_until='networkidle', timeout=30000)
            
            # Wait for content to load
            await page.wait_for_timeout(3000)
            
            # Generate filename
            safe_title = "".join(c for c in title if c.isalnum() or c in (' ', '-', '_')).rstrip()[:50]
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"{listing_id}_{safe_title}_{timestamp}.png"
            filepath = os.path.join(self.output_dir, filename)
            
            # Take screenshot
            await page.screenshot(path=filepath, full_page=True)
            
            # Close page to free memory
            await page.close()
            
            self.screenshot_count += 1
            logger.info(f"✅ Screenshot saved: {filename}")
            return True
            
        except Exception as e:
            self.failed_count += 1
            logger.error(f"❌ Failed to screenshot {title}: {e}")
            if 'page' in locals():
                await page.close()
            return False
    
    async def collect_all_screenshots(self):
        """Main function to collect all screenshots"""
        logger.info("🚀 Starting screenshot collection...")
        
        # Load listings
        listings = await self.load_listings()
        if not listings:
            logger.error("No listings found to process")
            return
            
        logger.info(f"📋 Found {len(listings)} listings to screenshot")
        
        async with async_playwright() as p:
            # Launch browser
            browser = await p.chromium.launch(
                headless=True,  # Set to False to see browser
                args=['--no-sandbox', '--disable-setuid-sandbox']
            )
            
            try:
                # Process listings in batches to avoid overwhelming Facebook
                batch_size = 3  # Conservative batch size
                for i in range(0, len(listings), batch_size):
                    batch = listings[i:i + batch_size]
                    
                    logger.info(f"📦 Processing batch {i//batch_size + 1}/{(len(listings) + batch_size - 1)//batch_size}")
                    
                    # Process batch
                    tasks = [self.screenshot_listing(browser, listing) for listing in batch]
                    await asyncio.gather(*tasks, return_exceptions=True)
                    
                    # Wait between batches to be respectful
                    if i + batch_size < len(listings):
                        logger.info("⏳ Waiting between batches...")
                        await asyncio.sleep(5)
                        
            finally:
                await browser.close()
        
        # Summary
        logger.info(f"""
🎯 Screenshot Collection Complete!
✅ Successful: {self.screenshot_count}
❌ Failed: {self.failed_count}
📁 Screenshots saved to: {self.output_dir}/
        """)

async def main():
    """Main entry point"""
    import sys
    
    # Check for command line argument first
    if len(sys.argv) > 1:
        input_file = sys.argv[1]
        if not os.path.exists(input_file):
            logger.error(f"Specified file not found: {input_file}")
            return
    else:
        # Default to latest import file
        input_files = [
            "google_sheet_import_complete_181_listings.json",
            "complete_csv_import_20250828_222849.json",
            "google_sheet_import_20250828_205743.json",
            "google_sheet_import_20250828_124040.json",
            "enhanced_286_complete_20250824_142413.json"
        ]
        
        input_file = None
        for file in input_files:
            if os.path.exists(file):
                input_file = file
                break
        
        if not input_file:
            logger.error("No valid input file found")
            return
    
    logger.info(f"📂 Using input file: {input_file}")
    
    # Create collector and run
    collector = ScreenshotCollector(input_file)
    await collector.collect_all_screenshots()

if __name__ == "__main__":
    asyncio.run(main())
