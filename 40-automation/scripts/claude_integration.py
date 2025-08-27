#!/usr/bin/env python3
"""
Claude Integration Helper for Marketplace Automation
Provides simple functions that Claude can call for marketplace analysis.
"""

import asyncio
import json
from datetime import datetime
from pathlib import Path
from browser_scraper import FacebookMarketplaceScraper
from continuous_automation import ContinuousMarketplaceMonitor


class ClaudeMarketplaceHelper:
    """Helper class for Claude to interact with marketplace automation."""
    
    def __init__(self):
        self.scraper = FacebookMarketplaceScraper()
        print(f"🤖 Claude Marketplace Helper ready with {len(self.scraper.reference_data)} reference models")
    
    async def extract_and_analyze(
        self, 
        facebook_url: str, 
        max_listings: int = 50,
        focus_on_deals: bool = True
    ) -> dict:
        """
        Extract listings from Facebook Marketplace and provide intelligent analysis.
        
        Args:
            facebook_url: Facebook Marketplace search URL
            max_listings: Maximum listings to extract
            focus_on_deals: If True, prioritize deal analysis
        
        Returns:
            Dictionary with extraction results and analysis
        """
        print(f"🚀 Claude-requested extraction starting...")
        print(f"📍 URL: {facebook_url}")
        print(f"🎯 Target: {max_listings} listings")
        
        try:
            # Extract listings
            listings = await self.scraper.scrape_facebook_marketplace(
                search_url=facebook_url,
                max_listings=max_listings,
                headless=True
            )
            
            # Analyze results
            analysis = self.analyze_extraction_results(listings, focus_on_deals)
            
            # Save for import
            output_file = f"claude_extraction_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
            self.save_for_import(listings, output_file)
            
            analysis['output_file'] = output_file
            analysis['import_instructions'] = {
                "step_1": f"Copy contents of {output_file}",
                "step_2": "Open marketplace tracker",
                "step_3": "Click '📥 Paste Data'",
                "step_4": "Paste and import"
            }
            
            return analysis
            
        except Exception as e:
            return {
                "status": "error",
                "error": str(e),
                "message": "Extraction failed"
            }
    
    def analyze_existing_listings(self, listings_json: str) -> dict:
        """
        Analyze existing listings that Claude provides.
        
        Args:
            listings_json: JSON string of existing listings
        
        Returns:
            Analysis results with recommendations
        """
        try:
            # Parse input
            if isinstance(listings_json, str):
                data = json.loads(listings_json)
            else:
                data = listings_json
            
            # Handle different input formats
            if isinstance(data, dict) and 'data' in data:
                listings = data['data']
            else:
                listings = data if isinstance(data, list) else [data]
            
            # Enhance and analyze
            enhanced_listings = []
            for listing in listings:
                enhanced = self.scraper._enhance_listing_data(listing)
                enhanced_listings.append(enhanced)
            
            # Generate analysis
            analysis = self.analyze_extraction_results(enhanced_listings, focus_on_deals=True)
            analysis['enhanced_listings'] = enhanced_listings
            
            return analysis
            
        except Exception as e:
            return {
                "status": "error",
                "error": str(e),
                "message": "Analysis failed"
            }
    
    def analyze_extraction_results(self, listings, focus_on_deals=True):
        """Analyze extraction results and provide insights."""
        analysis = {
            "status": "success",
            "timestamp": datetime.now().isoformat(),
            "total_listings": len(listings),
            "analysis_summary": {},
            "recommendations": {},
            "deal_alerts": [],
            "market_insights": []
        }
        
        # Categorize by recommendation
        recommendations = {"BUY": [], "CONSIDER": [], "PASS": [], "RESEARCH": []}
        total_savings = 0
        with_reference_data = 0
        total_price = 0
        
        for listing in listings:
            market_analysis = listing.get('market_analysis', {})
            recommendation = market_analysis.get('recommendation', 'RESEARCH')
            
            recommendations[recommendation].append(listing)
            
            if listing.get('has_reference_data'):
                with_reference_data += 1
            
            if market_analysis.get('potential_savings'):
                total_savings += market_analysis['potential_savings']
            
            total_price += listing.get('price', 0)
            
            # Add to deal alerts if significant
            if recommendation == "BUY" and market_analysis.get('potential_savings', 0) > 1000:
                analysis['deal_alerts'].append({
                    "title": listing.get('title', ''),
                    "price": listing.get('price', 0),
                    "savings": market_analysis.get('potential_savings', 0),
                    "reason": market_analysis.get('reason', ''),
                    "url": listing.get('url', ''),
                    "location": listing.get('location', '')
                })
        
        # Calculate summary statistics
        analysis['analysis_summary'] = {
            "buy_count": len(recommendations['BUY']),
            "consider_count": len(recommendations['CONSIDER']),
            "pass_count": len(recommendations['PASS']),
            "research_count": len(recommendations['RESEARCH']),
            "with_reference_data": with_reference_data,
            "reference_data_percentage": round(with_reference_data / len(listings) * 100, 1) if listings else 0,
            "total_potential_savings": round(total_savings, 0),
            "average_price": round(total_price / len(listings), 0) if listings else 0
        }
        
        analysis['recommendations'] = recommendations
        
        # Generate market insights
        if focus_on_deals and analysis['deal_alerts']:
            analysis['market_insights'].append(
                f"🔥 Found {len(analysis['deal_alerts'])} high-value deals with potential savings of ${total_savings:,.0f}"
            )
        
        if with_reference_data > 0:
            analysis['market_insights'].append(
                f"📊 {with_reference_data} listings matched against reference data ({with_reference_data/len(listings)*100:.0f}%)"
            )
        
        # Add model-specific insights
        makes = {}
        for listing in listings:
            make = listing.get('make', 'Unknown')
            if make != 'Unknown':
                if make not in makes:
                    makes[make] = []
                makes[make].append(listing)
        
        for make, make_listings in makes.items():
            avg_price = sum(l.get('price', 0) for l in make_listings) / len(make_listings)
            buy_count = sum(1 for l in make_listings if l.get('market_analysis', {}).get('recommendation') == 'BUY')
            if buy_count > 0:
                analysis['market_insights'].append(
                    f"💰 {make}: {buy_count}/{len(make_listings)} listings are BUY recommendations (avg: ${avg_price:,.0f})"
                )
        
        return analysis
    
    def save_for_import(self, listings, filename):
        """Save listings in marketplace tracker import format."""
        export_data = {
            "timestamp": datetime.now().isoformat(),
            "listingCount": len(listings),
            "extractionMethod": "claude_assisted_automation",
            "data": listings
        }
        
        with open(filename, 'w') as f:
            json.dump(export_data, f, indent=2)
    
    def get_top_deals(self, max_count=10):
        """Get top deals from recent extractions."""
        output_dir = Path("output")
        if not output_dir.exists():
            return {"message": "No extractions found"}
        
        all_deals = []
        
        # Load recent deal alerts
        for deals_file in sorted(output_dir.glob("deals_alert_*.json"), reverse=True)[:5]:
            try:
                with open(deals_file, 'r') as f:
                    deals_data = json.load(f)
                    all_deals.extend(deals_data.get('deals', []))
            except:
                continue
        
        # Sort by potential savings
        all_deals.sort(key=lambda x: x.get('analysis', {}).get('potential_savings', 0), reverse=True)
        
        return {
            "top_deals": all_deals[:max_count],
            "total_deals_available": len(all_deals)
        }


# Convenience functions for Claude to call directly

async def quick_facebook_extraction(facebook_url: str, max_listings: int = 50):
    """Quick extraction function that Claude can call directly."""
    helper = ClaudeMarketplaceHelper()
    return await helper.extract_and_analyze(facebook_url, max_listings)


def analyze_marketplace_data(listings_json: str):
    """Analyze marketplace data that Claude provides."""
    helper = ClaudeMarketplaceHelper()
    return helper.analyze_existing_listings(listings_json)


def get_market_opportunities():
    """Get current market opportunities from recent extractions."""
    helper = ClaudeMarketplaceHelper()
    return helper.get_top_deals()


# Demo function for testing
async def demo_extraction():
    """Demo extraction for testing purposes."""
    print("🧪 Running demo extraction...")
    
    # Use a test URL (this would be a real Facebook Marketplace URL in practice)
    test_url = "https://www.facebook.com/marketplace/search/?query=jet%20ski"
    
    result = await quick_facebook_extraction(test_url, max_listings=5)
    
    print("📊 Demo Results:")
    print(json.dumps(result, indent=2))
    
    return result


if __name__ == "__main__":
    print("🤖 Claude Marketplace Integration Helper")
    print("="*50)
    print("Available functions for Claude:")
    print("  • quick_facebook_extraction(url, max_listings)")
    print("  • analyze_marketplace_data(listings_json)")
    print("  • get_market_opportunities()")
    print()
    print("Running demo...")
    
    # Run demo (commented out to avoid actual scraping)
    # asyncio.run(demo_extraction())
