#!/usr/bin/env python3
"""
Marketplace Automation REST API Server
Provides continuous automation capabilities for Facebook Marketplace extraction.
Can be integrated with Claude and other AI tools.
"""

import asyncio
import json
import logging
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Any
import aiohttp
from aiohttp import web, ClientSession
from browser_scraper import FacebookMarketplaceScraper
import traceback

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


class MarketplaceAutomationServer:
    """REST API server for continuous marketplace automation."""
    
    def __init__(self, host='localhost', port=8080):
        self.host = host
        self.port = port
        self.app = web.Application()
        self.scraper = FacebookMarketplaceScraper()
        self.setup_routes()
        
        # Track running extractions
        self.active_extractions = {}
        self.extraction_history = []
        
        logger.info("Marketplace Automation Server initialized")
    
    def setup_routes(self):
        """Set up API routes."""
        
        # CORS middleware
        async def cors_middleware(request, handler):
            response = await handler(request)
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
            response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
            return response
        
        self.app.middlewares.append(cors_middleware)
        
        # Routes
        self.app.router.add_get('/', self.index)
        self.app.router.add_get('/health', self.health_check)
        self.app.router.add_get('/status', self.get_status)
        self.app.router.add_post('/extract', self.extract_listings)
        self.app.router.add_post('/enhance', self.enhance_listings)
        self.app.router.add_post('/analyze', self.analyze_prices)
        self.app.router.add_get('/extraction/{extraction_id}', self.get_extraction_status)
        self.app.router.add_get('/history', self.get_extraction_history)
        
        # Serve static files
        self.app.router.add_static('/', Path(__file__).parent, show_index=True)
    
    async def index(self, request):
        """Serve the main automation interface."""
        return web.FileResponse(Path(__file__).parent / 'web_interface.html')
    
    async def health_check(self, request):
        """Health check endpoint."""
        return web.json_response({
            "status": "healthy",
            "server": "marketplace-automation",
            "timestamp": datetime.now().isoformat(),
            "reference_models": len(self.scraper.reference_data),
            "active_extractions": len(self.active_extractions)
        })
    
    async def get_status(self, request):
        """Get current server status and capabilities."""
        return web.json_response({
            "server_info": {
                "name": "Marketplace Automation Server",
                "version": "1.0.0",
                "host": self.host,
                "port": self.port
            },
            "capabilities": {
                "facebook_marketplace_extraction": True,
                "intelligent_price_analysis": True,
                "reference_data_enhancement": True,
                "deal_detection": True
            },
            "statistics": {
                "reference_models_loaded": len(self.scraper.reference_data),
                "total_extractions": len(self.extraction_history),
                "active_extractions": len(self.active_extractions)
            },
            "sample_models": list(self.scraper.reference_data.keys())[:10]
        })
    
    async def extract_listings(self, request):
        """Extract listings from Facebook Marketplace."""
        try:
            data = await request.json()
            search_url = data.get('search_url')
            max_listings = data.get('max_listings', 50)
            headless = data.get('headless', True)
            
            if not search_url:
                return web.json_response(
                    {"error": "search_url is required"}, 
                    status=400
                )
            
            # Generate extraction ID
            extraction_id = f"extract_{int(datetime.now().timestamp())}"
            
            # Start extraction in background
            self.active_extractions[extraction_id] = {
                "id": extraction_id,
                "status": "started",
                "search_url": search_url,
                "max_listings": max_listings,
                "start_time": datetime.now().isoformat(),
                "progress": 0,
                "message": "Starting extraction..."
            }
            
            # Start async extraction
            asyncio.create_task(
                self._run_extraction(extraction_id, search_url, max_listings, headless)
            )
            
            return web.json_response({
                "extraction_id": extraction_id,
                "status": "started",
                "message": "Extraction started successfully",
                "estimated_time": f"{max_listings * 2} seconds"
            })
            
        except Exception as e:
            logger.error(f"Extract listings error: {e}")
            return web.json_response(
                {"error": str(e)}, 
                status=500
            )
    
    async def _run_extraction(self, extraction_id: str, search_url: str, max_listings: int, headless: bool):
        """Run the actual extraction in background."""
        try:
            # Update status
            self.active_extractions[extraction_id]["status"] = "extracting"
            self.active_extractions[extraction_id]["message"] = "Extracting listings from Facebook Marketplace..."
            self.active_extractions[extraction_id]["progress"] = 10
            
            # Run extraction
            listings = await self.scraper.scrape_facebook_marketplace(
                search_url=search_url,
                max_listings=max_listings,
                headless=headless
            )
            
            # Update progress
            self.active_extractions[extraction_id]["progress"] = 80
            self.active_extractions[extraction_id]["message"] = "Enhancing listings with reference data..."
            
            # Save results
            results = {
                "extraction_id": extraction_id,
                "timestamp": datetime.now().isoformat(),
                "search_url": search_url,
                "listingCount": len(listings),
                "extractionMethod": "automated_browser_scraping",
                "data": listings
            }
            
            # Calculate statistics
            buy_count = sum(1 for l in listings if l.get('market_analysis', {}).get('recommendation') == 'BUY')
            consider_count = sum(1 for l in listings if l.get('market_analysis', {}).get('recommendation') == 'CONSIDER')
            
            results["statistics"] = {
                "buy_recommendations": buy_count,
                "consider_recommendations": consider_count,
                "total_analyzed": len([l for l in listings if l.get('market_analysis')])
            }
            
            # Complete extraction
            self.active_extractions[extraction_id].update({
                "status": "completed",
                "message": f"Successfully extracted {len(listings)} listings",
                "progress": 100,
                "results": results,
                "end_time": datetime.now().isoformat()
            })
            
            # Add to history
            self.extraction_history.append(self.active_extractions[extraction_id].copy())
            
            # Save to file
            output_file = f"output/extraction_{extraction_id}.json"
            with open(output_file, 'w') as f:
                json.dump(results, f, indent=2)
            
            logger.info(f"Extraction {extraction_id} completed: {len(listings)} listings")
            
        except Exception as e:
            logger.error(f"Extraction {extraction_id} failed: {e}")
            self.active_extractions[extraction_id].update({
                "status": "failed",
                "message": f"Extraction failed: {str(e)}",
                "progress": 0,
                "error": str(e),
                "end_time": datetime.now().isoformat()
            })
    
    async def get_extraction_status(self, request):
        """Get status of a specific extraction."""
        extraction_id = request.match_info['extraction_id']
        
        if extraction_id in self.active_extractions:
            return web.json_response(self.active_extractions[extraction_id])
        else:
            # Check history
            for extraction in self.extraction_history:
                if extraction['id'] == extraction_id:
                    return web.json_response(extraction)
            
            return web.json_response(
                {"error": "Extraction not found"}, 
                status=404
            )
    
    async def enhance_listings(self, request):
        """Enhance existing listings with reference data."""
        try:
            data = await request.json()
            listings_data = data.get('listings')
            
            if not listings_data:
                return web.json_response(
                    {"error": "listings data is required"}, 
                    status=400
                )
            
            # Parse listings
            if isinstance(listings_data, str):
                listings = json.loads(listings_data)
            else:
                listings = listings_data
            
            # Handle both formats: {"data": [...]} and [...]
            if isinstance(listings, dict) and 'data' in listings:
                listings_array = listings['data']
            else:
                listings_array = listings
            
            # Enhance each listing
            enhanced_listings = []
            for listing in listings_array:
                enhanced = self.scraper._enhance_listing_data(listing)
                enhanced_listings.append(enhanced)
            
            # Create enhanced export format
            enhanced_export = {
                "timestamp": datetime.now().isoformat(),
                "listingCount": len(enhanced_listings),
                "enhancementMethod": "reference_data_analysis",
                "data": enhanced_listings
            }
            
            return web.json_response({
                "status": "success",
                "enhanced_count": len(enhanced_listings),
                "enhanced_data": enhanced_export
            })
            
        except Exception as e:
            logger.error(f"Enhancement error: {e}")
            return web.json_response(
                {"error": str(e)}, 
                status=500
            )
    
    async def analyze_prices(self, request):
        """Analyze prices and provide recommendations."""
        try:
            data = await request.json()
            listings_data = data.get('listings')
            
            if not listings_data:
                return web.json_response(
                    {"error": "listings data is required"}, 
                    status=400
                )
            
            # Parse listings
            if isinstance(listings_data, str):
                listings = json.loads(listings_data)
            else:
                listings = listings_data
            
            # Handle both formats
            if isinstance(listings, dict) and 'data' in listings:
                listings_array = listings['data']
            else:
                listings_array = listings
            
            # Analyze each listing
            analysis_results = {
                "total_listings": len(listings_array),
                "analysis_timestamp": datetime.now().isoformat(),
                "recommendations": {
                    "BUY": [],
                    "CONSIDER": [],
                    "PASS": [],
                    "RESEARCH": []
                },
                "statistics": {
                    "with_reference_data": 0,
                    "total_potential_savings": 0,
                    "average_price": 0
                }
            }
            
            total_price = 0
            total_savings = 0
            
            for listing in listings_array:
                enhanced = self.scraper._enhance_listing_data(listing)
                market_analysis = enhanced.get('market_analysis', {})
                recommendation = market_analysis.get('recommendation', 'RESEARCH')
                
                analysis_results["recommendations"][recommendation].append({
                    "id": enhanced.get('id'),
                    "title": enhanced.get('title'),
                    "price": enhanced.get('price', 0),
                    "analysis": market_analysis
                })
                
                if enhanced.get('has_reference_data'):
                    analysis_results["statistics"]["with_reference_data"] += 1
                
                if market_analysis.get('potential_savings'):
                    total_savings += market_analysis['potential_savings']
                
                total_price += enhanced.get('price', 0)
            
            # Calculate statistics
            if len(listings_array) > 0:
                analysis_results["statistics"]["average_price"] = total_price / len(listings_array)
            analysis_results["statistics"]["total_potential_savings"] = total_savings
            
            return web.json_response(analysis_results)
            
        except Exception as e:
            logger.error(f"Price analysis error: {e}")
            return web.json_response(
                {"error": str(e)}, 
                status=500
            )
    
    async def get_extraction_history(self, request):
        """Get history of all extractions."""
        return web.json_response({
            "history": self.extraction_history,
            "active_extractions": list(self.active_extractions.keys()),
            "total_extractions": len(self.extraction_history)
        })
    
    async def start_server(self):
        """Start the automation server."""
        try:
            runner = web.AppRunner(self.app)
            await runner.setup()
            
            site = web.TCPSite(runner, self.host, self.port)
            await site.start()
            
            logger.info(f"🚀 Marketplace Automation Server running on http://{self.host}:{self.port}")
            logger.info(f"📊 Loaded {len(self.scraper.reference_data)} reference models")
            logger.info("🔗 API Endpoints:")
            logger.info(f"  • GET  http://{self.host}:{self.port}/health - Health check")
            logger.info(f"  • GET  http://{self.host}:{self.port}/status - Server status")
            logger.info(f"  • POST http://{self.host}:{self.port}/extract - Extract listings")
            logger.info(f"  • POST http://{self.host}:{self.port}/enhance - Enhance existing listings")
            logger.info(f"  • POST http://{self.host}:{self.port}/analyze - Analyze prices")
            logger.info(f"  • GET  http://{self.host}:{self.port}/ - Web interface")
            
            # Keep server running
            while True:
                await asyncio.sleep(1)
                
        except Exception as e:
            logger.error(f"Server startup failed: {e}")
            raise


async def main():
    """Main entry point."""
    import argparse
    
    parser = argparse.ArgumentParser(description="Marketplace Automation Server")
    parser.add_argument("--host", default="localhost", help="Server host")
    parser.add_argument("--port", type=int, default=8080, help="Server port")
    
    args = parser.parse_args()
    
    print("🏍️ Marketplace Automation Server")
    print("="*50)
    print(f"🚀 Starting server on http://{args.host}:{args.port}")
    print("📊 Loading reference data...")
    
    try:
        server = MarketplaceAutomationServer(args.host, args.port)
        await server.start_server()
    except KeyboardInterrupt:
        print("\n🛑 Server stopped by user")
    except Exception as e:
        print(f"❌ Server failed: {e}")
        logger.error(f"Server error: {traceback.format_exc()}")


if __name__ == "__main__":
    asyncio.run(main())
