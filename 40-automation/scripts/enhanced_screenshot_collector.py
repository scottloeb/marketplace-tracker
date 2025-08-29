#!/usr/bin/env python3
"""
Enhanced Screenshot Collector with Detail Expansion
Handles "See more" buttons and extracts full listing details
"""

import json
import asyncio
import os
from datetime import datetime
from playwright.async_api import async_playwright
import logging
import re

logger = logging.getLogger(__name__)

class EnhancedScreenshotCollector:
    def __init__(self, input_file, output_dir="screenshots"):
        self.input_file = input_file
        self.output_dir = output_dir
        self.screenshot_count = 0
        self.failed_count = 0
        self.extracted_data = []
        
        os.makedirs(output_dir, exist_ok=True)
        
    async def expand_details(self, page):
        """Expand all 'See more' buttons and details"""
        try:
            # Common "See more" button selectors
            see_more_selectors = [
                '[aria-label="See more"]',
                'button:has-text("See more")',
                '[data-testid="see-more-button"]',
                '.see-more-button',
                'button[aria-expanded="false"]'
            ]
            
            # Try to click all "See more" buttons
            for selector in see_more_selectors:
                buttons = await page.query_selector_all(selector)
                for button in buttons:
                    try:
                        await button.click()
                        await page.wait_for_timeout(500)  # Brief wait for expansion
                    except:
                        continue
            
            # Wait for content to fully load
            await page.wait_for_timeout(1000)
            
        except Exception as e:
            logger.debug(f"Detail expansion failed: {e}")
    
    async def extract_listing_data(self, page, url):
        """Extract comprehensive listing data from the page"""
        data = {"url": url}
        
        try:
            # Extract price
            price_selectors = [
                '[data-testid="marketplace-product-price"]',
                '.marketplace-price',
                '[aria-label*="price"]',
                'span:has-text("$")'
            ]
            
            for selector in price_selectors:
                price_elem = await page.query_selector(selector)
                if price_elem:
                    price_text = await price_elem.inner_text()
                    price_match = re.search(r'\$[\d,]+', price_text)
                    if price_match:
                        data['price'] = price_match.group().replace('$', '').replace(',', '')
                        break
            
            # Extract title
            title_selectors = [
                'h1',
                '[data-testid="marketplace-product-title"]',
                '.marketplace-title'
            ]
            
            for selector in title_selectors:
                title_elem = await page.query_selector(selector)
                if title_elem:
                    data['title'] = await title_elem.inner_text()
                    break
            
            # Extract description/details
            desc_selectors = [
                '[data-testid="marketplace-product-description"]',
                '.marketplace-description',
                '[role="article"] div:has-text("Details")'
            ]
            
            for selector in desc_selectors:
                desc_elem = await page.query_selector(selector)
                if desc_elem:
                    data['description'] = await desc_elem.inner_text()
                    break
            
            # Extract location
            location_selectors = [
                '[data-testid="marketplace-product-location"]',
                '.marketplace-location',
                'span:has-text("miles away")'
            ]
            
            for selector in location_selectors:
                loc_elem = await page.query_selector(selector)
                if loc_elem:
                    data['location'] = await loc_elem.inner_text()
                    break
            
            # Extract seller info
            seller_selectors = [
                '[data-testid="marketplace-product-seller"]',
                '.marketplace-seller'
            ]
            
            for selector in seller_selectors:
                seller_elem = await page.query_selector(selector)
                if seller_elem:
                    data['seller'] = await seller_elem.inner_text()
                    break
            
            # Extract images (URLs)
            img_elements = await page.query_selector_all('img')
            images = []
            for img in img_elements:
                src = await img.get_attribute('src')
                if src and ('scontent' in src or 'fbcdn' in src):
                    images.append(src)
            data['images'] = images[:10]  # Limit to first 10 images
            
            return data
            
        except Exception as e:
            logger.error(f"Data extraction failed for {url}: {e}")
            return data
    
    async def screenshot_and_extract(self, browser, listing):
        """Enhanced screenshot with data extraction"""
        url = listing.get('url', '')
        title = listing.get('title', 'Unknown')
        listing_id = listing.get('id', 'unknown')
        
        if not url:
            logger.warning(f"No URL for listing: {title}")
            return None
            
        try:
            page = await browser.new_page()
            
            # Navigate to listing
            await page.goto(url, wait_until='networkidle', timeout=30000)
            
            # Expand all details
            await self.expand_details(page)
            
            # Extract data
            extracted_data = await self.extract_listing_data(page, url)
            
            # Take screenshot
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            clean_title = re.sub(r'[^\w\s-]', '', title)[:50]
            filename = f"{listing_id}_{clean_title}_{timestamp}.png"
            filepath = os.path.join(self.output_dir, filename)
            
            await page.screenshot(path=filepath, full_page=True)
            
            # Add screenshot path to extracted data
            extracted_data['screenshot'] = filename
            extracted_data['listing_id'] = listing_id
            extracted_data['extraction_timestamp'] = timestamp
            
            self.extracted_data.append(extracted_data)
            self.screenshot_count += 1
            
            logger.info(f"✅ Enhanced capture: {title} - Price: ${extracted_data.get('price', 'N/A')}")
            
            await page.close()
            return extracted_data
            
        except Exception as e:
            logger.error(f"❌ Failed to capture {title}: {e}")
            self.failed_count += 1
            if 'page' in locals():
                await page.close()
            return None
    
    async def collect_enhanced_screenshots(self):
        """Main collection process with enhanced data extraction"""
        logger.info("🚀 Starting enhanced screenshot collection with data extraction...")
        
        # Load listings
        try:
            with open(self.input_file, 'r') as f:
                data = json.load(f)
            listings = data['data'] if 'data' in data else data
        except Exception as e:
            logger.error(f"Error loading listings: {e}")
            return
        
        logger.info(f"📋 Found {len(listings)} listings to process")
        
        async with async_playwright() as p:
            browser = await p.chromium.launch(headless=True)
            
            try:
                # Process in batches of 3 for enhanced extraction
                batch_size = 3
                for i in range(0, len(listings), batch_size):
                    batch = listings[i:i + batch_size]
                    batch_num = (i // batch_size) + 1
                    total_batches = (len(listings) + batch_size - 1) // batch_size
                    
                    logger.info(f"📦 Processing enhanced batch {batch_num}/{total_batches}")
                    
                    # Process batch with data extraction
                    tasks = [self.screenshot_and_extract(browser, listing) for listing in batch]
                    await asyncio.gather(*tasks, return_exceptions=True)
                    
                    # Wait between batches
                    if i + batch_size < len(listings):
                        logger.info("⏳ Waiting between enhanced batches...")
                        await asyncio.sleep(8)  # Longer wait for detailed extraction
                        
            finally:
                await browser.close()
        
        # Save extracted data
        output_file = f"enhanced_extraction_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        with open(output_file, 'w') as f:
            json.dump({
                'extraction_timestamp': datetime.now().isoformat(),
                'total_processed': len(self.extracted_data),
                'data': self.extracted_data
            }, f, indent=2)
        
        logger.info(f"""
🎯 Enhanced Collection Complete!
✅ Successful: {self.screenshot_count}
❌ Failed: {self.failed_count}
📁 Screenshots: {self.output_dir}/
📊 Enhanced data: {output_file}
💰 Prices extracted: {len([d for d in self.extracted_data if d.get('price')])}
        """)

async def main():
    """Main entry point for enhanced collector"""
    import sys
    
    if len(sys.argv) > 1:
        input_file = sys.argv[1]
    else:
        input_file = "google_sheet_import_complete_181_listings.json"
    
    if not os.path.exists(input_file):
        logger.error(f"Input file not found: {input_file}")
        return
    
    logger.info(f"📂 Using input file: {input_file}")
    
    collector = EnhancedScreenshotCollector(input_file)
    await collector.collect_enhanced_screenshots()

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    asyncio.run(main())
