#!/usr/bin/env python3
"""
One-Click Marketplace Update Pipeline
Runs enhancement → analysis → Ocean Explorer export with a single command
"""

import json
import os
import asyncio
import subprocess
import sys
from datetime import datetime
import logging

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class MarketplacePipeline:
    def __init__(self):
        self.timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        self.base_dir = os.getcwd()
        
    def find_latest_import_file(self):
        """Find the most recent import file"""
        import_files = [
            f for f in os.listdir('.')
            if f.startswith('google_sheet_import_') and f.endswith('.json')
        ]
        
        if not import_files:
            logger.error("No import files found")
            return None
            
        # Sort by timestamp (newest first)
        import_files.sort(reverse=True)
        latest_file = import_files[0]
        logger.info(f"📂 Using latest import: {latest_file}")
        return latest_file
    
    def load_listings(self, filename):
        """Load listings from JSON file"""
        try:
            with open(filename, 'r') as f:
                data = json.load(f)
                
            # Handle both direct array and wrapper object
            if isinstance(data, dict) and 'data' in data:
                return data['data']
            elif isinstance(data, list):
                return data
            else:
                logger.error(f"Invalid JSON structure in {filename}")
                return []
                
        except Exception as e:
            logger.error(f"Error loading listings: {e}")
            return []
    
    async def run_enhancement_phase(self, input_file):
        """Phase 1: Enhance listings with prices and details"""
        logger.info("🔍 Phase 1: Starting listing enhancement...")
        
        # Check if we have enhancement scripts
        enhancement_scripts = [
            '40-automation/facebook_marketplace_scraper.py',
            '40-automation/enhanced_scraper.py',
            'match_listings_to_specs.py'
        ]
        
        available_scripts = [s for s in enhancement_scripts if os.path.exists(s)]
        
        if not available_scripts:
            logger.warning("⚠️  No enhancement scripts found - using manual enhancement")
            return await self.manual_enhancement_fallback(input_file)
        
        # Try to run enhancement
        try:
            script = available_scripts[0]
            logger.info(f"🤖 Running enhancement script: {script}")
            
            result = subprocess.run([
                sys.executable, script, 
                '--input', input_file,
                '--output', f'enhanced_{self.timestamp}.json'
            ], capture_output=True, text=True, timeout=300)
            
            if result.returncode == 0:
                enhanced_file = f'enhanced_{self.timestamp}.json'
                logger.info(f"✅ Enhancement complete: {enhanced_file}")
                return enhanced_file
            else:
                logger.error(f"❌ Enhancement failed: {result.stderr}")
                return await self.manual_enhancement_fallback(input_file)
                
        except subprocess.TimeoutExpired:
            logger.error("❌ Enhancement script timed out")
            return await self.manual_enhancement_fallback(input_file)
        except Exception as e:
            logger.error(f"❌ Enhancement error: {e}")
            return await self.manual_enhancement_fallback(input_file)
    
    async def manual_enhancement_fallback(self, input_file):
        """Fallback: Create enhanced file with basic structure"""
        logger.info("📝 Creating basic enhanced structure...")
        
        listings = self.load_listings(input_file)
        if not listings:
            return None
        
        # Add basic enhancement fields
        for listing in listings:
            listing.update({
                'enhanced': False,
                'enhancement_status': 'pending',
                'market_analysis': {
                    'recommendation': 'PENDING',
                    'confidence': 0,
                    'reasoning': 'Awaiting price data'
                },
                'specs_matched': False
            })
        
        # Save enhanced file
        enhanced_file = f'enhanced_basic_{self.timestamp}.json'
        enhanced_data = {
            'timestamp': datetime.now().isoformat(),
            'listingCount': len(listings),
            'source': 'Manual Enhancement Fallback',
            'data': listings
        }
        
        with open(enhanced_file, 'w') as f:
            json.dump(enhanced_data, f, indent=2)
            
        logger.info(f"✅ Basic enhanced file created: {enhanced_file}")
        return enhanced_file
    
    def run_analysis_phase(self, enhanced_file):
        """Phase 2: Run market analysis"""
        logger.info("📊 Phase 2: Starting market analysis...")
        
        listings = self.load_listings(enhanced_file)
        if not listings:
            return enhanced_file
        
        # Basic market analysis
        analysis_summary = {
            'total_listings': len(listings),
            'by_make': {},
            'by_status': {},
            'price_ranges': {
                'under_8k': 0,
                '8k_15k': 0,
                '15k_25k': 0,
                'over_25k': 0,
                'no_price': 0
            }
        }
        
        for listing in listings:
            # Count by make
            make = listing.get('make', 'Unknown')
            analysis_summary['by_make'][make] = analysis_summary['by_make'].get(make, 0) + 1
            
            # Count by status
            status = listing.get('status', 'pending')
            analysis_summary['by_status'][status] = analysis_summary['by_status'].get(status, 0) + 1
            
            # Price analysis
            price = listing.get('price', 0)
            if price == 0:
                analysis_summary['price_ranges']['no_price'] += 1
            elif price < 8000:
                analysis_summary['price_ranges']['under_8k'] += 1
            elif price < 15000:
                analysis_summary['price_ranges']['8k_15k'] += 1
            elif price < 25000:
                analysis_summary['price_ranges']['15k_25k'] += 1
            else:
                analysis_summary['price_ranges']['over_25k'] += 1
        
        # Save analysis
        analysis_file = f'market_analysis_{self.timestamp}.json'
        with open(analysis_file, 'w') as f:
            json.dump(analysis_summary, f, indent=2)
        
        logger.info(f"✅ Market analysis complete: {analysis_file}")
        logger.info(f"📊 Summary: {analysis_summary['total_listings']} listings, {len(analysis_summary['by_make'])} makes")
        
        return enhanced_file
    
    def create_ocean_explorer_export(self, enhanced_file):
        """Phase 3: Create Ocean Explorer export"""
        logger.info("🌊 Phase 3: Creating Ocean Explorer export...")
        
        listings = self.load_listings(enhanced_file)
        if not listings:
            return None
        
        # Convert to Ocean Explorer format
        ocean_data = []
        for listing in listings:
            ocean_item = {
                'id': listing.get('id'),
                'title': listing.get('title', ''),
                'url': listing.get('url', ''),
                'price': listing.get('price', 0),
                'make': listing.get('make', 'Unknown'),
                'model': listing.get('model', ''),
                'year': listing.get('year', ''),
                'location': listing.get('location', ''),
                'status': listing.get('status', 'pending'),
                'market_analysis': listing.get('market_analysis', {
                    'recommendation': 'PENDING',
                    'confidence': 0,
                    'reasoning': 'Awaiting enhancement'
                }),
                'addedDate': listing.get('addedDate', datetime.now().isoformat())
            }
            ocean_data.append(ocean_item)
        
        # Save Ocean Explorer file
        ocean_file = f'ocean_explorer_export_{self.timestamp}.json'
        with open(ocean_file, 'w') as f:
            json.dump(ocean_data, f, indent=2)
        
        logger.info(f"✅ Ocean Explorer export complete: {ocean_file}")
        return ocean_file
    
    def create_update_script(self):
        """Create a simple update script for daily automation"""
        script_content = f'''#!/bin/bash
# Daily Marketplace Update Script
# Generated: {datetime.now().isoformat()}

echo "🚀 Starting daily marketplace update..."

# Navigate to marketplace tracker directory
cd "$(dirname "$0")"

# Run the pipeline
python3 one_click_pipeline.py

# Optional: Commit results to git
# git add -A
# git commit -m "Daily marketplace update $(date +%Y%m%d_%H%M%S)"

echo "✅ Daily update complete!"
'''
        
        with open('daily_update.sh', 'w') as f:
            f.write(script_content)
        
        # Make executable
        os.chmod('daily_update.sh', 0o755)
        logger.info("✅ Created daily_update.sh script")
    
    async def run_pipeline(self):
        """Run the complete pipeline"""
        logger.info("🚀 Starting One-Click Marketplace Pipeline...")
        
        # Find input file
        input_file = self.find_latest_import_file()
        if not input_file:
            logger.error("❌ No input file found")
            return
        
        try:
            # Phase 1: Enhancement
            enhanced_file = await self.run_enhancement_phase(input_file)
            if not enhanced_file:
                logger.error("❌ Enhancement phase failed")
                return
            
            # Phase 2: Analysis
            analyzed_file = self.run_analysis_phase(enhanced_file)
            
            # Phase 3: Ocean Explorer Export
            ocean_file = self.create_ocean_explorer_export(analyzed_file)
            
            # Create daily update script
            self.create_update_script()
            
            # Final summary
            logger.info(f"""
🎯 Pipeline Complete! Files created:
📈 Enhanced Data: {enhanced_file}
📊 Market Analysis: market_analysis_{self.timestamp}.json
🌊 Ocean Explorer: {ocean_file}
🔄 Daily Script: daily_update.sh

🚀 Next Steps:
1. Import {ocean_file} into Ocean Explorer
2. Review market analysis for opportunities
3. Use daily_update.sh for automated updates
            """)
            
        except Exception as e:
            logger.error(f"❌ Pipeline failed: {e}")

async def main():
    """Main entry point"""
    pipeline = MarketplacePipeline()
    await pipeline.run_pipeline()

if __name__ == "__main__":
    asyncio.run(main())
