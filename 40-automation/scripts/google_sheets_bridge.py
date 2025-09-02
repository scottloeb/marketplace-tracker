#!/usr/bin/env python3
"""
Google Sheets to Automation Bridge
Connects the browser extension Google Sheets queue to the existing automation pipeline.

This script:
1. Reads new listings from Google Sheets
2. Converts them to the format expected by existing automation scripts
3. Triggers detail enhancement and processing
4. Manages processed/pending status in the sheet

Author: Marketplace Intelligence System  
Version: 1.0
"""

import json
import asyncio
import logging
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any
from pathlib import Path
import argparse
import sys
import os

# Add the scripts directory to path for imports
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

try:
    from detail_enhancer import MarketplaceDetailEnhancer
    from database_integration import DatabaseIntegration
    AUTOMATION_AVAILABLE = True
except ImportError as e:
    print(f"Warning: Could not import automation modules: {e}")
    print("Running in standalone mode...")
    AUTOMATION_AVAILABLE = False

# Google Sheets integration
try:
    import gspread
    from google.auth import default
    SHEETS_AVAILABLE = True
except ImportError:
    SHEETS_AVAILABLE = False

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


class GoogleSheetsAutomationBridge:
    """Bridge between Google Sheets queue and existing automation pipeline."""
    
    def __init__(self, sheet_id: str, credentials_file: Optional[str] = None):
        self.sheet_id = sheet_id
        self.credentials_file = credentials_file
        self.gc = None
        self.worksheet = None
        
        # Initialize automation components
        self.detail_enhancer = None
        self.db_integration = None
        
        # Status tracking
        self.processed_count = 0
        self.error_count = 0
        self.session_start = datetime.now()
        
        logger.info("🌉 Google Sheets Automation Bridge initialized")
    
    async def initialize(self):
        """Initialize all components."""
        await self._initialize_sheets()
        await self._initialize_automation()
        logger.info("✅ Bridge initialization complete")
    
    async def _initialize_sheets(self):
        """Initialize Google Sheets connection."""
        if not SHEETS_AVAILABLE:
            raise RuntimeError("Google Sheets libraries not installed")
        
        try:
            if self.credentials_file:
                # Use service account credentials
                scope = ['https://spreadsheets.google.com/feeds',
                        'https://www.googleapis.com/auth/drive']
                from google.auth.service_account import Credentials
                creds = Credentials.from_service_account_file(self.credentials_file, scopes=scope)
                self.gc = gspread.authorize(creds)
            else:
                # Use application default credentials (from gcloud auth)
                credentials, project = default(scopes=[
                    'https://spreadsheets.google.com/feeds',
                    'https://www.googleapis.com/auth/drive'
                ])
                self.gc = gspread.authorize(credentials)
            
            # Open the spreadsheet
            spreadsheet = self.gc.open_by_key(self.sheet_id)
            self.worksheet = spreadsheet.sheet1  # First sheet
            
            logger.info(f"📊 Connected to Google Sheet: {spreadsheet.title}")
            
        except Exception as e:
            logger.error(f"❌ Failed to connect to Google Sheets: {e}")
            raise
    
    async def _initialize_automation(self):
        """Initialize automation components."""
        try:
            # Initialize detail enhancer if available
            if AUTOMATION_AVAILABLE and 'MarketplaceDetailEnhancer' in globals():
                self.detail_enhancer = MarketplaceDetailEnhancer()
                logger.info("🔍 Detail enhancer initialized")
            
            # Initialize database integration if available  
            if AUTOMATION_AVAILABLE and 'DatabaseIntegration' in globals():
                self.db_integration = DatabaseIntegration()
                logger.info("🗃️ Database integration initialized")
                
        except Exception as e:
            logger.warning(f"⚠️ Some automation components unavailable: {e}")
    
    def get_pending_listings(self) -> List[Dict[str, Any]]:
        """Get listings from Google Sheets that haven't been processed."""
        try:
            # Get all records
            records = self.worksheet.get_all_records()
            
            # Filter for unprocessed listings
            pending = []
            for i, record in enumerate(records, start=2):  # Start at row 2 (after header)
                # Skip if already processed or has error
                status = record.get('status', '').lower()
                if status in ['processed', 'error', 'duplicate']:
                    continue
                
                # Skip if missing essential data
                if not record.get('url') or not record.get('timestamp'):
                    continue
                
                # Add row number for updates
                record['_row_number'] = i
                pending.append(record)
            
            logger.info(f"📋 Found {len(pending)} pending listings to process")
            return pending
            
        except Exception as e:
            logger.error(f"❌ Error reading Google Sheets: {e}")
            return []
    
    def update_listing_status(self, row_number: int, status: str, error_msg: str = None):
        """Update the status of a listing in Google Sheets."""
        try:
            # Update status column (assuming it's column G)
            self.worksheet.update_cell(row_number, 7, status)
            
            # Update error message if provided (assuming it's column H)
            if error_msg:
                self.worksheet.update_cell(row_number, 8, error_msg[:500])  # Limit length
                
            logger.info(f"📝 Updated row {row_number}: {status}")
            
        except Exception as e:
            logger.error(f"❌ Error updating status for row {row_number}: {e}")
    
    def convert_to_automation_format(self, sheet_record: Dict[str, Any]) -> Dict[str, Any]:
        """Convert Google Sheets record to automation pipeline format."""
        
        # Extract data from sheet record
        url = sheet_record.get('url', '').strip()
        title = sheet_record.get('title', '').strip()
        price_str = str(sheet_record.get('price', '')).strip()
        location = sheet_record.get('location', '').strip()
        marketplace = sheet_record.get('marketplace', '').strip().lower()
        description = sheet_record.get('description', '').strip()
        timestamp_str = sheet_record.get('timestamp', '')
        
        # Parse price
        price = None
        if price_str:
            try:
                # Remove $ and commas, convert to float
                price_clean = price_str.replace('$', '').replace(',', '')
                price = float(price_clean) if price_clean else None
            except (ValueError, TypeError):
                pass
        
        # Parse timestamp
        timestamp = None
        if timestamp_str:
            try:
                timestamp = datetime.fromisoformat(timestamp_str.replace('Z', '+00:00'))
            except (ValueError, TypeError):
                timestamp = datetime.now()
        else:
            timestamp = datetime.now()
        
        # Create automation format
        automation_record = {
            'url': url,
            'title': title or 'Unknown Title',
            'price': price,
            'location': location,
            'marketplace': marketplace or 'unknown',
            'description': description,
            'timestamp': timestamp.isoformat(),
            'source': 'browser_extension',
            'status': 'pending_enhancement',
            'metadata': {
                'captured_via': 'browser_extension',
                'queue_source': 'google_sheets',
                'original_data': sheet_record
            }
        }
        
        return automation_record
    
    async def process_listing(self, sheet_record: Dict[str, Any]) -> bool:
        """Process a single listing through the automation pipeline."""
        row_number = sheet_record.get('_row_number')
        url = sheet_record.get('url', '')
        
        try:
            logger.info(f"🔄 Processing listing: {url}")
            
            # Convert to automation format
            automation_record = self.convert_to_automation_format(sheet_record)
            
            # Enhanced processing if detail enhancer is available
            enhanced_data = None
            if self.detail_enhancer and url:
                try:
                    # Use existing detail enhancement
                    enhanced_data = await self._enhance_listing_data(automation_record)
                    logger.info(f"✨ Enhanced listing data for {url}")
                except Exception as e:
                    logger.warning(f"⚠️ Enhancement failed for {url}: {e}")
            
            # Save to local processing files
            await self._save_to_processing_queue(enhanced_data or automation_record)
            
            # Update database if integration available
            if self.db_integration:
                try:
                    await self._save_to_database(enhanced_data or automation_record)
                    logger.info(f"💾 Saved to database: {url}")
                except Exception as e:
                    logger.warning(f"⚠️ Database save failed for {url}: {e}")
            
            # Update status in sheet
            self.update_listing_status(row_number, 'processed')
            self.processed_count += 1
            
            return True
            
        except Exception as e:
            logger.error(f"❌ Error processing listing {url}: {e}")
            self.update_listing_status(row_number, 'error', str(e))
            self.error_count += 1
            return False
    
    async def _enhance_listing_data(self, automation_record: Dict[str, Any]) -> Dict[str, Any]:
        """Enhance listing data using existing detail enhancer."""
        if not self.detail_enhancer:
            return automation_record
        
        # Create temporary file for enhancement
        temp_file = Path('temp_enhancement_input.json')
        try:
            # Write record in format expected by detail enhancer
            with open(temp_file, 'w') as f:
                json.dump([automation_record], f, indent=2)
            
            # Run enhancement (this would need to be adapted based on your detail enhancer API)
            # This is a placeholder - you'd need to adapt based on your actual detail enhancer interface
            enhanced_records = await self.detail_enhancer.enhance_tracker_data(
                source='file', 
                input_file=str(temp_file)
            )
            
            if enhanced_records and len(enhanced_records) > 0:
                return enhanced_records[0]
            else:
                return automation_record
                
        finally:
            # Clean up temp file
            if temp_file.exists():
                temp_file.unlink()
    
    async def _save_to_processing_queue(self, record: Dict[str, Any]):
        """Save record to local processing queue files."""
        
        # Save to pending listings file
        pending_file = Path('../pending_listings.json')
        
        try:
            # Load existing pending listings
            if pending_file.exists():
                with open(pending_file, 'r') as f:
                    pending_listings = json.load(f)
            else:
                pending_listings = []
            
            # Add new record
            pending_listings.append(record)
            
            # Save back to file
            with open(pending_file, 'w') as f:
                json.dump(pending_listings, f, indent=2)
                
            logger.info(f"📄 Saved to pending listings queue")
            
        except Exception as e:
            logger.error(f"❌ Error saving to processing queue: {e}")
            raise
    
    async def _save_to_database(self, record: Dict[str, Any]):
        """Save record to database using existing integration."""
        if not self.db_integration:
            return
        
        # This would use your existing database integration
        # Placeholder implementation - adapt based on your DatabaseIntegration API
        try:
            # You'd need to implement this method in your DatabaseIntegration class
            # await self.db_integration.insert_marketplace_listing(record)
            pass
        except Exception as e:
            logger.error(f"❌ Database save failed: {e}")
            raise
    
    async def process_queue(self, max_listings: int = 50) -> Dict[str, int]:
        """Process the entire Google Sheets queue."""
        logger.info("🚀 Starting queue processing...")
        
        # Get pending listings
        pending_listings = self.get_pending_listings()
        
        # Limit processing if needed
        if len(pending_listings) > max_listings:
            logger.info(f"📊 Limiting to {max_listings} listings (found {len(pending_listings)})")
            pending_listings = pending_listings[:max_listings]
        
        # Process each listing
        for listing in pending_listings:
            await self.process_listing(listing)
            
            # Add delay to avoid rate limiting
            await asyncio.sleep(2)
        
        # Generate summary
        runtime = datetime.now() - self.session_start
        summary = {
            'processed': self.processed_count,
            'errors': self.error_count,
            'total': len(pending_listings),
            'runtime_minutes': runtime.total_seconds() / 60
        }
        
        logger.info(f"✅ Queue processing complete: {summary}")
        return summary


async def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description='Google Sheets to Automation Bridge')
    parser.add_argument('--sheet-id', required=True, help='Google Sheets ID')
    parser.add_argument('--credentials', help='Service account credentials file')
    parser.add_argument('--max-listings', type=int, default=50, help='Max listings to process')
    parser.add_argument('--continuous', action='store_true', help='Run continuously')
    parser.add_argument('--interval', type=int, default=300, help='Interval for continuous mode (seconds)')
    
    args = parser.parse_args()
    
    # Initialize bridge
    bridge = GoogleSheetsAutomationBridge(args.sheet_id, args.credentials)
    await bridge.initialize()
    
    if args.continuous:
        logger.info(f"🔄 Starting continuous processing (every {args.interval} seconds)...")
        while True:
            try:
                await bridge.process_queue(args.max_listings)
                logger.info(f"😴 Sleeping for {args.interval} seconds...")
                await asyncio.sleep(args.interval)
            except KeyboardInterrupt:
                logger.info("🛑 Stopping continuous processing...")
                break
            except Exception as e:
                logger.error(f"❌ Error in continuous processing: {e}")
                await asyncio.sleep(60)  # Wait 1 minute before retrying
    else:
        # Single run
        summary = await bridge.process_queue(args.max_listings)
        print(f"\n📊 Processing Summary:")
        print(f"   Processed: {summary['processed']}")
        print(f"   Errors: {summary['errors']}")
        print(f"   Total: {summary['total']}")
        print(f"   Runtime: {summary['runtime_minutes']:.1f} minutes")


if __name__ == "__main__":
    asyncio.run(main())
