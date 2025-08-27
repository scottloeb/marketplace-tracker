#!/usr/bin/env python3
"""
Facebook Marketplace Detail Enhancer
Automatically fills missing details from URL-only listings captured on mobile.
"""

import asyncio
import json
import csv
import re
import os
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Any
from urllib.parse import urlparse
import aiohttp
from playwright.async_api import async_playwright
from browser_scraper import FacebookMarketplaceScraper
import argparse


class MarketplaceDetailEnhancer:
    """Enhance marketplace listings with complete details from Facebook URLs."""
    
    def __init__(self):
        self.scraper = FacebookMarketplaceScraper()
        self.session = None
        print(f"🔍 Detail Enhancer initialized with {len(self.scraper.reference_data)} reference models")
    
    async def enhance_tracker_data(self, source='tracker', input_file=None, output_enhanced=True):
        """
        Enhance URL-only listings from marketplace tracker with complete details.
        
        Args:
            source: Data source ('tracker' for localStorage, 'file' for JSON file)
            input_file: Specific JSON file to process (when source='file')
            output_enhanced: Whether to output enhanced data for import
        
        Returns:
            Dictionary with enhancement results
        """
        print("🚀 Starting detail enhancement for tracker data...")
        
        # Load listings that need enhancement
        if source == 'tracker':
            listings_to_enhance = self._load_from_tracker_format()
        else:
            # Use specified input file or default
            filename = input_file or "tracker_export.json"
            listings_to_enhance = self._load_from_file(filename)
        
        if not listings_to_enhance:
            return {
                "status": "no_data",
                "message": "No listings found to enhance"
            }
        
        # Find URL-only or incomplete listings
        incomplete_listings = self._find_incomplete_listings(listings_to_enhance)
        
        print(f"📊 Found {len(incomplete_listings)} listings needing enhancement")
        print(f"📋 Total listings in tracker: {len(listings_to_enhance)}")
        
        if not incomplete_listings:
            return {
                "status": "complete",
                "message": "All listings already have complete data",
                "total_listings": len(listings_to_enhance)
            }
        
        # Enhance incomplete listings
        enhanced_listings = await self._enhance_incomplete_listings(incomplete_listings)
        
        # Merge enhanced data back into full dataset
        enhanced_dataset = self._merge_enhanced_data(listings_to_enhance, enhanced_listings)
        
        # Save enhanced results
        if output_enhanced:
            output_file = self._save_enhanced_data(enhanced_dataset)
        else:
            output_file = None
        
        # Generate enhancement report
        report = self._generate_enhancement_report(
            original_count=len(listings_to_enhance),
            enhanced_count=len(enhanced_listings),
            enhanced_data=enhanced_dataset
        )
        
        if output_file:
            report['output_file'] = output_file
            report['import_instructions'] = {
                "step_1": f"Copy contents of {output_file}",
                "step_2": "Open marketplace tracker", 
                "step_3": "Click '📥 Paste Data'",
                "step_4": "Paste and import enhanced data"
            }
        
        return report
    
    def _load_from_tracker_format(self):
        """Load listings from a tracker export format."""
        print("📱 Loading REAL tracker data from JSON export...")
        print("💡 Expected: JSON file exported from your marketplace tracker")
        
        # Look for recent tracker exports
        possible_files = [
            "tracker_export.json",
            "marketplace_tracker_export.json", 
            "mobile_export.json",
            "listings_export.json"
        ]
        
        tracker_data = None
        for filename in possible_files:
            if Path(filename).exists():
                print(f"📂 Found tracker export: {filename}")
                try:
                    with open(filename, 'r') as f:
                        data = json.load(f)
                        if isinstance(data, dict) and 'data' in data:
                            tracker_data = data['data']
                        elif isinstance(data, list):
                            tracker_data = data
                        else:
                            tracker_data = [data]
                        break
                except Exception as e:
                    print(f"⚠️ Could not read {filename}: {e}")
                    continue
        
        if not tracker_data:
            print("❌ No tracker export file found!")
            print("📋 SOLUTION:")
            print("1. Export your tracker data to JSON")
            print("2. Save as 'tracker_export.json' in this directory")
            print("3. Re-run the detail enhancer")
            print()
            print("🔧 OR specify file directly:")
            print("python3 detail_enhancer.py --source file --input-file YOUR_FILE.json")
            return []
        
        print(f"✅ Loaded {len(tracker_data)} listings from tracker export")
        
        # Show summary of what we loaded
        url_only_count = sum(1 for l in tracker_data if l.get('urlOnly') or l.get('status') == 'url_only')
        complete_count = len(tracker_data) - url_only_count
        
        print(f"📊 Data breakdown:")
        print(f"  • {url_only_count} URL-only listings (need enhancement)")
        print(f"  • {complete_count} complete listings (already processed)")
        
        return tracker_data
    
    def _load_from_file(self, filename="tracker_export.json"):
        """Load listings from JSON file."""
        print(f"📂 Loading data from: {filename}")
        
        try:
            if not Path(filename).exists():
                raise FileNotFoundError(f"File not found: {filename}")
                
            with open(filename, 'r') as f:
                data = json.load(f)
                
                # Handle different JSON formats
                if isinstance(data, dict):
                    if 'data' in data:
                        listings = data['data']  # Standard tracker export format
                    elif 'listings' in data:
                        listings = data['listings']  # Alternative format
                    else:
                        listings = [data]  # Single listing object
                elif isinstance(data, list):
                    listings = data  # Direct array of listings
                else:
                    raise ValueError("Unrecognized JSON format")
                
                print(f"✅ Loaded {len(listings)} listings from {filename}")
                
                # Show breakdown
                url_count = sum(1 for l in listings if l.get('url'))
                url_only_count = sum(1 for l in listings 
                                   if l.get('urlOnly') or l.get('status') == 'url_only' 
                                   or not l.get('title') or not l.get('price'))
                
                print(f"📊 Data analysis:")
                print(f"  • {url_count} listings have URLs")
                print(f"  • {url_only_count} need enhancement (missing details)")
                print(f"  • {len(listings) - url_only_count} appear complete")
                
                return listings
                
        except FileNotFoundError:
            print(f"❌ File {filename} not found!")
            print()
            print("📋 SOLUTION:")
            print("1. Open your marketplace tracker")
            print("2. Click '📋 Copy All Data'")
            print("3. Save the copied JSON as a file")
            print("4. Run: python3 detail_enhancer.py --source file --input-file YOUR_FILE.json")
            return []
            
        except Exception as e:
            print(f"❌ Error loading {filename}: {e}")
            print()
            print("📋 Possible issues:")
            print("• File is not valid JSON")
            print("• File is empty or corrupted")
            print("• Wrong file format (expected tracker export)")
            return []
    
    def _find_incomplete_listings(self, listings):
        """Find listings that need enhancement."""
        incomplete = []
        
        for listing in listings:
            needs_enhancement = (
                not listing.get('title') or  # No title
                listing.get('title', '').strip() == '' or  # Empty title
                not listing.get('price') or  # No price
                listing.get('price') in [0, None] or  # Zero/null price
                not listing.get('location') or  # No location
                not listing.get('photos') or  # No photos
                len(listing.get('photos', [])) == 0 or  # Empty photos
                not listing.get('specs') or  # No specs
                len(listing.get('specs', {})) == 0  # Empty specs
            )
            
            # Must have URL to enhance
            if needs_enhancement and listing.get('url'):
                incomplete.append(listing)
        
        return incomplete
    
    async def _enhance_incomplete_listings(self, incomplete_listings):
        """Enhance incomplete listings by extracting details from Facebook."""
        enhanced = []
        
        async with async_playwright() as p:
            browser = await p.chromium.launch(headless=True)
            
            try:
                for i, listing in enumerate(incomplete_listings):
                    print(f"🔍 Enhancing listing {i+1}/{len(incomplete_listings)}: {listing.get('url', 'No URL')}")
                    
                    try:
                        enhanced_listing = await self._extract_listing_details(browser, listing)
                        enhanced.append(enhanced_listing)
                        
                        # Small delay to be respectful
                        await asyncio.sleep(2)
                        
                    except Exception as e:
                        print(f"⚠️ Failed to enhance listing {i+1}: {e}")
                        # Keep original listing even if enhancement fails
                        enhanced.append(listing)
                        continue
                
            finally:
                await browser.close()
        
        return enhanced
    
    async def _extract_listing_details(self, browser, listing):
        """Extract full details from a Facebook listing URL."""
        url = listing.get('url')
        if not url:
            return listing
        
        page = await browser.new_page()
        
        try:
            # Set realistic user agent
            await page.set_extra_http_headers({
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
            })
            
            print(f"🌐 Loading Facebook listing: {url}")
            await page.goto(url, wait_until="networkidle", timeout=30000)
            
            # Handle Facebook interruptions
            await self._handle_facebook_interruptions(page)
            
            # Extract complete listing details
            enhanced_listing = listing.copy()
            
            # Extract title if missing
            if not enhanced_listing.get('title'):
                title = await self._extract_title(page)
                if title:
                    enhanced_listing['title'] = title
            
            # Extract price if missing
            if not enhanced_listing.get('price'):
                price = await self._extract_price(page)
                if price:
                    enhanced_listing['price'] = price
            
            # Extract location if missing
            if not enhanced_listing.get('location'):
                location = await self._extract_location(page)
                if location:
                    enhanced_listing['location'] = location
            
            # Extract photos
            photos = await self._extract_photos(page)
            enhanced_listing['photos'] = photos
            
            # Extract additional details
            details = await self._extract_additional_details(page)
            enhanced_listing.update(details)
            
            # Enhance with reference data and market analysis
            enhanced_listing = self.scraper._enhance_listing_data(enhanced_listing)
            
            # Add stock photos and reference specs
            enhanced_listing = await self._add_reference_photos_and_specs(enhanced_listing)
            
            print(f"✅ Enhanced: {enhanced_listing.get('title', 'Unknown')[:50]}...")
            return enhanced_listing
            
        except Exception as e:
            print(f"⚠️ Enhancement failed for {url}: {e}")
            return listing
            
        finally:
            await page.close()
    
    async def _handle_facebook_interruptions(self, page):
        """Handle Facebook login prompts, cookie notices, etc."""
        try:
            await page.wait_for_timeout(2000)
            
            # Handle cookie notices
            cookie_selectors = [
                'button:has-text("Allow essential and optional cookies")',
                'button:has-text("Accept All Cookies")',
                '[data-testid="cookie-policy-banner-accept"]'
            ]
            
            for selector in cookie_selectors:
                try:
                    element = await page.query_selector(selector)
                    if element:
                        await element.click()
                        await page.wait_for_timeout(1000)
                        break
                except:
                    continue
            
            # Handle login prompts
            login_selectors = [
                'button:has-text("Not Now")',
                '[aria-label="Close"]'
            ]
            
            for selector in login_selectors:
                try:
                    element = await page.query_selector(selector)
                    if element:
                        await element.click()
                        await page.wait_for_timeout(1000)
                        break
                except:
                    continue
                    
        except Exception as e:
            print(f"⚠️ Could not handle Facebook interruptions: {e}")
    
    async def _extract_title(self, page):
        """Extract listing title from Facebook page."""
        title_selectors = [
            'h1[class*="marketplace"]',
            '[data-testid="post_message"] span',
            'h1 span',
            '.marketplace-product-title',
            '[role="main"] h1'
        ]
        
        for selector in title_selectors:
            try:
                element = await page.query_selector(selector)
                if element:
                    title = await element.inner_text()
                    if title and len(title.strip()) > 5:
                        return title.strip()
            except:
                continue
        
        return None
    
    async def _extract_price(self, page):
        """Extract price from Facebook listing page."""
        price_selectors = [
            '[data-testid="marketplace-product-price-amount"]',
            'span:has-text("$")',
            '.marketplace-product-price'
        ]
        
        for selector in price_selectors:
            try:
                element = await page.query_selector(selector)
                if element:
                    price_text = await element.inner_text()
                    price = self.scraper._parse_price(price_text)
                    if price > 0:
                        return price
            except:
                continue
        
        return None
    
    async def _extract_location(self, page):
        """Extract location from Facebook listing page."""
        try:
            # Look for location in page content
            content = await page.content()
            location_patterns = [
                r'([A-Za-z\s]+,\s*[A-Z]{2})',  # City, State
                r'([A-Za-z\s]+,\s*[A-Za-z\s]+)'  # City, Region
            ]
            
            for pattern in location_patterns:
                matches = re.findall(pattern, content)
                if matches:
                    # Return the first reasonable location match
                    for match in matches:
                        if len(match) > 5 and ',' in match:
                            return match
            
        except Exception as e:
            print(f"⚠️ Location extraction failed: {e}")
        
        return None
    
    async def _extract_photos(self, page):
        """Extract photos from Facebook listing."""
        photos = []
        
        try:
            # Look for listing images
            img_selectors = [
                'img[data-testid="marketplace-product-image"]',
                'img[src*="marketplace"]',
                '[role="img"] img'
            ]
            
            for selector in img_selectors:
                try:
                    elements = await page.query_selector_all(selector)
                    for element in elements[:10]:  # Limit to first 10 images
                        src = await element.get_attribute('src')
                        if src and src.startswith('http') and 'marketplace' in src:
                            photos.append({
                                "url": src,
                                "type": "listing_photo",
                                "extracted_date": datetime.now().isoformat()
                            })
                except:
                    continue
        
        except Exception as e:
            print(f"⚠️ Photo extraction failed: {e}")
        
        return photos[:5]  # Return max 5 photos
    
    async def _extract_additional_details(self, page):
        """Extract additional details like seller info, description, etc."""
        details = {}
        
        try:
            # Extract description/details text
            description_selectors = [
                '[data-testid="post_message"]',
                '.marketplace-product-description',
                '[role="main"] p'
            ]
            
            for selector in description_selectors:
                try:
                    element = await page.query_selector(selector)
                    if element:
                        description = await element.inner_text()
                        if description and len(description.strip()) > 10:
                            details['description'] = description.strip()
                            details['notes'] = description.strip()[:200] + ('...' if len(description) > 200 else '')
                            break
                except:
                    continue
            
            # Extract seller information
            try:
                seller_element = await page.query_selector('[data-testid="marketplace-product-seller-name"], .marketplace-seller-name')
                if seller_element:
                    seller_name = await seller_element.inner_text()
                    details['seller'] = seller_name.strip()
            except:
                pass
            
            # Extract listing date
            try:
                # Look for "Listed X days ago" or similar
                content = await page.content()
                date_match = re.search(r'Listed (\d+) (day|week|hour)s? ago', content)
                if date_match:
                    details['facebook_listing_age'] = f"{date_match.group(1)} {date_match.group(2)}s ago"
            except:
                pass
        
        except Exception as e:
            print(f"⚠️ Additional details extraction failed: {e}")
        
        return details
    
    async def _add_reference_photos_and_specs(self, listing):
        """Add stock photos and reference specifications."""
        enhanced = listing.copy()
        
        # Add reference specs if we have them
        if listing.get('has_reference_data') and listing.get('reference_specs'):
            specs = listing['reference_specs']
            enhanced['specs'] = {
                "horsepower": specs.get('Horsepower', ''),
                "engine_displacement": specs.get('Engine_Displacement_cc', ''),
                "engine_type": specs.get('Engine_Type', ''),
                "fuel_capacity": specs.get('Fuel_Capacity_gal', ''),
                "dry_weight": specs.get('Dry_Weight_lbs', ''),
                "length": specs.get('Length_inches', ''),
                "beam_width": specs.get('Beam_Width_inches', ''),
                "top_speed": specs.get('Top_Speed_mph', ''),
                "msrp": specs.get('MSRP_USD', '')
            }
        
        # Add stock photos based on make/model
        stock_photos = await self._get_stock_photos(listing)
        if stock_photos:
            enhanced['stock_photos'] = stock_photos
        
        return enhanced
    
    async def _get_stock_photos(self, listing):
        """Get stock photos for the make/model."""
        stock_photos = []
        
        make = listing.get('make', '')
        model = listing.get('model', '') 
        year = listing.get('year', '')
        
        if make and model:
            # For now, create placeholder stock photo references
            # In production, you'd search for actual stock images
            stock_photos = [
                {
                    "url": f"https://example.com/stock/{make.lower()}_{model.lower()}_{year}_front.jpg",
                    "type": "stock_photo_front",
                    "description": f"{make} {model} {year} front view"
                },
                {
                    "url": f"https://example.com/stock/{make.lower()}_{model.lower()}_{year}_side.jpg", 
                    "type": "stock_photo_side",
                    "description": f"{make} {model} {year} side view"
                }
            ]
        
        return stock_photos
    
    def _merge_enhanced_data(self, original_listings, enhanced_listings):
        """Merge enhanced data back into the original dataset."""
        enhanced_by_url = {listing.get('url'): listing for listing in enhanced_listings}
        
        merged_dataset = []
        for original in original_listings:
            url = original.get('url')
            if url in enhanced_by_url:
                # Use enhanced version
                merged_dataset.append(enhanced_by_url[url])
            else:
                # Keep original
                merged_dataset.append(original)
        
        return merged_dataset
    
    def _save_enhanced_data(self, enhanced_dataset):
        """Save enhanced dataset in tracker import format."""
        timestamp = datetime.now()
        filename = f"enhanced_tracker_data_{timestamp.strftime('%Y%m%d_%H%M%S')}.json"
        
        export_data = {
            "timestamp": timestamp.isoformat(),
            "listingCount": len(enhanced_dataset),
            "enhancementMethod": "automated_detail_extraction",
            "data": enhanced_dataset
        }
        
        with open(filename, 'w') as f:
            json.dump(export_data, f, indent=2)
        
        print(f"💾 Saved enhanced data: {filename}")
        return filename
    
    def _generate_enhancement_report(self, original_count, enhanced_count, enhanced_data):
        """Generate comprehensive enhancement report."""
        # Calculate enhancement statistics
        complete_listings = sum(1 for l in enhanced_data if self._is_complete_listing(l))
        with_photos = sum(1 for l in enhanced_data if l.get('photos'))
        with_specs = sum(1 for l in enhanced_data if l.get('specs'))
        with_market_analysis = sum(1 for l in enhanced_data if l.get('market_analysis'))
        
        # Deal analysis
        buy_recommendations = sum(1 for l in enhanced_data 
                                 if l.get('market_analysis', {}).get('recommendation') == 'BUY')
        consider_recommendations = sum(1 for l in enhanced_data 
                                      if l.get('market_analysis', {}).get('recommendation') == 'CONSIDER')
        
        total_potential_savings = sum(
            l.get('market_analysis', {}).get('potential_savings', 0) 
            for l in enhanced_data 
            if l.get('market_analysis', {}).get('potential_savings')
        )
        
        report = {
            "status": "success",
            "timestamp": datetime.now().isoformat(),
            "enhancement_summary": {
                "original_listings": original_count,
                "enhanced_listings": enhanced_count,
                "completion_rate": f"{(complete_listings/original_count)*100:.1f}%"
            },
            "data_quality": {
                "complete_listings": complete_listings,
                "with_photos": with_photos,
                "with_specs": with_specs,
                "with_market_analysis": with_market_analysis
            },
            "market_intelligence": {
                "buy_recommendations": buy_recommendations,
                "consider_recommendations": consider_recommendations,
                "total_potential_savings": round(total_potential_savings, 0)
            },
            "next_steps": [
                "Import enhanced data back to tracker",
                "Review BUY recommendations for immediate action",
                "Use market analysis for decision making",
                "Set up continuous monitoring for new listings"
            ]
        }
        
        return report
    
    def _is_complete_listing(self, listing):
        """Check if a listing has complete data."""
        return all([
            listing.get('title'),
            listing.get('price'),
            listing.get('location'),
            listing.get('photos') and len(listing.get('photos', [])) > 0,
            listing.get('specs') and len(listing.get('specs', {})) > 0
        ])


async def main():
    """Main CLI interface."""
    parser = argparse.ArgumentParser(description="Enhance marketplace tracker data with complete details")
    parser.add_argument("--source", choices=["tracker", "file"], default="tracker",
                        help="Data source (tracker localStorage or JSON file)")
    parser.add_argument("--input-file", default="tracker_export.json",
                        help="Input JSON file (when source=file)")
    parser.add_argument("--no-output", action="store_true",
                        help="Don't generate output file")
    
    args = parser.parse_args()
    
    print("🏍️ Marketplace Detail Enhancer")
    print("="*50)
    print(f"📊 Source: {args.source}")
    print("🎯 Goal: Auto-fill missing details from Facebook URLs")
    
    enhancer = MarketplaceDetailEnhancer()
    
    try:
        report = await enhancer.enhance_tracker_data(
            source=args.source,
            input_file=args.input_file if args.source == 'file' else None,
            output_enhanced=not args.no_output
        )
        
        if report['status'] == 'success':
            print("\n✅ ENHANCEMENT COMPLETE")
            print("="*50)
            
            summary = report['enhancement_summary']
            quality = report['data_quality']
            market = report['market_intelligence']
            
            print(f"📊 Enhanced {summary['enhanced_listings']}/{summary['original_listings']} listings ({summary['completion_rate']})")
            print(f"🖼️ {quality['with_photos']} listings now have photos")
            print(f"⚙️ {quality['with_specs']} listings have reference specs")
            print(f"🧠 {quality['with_market_analysis']} listings analyzed for deals")
            print(f"🔥 {market['buy_recommendations']} BUY recommendations found")
            print(f"💰 ${market['total_potential_savings']:,.0f} potential savings identified")
            
            if 'output_file' in report:
                print(f"\n💾 Enhanced data saved: {report['output_file']}")
                print("\n📋 IMPORT INSTRUCTIONS:")
                for step, instruction in report['import_instructions'].items():
                    print(f"  {step.replace('_', ' ').title()}: {instruction}")
            
            print("\n🎯 Your URL-only mobile captures are now complete marketplace intelligence!")
        
        else:
            print(f"\n⚠️ Enhancement completed with status: {report['status']}")
            print(f"💬 {report['message']}")
    
    except Exception as e:
        print(f"\n❌ Enhancement failed: {e}")
        return 1
    
    return 0


if __name__ == "__main__":
    exit(asyncio.run(main()))
