#!/usr/bin/env python3
"""
Fixed Facebook Marketplace Detail Enhancer
Handles individual listing URLs with stealth configuration.
"""

import asyncio
import json
import re
import random
from datetime import datetime
from typing import Dict, List, Optional, Any
from playwright.async_api import async_playwright
import argparse

class FixedMarketplaceEnhancer:
    """Enhanced scraper with stealth configuration and better parsing."""
    
    async def enhance_listings_from_file(self, input_file: str):
        """Process individual listing URLs from JSON file."""
        
        # Load listings
        with open(input_file, 'r') as f:
            listings = json.load(f)
        
        print(f"Processing {len(listings)} listings...")
        
        async with async_playwright() as p:
            # Enhanced browser configuration
            browser = await p.chromium.launch(
                headless=True,
                args=[
                    '--no-sandbox',
                    '--disable-blink-features=AutomationControlled',
                    '--disable-dev-shm-usage',
                    '--disable-web-security',
                    '--disable-extensions',
                    '--no-first-run'
                ]
            )
            
            # Create stealth context
            context = await browser.new_context(
                viewport={'width': 1366, 'height': 768},
                user_agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',
                locale='en-US',
                timezone_id='America/New_York'
            )
            
            try:
                enhanced_listings = []
                
                for i, listing in enumerate(listings):
                    print(f"Processing listing {i+1}/{len(listings)}: {listing.get('url', 'No URL')}")
                    
                    enhanced = await self._process_single_listing(context, listing)
                    enhanced_listings.append(enhanced)
                    
                    # Random delay to avoid detection
                    await asyncio.sleep(random.uniform(2, 5))
                
                # Save results
                output_file = f"enhanced_tracker_data_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
                
                output_data = {
                    "timestamp": datetime.now().isoformat(),
                    "listingCount": len(enhanced_listings),
                    "enhancementMethod": "fixed_individual_extraction",
                    "data": enhanced_listings
                }
                
                with open(output_file, 'w') as f:
                    json.dump(output_data, f, indent=2)
                
                print(f"Enhanced data saved: {output_file}")
                return output_file
                
            finally:
                await browser.close()
    
    async def _process_single_listing(self, context, listing: Dict) -> Dict:
        """Process a single Facebook listing URL."""
        url = listing.get('url', '')
        
        if not url or 'facebook.com' not in url:
            return listing
        
        page = await context.new_page()
        
        try:
            # Navigate to listing
            await page.goto(url, wait_until="domcontentloaded", timeout=15000)
            
            # Wait for content to load
            await asyncio.sleep(random.uniform(1, 3))
            
            # Extract title
            title = await self._extract_title(page)
            
            # Extract price with improved parsing
            price = await self._extract_price(page)
            
            # Extract location
            location = await self._extract_location(page)
            
            # Update listing
            enhanced = listing.copy()
            if title and title != "Unknown":
                enhanced['title'] = title
                enhanced['status'] = 'enhanced'
            if price > 0:
                enhanced['price'] = price
            if location:
                enhanced['location'] = location
            
            # Add extracted info
            if title:
                parsed_info = self._parse_jetski_info(title)
                enhanced.update(parsed_info)
            
            print(f"✅ Enhanced: {title[:50]}... - ${price}")
            return enhanced
            
        except Exception as e:
            print(f"⚠️ Failed to enhance {url}: {str(e)}")
            return listing
            
        finally:
            await page.close()
    
    async def _extract_title(self, page) -> str:
        """Extract listing title with multiple selectors."""
        selectors = [
            'h1[data-testid="fb-marketplace-item-details-header-title"]',
            'h1.x1heor9g',
            'span[dir="auto"][role="heading"]',
            'h1 span',
            '.x1lliihq.x6ikm8r.x10wlt62.x1n2onr6'
        ]
        
        for selector in selectors:
            try:
                element = await page.wait_for_selector(selector, timeout=3000)
                if element:
                    title = await element.inner_text()
                    if title and len(title.strip()) > 3:
                        return title.strip()
            except:
                continue
        
        return ""
    
    async def _extract_price(self, page) -> float:
        """Extract price with improved parsing."""
        selectors = [
            '[data-testid="marketplace-item-price-amount"]',
            'span.x193iq5w.xeuugli.x13faqbe.x1vvkbs.x1s928wv.xhkezso.x1gmr53x.x1cpjm7i.x1fgarty.x1943h6x.x4zkp8e.x676frb.x1nxh6w3.x1sibtaa.xo1l8bm.xi81zsa',
            'span:has-text("$"):not(:has-text("Save"))'
        ]
        
        for selector in selectors:
            try:
                elements = await page.query_selector_all(selector)
                for element in elements:
                    text = await element.inner_text()
                    if '$' in text and 'Save' not in text:
                        price = self._parse_price_text(text)
                        if price > 0:
                            return price
            except:
                continue
        
        return 0.0
    
    def _parse_price_text(self, price_text: str) -> float:
        """Fixed price parsing logic."""
        if not price_text:
            return 0.0
        
        # Find the first price pattern
        price_match = re.search(r'\$[\d,]+(?:\.\d{2})?', price_text)
        if price_match:
            # Extract just the matched price
            price_str = price_match.group()
            # Remove $ and commas
            price_clean = price_str.replace('$', '').replace(',', '')
            try:
                return float(price_clean)
            except ValueError:
                return 0.0
        
        return 0.0
    
    async def _extract_location(self, page) -> str:
        """Extract location information."""
        selectors = [
            '[data-testid="marketplace-item-location"]',
            'span:has-text(", ")',
            'div:has-text("mi away")'
        ]
        
        for selector in selectors:
            try:
                element = await page.query_selector(selector)
                if element:
                    text = await element.inner_text()
                    # Look for city, state pattern
                    location_match = re.search(r'([A-Za-z\s]+,\s*[A-Z]{2})', text)
                    if location_match:
                        return location_match.group(1)
            except:
                continue
        
        return ""
    
    def _parse_jetski_info(self, title: str) -> Dict:
        """Parse jet ski information from title."""
        title_lower = title.lower()
        info = {
            "make": "",
            "model": "",
            "year": "",
            "type": "Jet Ski"
        }
        
        # Extract year
        year_match = re.search(r'\b(19|20)\d{2}\b', title)
        if year_match:
            info["year"] = year_match.group()
        
        # Extract make
        if "seadoo" in title_lower or "sea-doo" in title_lower:
            info["make"] = "Sea-Doo"
        elif "yamaha" in title_lower:
            info["make"] = "Yamaha"
        elif "kawasaki" in title_lower:
            info["make"] = "Kawasaki"
        
        return info

async def main():
    parser = argparse.ArgumentParser(description="Fixed Facebook Marketplace Enhancer")
    parser.add_argument("--input-file", required=True, help="JSON file with listings to enhance")
    args = parser.parse_args()
    
    enhancer = FixedMarketplaceEnhancer()
    await enhancer.enhance_listings_from_file(args.input_file)

if __name__ == "__main__":
    asyncio.run(main())
