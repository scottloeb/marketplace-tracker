#!/usr/bin/env python3
"""
Advanced Duplicate Detection and Management
Handles complex scenarios like price changes, re-listings, and tracking history
"""

import json
import hashlib
import difflib
from datetime import datetime, timedelta
import re
import logging

logger = logging.getLogger(__name__)

class AdvancedDuplicateManager:
    """
    Sophisticated duplicate detection that handles:
    1. Same item re-listed (delisted then relisted)
    2. Price changes over time
    3. Description updates
    4. Photo additions/changes
    5. Location changes
    6. Historical tracking
    """
    
    def __init__(self):
        self.duplicate_db = "duplicate_database.json"
        self.price_history_db = "price_history_database.json"
        self.similarity_threshold = 0.85
        
    def create_composite_fingerprint(self, listing_data):
        """
        Create multiple fingerprints for different matching strategies
        Returns dict with different fingerprint types
        """
        title = listing_data.get('title', '')
        description = listing_data.get('description', '')
        price = listing_data.get('price')
        location = listing_data.get('location', '')
        images = listing_data.get('images', [])
        
        fingerprints = {
            # Exact match - for identical listings
            'exact': self._create_exact_fingerprint(title, description, price, location),
            
            # Content match - ignores price changes
            'content': self._create_content_fingerprint(title, description, location),
            
            # Item match - core item identity (make/model/year)
            'item': self._create_item_fingerprint(title),
            
            # Image match - based on image signatures
            'images': self._create_image_fingerprint(images),
            
            # Seller + item match
            'seller_item': self._create_seller_item_fingerprint(listing_data),
        }
        
        return fingerprints
    
    def _create_exact_fingerprint(self, title, description, price, location):
        """Exact match including price and description"""
        data = f"{self._normalize_text(title)}{self._normalize_text(description)}{price}{location}"
        return hashlib.md5(data.encode()).hexdigest()[:16]
    
    def _create_content_fingerprint(self, title, description, location):
        """Content match ignoring price"""
        data = f"{self._normalize_text(title)}{self._normalize_text(description)}{location}"
        return hashlib.md5(data.encode()).hexdigest()[:16]
    
    def _create_item_fingerprint(self, title):
        """Core item identity - make, model, year"""
        normalized = self._normalize_text(title)
        
        # Extract key identifiers
        make_model_year = self._extract_make_model_year(normalized)
        
        # Create fingerprint from core attributes
        data = f"{make_model_year['make']}{make_model_year['model']}{make_model_year['year']}"
        return hashlib.md5(data.encode()).hexdigest()[:16]
    
    def _create_image_fingerprint(self, images):
        """Create fingerprint from image URLs/hashes"""
        if not images:
            return None
        
        # Sort images for consistent fingerprinting
        image_urls = sorted([img for img in images if img])
        image_data = ''.join(image_urls)
        return hashlib.md5(image_data.encode()).hexdigest()[:16]
    
    def _create_seller_item_fingerprint(self, listing_data):
        """Fingerprint combining seller and item info"""
        seller = listing_data.get('seller', '')
        title = listing_data.get('title', '')
        location = listing_data.get('location', '')
        
        # Extract seller identifier (could be name, profile, etc.)
        seller_id = self._extract_seller_identifier(seller)
        item_id = self._create_item_fingerprint(title)
        
        data = f"{seller_id}{item_id}{location}"
        return hashlib.md5(data.encode()).hexdigest()[:16]
    
    def _extract_make_model_year(self, title):
        """Extract make, model, year from title"""
        title_lower = title.lower()
        
        # Common makes
        makes = ['yamaha', 'sea-doo', 'seadoo', 'kawasaki', 'honda', 'polaris']
        make = next((m for m in makes if m in title_lower), 'unknown')
        
        # Year extraction (4-digit years)
        year_match = re.search(r'(20\d{2}|19\d{2})', title)
        year = year_match.group(1) if year_match else 'unknown'
        
        # Model extraction (after make, before year)
        model_patterns = [
            r'(vx|fx|gp|gtr|gtx|gti|rxt|svho|cruiser|deluxe|wake|pro)',
            r'(superjet|waverunner|jetski)'
        ]
        
        model = 'unknown'
        for pattern in model_patterns:
            model_match = re.search(pattern, title_lower)
            if model_match:
                model = model_match.group(1)
                break
        
        return {'make': make, 'model': model, 'year': year}
    
    def _extract_seller_identifier(self, seller_data):
        """Extract stable seller identifier"""
        # This could be enhanced to extract profile IDs, names, etc.
        return self._normalize_text(seller_data) if seller_data else 'unknown'
    
    def _normalize_text(self, text):
        """Normalize text for consistent comparison"""
        if not text:
            return ''
        
        # Remove common marketplace prefixes
        text = re.sub(r'\(\d+\)\s*Marketplace\s*-\s*', '', text)
        text = re.sub(r'\|\s*Facebook$', '', text)
        
        # Normalize whitespace and case
        text = ' '.join(text.lower().split())
        
        return text
    
    def find_duplicates(self, new_listing):
        """
        Main duplicate detection method
        Returns comprehensive duplicate analysis
        """
        fingerprints = self.create_composite_fingerprint(new_listing)
        duplicate_db = self._load_duplicate_db()
        
        results = {
            'is_duplicate': False,
            'match_type': None,
            'confidence': 0.0,
            'matched_listings': [],
            'recommended_action': 'add_new',
            'price_change_detected': False,
            'content_change_detected': False,
            'image_change_detected': False
        }
        
        # Check each fingerprint type
        for fp_type, fp_value in fingerprints.items():
            if not fp_value:
                continue
                
            matches = self._find_matches_by_fingerprint(fp_type, fp_value, duplicate_db)
            
            for match in matches:
                match_info = {
                    'fingerprint_type': fp_type,
                    'matched_listing_id': match['listing_id'],
                    'original_url': match['original_url'],
                    'confidence': self._calculate_confidence(fp_type, new_listing, match),
                    'changes_detected': self._detect_changes(new_listing, match)
                }
                
                results['matched_listings'].append(match_info)
        
        if results['matched_listings']:
            results['is_duplicate'] = True
            
            # Determine best match and recommended action
            best_match = max(results['matched_listings'], key=lambda x: x['confidence'])
            results['match_type'] = best_match['fingerprint_type']
            results['confidence'] = best_match['confidence']
            
            # Determine recommended action based on changes
            changes = best_match['changes_detected']
            if changes['price_changed']:
                results['recommended_action'] = 'update_price_history'
                results['price_change_detected'] = True
            elif changes['content_changed']:
                results['recommended_action'] = 'update_listing_details'
                results['content_change_detected'] = True
            elif changes['images_changed']:
                results['recommended_action'] = 'update_images'
                results['image_change_detected'] = True
            else:
                results['recommended_action'] = 'skip_duplicate'
        
        return results
    
    def _find_matches_by_fingerprint(self, fp_type, fp_value, db):
        """Find all matches for a specific fingerprint type"""
        matches = []
        
        for listing_id, listing_data in db.items():
            stored_fps = listing_data.get('fingerprints', {})
            
            if fp_type in stored_fps and stored_fps[fp_type] == fp_value:
                matches.append(listing_data)
        
        return matches
    
    def _calculate_confidence(self, fp_type, new_listing, stored_listing):
        """Calculate confidence score for a match"""
        confidence_weights = {
            'exact': 1.0,
            'content': 0.9,
            'item': 0.7,
            'images': 0.8,
            'seller_item': 0.85
        }
        
        base_confidence = confidence_weights.get(fp_type, 0.5)
        
        # Additional factors
        title_similarity = difflib.SequenceMatcher(
            None, 
            new_listing.get('title', '').lower(),
            stored_listing.get('title', '').lower()
        ).ratio()
        
        # Time factor - recent listings more likely to be re-listings
        time_factor = self._calculate_time_factor(stored_listing.get('last_seen'))
        
        final_confidence = base_confidence * 0.7 + title_similarity * 0.2 + time_factor * 0.1
        
        return min(final_confidence, 1.0)
    
    def _calculate_time_factor(self, last_seen_str):
        """Calculate time-based confidence factor"""
        try:
            last_seen = datetime.fromisoformat(last_seen_str.replace('Z', '+00:00'))
            time_diff = datetime.now() - last_seen
            
            # Higher confidence for recent listings (within last 30 days)
            if time_diff <= timedelta(days=7):
                return 1.0
            elif time_diff <= timedelta(days=30):
                return 0.8
            elif time_diff <= timedelta(days=90):
                return 0.6
            else:
                return 0.3
                
        except:
            return 0.5
    
    def _detect_changes(self, new_listing, stored_listing):
        """Detect what changed between listings"""
        changes = {
            'price_changed': False,
            'content_changed': False,
            'images_changed': False,
            'price_direction': None,
            'price_change_amount': None
        }
        
        # Price changes
        old_price = stored_listing.get('price')
        new_price = new_listing.get('price')
        
        if old_price and new_price and old_price != new_price:
            changes['price_changed'] = True
            changes['price_change_amount'] = new_price - old_price
            changes['price_direction'] = 'increase' if new_price > old_price else 'decrease'
        
        # Content changes
        old_desc = stored_listing.get('description', '')
        new_desc = new_listing.get('description', '')
        
        if old_desc and new_desc:
            similarity = difflib.SequenceMatcher(None, old_desc, new_desc).ratio()
            if similarity < 0.9:  # Less than 90% similar
                changes['content_changed'] = True
        
        # Image changes
        old_images = set(stored_listing.get('images', []))
        new_images = set(new_listing.get('images', []))
        
        if old_images != new_images:
            changes['images_changed'] = True
            changes['images_added'] = list(new_images - old_images)
            changes['images_removed'] = list(old_images - new_images)
        
        return changes
    
    def add_to_duplicate_db(self, listing_data, fingerprints):
        """Add new listing to duplicate database"""
        db = self._load_duplicate_db()
        
        listing_id = listing_data.get('id') or str(datetime.now().timestamp())
        
        db[listing_id] = {
            'listing_id': listing_id,
            'original_url': listing_data.get('url'),
            'title': listing_data.get('title'),
            'price': listing_data.get('price'),
            'description': listing_data.get('description'),
            'images': listing_data.get('images', []),
            'seller': listing_data.get('seller'),
            'location': listing_data.get('location'),
            'fingerprints': fingerprints,
            'first_seen': datetime.now().isoformat(),
            'last_seen': datetime.now().isoformat(),
            'times_seen': 1
        }
        
        self._save_duplicate_db(db)
        return listing_id
    
    def update_duplicate_entry(self, listing_id, new_data, changes):
        """Update existing duplicate entry with changes"""
        db = self._load_duplicate_db()
        
        if listing_id in db:
            entry = db[listing_id]
            
            # Update changed fields
            if changes['price_changed']:
                self._record_price_change(listing_id, entry['price'], new_data.get('price'))
                entry['price'] = new_data.get('price')
            
            if changes['content_changed']:
                entry['description'] = new_data.get('description')
            
            if changes['images_changed']:
                entry['images'] = new_data.get('images', [])
            
            # Update metadata
            entry['last_seen'] = datetime.now().isoformat()
            entry['times_seen'] += 1
            
            db[listing_id] = entry
            self._save_duplicate_db(db)
    
    def _record_price_change(self, listing_id, old_price, new_price):
        """Record price change in history database"""
        history_db = self._load_price_history_db()
        
        if listing_id not in history_db:
            history_db[listing_id] = []
        
        history_db[listing_id].append({
            'timestamp': datetime.now().isoformat(),
            'old_price': old_price,
            'new_price': new_price,
            'change_amount': new_price - old_price if (old_price and new_price) else None,
            'change_type': 'increase' if (old_price and new_price and new_price > old_price) else 'decrease'
        })
        
        self._save_price_history_db(history_db)
    
    def get_price_history(self, listing_id):
        """Get complete price history for a listing"""
        history_db = self._load_price_history_db()
        return history_db.get(listing_id, [])
    
    def _load_duplicate_db(self):
        """Load duplicate database"""
        try:
            with open(self.duplicate_db, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            return {}
    
    def _save_duplicate_db(self, db):
        """Save duplicate database"""
        with open(self.duplicate_db, 'w') as f:
            json.dump(db, f, indent=2)
    
    def _load_price_history_db(self):
        """Load price history database"""
        try:
            with open(self.price_history_db, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            return {}
    
    def _save_price_history_db(self, db):
        """Save price history database"""
        with open(self.price_history_db, 'w') as f:
            json.dump(db, f, indent=2)

# Usage example
if __name__ == "__main__":
    dm = AdvancedDuplicateManager()
    
    # Test with sample listing
    test_listing = {
        'title': '2020 Yamaha VX Cruiser HO - Low Hours',
        'price': 12500,
        'description': 'Excellent condition, garage kept...',
        'url': 'https://facebook.com/marketplace/item/123',
        'images': ['img1.jpg', 'img2.jpg'],
        'seller': 'John Doe',
        'location': 'Sacramento, CA'
    }
    
    # Check for duplicates
    duplicate_result = dm.find_duplicates(test_listing)
    print(f"Duplicate check: {duplicate_result}")
    
    # Add to database if not duplicate
    if not duplicate_result['is_duplicate']:
        fingerprints = dm.create_composite_fingerprint(test_listing)
        listing_id = dm.add_to_duplicate_db(test_listing, fingerprints)
        print(f"Added to database with ID: {listing_id}")
