#!/usr/bin/env python3
"""
Facebook Marketplace Jet Ski Scraper
Standalone browser automation tool for extracting jet ski listings.
"""

import asyncio
import json
import csv
import re
from datetime import datetime
from typing import Dict, List, Optional, Any
from playwright.async_api import async_playwright
import argparse


class FacebookMarketplaceScraper:
    """Browser automation scraper for Facebook Marketplace jet ski listings."""
    
    def __init__(self):
        self.reference_data = {}
        self.load_reference_data()
    
    def load_reference_data(self):
        """Load jet ski reference data for intelligent enhancement."""
        try:
            with open('/workspace/reference/jet_ski_specs_main.csv', 'r') as f:
                lines = list(csv.reader(f))
                
                if len(lines) < 2:
                    raise ValueError("CSV file has insufficient data")
                
                # First row contains model names (skip 'Specification' column)
                model_headers = lines[0][1:]  # Skip first column
                
                # Process each specification row
                for row in lines[1:]:
                    if len(row) < 2:
                        continue
                    
                    spec_name = row[0]  # First column is the specification name
                    spec_values = row[1:]  # Rest are values for each model
                    
                    # Map each model to its specification value
                    for i, model_name in enumerate(model_headers):
                        if i < len(spec_values):
                            model_info = model_name.replace('_', ' ')
                            if model_info not in self.reference_data:
                                self.reference_data[model_info] = {}
                            self.reference_data[model_info][spec_name] = spec_values[i]
            
            print(f"✅ Loaded reference data for {len(self.reference_data)} jet ski models")
            
        except Exception as e:
            print(f"⚠️ Failed to load reference data: {e}")
            self.reference_data = {}
    
    async def scrape_facebook_marketplace(
        self, 
        search_url: str, 
        max_listings: int = 50,
        headless: bool = True
    ) -> List[Dict[str, Any]]:
        """
        Scrape Facebook Marketplace for jet ski listings.
        
        Args:
            search_url: Facebook Marketplace search URL
            max_listings: Maximum number of listings to extract
            headless: Run browser in headless mode
        
        Returns:
            List of extracted and enhanced listings
        """
        print(f"🚀 Starting Facebook Marketplace scrape...")
        print(f"📍 URL: {search_url}")
        print(f"🎯 Target: {max_listings} listings")
        
        async with async_playwright() as p:
            # Launch browser
            browser = await p.chromium.launch(
                headless=headless,
                args=['--no-sandbox', '--disable-dev-shm-usage']
            )
            
            try:
                page = await browser.new_page()
                
                # Set user agent to avoid detection
                await page.set_extra_http_headers({
                    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
                })
                
                # Navigate to search URL
                print("🌐 Loading Facebook Marketplace...")
                await page.goto(search_url, wait_until="networkidle", timeout=30000)
                
                # Handle potential login screen or popups
                await self._handle_facebook_interruptions(page)
                
                # Wait for listings to load
                try:
                    await page.wait_for_selector('[data-testid="marketplace-item"], .marketplace-list-item, [role="gridcell"]', timeout=15000)
                    print("✅ Listings loaded successfully")
                except:
                    print("⚠️ Marketplace items not found with standard selectors, trying alternative...")
                    await page.wait_for_selector('a[href*="/marketplace/item/"]', timeout=10000)
                
                # Extract listings
                listings = await self._extract_all_listings(page, max_listings)
                
                print(f"📊 Extracted {len(listings)} raw listings")
                
                # Enhance listings with reference data
                enhanced_listings = []
                for i, listing in enumerate(listings):
                    print(f"🔍 Enhancing listing {i+1}/{len(listings)}: {listing.get('title', 'Unknown')[:50]}...")
                    enhanced = self._enhance_listing_data(listing)
                    enhanced_listings.append(enhanced)
                
                print(f"✅ Enhanced {len(enhanced_listings)} listings with reference data")
                return enhanced_listings
                
            finally:
                await browser.close()
    
    async def _handle_facebook_interruptions(self, page):
        """Handle Facebook login prompts, cookie notices, etc."""
        try:
            # Wait a moment for any popups to appear
            await page.wait_for_timeout(2000)
            
            # Close cookie/privacy notices
            cookie_selectors = [
                'button:has-text("Allow essential and optional cookies")',
                'button:has-text("Accept All Cookies")',
                'button:has-text("Accept")',
                '[data-testid="cookie-policy-banner-accept"]'
            ]
            
            for selector in cookie_selectors:
                try:
                    element = await page.query_selector(selector)
                    if element:
                        await element.click()
                        await page.wait_for_timeout(1000)
                        print("✅ Handled cookie notice")
                        break
                except:
                    continue
            
            # Handle "Log In" prompts - try to dismiss
            login_selectors = [
                'button:has-text("Not Now")',
                'button:has-text("Continue as Guest")',
                '[aria-label="Close"]',
                'button[aria-label="Close"]'
            ]
            
            for selector in login_selectors:
                try:
                    element = await page.query_selector(selector)
                    if element:
                        await element.click()
                        await page.wait_for_timeout(1000)
                        print("✅ Dismissed login prompt")
                        break
                except:
                    continue
                    
        except Exception as e:
            print(f"⚠️ Could not handle Facebook interruptions: {e}")
    
    async def _extract_all_listings(self, page, max_listings: int) -> List[Dict[str, Any]]:
        """Extract all listings from the page with scrolling."""
        listings = []
        seen_urls = set()
        last_count = 0
        stagnant_scrolls = 0
        
        while len(listings) < max_listings and stagnant_scrolls < 5:
            # Try multiple selectors for listings
            listing_selectors = [
                '[data-testid="marketplace-item"]',
                '.marketplace-list-item',
                '[role="gridcell"]',
                'a[href*="/marketplace/item/"]'
            ]
            
            listing_elements = []
            for selector in listing_selectors:
                elements = await page.query_selector_all(selector)
                if elements:
                    listing_elements = elements
                    break
            
            if not listing_elements:
                print("⚠️ No listing elements found")
                break
            
            # Extract data from current page elements
            for element in listing_elements:
                if len(listings) >= max_listings:
                    break
                
                try:
                    listing = await self._extract_single_listing(element)
                    if listing and listing["url"] not in seen_urls:
                        listings.append(listing)
                        seen_urls.add(listing["url"])
                        
                except Exception as e:
                    print(f"⚠️ Failed to extract listing: {e}")
                    continue
            
            # Check if we got new listings
            if len(listings) == last_count:
                stagnant_scrolls += 1
            else:
                stagnant_scrolls = 0
            last_count = len(listings)
            
            # Scroll to load more listings
            if len(listings) < max_listings:
                print(f"📜 Scrolling for more listings... ({len(listings)}/{max_listings})")
                await page.evaluate("window.scrollTo(0, document.body.scrollHeight)")
                await page.wait_for_timeout(3000)
                
                # Try clicking "See more" if it exists
                try:
                    see_more = await page.query_selector('text="See more"')
                    if see_more:
                        await see_more.click()
                        await page.wait_for_timeout(2000)
                except:
                    pass
        
        print(f"📊 Final extraction: {len(listings)} unique listings")
        return listings
    
    async def _extract_single_listing(self, element) -> Optional[Dict[str, Any]]:
        """Extract data from a single listing element."""
        try:
            # Extract title
            title_selectors = [
                'span[dir="auto"]',
                '.marketplace-tile-title',
                '[data-testid="marketplace-item-title"]',
                'h3',
                'h4'
            ]
            
            title = "Unknown"
            for selector in title_selectors:
                try:
                    title_element = await element.query_selector(selector)
                    if title_element:
                        title = await title_element.inner_text()
                        if title and len(title.strip()) > 3:  # Valid title
                            break
                except:
                    continue
            
            # Extract price
            price_selectors = [
                'span:has-text("$")',
                '.marketplace-tile-price',
                '[data-testid="marketplace-item-price"]'
            ]
            
            price = 0
            for selector in price_selectors:
                try:
                    price_element = await element.query_selector(selector)
                    if price_element:
                        price_text = await price_element.inner_text()
                        price = self._parse_price(price_text)
                        if price > 0:
                            break
                except:
                    continue
            
            # Extract URL
            url = ""
            try:
                link_element = await element.query_selector('a')
                if link_element:
                    href = await link_element.get_attribute('href')
                    if href:
                        if href.startswith('/'):
                            url = f"https://www.facebook.com{href}"
                        else:
                            url = href
            except:
                pass
            
            # Extract location
            location = ""
            try:
                # Look for location text patterns
                text_content = await element.inner_text()
                location_match = re.search(r'([A-Za-z\s]+,\s*[A-Z]{2})', text_content)
                if location_match:
                    location = location_match.group(1)
            except:
                pass
            
            # Only return if we have essential data
            if title != "Unknown" and url:
                return {
                    "id": int(datetime.now().timestamp() * 1000000 + len(title)),  # Unique ID
                    "title": title.strip(),
                    "price": price,
                    "url": url,
                    "source": "Facebook Marketplace",
                    "location": location.strip(),
                    "status": "pending",
                    "addedDate": datetime.now().isoformat(),
                    "extractedVia": "browser_automation",
                    "mobileAdded": False
                }
            
            return None
            
        except Exception as e:
            print(f"⚠️ Failed to extract listing: {e}")
            return None
    
    def _parse_price(self, price_text: str) -> float:
        """Parse price text to float value."""
        if not price_text:
            return 0.0
        
        # Remove currency symbols and commas
        price_clean = re.sub(r'[^\d.]', '', price_text)
        try:
            return float(price_clean)
        except ValueError:
            return 0.0
    
    def _enhance_listing_data(self, listing: Dict[str, Any]) -> Dict[str, Any]:
        """Enhance listing data with reference information."""
        enhanced = listing.copy()
        
        # Parse title for make, model, year
        title = listing.get("title", "").lower()
        parsed_info = self._parse_jetski_title(title)
        enhanced.update(parsed_info)
        
        # Add reference data if available
        model_key = f"{parsed_info.get('make', '')} {parsed_info.get('year', '')} {parsed_info.get('model', '')}"
        model_key = model_key.strip().replace("  ", " ")
        
        # Try to find matching reference data
        best_match = self._find_best_spec_match(model_key)
        if best_match:
            enhanced["reference_specs"] = self.reference_data[best_match]
            enhanced["has_reference_data"] = True
            enhanced["matched_model"] = best_match
        else:
            enhanced["has_reference_data"] = False
        
        # Add price analysis
        enhanced["market_analysis"] = self._analyze_listing_price(enhanced)
        
        return enhanced
    
    def _find_best_spec_match(self, search_key: str) -> Optional[str]:
        """Find the best matching model in reference data."""
        search_lower = search_key.lower()
        
        # Direct match first
        for model_key in self.reference_data.keys():
            if model_key.lower() == search_lower:
                return model_key
        
        # Partial match
        for model_key in self.reference_data.keys():
            model_lower = model_key.lower()
            # Check if key parts match
            if any(part in model_lower for part in search_lower.split() if len(part) > 2):
                return model_key
        
        return None
    
    def _parse_jetski_title(self, title: str) -> Dict[str, str]:
        """Parse jet ski title to extract make, model, year, etc."""
        parsed = {
            "make": "",
            "model": "",
            "year": "",
            "condition": "",
            "type": "Jet Ski"
        }
        
        # Extract make
        if "kawasaki" in title:
            parsed["make"] = "Kawasaki"
        elif "sea-doo" in title or "seadoo" in title:
            parsed["make"] = "SeaDoo"
        elif "yamaha" in title:
            parsed["make"] = "Yamaha"
        elif "polaris" in title:
            parsed["make"] = "Polaris"
        
        # Extract year
        year_match = re.search(r'\b(19|20)\d{2}\b', title)
        if year_match:
            parsed["year"] = year_match.group()
        
        # Extract model
        models = {
            "ultra": "Ultra", "gtr": "GTR", "gtx": "GTX", "gti": "GTI",
            "rxp": "RXP", "rxt": "RXT", "spark": "Spark", "stx": "STX",
            "sxr": "SXR", "fx": "FX", "vx": "VX", "ex": "EX",
            "waverunner": "WaveRunner"
        }
        
        for model_key, model_name in models.items():
            if model_key in title:
                parsed["model"] = model_name
                break
        
        # Extract condition
        conditions = ["new", "used", "excellent", "good", "fair", "salvage", "parts"]
        for condition in conditions:
            if condition in title:
                parsed["condition"] = condition.title()
                break
        
        return parsed
    
    def _analyze_listing_price(self, listing: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze listing price against reference data."""
        analysis = {
            "status": "unknown",
            "confidence": 0.0,
            "recommendation": "RESEARCH",
            "reason": "Insufficient data for analysis"
        }
        
        if listing.get("has_reference_data") and listing.get("reference_specs"):
            try:
                msrp = float(listing["reference_specs"].get("MSRP_USD", 0))
                current_price = listing.get("price", 0)
                
                if msrp > 0 and current_price > 0:
                    years_old = datetime.now().year - int(listing.get("year", "0") or "0")
                    expected_depreciation = min(years_old * 0.08, 0.6)  # 8% per year, max 60%
                    expected_price = msrp * (1 - expected_depreciation)
                    
                    price_ratio = current_price / expected_price
                    
                    if price_ratio < 0.75:
                        analysis.update({
                            "status": "underpriced",
                            "confidence": 0.8,
                            "recommendation": "BUY",
                            "reason": f"${current_price:,.0f} is {(1-price_ratio)*100:.0f}% below expected ${expected_price:,.0f}",
                            "potential_savings": expected_price - current_price
                        })
                    elif price_ratio < 0.9:
                        analysis.update({
                            "status": "good_deal",
                            "confidence": 0.6,
                            "recommendation": "CONSIDER",
                            "reason": f"${current_price:,.0f} is {(1-price_ratio)*100:.0f}% below expected ${expected_price:,.0f}",
                            "potential_savings": expected_price - current_price
                        })
                    elif price_ratio > 1.2:
                        analysis.update({
                            "status": "overpriced",
                            "confidence": 0.7,
                            "recommendation": "PASS",
                            "reason": f"${current_price:,.0f} is {(price_ratio-1)*100:.0f}% above expected ${expected_price:,.0f}"
                        })
                    else:
                        analysis.update({
                            "status": "fair_price",
                            "confidence": 0.5,
                            "recommendation": "RESEARCH",
                            "reason": f"${current_price:,.0f} is near expected ${expected_price:,.0f}"
                        })
                        
            except Exception as e:
                print(f"⚠️ Price analysis failed: {e}")
        
        return analysis
    
    async def _extract_all_listings(self, page, max_listings: int) -> List[Dict[str, Any]]:
        """Extract all listings from the page with scrolling."""
        listings = []
        seen_urls = set()
        scroll_attempts = 0
        max_scrolls = 10
        
        while len(listings) < max_listings and scroll_attempts < max_scrolls:
            # Get current listings
            current_listings = await self._get_listings_on_page(page)
            
            # Add new listings
            new_count = 0
            for listing in current_listings:
                if listing["url"] not in seen_urls and len(listings) < max_listings:
                    listings.append(listing)
                    seen_urls.add(listing["url"])
                    new_count += 1
            
            print(f"📄 Page {scroll_attempts + 1}: Found {new_count} new listings (Total: {len(listings)})")
            
            # Scroll for more
            if len(listings) < max_listings:
                await page.evaluate("window.scrollTo(0, document.body.scrollHeight)")
                await page.wait_for_timeout(3000)
                scroll_attempts += 1
                
                # Try clicking load more
                try:
                    load_more = await page.query_selector('text="See more", text="Show more", text="Load more"')
                    if load_more:
                        await load_more.click()
                        await page.wait_for_timeout(2000)
                except:
                    pass
        
        return listings[:max_listings]
    
    async def _get_listings_on_page(self, page) -> List[Dict[str, Any]]:
        """Get all listings currently visible on the page."""
        listings = []
        
        # Try multiple approaches to find listings
        selectors = [
            'a[href*="/marketplace/item/"]',
            '[data-testid="marketplace-item"] a',
            '.marketplace-list-item a'
        ]
        
        for selector in selectors:
            try:
                elements = await page.query_selector_all(selector)
                if elements:
                    for element in elements:
                        listing = await self._extract_listing_from_link(element)
                        if listing:
                            listings.append(listing)
                    break
            except:
                continue
        
        return listings
    
    async def _extract_listing_from_link(self, link_element) -> Optional[Dict[str, Any]]:
        """Extract listing data from a link element."""
        try:
            # Get URL
            href = await link_element.get_attribute('href')
            if not href or '/marketplace/item/' not in href:
                return None
            
            url = href if href.startswith('http') else f"https://www.facebook.com{href}"
            
            # Get parent container for more data
            parent = await link_element.evaluate_handle('element => element.closest("[role=\'gridcell\'], .marketplace-list-item, [data-testid=\'marketplace-item\']")')
            if not parent:
                parent = link_element
            
            # Extract title
            title = await parent.evaluate('''element => {
                const titleSelectors = ['span[dir="auto"]', 'h3', 'h4', '.marketplace-tile-title'];
                for (const selector of titleSelectors) {
                    const titleEl = element.querySelector(selector);
                    if (titleEl && titleEl.textContent.trim().length > 3) {
                        return titleEl.textContent.trim();
                    }
                }
                return "Unknown";
            }''')
            
            # Extract price
            price_text = await parent.evaluate('''element => {
                const priceSelectors = ['span:has-text("$")', '.marketplace-tile-price'];
                for (const selector of priceSelectors) {
                    const priceEl = element.querySelector(selector);
                    if (priceEl && priceEl.textContent.includes('$')) {
                        return priceEl.textContent;
                    }
                }
                return "$0";
            }''')
            
            price = self._parse_price(price_text)
            
            # Extract location
            text_content = await parent.inner_text()
            location_match = re.search(r'([A-Za-z\s]+,\s*[A-Z]{2})', text_content)
            location = location_match.group(1) if location_match else ""
            
            # Only return valid listings
            if title != "Unknown" and url:
                return {
                    "id": int(datetime.now().timestamp() * 1000000) + hash(url) % 1000000,
                    "title": title,
                    "price": price,
                    "url": url,
                    "source": "Facebook Marketplace",
                    "location": location,
                    "status": "pending",
                    "addedDate": datetime.now().isoformat(),
                    "extractedVia": "browser_automation",
                    "mobileAdded": False
                }
            
            return None
            
        except Exception as e:
            print(f"⚠️ Failed to extract listing data: {e}")
            return None
    
    def _parse_price(self, price_text: str) -> float:
        """Parse price text to float."""
        if not price_text:
            return 0.0
        
        # Extract numbers from price text
        price_clean = re.sub(r'[^\d.]', '', price_text)
        try:
            return float(price_clean)
        except ValueError:
            return 0.0
    
    def save_to_marketplace_format(self, listings: List[Dict[str, Any]], output_file: str = "extracted_listings.json"):
        """Save listings in the marketplace tracker format."""
        export_data = {
            "timestamp": datetime.now().isoformat(),
            "listingCount": len(listings),
            "extractionMethod": "automated_browser_scraping",
            "data": listings
        }
        
        with open(output_file, 'w') as f:
            json.dump(export_data, f, indent=2)
        
        print(f"💾 Saved {len(listings)} listings to {output_file}")
        return output_file


async def main():
    """Main CLI interface for the scraper."""
    parser = argparse.ArgumentParser(description="Scrape Facebook Marketplace for jet ski listings")
    parser.add_argument("url", help="Facebook Marketplace search URL for jet skis")
    parser.add_argument("--max-listings", type=int, default=50, help="Maximum listings to extract")
    parser.add_argument("--output", default="extracted_listings.json", help="Output file name")
    parser.add_argument("--headless", action="store_true", help="Run in headless mode")
    parser.add_argument("--no-headless", dest="headless", action="store_false", help="Run with visible browser")
    parser.set_defaults(headless=True)
    
    args = parser.parse_args()
    
    scraper = FacebookMarketplaceScraper()
    
    print("🏍️ Facebook Marketplace Jet Ski Scraper")
    print("="*50)
    
    try:
        listings = await scraper.scrape_facebook_marketplace(
            search_url=args.url,
            max_listings=args.max_listings,
            headless=args.headless
        )
        
        if listings:
            output_file = scraper.save_to_marketplace_format(listings, args.output)
            
            # Print summary
            print("\n📊 EXTRACTION SUMMARY")
            print("="*50)
            print(f"✅ Total listings extracted: {len(listings)}")
            print(f"💾 Saved to: {output_file}")
            
            # Show price analysis summary
            buy_recommendations = [l for l in listings if l.get("market_analysis", {}).get("recommendation") == "BUY"]
            consider_recommendations = [l for l in listings if l.get("market_analysis", {}).get("recommendation") == "CONSIDER"]
            
            print(f"🎯 BUY recommendations: {len(buy_recommendations)}")
            print(f"🤔 CONSIDER recommendations: {len(consider_recommendations)}")
            
            if buy_recommendations:
                print("\n🔥 TOP BUY RECOMMENDATIONS:")
                for rec in buy_recommendations[:5]:
                    analysis = rec.get("market_analysis", {})
                    print(f"  • {rec['title'][:50]}... - ${rec['price']:,.0f} ({analysis.get('reason', 'Good deal')})")
            
            print(f"\n📋 Ready to import into marketplace tracker!")
            print(f"   Copy the contents of {output_file} and paste into your tracker's import function.")
        
        else:
            print("❌ No listings extracted. Check the URL and try again.")
    
    except Exception as e:
        print(f"❌ Scraping failed: {e}")
        return 1
    
    return 0


if __name__ == "__main__":
    exit(asyncio.run(main()))