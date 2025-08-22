#!/usr/bin/env python3
"""
Continuous Marketplace Automation
Simple service for ongoing marketplace monitoring and data extraction.
"""

import asyncio
import json
import time
from datetime import datetime, timedelta
from pathlib import Path
from browser_scraper import FacebookMarketplaceScraper
import argparse


class ContinuousMarketplaceMonitor:
    """Continuous monitoring service for marketplace listings."""
    
    def __init__(self, config_file="automation_config.json"):
        self.config_file = config_file
        self.scraper = FacebookMarketplaceScraper()
        self.config = self.load_config()
        self.running = False
        
        print(f"🏍️ Continuous Marketplace Monitor initialized")
        print(f"📊 Loaded {len(self.scraper.reference_data)} reference models")
    
    def load_config(self):
        """Load automation configuration."""
        default_config = {
            "search_urls": [
                "https://www.facebook.com/marketplace/search/?query=jet%20ski&daysSinceListed=1"
            ],
            "monitoring_interval_minutes": 60,
            "max_listings_per_run": 25,
            "auto_export_format": "marketplace_tracker",
            "deal_alert_threshold": 0.75,  # Alert when price is 25%+ below expected
            "output_directory": "output",
            "enable_notifications": False
        }
        
        config_path = Path(self.config_file)
        if config_path.exists():
            try:
                with open(config_path, 'r') as f:
                    config = json.load(f)
                    # Merge with defaults
                    for key, value in default_config.items():
                        if key not in config:
                            config[key] = value
                    return config
            except Exception as e:
                print(f"⚠️ Config load error: {e}, using defaults")
        
        # Save default config
        with open(config_path, 'w') as f:
            json.dump(default_config, f, indent=2)
        
        print(f"✅ Created default config: {config_path}")
        return default_config
    
    async def monitor_continuously(self):
        """Run continuous monitoring."""
        self.running = True
        print("🚀 Starting continuous marketplace monitoring...")
        print(f"⏰ Monitoring interval: {self.config['monitoring_interval_minutes']} minutes")
        print(f"🎯 Max listings per run: {self.config['max_listings_per_run']}")
        print(f"💰 Deal alert threshold: {(1-self.config['deal_alert_threshold'])*100:.0f}% below expected")
        
        try:
            while self.running:
                await self.run_monitoring_cycle()
                
                # Wait for next cycle
                wait_seconds = self.config['monitoring_interval_minutes'] * 60
                print(f"⏸️ Waiting {self.config['monitoring_interval_minutes']} minutes until next cycle...")
                
                for i in range(wait_seconds):
                    if not self.running:
                        break
                    await asyncio.sleep(1)
                    
        except KeyboardInterrupt:
            print("\n🛑 Monitoring stopped by user")
        except Exception as e:
            print(f"❌ Monitoring failed: {e}")
        finally:
            self.running = False
    
    async def run_monitoring_cycle(self):
        """Run a single monitoring cycle."""
        cycle_time = datetime.now()
        print(f"\n🔄 Starting monitoring cycle at {cycle_time.strftime('%H:%M:%S')}")
        
        all_new_listings = []
        deal_alerts = []
        
        for i, search_url in enumerate(self.config['search_urls']):
            print(f"🔍 Processing search {i+1}/{len(self.config['search_urls'])}...")
            
            try:
                # Extract listings
                listings = await self.scraper.scrape_facebook_marketplace(
                    search_url=search_url,
                    max_listings=self.config['max_listings_per_run'],
                    headless=True
                )
                
                print(f"📊 Found {len(listings)} listings from search {i+1}")
                
                # Check for new listings and deals
                new_listings, deals = self.process_listings(listings)
                all_new_listings.extend(new_listings)
                deal_alerts.extend(deals)
                
            except Exception as e:
                print(f"⚠️ Search {i+1} failed: {e}")
                continue
        
        # Save results
        if all_new_listings:
            await self.save_monitoring_results(cycle_time, all_new_listings, deal_alerts)
        
        # Print cycle summary
        print(f"✅ Cycle complete: {len(all_new_listings)} new listings, {len(deal_alerts)} deals found")
    
    def process_listings(self, listings):
        """Process listings to find new ones and deals."""
        new_listings = []
        deals = []
        
        # Load existing listings to avoid duplicates
        existing_urls = self.load_existing_urls()
        
        for listing in listings:
            url = listing.get('url', '')
            
            # Check if it's a new listing
            if url and url not in existing_urls:
                new_listings.append(listing)
                
                # Check if it's a deal
                market_analysis = listing.get('market_analysis', {})
                recommendation = market_analysis.get('recommendation')
                
                if recommendation in ['BUY', 'CONSIDER']:
                    deals.append({
                        "listing": listing,
                        "analysis": market_analysis,
                        "alert_level": "HIGH" if recommendation == "BUY" else "MEDIUM"
                    })
        
        return new_listings, deals
    
    def load_existing_urls(self):
        """Load existing listing URLs to avoid duplicates."""
        existing_urls = set()
        
        # Check output directory for previous extractions
        output_dir = Path(self.config['output_directory'])
        if output_dir.exists():
            for json_file in output_dir.glob('*.json'):
                try:
                    with open(json_file, 'r') as f:
                        data = json.load(f)
                        if 'data' in data:
                            for listing in data['data']:
                                if 'url' in listing:
                                    existing_urls.add(listing['url'])
                except:
                    continue
        
        return existing_urls
    
    async def save_monitoring_results(self, cycle_time, new_listings, deals):
        """Save monitoring results to files."""
        output_dir = Path(self.config['output_directory'])
        output_dir.mkdir(exist_ok=True)
        
        # Save all new listings
        if new_listings:
            filename = f"monitoring_{cycle_time.strftime('%Y%m%d_%H%M%S')}.json"
            filepath = output_dir / filename
            
            export_data = {
                "timestamp": cycle_time.isoformat(),
                "listingCount": len(new_listings),
                "extractionMethod": "continuous_monitoring",
                "monitoring_cycle": cycle_time.strftime('%Y-%m-%d %H:%M:%S'),
                "data": new_listings
            }
            
            with open(filepath, 'w') as f:
                json.dump(export_data, f, indent=2)
            
            print(f"💾 Saved {len(new_listings)} new listings to {filename}")
        
        # Save deal alerts
        if deals:
            deals_filename = f"deals_alert_{cycle_time.strftime('%Y%m%d_%H%M%S')}.json"
            deals_filepath = output_dir / deals_filename
            
            deals_data = {
                "timestamp": cycle_time.isoformat(),
                "deal_count": len(deals),
                "deals": deals
            }
            
            with open(deals_filepath, 'w') as f:
                json.dump(deals_data, f, indent=2)
            
            print(f"🔥 DEAL ALERT: {len(deals)} potential deals saved to {deals_filename}")
            
            # Print deal summary
            for deal in deals[:3]:  # Show top 3 deals
                listing = deal['listing']
                analysis = deal['analysis']
                print(f"  💰 {deal['alert_level']}: {listing.get('title', '')[:50]}...")
                print(f"     ${listing.get('price', 0):,.0f} - {analysis.get('reason', 'Good deal detected')}")
    
    def stop_monitoring(self):
        """Stop the monitoring service."""
        self.running = False
        print("🛑 Stopping continuous monitoring...")


async def run_single_extraction(urls, max_listings):
    """Run a single extraction for immediate results."""
    monitor = ContinuousMarketplaceMonitor()
    
    print("🚀 Running single extraction...")
    all_listings = []
    
    for i, url in enumerate(urls):
        print(f"🔍 Extracting from search {i+1}/{len(urls)}...")
        
        try:
            listings = await monitor.scraper.scrape_facebook_marketplace(
                search_url=url,
                max_listings=max_listings,
                headless=True
            )
            all_listings.extend(listings)
            print(f"✅ Extracted {len(listings)} listings")
            
        except Exception as e:
            print(f"❌ Extraction {i+1} failed: {e}")
    
    if all_listings:
        # Save results
        timestamp = datetime.now()
        filename = f"single_extraction_{timestamp.strftime('%Y%m%d_%H%M%S')}.json"
        
        output_data = {
            "timestamp": timestamp.isoformat(),
            "listingCount": len(all_listings),
            "extractionMethod": "single_run",
            "data": all_listings
        }
        
        with open(filename, 'w') as f:
            json.dump(output_data, f, indent=2)
        
        # Show summary
        buy_count = sum(1 for l in all_listings if l.get('market_analysis', {}).get('recommendation') == 'BUY')
        consider_count = sum(1 for l in all_listings if l.get('market_analysis', {}).get('recommendation') == 'CONSIDER')
        
        print(f"\n📊 EXTRACTION COMPLETE")
        print(f"✅ Total listings: {len(all_listings)}")
        print(f"🔥 BUY recommendations: {buy_count}")
        print(f"💰 CONSIDER recommendations: {consider_count}")
        print(f"💾 Saved to: {filename}")
        print(f"📋 Ready to import into marketplace tracker!")
        
        return filename
    
    return None


async def main():
    """Main entry point with CLI options."""
    parser = argparse.ArgumentParser(description="Continuous Marketplace Automation")
    parser.add_argument("--mode", choices=["continuous", "single"], default="single",
                        help="Run in continuous monitoring mode or single extraction")
    parser.add_argument("--url", action="append", help="Facebook Marketplace search URL (can specify multiple)")
    parser.add_argument("--max-listings", type=int, default=50, help="Maximum listings per extraction")
    parser.add_argument("--interval", type=int, default=60, help="Monitoring interval in minutes (continuous mode)")
    
    args = parser.parse_args()
    
    print("🏍️ Marketplace Continuous Automation")
    print("="*50)
    
    if args.mode == "continuous":
        print("🔄 Starting continuous monitoring mode...")
        
        monitor = ContinuousMarketplaceMonitor()
        
        # Update config if provided
        if args.url:
            monitor.config['search_urls'] = args.url
        if args.interval:
            monitor.config['monitoring_interval_minutes'] = args.interval
        if args.max_listings:
            monitor.config['max_listings_per_run'] = args.max_listings
        
        await monitor.monitor_continuously()
        
    else:
        print("⚡ Running single extraction mode...")
        
        if not args.url:
            print("❌ At least one --url is required for single extraction mode")
            return 1
        
        result_file = await run_single_extraction(args.url, args.max_listings)
        if result_file:
            print(f"\n🎯 SUCCESS! Import {result_file} into your marketplace tracker.")
        else:
            print("❌ No listings extracted")
            return 1
    
    return 0


if __name__ == "__main__":
    try:
        exit_code = asyncio.run(main())
        exit(exit_code)
    except KeyboardInterrupt:
        print("\n🛑 Automation stopped by user")
        exit(0)