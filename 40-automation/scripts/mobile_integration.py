#!/usr/bin/env python3
"""
Mobile Integration Strategy for Marketplace Tracker
Handles URL sharing from mobile → automatic processing → Supabase sync
"""

import json
import os
import hashlib
from datetime import datetime
import asyncio
import logging

logger = logging.getLogger(__name__)

class MobileIntegrationHandler:
    """
    Handles the mobile-to-tracker workflow:
    1. Phone shares URL → landing page
    2. URL queued for processing
    3. Background automation processes listing
    4. Real-time sync to Supabase
    5. Available on all devices
    """
    
    def __init__(self, supabase_client=None):
        self.supabase = supabase_client
        self.processing_queue = "mobile_queue.json"
        self.duplicate_cache = "duplicate_cache.json"
        
    def generate_listing_fingerprint(self, title, price=None, description=None, images=None):
        """
        Generate unique fingerprint for duplicate detection
        Uses title + content hash instead of just URL
        """
        fingerprint_data = {
            'title_normalized': self.normalize_title(title),
            'price': price,
            'description_hash': hashlib.md5(description.encode()).hexdigest() if description else None,
            'image_count': len(images) if images else 0
        }
        
        # Create composite fingerprint
        fingerprint_string = f"{fingerprint_data['title_normalized']}_{fingerprint_data['price']}_{fingerprint_data['description_hash']}"
        return hashlib.md5(fingerprint_string.encode()).hexdigest()[:16]
    
    def normalize_title(self, title):
        """Normalize title for comparison (remove year variations, etc.)"""
        import re
        
        # Remove Facebook marketplace prefix
        title = re.sub(r'\(\d+\)\s*Marketplace\s*-\s*', '', title)
        title = re.sub(r'\|\s*Facebook$', '', title)
        
        # Normalize whitespace and case
        title = ' '.join(title.lower().split())
        
        # Extract make/model/year for comparison
        # This helps identify the same ski listed with slight title variations
        return title
    
    def add_to_mobile_queue(self, url, source="mobile"):
        """Add URL to processing queue"""
        queue_data = self.load_queue()
        
        new_item = {
            'id': datetime.now().timestamp(),
            'url': url,
            'source': source,
            'status': 'pending',
            'added_date': datetime.now().isoformat(),
            'processing_attempts': 0
        }
        
        queue_data.append(new_item)
        self.save_queue(queue_data)
        
        logger.info(f"📱 Added to mobile queue: {url}")
        return new_item['id']
    
    async def process_mobile_queue(self):
        """Process all items in mobile queue"""
        queue_data = self.load_queue()
        pending_items = [item for item in queue_data if item['status'] == 'pending']
        
        if not pending_items:
            logger.info("📱 Mobile queue is empty")
            return
        
        logger.info(f"📱 Processing {len(pending_items)} mobile queue items...")
        
        # Import enhanced collector
        from enhanced_screenshot_collector import EnhancedScreenshotCollector
        
        # Process each item
        for item in pending_items:
            try:
                # Mark as processing
                item['status'] = 'processing'
                item['processing_attempts'] += 1
                self.save_queue(queue_data)
                
                # Process the single URL
                result = await self.process_single_url(item['url'])
                
                if result:
                    # Check for duplicates
                    fingerprint = self.generate_listing_fingerprint(
                        result.get('title', ''),
                        result.get('price'),
                        result.get('description'),
                        result.get('images')
                    )
                    
                    duplicate_info = self.check_duplicate(fingerprint, result)
                    
                    if duplicate_info['is_duplicate']:
                        logger.info(f"🔄 Duplicate detected: {duplicate_info['action']}")
                        item['status'] = 'duplicate'
                        item['duplicate_action'] = duplicate_info['action']
                        item['original_listing'] = duplicate_info['original_id']
                    else:
                        # Add to tracker and sync to Supabase
                        await self.add_to_tracker(result)
                        item['status'] = 'completed'
                        item['listing_id'] = result.get('listing_id')
                    
                    item['fingerprint'] = fingerprint
                    
                else:
                    item['status'] = 'failed'
                    
                item['processed_date'] = datetime.now().isoformat()
                self.save_queue(queue_data)
                
            except Exception as e:
                logger.error(f"❌ Mobile processing failed for {item['url']}: {e}")
                item['status'] = 'failed'
                item['error'] = str(e)
                self.save_queue(queue_data)
    
    def check_duplicate(self, fingerprint, new_data):
        """
        Advanced duplicate detection with change tracking
        Returns: {'is_duplicate': bool, 'action': str, 'original_id': str}
        """
        cache = self.load_duplicate_cache()
        
        # Check exact fingerprint match
        if fingerprint in cache:
            original = cache[fingerprint]
            
            # Compare for changes
            changes = self.detect_changes(original, new_data)
            
            if changes:
                return {
                    'is_duplicate': True,
                    'action': 'update_existing',
                    'original_id': original['listing_id'],
                    'changes': changes
                }
            else:
                return {
                    'is_duplicate': True,
                    'action': 'skip_identical',
                    'original_id': original['listing_id']
                }
        
        # Check for similar listings (same make/model but different details)
        similar_matches = self.find_similar_listings(new_data, cache)
        
        if similar_matches:
            # Manual review needed
            return {
                'is_duplicate': True,
                'action': 'manual_review',
                'similar_listings': similar_matches
            }
        
        # Not a duplicate - add to cache
        cache[fingerprint] = {
            'listing_id': new_data.get('listing_id'),
            'title': new_data.get('title'),
            'price': new_data.get('price'),
            'first_seen': datetime.now().isoformat(),
            'last_updated': datetime.now().isoformat()
        }
        
        self.save_duplicate_cache(cache)
        
        return {'is_duplicate': False, 'action': 'add_new'}
    
    def detect_changes(self, original, new_data):
        """Detect what changed between original and new listing"""
        changes = []
        
        if original.get('price') != new_data.get('price'):
            changes.append({
                'field': 'price',
                'old_value': original.get('price'),
                'new_value': new_data.get('price'),
                'change_type': 'price_update'
            })
        
        # Add more change detection logic here
        return changes
    
    def find_similar_listings(self, new_data, cache):
        """Find potentially similar listings for manual review"""
        # Implement fuzzy matching logic
        return []
    
    def load_queue(self):
        """Load mobile processing queue"""
        try:
            with open(self.processing_queue, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            return []
    
    def save_queue(self, queue_data):
        """Save mobile processing queue"""
        with open(self.processing_queue, 'w') as f:
            json.dump(queue_data, f, indent=2)
    
    def load_duplicate_cache(self):
        """Load duplicate detection cache"""
        try:
            with open(self.duplicate_cache, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            return {}
    
    def save_duplicate_cache(self, cache_data):
        """Save duplicate detection cache"""
        with open(self.duplicate_cache, 'w') as f:
            json.dump(cache_data, f, indent=2)
    
    async def process_single_url(self, url):
        """Process a single URL with enhanced extraction"""
        # This would use the enhanced screenshot collector
        # Implementation depends on your specific needs
        pass
    
    async def add_to_tracker(self, listing_data):
        """Add processed listing to tracker and sync to Supabase"""
        # Add to local tracker
        # Sync to Supabase
        # Update real-time dashboard
        pass

# Web interface for mobile URL submission
MOBILE_LANDING_PAGE = """
<!DOCTYPE html>
<html>
<head>
    <title>Add Listing - Marketplace Tracker</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; padding: 20px; }
        .container { max-width: 400px; margin: 0 auto; }
        input[type="url"] { width: 100%; padding: 15px; border: 2px solid #ddd; border-radius: 8px; font-size: 16px; }
        button { width: 100%; padding: 15px; background: #007AFF; color: white; border: none; border-radius: 8px; font-size: 16px; margin-top: 10px; }
        .status { padding: 10px; border-radius: 8px; margin-top: 10px; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <div class="container">
        <h2>🏍️ Add Listing</h2>
        <p>Share a Facebook Marketplace URL to add it to your tracker:</p>
        
        <form onsubmit="addListing(event)">
            <input type="url" id="url" placeholder="https://www.facebook.com/marketplace/item/..." required>
            <button type="submit">Add to Queue</button>
        </form>
        
        <div id="status"></div>
        
        <div style="margin-top: 30px; font-size: 14px; color: #666;">
            <h4>How it works:</h4>
            <ol>
                <li>📱 Share URL from your phone</li>
                <li>🤖 Automatic screenshot & data extraction</li>
                <li>📊 Market analysis & pricing</li>
                <li>🔄 Real-time sync across devices</li>
            </ol>
        </div>
    </div>
    
    <script>
        async function addListing(event) {
            event.preventDefault();
            const url = document.getElementById('url').value;
            const status = document.getElementById('status');
            
            status.innerHTML = '<div class="status">📦 Adding to queue...</div>';
            
            try {
                const response = await fetch('/api/add-listing', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ url: url, source: 'mobile' })
                });
                
                if (response.ok) {
                    status.innerHTML = '<div class="status success">✅ Added to processing queue! Check your tracker in a few minutes.</div>';
                    document.getElementById('url').value = '';
                } else {
                    throw new Error('Failed to add listing');
                }
            } catch (error) {
                status.innerHTML = '<div class="status error">❌ Failed to add listing. Please try again.</div>';
            }
        }
    </script>
</body>
</html>
"""

if __name__ == "__main__":
    # Example usage
    handler = MobileIntegrationHandler()
    
    # Add URL from mobile
    handler.add_to_mobile_queue("https://www.facebook.com/marketplace/item/1106057990957133/", "mobile")
    
    # Process queue
    asyncio.run(handler.process_mobile_queue())
