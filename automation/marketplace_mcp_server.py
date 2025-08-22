#!/usr/bin/env python3
"""
Custom MCP Server for Facebook Marketplace Jet Ski Data Extraction
This server provides automated data import capabilities for the marketplace tracker.
"""

import asyncio
import json
import logging
import csv
from datetime import datetime
from typing import Dict, List, Optional, Any
from urllib.parse import urlparse, parse_qs
import aiohttp
from playwright.async_api import async_playwright, Browser, Page
import pandas as pd
from mcp.server import Server
from mcp.types import Tool, TextContent

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class JetSkiMarketplaceMCP:
    """Custom MCP Server for automated jet ski marketplace data extraction."""
    
    def __init__(self):
        self.server = Server("jetski-marketplace-extractor")
        self.browser: Optional[Browser] = None
        self.reference_data = {}
        self.setup_tools()
        self.load_reference_data()
    
    def load_reference_data(self):
        """Load jet ski reference data for intelligent enhancement."""
        try:
            # Load jet ski specs for price validation and data enhancement
            with open('/workspace/reference/jet_ski_specs_main.csv', 'r') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    # Parse specs for each model
                    for key, value in row.items():
                        if key != 'Specification':
                            model_info = key.replace('_', ' ')
                            if model_info not in self.reference_data:
                                self.reference_data[model_info] = {}
                            self.reference_data[model_info][row['Specification']] = value
            
            logger.info(f"Loaded reference data for {len(self.reference_data)} jet ski models")
            
        except Exception as e:
            logger.error(f"Failed to load reference data: {e}")
            self.reference_data = {}
    
    def setup_tools(self):
        """Register MCP tools for marketplace automation."""
        
        @self.server.tool()
        async def extract_facebook_marketplace_listings(
            search_url: str,
            max_listings: int = 50,
            include_sold: bool = False
        ) -> List[Dict[str, Any]]:
            """
            Extract jet ski listings from Facebook Marketplace.
            
            Args:
                search_url: Facebook Marketplace search URL for jet skis
                max_listings: Maximum number of listings to extract (default: 50)
                include_sold: Whether to include sold listings (default: False)
            
            Returns:
                List of extracted listing dictionaries
            """
            logger.info(f"Starting extraction from: {search_url}")
            
            try:
                listings = await self._scrape_facebook_marketplace(
                    search_url, max_listings, include_sold
                )
                
                # Enhance listings with reference data
                enhanced_listings = []
                for listing in listings:
                    enhanced = await self._enhance_listing_data(listing)
                    enhanced_listings.append(enhanced)
                
                logger.info(f"Successfully extracted {len(enhanced_listings)} listings")
                return enhanced_listings
                
            except Exception as e:
                logger.error(f"Extraction failed: {e}")
                raise
        
        @self.server.tool()
        async def enhance_existing_listings(
            listings_json: str
        ) -> List[Dict[str, Any]]:
            """
            Enhance existing listings with reference data and market intelligence.
            
            Args:
                listings_json: JSON string of existing listings to enhance
            
            Returns:
                List of enhanced listing dictionaries
            """
            try:
                listings = json.loads(listings_json)
                enhanced_listings = []
                
                for listing in listings:
                    enhanced = await self._enhance_listing_data(listing)
                    enhanced_listings.append(enhanced)
                
                logger.info(f"Enhanced {len(enhanced_listings)} existing listings")
                return enhanced_listings
                
            except Exception as e:
                logger.error(f"Enhancement failed: {e}")
                raise
        
        @self.server.tool()
        async def validate_listing_prices(
            listings_json: str
        ) -> Dict[str, Any]:
            """
            Validate listing prices against reference MSRP data.
            
            Args:
                listings_json: JSON string of listings to validate
            
            Returns:
                Dictionary with price analysis and recommendations
            """
            try:
                listings = json.loads(listings_json)
                analysis = {
                    "total_listings": len(listings),
                    "price_analysis": [],
                    "recommendations": [],
                    "market_insights": {}
                }
                
                for listing in listings:
                    price_analysis = await self._analyze_listing_price(listing)
                    analysis["price_analysis"].append(price_analysis)
                    
                    if price_analysis.get("recommendation") == "BUY":
                        analysis["recommendations"].append({
                            "listing_id": listing.get("id"),
                            "title": listing.get("title"),
                            "reason": price_analysis.get("reason"),
                            "potential_savings": price_analysis.get("savings_amount")
                        })
                
                return analysis
                
            except Exception as e:
                logger.error(f"Price validation failed: {e}")
                raise
    
    async def _scrape_facebook_marketplace(
        self, search_url: str, max_listings: int, include_sold: bool
    ) -> List[Dict[str, Any]]:
        """Scrape Facebook Marketplace for jet ski listings."""
        
        if not self.browser:
            playwright = await async_playwright().start()
            self.browser = await playwright.chromium.launch(headless=True)
        
        page = await self.browser.new_page()
        
        try:
            # Navigate to the search URL
            await page.goto(search_url, wait_until="networkidle")
            
            # Wait for listings to load
            await page.wait_for_selector('[data-testid="marketplace-item"]', timeout=10000)
            
            listings = []
            processed_count = 0
            
            while processed_count < max_listings:
                # Get current listings on page
                listing_elements = await page.query_selector_all('[data-testid="marketplace-item"]')
                
                for element in listing_elements[processed_count:]:
                    if processed_count >= max_listings:
                        break
                    
                    try:
                        listing_data = await self._extract_listing_from_element(element, page)
                        if listing_data and (include_sold or not listing_data.get("is_sold", False)):
                            listings.append(listing_data)
                            processed_count += 1
                            
                    except Exception as e:
                        logger.warning(f"Failed to extract listing {processed_count}: {e}")
                        continue
                
                # Try to load more listings if needed
                if processed_count < max_listings:
                    try:
                        # Scroll to load more
                        await page.evaluate("window.scrollTo(0, document.body.scrollHeight)")
                        await page.wait_for_timeout(2000)
                        
                        # Check if "See more" button exists and click it
                        see_more_btn = await page.query_selector('text="See more"')
                        if see_more_btn:
                            await see_more_btn.click()
                            await page.wait_for_timeout(3000)
                        else:
                            # No more listings to load
                            break
                            
                    except Exception as e:
                        logger.info("No more listings to load")
                        break
            
            return listings
            
        finally:
            await page.close()
    
    async def _extract_listing_from_element(self, element, page: Page) -> Optional[Dict[str, Any]]:
        """Extract data from a single listing element."""
        try:
            # Extract basic listing data
            title_element = await element.query_selector('span[dir="auto"]')
            title = await title_element.inner_text() if title_element else "Unknown"
            
            price_element = await element.query_selector('span:has-text("$")')
            price_text = await price_element.inner_text() if price_element else "0"
            price = self._parse_price(price_text)
            
            # Get listing URL
            link_element = await element.query_selector('a')
            relative_url = await link_element.get_attribute('href') if link_element else ""
            full_url = f"https://www.facebook.com{relative_url}" if relative_url else ""
            
            # Extract location if available
            location_element = await element.query_selector('span:has-text(","):last-of-type')
            location = await location_element.inner_text() if location_element else ""
            
            # Check if sold
            sold_element = await element.query_selector('text="Sold"')
            is_sold = sold_element is not None
            
            # Extract image URL
            img_element = await element.query_selector('img')
            image_url = await img_element.get_attribute('src') if img_element else ""
            
            listing_data = {
                "id": int(datetime.now().timestamp() * 1000),  # Unique ID based on timestamp
                "title": title.strip(),
                "price": price,
                "url": full_url,
                "source": "Facebook Marketplace",
                "location": location.strip(),
                "image_url": image_url,
                "is_sold": is_sold,
                "status": "pending",
                "addedDate": datetime.now().isoformat(),
                "extractedVia": "MCP_automation",
                "rawText": title  # Store for further parsing
            }
            
            return listing_data
            
        except Exception as e:
            logger.error(f"Failed to extract listing element: {e}")
            return None
    
    async def _enhance_listing_data(self, listing: Dict[str, Any]) -> Dict[str, Any]:
        """Enhance listing data with reference information and intelligent parsing."""
        enhanced = listing.copy()
        
        # Parse title for make, model, year
        title = listing.get("title", "").lower()
        parsed_info = self._parse_jetski_title(title)
        enhanced.update(parsed_info)
        
        # Add reference data if we can match the model
        model_key = f"{parsed_info.get('make', '')} {parsed_info.get('year', '')} {parsed_info.get('model', '')}"
        if model_key.strip() in self.reference_data:
            enhanced["reference_specs"] = self.reference_data[model_key.strip()]
            enhanced["has_reference_data"] = True
        else:
            enhanced["has_reference_data"] = False
        
        # Add market analysis
        market_analysis = await self._analyze_listing_price(enhanced)
        enhanced["market_analysis"] = market_analysis
        
        return enhanced
    
    def _parse_jetski_title(self, title: str) -> Dict[str, str]:
        """Parse jet ski title to extract make, model, year, etc."""
        parsed = {
            "make": "",
            "model": "",
            "year": "",
            "condition": "",
            "type": "Jet Ski"
        }
        
        # Common jet ski makes
        makes = ["kawasaki", "sea-doo", "seadoo", "yamaha", "polaris"]
        for make in makes:
            if make in title:
                parsed["make"] = make.title().replace("-", "-")
                break
        
        # Extract year (4 digits)
        import re
        year_match = re.search(r'\b(19|20)\d{2}\b', title)
        if year_match:
            parsed["year"] = year_match.group()
        
        # Common models
        models = ["ultra", "gtr", "gtx", "gti", "rxp", "rxt", "spark", "stx", "sxr", "fx", "vx", "ex", "waverunner"]
        for model in models:
            if model in title:
                parsed["model"] = model.upper()
                break
        
        # Condition indicators
        conditions = ["new", "used", "excellent", "good", "fair", "salvage", "parts"]
        for condition in conditions:
            if condition in title:
                parsed["condition"] = condition.title()
                break
        
        return parsed
    
    async def _analyze_listing_price(self, listing: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze listing price against reference data and market trends."""
        analysis = {
            "status": "unknown",
            "confidence": 0.0,
            "recommendation": "RESEARCH",
            "reason": "Insufficient data for analysis"
        }
        
        # If we have reference data, compare against MSRP
        if listing.get("has_reference_data") and listing.get("reference_specs"):
            try:
                msrp = float(listing["reference_specs"].get("MSRP_USD", 0))
                current_price = listing.get("price", 0)
                
                if msrp > 0 and current_price > 0:
                    # Calculate depreciation and price percentage
                    years_old = datetime.now().year - int(listing.get("year", "0"))
                    expected_depreciation = min(years_old * 0.08, 0.6)  # 8% per year, max 60%
                    expected_price = msrp * (1 - expected_depreciation)
                    
                    price_percentage = current_price / expected_price
                    
                    if price_percentage < 0.75:  # More than 25% below expected
                        analysis.update({
                            "status": "underpriced",
                            "confidence": 0.8,
                            "recommendation": "BUY",
                            "reason": f"Price ${current_price:,.0f} is {(1-price_percentage)*100:.0f}% below expected ${expected_price:,.0f}",
                            "savings_amount": expected_price - current_price,
                            "msrp": msrp,
                            "expected_price": expected_price
                        })
                    elif price_percentage < 0.9:  # 10-25% below expected
                        analysis.update({
                            "status": "good_deal",
                            "confidence": 0.6,
                            "recommendation": "CONSIDER",
                            "reason": f"Price ${current_price:,.0f} is {(1-price_percentage)*100:.0f}% below expected ${expected_price:,.0f}",
                            "savings_amount": expected_price - current_price,
                            "msrp": msrp,
                            "expected_price": expected_price
                        })
                    elif price_percentage > 1.2:  # More than 20% above expected
                        analysis.update({
                            "status": "overpriced",
                            "confidence": 0.7,
                            "recommendation": "PASS",
                            "reason": f"Price ${current_price:,.0f} is {(price_percentage-1)*100:.0f}% above expected ${expected_price:,.0f}",
                            "overprice_amount": current_price - expected_price,
                            "msrp": msrp,
                            "expected_price": expected_price
                        })
                    else:
                        analysis.update({
                            "status": "fair_price",
                            "confidence": 0.5,
                            "recommendation": "RESEARCH",
                            "reason": f"Price ${current_price:,.0f} is near expected ${expected_price:,.0f}",
                            "msrp": msrp,
                            "expected_price": expected_price
                        })
                        
            except Exception as e:
                logger.error(f"Price analysis failed: {e}")
        
        return analysis
    
    def _parse_price(self, price_text: str) -> float:
        """Parse price text to float value."""
        import re
        # Remove non-digit characters except decimal point
        price_clean = re.sub(r'[^\d.]', '', price_text)
        try:
            return float(price_clean)
        except ValueError:
            return 0.0
    
    async def start_browser(self):
        """Start the browser for web scraping."""
        if not self.browser:
            playwright = await async_playwright().start()
            self.browser = await playwright.chromium.launch(
                headless=True,
                args=['--no-sandbox', '--disable-dev-shm-usage']
            )
    
    async def close_browser(self):
        """Close the browser."""
        if self.browser:
            await self.browser.close()
            self.browser = None
    
    async def run(self):
        """Run the MCP server."""
        try:
            await self.start_browser()
            logger.info("Jet Ski Marketplace MCP Server started successfully")
            await self.server.run()
        finally:
            await self.close_browser()


async def main():
    """Main entry point for the MCP server."""
    mcp_server = JetSkiMarketplaceMCP()
    await mcp_server.run()


if __name__ == "__main__":
    asyncio.run(main())