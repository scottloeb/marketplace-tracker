#!/usr/bin/env python3
"""
Price History Tracker for Marketplace Listings
Tracks price changes and market trends to identify buying opportunities.
"""

import json
import sqlite3
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any
from pathlib import Path
import statistics


class PriceHistoryTracker:
    """Track price changes and market trends for marketplace listings."""
    
    def __init__(self, db_file="price_history.db"):
        self.db_file = db_file
        self.setup_database()
        print(f"💰 Price History Tracker initialized with database: {db_file}")
    
    def setup_database(self):
        """Initialize the price history database."""
        conn = sqlite3.connect(self.db_file)
        cursor = conn.cursor()
        
        # Create price history table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS price_history (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                listing_url TEXT NOT NULL,
                listing_id TEXT,
                title TEXT,
                price REAL,
                location TEXT,
                seller TEXT,
                recorded_date TEXT NOT NULL,
                source TEXT DEFAULT 'Facebook Marketplace',
                change_type TEXT,  -- 'new', 'price_change', 'update'
                previous_price REAL,
                price_change REAL,
                notes TEXT
            )
        ''')
        
        # Create listing trends table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS listing_trends (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                listing_url TEXT NOT NULL,
                current_price REAL,
                original_price REAL,
                lowest_price REAL,
                highest_price REAL,
                price_changes INTEGER DEFAULT 0,
                days_tracked INTEGER DEFAULT 0,
                trend_direction TEXT,  -- 'dropping', 'rising', 'stable'
                trend_confidence REAL,
                last_updated TEXT,
                buying_opportunity_score REAL,
                UNIQUE(listing_url)
            )
        ''')
        
        # Create market trends table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS market_trends (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                make TEXT,
                model TEXT,
                year_range TEXT,
                average_price REAL,
                price_trend TEXT,
                sample_size INTEGER,
                trend_period TEXT,
                calculated_date TEXT
            )
        ''')
        
        conn.commit()
        conn.close()
        print("✅ Price history database initialized")
    
    def process_listing_update(self, listing_data: Dict[str, Any], is_new_listing: bool = False) -> Dict[str, Any]:
        """
        Process a listing update and track price changes.
        
        Args:
            listing_data: The listing data from tracker
            is_new_listing: Whether this is a new listing or an update
        
        Returns:
            Dictionary with update analysis and recommendations
        """
        url = listing_data.get('url')
        current_price = listing_data.get('price')
        
        if not url:
            return {"error": "No URL provided"}
        
        conn = sqlite3.connect(self.db_file)
        cursor = conn.cursor()
        
        try:
            # Check if we've seen this listing before
            cursor.execute(
                "SELECT price, recorded_date FROM price_history WHERE listing_url = ? ORDER BY recorded_date DESC LIMIT 1",
                (url,)
            )
            last_record = cursor.fetchone()
            
            if last_record and not is_new_listing:
                # This is an update to existing listing
                previous_price, last_date = last_record
                result = self._handle_price_update(cursor, listing_data, previous_price)
            else:
                # This is a new listing
                result = self._handle_new_listing(cursor, listing_data)
            
            conn.commit()
            
            # Update trend analysis
            self._update_listing_trends(url)
            self._update_market_trends(listing_data)
            
            return result
            
        finally:
            conn.close()
    
    def _handle_new_listing(self, cursor, listing_data: Dict[str, Any]) -> Dict[str, Any]:
        """Handle a new listing entry."""
        url = listing_data.get('url')
        current_price = listing_data.get('price')
        
        # Record new listing
        cursor.execute('''
            INSERT INTO price_history 
            (listing_url, listing_id, title, price, location, seller, recorded_date, change_type)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            url,
            str(listing_data.get('id', '')),
            listing_data.get('title', ''),
            current_price,
            listing_data.get('location', ''),
            listing_data.get('seller', ''),
            datetime.now().isoformat(),
            'new'
        ))
        
        # Initialize trend tracking
        cursor.execute('''
            INSERT OR REPLACE INTO listing_trends
            (listing_url, current_price, original_price, lowest_price, highest_price, 
             price_changes, days_tracked, trend_direction, last_updated, buying_opportunity_score)
            VALUES (?, ?, ?, ?, ?, 0, 0, 'new', ?, 0.5)
        ''', (
            url, current_price, current_price, current_price, current_price,
            datetime.now().isoformat()
        ))
        
        return {
            "status": "new_listing",
            "message": "New listing tracked",
            "price": current_price,
            "tracking_started": True
        }
    
    def _handle_price_update(self, cursor, listing_data: Dict[str, Any], previous_price: float) -> Dict[str, Any]:
        """Handle price update for existing listing."""
        url = listing_data.get('url')
        current_price = listing_data.get('price')
        
        if not current_price:
            return {"status": "no_price", "message": "No current price to compare"}
        
        price_change = current_price - previous_price
        change_percentage = (price_change / previous_price) * 100 if previous_price > 0 else 0
        
        # Record price change
        cursor.execute('''
            INSERT INTO price_history 
            (listing_url, listing_id, title, price, location, seller, recorded_date, 
             change_type, previous_price, price_change, notes)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            url,
            str(listing_data.get('id', '')),
            listing_data.get('title', ''),
            current_price,
            listing_data.get('location', ''),
            listing_data.get('seller', ''),
            datetime.now().isoformat(),
            'price_change' if abs(price_change) > 0.01 else 'update',
            previous_price,
            price_change,
            f"Price change: {change_percentage:+.1f}%"
        ))
        
        # Analyze the change
        change_analysis = self._analyze_price_change(price_change, change_percentage, listing_data)
        
        return {
            "status": "price_updated",
            "previous_price": previous_price,
            "current_price": current_price,
            "price_change": price_change,
            "change_percentage": round(change_percentage, 1),
            "analysis": change_analysis
        }
    
    def _analyze_price_change(self, price_change: float, change_percentage: float, listing_data: Dict[str, Any]) -> Dict[str, Any]:
        """Analyze the significance of a price change."""
        analysis = {
            "significance": "minor",
            "recommendation": "monitor",
            "urgency": "low",
            "reason": ""
        }
        
        abs_change = abs(price_change)
        abs_percentage = abs(change_percentage)
        
        if price_change < 0:  # Price drop
            if abs_percentage > 15:
                analysis.update({
                    "significance": "major_drop",
                    "recommendation": "buy_opportunity",
                    "urgency": "high",
                    "reason": f"Significant price drop of {abs_percentage:.1f}% (${abs_change:,.0f})"
                })
            elif abs_percentage > 5:
                analysis.update({
                    "significance": "moderate_drop", 
                    "recommendation": "investigate",
                    "urgency": "medium",
                    "reason": f"Price dropped {abs_percentage:.1f}% (${abs_change:,.0f}) - seller may be motivated"
                })
            else:
                analysis.update({
                    "significance": "minor_drop",
                    "recommendation": "monitor",
                    "urgency": "low", 
                    "reason": f"Small price drop of {abs_percentage:.1f}%"
                })
        
        elif price_change > 0:  # Price increase
            if abs_percentage > 10:
                analysis.update({
                    "significance": "major_increase",
                    "recommendation": "pass",
                    "urgency": "low",
                    "reason": f"Price increased {abs_percentage:.1f}% - may be overpriced now"
                })
            else:
                analysis.update({
                    "significance": "minor_increase",
                    "recommendation": "monitor",
                    "urgency": "low",
                    "reason": f"Price increased {abs_percentage:.1f}% - still worth monitoring"
                })
        
        return analysis
    
    def _update_listing_trends(self, url: str):
        """Update trend analysis for a specific listing."""
        conn = sqlite3.connect(self.db_file)
        cursor = conn.cursor()
        
        try:
            # Get price history for this listing
            cursor.execute('''
                SELECT price, recorded_date FROM price_history 
                WHERE listing_url = ? 
                ORDER BY recorded_date ASC
            ''', (url,))
            
            price_history = cursor.fetchall()
            
            if len(price_history) < 2:
                return  # Need at least 2 data points for trend analysis
            
            prices = [p[0] for p in price_history if p[0] is not None]
            dates = [datetime.fromisoformat(p[1]) for p in price_history]
            
            if len(prices) < 2:
                return
            
            # Calculate trend metrics
            original_price = prices[0]
            current_price = prices[-1]
            lowest_price = min(prices)
            highest_price = max(prices)
            price_changes = len(prices) - 1
            days_tracked = (dates[-1] - dates[0]).days
            
            # Determine trend direction
            recent_prices = prices[-3:] if len(prices) >= 3 else prices
            if len(recent_prices) >= 2:
                trend_slope = (recent_prices[-1] - recent_prices[0]) / len(recent_prices)
                
                if trend_slope < -50:  # Dropping by $50+ per data point
                    trend_direction = "dropping"
                    trend_confidence = 0.8
                elif trend_slope > 50:   # Rising by $50+ per data point
                    trend_direction = "rising"
                    trend_confidence = 0.8
                else:
                    trend_direction = "stable"
                    trend_confidence = 0.6
            else:
                trend_direction = "insufficient_data"
                trend_confidence = 0.0
            
            # Calculate buying opportunity score
            buying_score = self._calculate_buying_opportunity_score(
                current_price, original_price, lowest_price, highest_price, trend_direction
            )
            
            # Update trends table
            cursor.execute('''
                INSERT OR REPLACE INTO listing_trends
                (listing_url, current_price, original_price, lowest_price, highest_price,
                 price_changes, days_tracked, trend_direction, trend_confidence, 
                 last_updated, buying_opportunity_score)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (
                url, current_price, original_price, lowest_price, highest_price,
                price_changes, days_tracked, trend_direction, trend_confidence,
                datetime.now().isoformat(), buying_score
            ))
            
            conn.commit()
            
        finally:
            conn.close()
    
    def _calculate_buying_opportunity_score(self, current, original, lowest, highest, trend):
        """Calculate a buying opportunity score (0.0 to 1.0)."""
        score = 0.5  # Base score
        
        # Price position scoring
        if highest > lowest:
            price_position = (highest - current) / (highest - lowest)
            score += price_position * 0.3  # Up to 30% bonus for being near lowest
        
        # Trend scoring
        if trend == "dropping":
            score += 0.2  # 20% bonus for dropping trend
        elif trend == "rising":
            score -= 0.1  # 10% penalty for rising trend
        
        # Total drop from original
        if original > 0:
            total_drop = (original - current) / original
            if total_drop > 0:
                score += min(total_drop, 0.2)  # Up to 20% bonus for significant drops
        
        return max(0.0, min(1.0, score))  # Clamp between 0 and 1
    
    def _update_market_trends(self, listing_data: Dict[str, Any]):
        """Update market-wide trends for make/model combinations."""
        make = listing_data.get('make')
        model = listing_data.get('model') 
        year = listing_data.get('year')
        
        if not all([make, model, year]):
            return  # Need complete data for market trends
        
        # This would analyze market trends across all listings
        # For now, we'll implement the individual listing trends
        pass
    
    def get_price_alerts(self, min_drop_percentage: float = 10) -> List[Dict[str, Any]]:
        """Get listings with significant price drops."""
        conn = sqlite3.connect(self.db_file)
        cursor = conn.cursor()
        
        try:
            # Find listings with recent significant price drops
            cursor.execute('''
                SELECT DISTINCT ph.listing_url, ph.title, ph.price, ph.previous_price,
                       ph.price_change, ph.recorded_date, lt.buying_opportunity_score
                FROM price_history ph
                JOIN listing_trends lt ON ph.listing_url = lt.listing_url
                WHERE ph.change_type = 'price_change' 
                  AND ph.price_change < 0
                  AND ABS(ph.price_change / ph.previous_price * 100) >= ?
                  AND ph.recorded_date >= datetime('now', '-7 days')
                ORDER BY ph.price_change ASC
            ''', (min_drop_percentage,))
            
            alerts = []
            for row in cursor.fetchall():
                url, title, price, prev_price, change, date, buy_score = row
                
                alerts.append({
                    "url": url,
                    "title": title,
                    "current_price": price,
                    "previous_price": prev_price,
                    "price_drop": abs(change),
                    "drop_percentage": abs(change / prev_price * 100) if prev_price > 0 else 0,
                    "recorded_date": date,
                    "buying_opportunity_score": buy_score,
                    "recommendation": "URGENT BUY" if buy_score > 0.8 else "INVESTIGATE"
                })
            
            return alerts
            
        finally:
            conn.close()
    
    def get_listing_history(self, url: str) -> Dict[str, Any]:
        """Get complete price history for a specific listing."""
        conn = sqlite3.connect(self.db_file)
        cursor = conn.cursor()
        
        try:
            # Get price history
            cursor.execute('''
                SELECT price, recorded_date, change_type, previous_price, price_change, notes
                FROM price_history 
                WHERE listing_url = ? 
                ORDER BY recorded_date ASC
            ''', (url,))
            
            history_records = cursor.fetchall()
            
            # Get trend summary
            cursor.execute('''
                SELECT current_price, original_price, lowest_price, highest_price,
                       price_changes, days_tracked, trend_direction, buying_opportunity_score
                FROM listing_trends 
                WHERE listing_url = ?
            ''', (url,))
            
            trend_data = cursor.fetchone()
            
            # Build response
            history = {
                "url": url,
                "records": [],
                "summary": None
            }
            
            for record in history_records:
                price, date, change_type, prev_price, change, notes = record
                history["records"].append({
                    "price": price,
                    "date": date,
                    "change_type": change_type,
                    "previous_price": prev_price,
                    "price_change": change,
                    "notes": notes
                })
            
            if trend_data:
                current, original, lowest, highest, changes, days, direction, buy_score = trend_data
                history["summary"] = {
                    "current_price": current,
                    "original_price": original,
                    "lowest_price": lowest,
                    "highest_price": highest,
                    "total_changes": changes,
                    "days_tracked": days,
                    "trend_direction": direction,
                    "buying_opportunity_score": buy_score,
                    "total_drop_from_original": original - current if original and current else 0,
                    "drop_percentage": ((original - current) / original * 100) if original and current and original > 0 else 0
                }
            
            return history
            
        finally:
            conn.close()
    
    def detect_duplicate_url_in_tracker(self, new_listing: Dict[str, Any], existing_listings: List[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
        """
        Detect if a URL is already in the tracker (triggers update workflow).
        
        Args:
            new_listing: The new listing being added
            existing_listings: All existing listings in tracker
        
        Returns:
            Existing listing data if duplicate found, None otherwise
        """
        new_url = new_listing.get('url')
        if not new_url:
            return None
        
        # Look for existing listing with same URL
        for existing in existing_listings:
            if existing.get('url') == new_url:
                print(f"🔄 Duplicate URL detected: {new_url}")
                return existing
        
        return None
    
    def create_price_update_recommendation(self, new_listing: Dict[str, Any], existing_listing: Dict[str, Any]) -> Dict[str, Any]:
        """
        Create recommendation for handling duplicate URL (price update).
        
        Args:
            new_listing: New listing data (with potentially updated price)
            existing_listing: Existing listing data
        
        Returns:
            Recommendation for how to handle the update
        """
        new_price = new_listing.get('price')
        old_price = existing_listing.get('price')
        
        recommendation = {
            "action": "update_detected",
            "update_type": "unknown",
            "recommendation": "investigate",
            "details": {}
        }
        
        if new_price and old_price:
            price_change = new_price - old_price
            change_percentage = (price_change / old_price) * 100 if old_price > 0 else 0
            
            recommendation["details"] = {
                "previous_price": old_price,
                "new_price": new_price,
                "price_change": price_change,
                "change_percentage": round(change_percentage, 1)
            }
            
            if abs(change_percentage) < 1:
                recommendation.update({
                    "update_type": "no_price_change",
                    "recommendation": "skip_update",
                    "reason": "Price unchanged"
                })
            elif price_change < 0:
                if abs(change_percentage) > 15:
                    recommendation.update({
                        "update_type": "major_price_drop",
                        "recommendation": "urgent_buy_signal",
                        "reason": f"Major price drop of {abs(change_percentage):.1f}% - seller motivated!"
                    })
                elif abs(change_percentage) > 5:
                    recommendation.update({
                        "update_type": "price_drop",
                        "recommendation": "buy_opportunity",
                        "reason": f"Price dropped {abs(change_percentage):.1f}% - good buying signal"
                    })
                else:
                    recommendation.update({
                        "update_type": "minor_price_drop",
                        "recommendation": "positive_signal",
                        "reason": f"Small price drop of {abs(change_percentage):.1f}%"
                    })
            else:  # Price increase
                recommendation.update({
                    "update_type": "price_increase",
                    "recommendation": "monitor",
                    "reason": f"Price increased {change_percentage:.1f}% - may be in demand"
                })
        
        elif new_price and not old_price:
            recommendation.update({
                "update_type": "price_added",
                "recommendation": "update_listing",
                "reason": "Price information now available"
            })
        
        elif not new_price and old_price:
            recommendation.update({
                "update_type": "price_removed",
                "recommendation": "investigate",
                "reason": "Price no longer listed - may be sold or removed"
            })
        
        return recommendation
    
    def get_market_insights(self, days: int = 30) -> Dict[str, Any]:
        """Get market insights and trends from price history."""
        conn = sqlite3.connect(self.db_file)
        cursor = conn.cursor()
        
        try:
            cutoff_date = (datetime.now() - timedelta(days=days)).isoformat()
            
            # Get price drop alerts
            alerts = self.get_price_alerts(min_drop_percentage=5)
            
            # Get trending data
            cursor.execute('''
                SELECT listing_url, current_price, original_price, trend_direction, 
                       buying_opportunity_score, days_tracked
                FROM listing_trends
                WHERE last_updated >= ?
                ORDER BY buying_opportunity_score DESC
            ''', (cutoff_date,))
            
            trending_data = cursor.fetchall()
            
            # Calculate market statistics
            dropping_count = sum(1 for t in trending_data if t[3] == 'dropping')
            rising_count = sum(1 for t in trending_data if t[3] == 'rising')
            stable_count = sum(1 for t in trending_data if t[3] == 'stable')
            
            high_opportunity_count = sum(1 for t in trending_data if t[4] > 0.7)
            
            insights = {
                "period_days": days,
                "total_tracked_listings": len(trending_data),
                "price_alerts": alerts,
                "market_trends": {
                    "dropping_prices": dropping_count,
                    "rising_prices": rising_count, 
                    "stable_prices": stable_count
                },
                "opportunities": {
                    "high_opportunity_listings": high_opportunity_count,
                    "total_potential_alerts": len(alerts)
                },
                "top_opportunities": [
                    {
                        "url": t[0],
                        "current_price": t[1],
                        "original_price": t[2],
                        "trend": t[3],
                        "opportunity_score": t[4],
                        "days_tracked": t[5]
                    }
                    for t in trending_data[:10]  # Top 10 opportunities
                ],
                "insights": []
            }
            
            # Generate actionable insights
            if len(alerts) > 0:
                insights["insights"].append(f"🔥 {len(alerts)} listings have significant price drops - investigate immediately!")
            
            if dropping_count > rising_count:
                insights["insights"].append(f"📉 Market trend: More prices dropping ({dropping_count}) than rising ({rising_count}) - buyer's market!")
            
            if high_opportunity_count > 0:
                insights["insights"].append(f"🎯 {high_opportunity_count} listings have high buying opportunity scores")
            
            return insights
            
        finally:
            conn.close()
    
    def export_price_data(self, format_type: str = "json") -> str:
        """Export price history data for analysis."""
        conn = sqlite3.connect(self.db_file)
        
        try:
            # Get all price history
            df_history = conn.execute('''
                SELECT listing_url, title, price, recorded_date, change_type, 
                       previous_price, price_change
                FROM price_history 
                ORDER BY recorded_date DESC
            ''').fetchall()
            
            # Get trend summaries
            df_trends = conn.execute('''
                SELECT listing_url, current_price, original_price, lowest_price, highest_price,
                       trend_direction, buying_opportunity_score, days_tracked
                FROM listing_trends
                ORDER BY buying_opportunity_score DESC
            ''').fetchall()
            
            if format_type == "json":
                export_data = {
                    "export_timestamp": datetime.now().isoformat(),
                    "price_history": [
                        {
                            "url": row[0], "title": row[1], "price": row[2], 
                            "date": row[3], "type": row[4], "prev_price": row[5], "change": row[6]
                        }
                        for row in df_history
                    ],
                    "trends": [
                        {
                            "url": row[0], "current": row[1], "original": row[2],
                            "lowest": row[3], "highest": row[4], "trend": row[5],
                            "opportunity_score": row[6], "days_tracked": row[7]
                        }
                        for row in df_trends
                    ]
                }
                
                filename = f"price_history_export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
                with open(filename, 'w') as f:
                    json.dump(export_data, f, indent=2)
                
                print(f"💾 Price history exported: {filename}")
                return filename
            
        finally:
            conn.close()


class TrackerPriceIntegration:
    """Integration between price tracker and marketplace tracker."""
    
    def __init__(self):
        self.price_tracker = PriceHistoryTracker()
        print("🔗 Tracker-Price integration ready")
    
    def process_tracker_import(self, import_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Process marketplace tracker import and detect price updates.
        
        Args:
            import_data: Data being imported to tracker
        
        Returns:
            Analysis of price changes and recommendations
        """
        if not import_data or 'data' not in import_data:
            return {"error": "Invalid import data format"}
        
        new_listings = import_data['data']
        
        # Load existing tracker data for comparison
        existing_listings = self._load_existing_tracker_data()
        
        price_updates = []
        new_listings_added = []
        
        for new_listing in new_listings:
            # Check if this URL already exists
            existing = self.price_tracker.detect_duplicate_url_in_tracker(new_listing, existing_listings)
            
            if existing:
                # This is an update - process price change
                update_result = self.price_tracker.process_listing_update(new_listing, is_new_listing=False)
                
                if update_result.get('status') == 'price_updated':
                    # Create update recommendation
                    recommendation = self.price_tracker.create_price_update_recommendation(new_listing, existing)
                    update_result['recommendation'] = recommendation
                    price_updates.append(update_result)
                    
                    print(f"💰 Price update detected: {new_listing.get('title', 'Unknown')}")
                    print(f"   ${update_result['previous_price']:,.0f} → ${update_result['current_price']:,.0f} ({update_result['change_percentage']:+.1f}%)")
            else:
                # This is a new listing
                self.price_tracker.process_listing_update(new_listing, is_new_listing=True)
                new_listings_added.append(new_listing)
        
        # Generate import analysis
        analysis = {
            "import_timestamp": datetime.now().isoformat(),
            "total_processed": len(new_listings),
            "new_listings": len(new_listings_added),
            "price_updates": len(price_updates),
            "price_update_details": price_updates,
            "recommendations": []
        }
        
        # Add recommendations based on price updates
        urgent_buys = [u for u in price_updates if u.get('recommendation', {}).get('recommendation') == 'urgent_buy_signal']
        if urgent_buys:
            analysis['recommendations'].append({
                "type": "urgent_action",
                "message": f"🔥 {len(urgent_buys)} listings have major price drops - investigate immediately!",
                "listings": urgent_buys
            })
        
        buy_opportunities = [u for u in price_updates if 'buy_opportunity' in u.get('recommendation', {}).get('recommendation', '')]
        if buy_opportunities:
            analysis['recommendations'].append({
                "type": "buy_opportunity",
                "message": f"💰 {len(buy_opportunities)} listings have good buying signals from price drops",
                "listings": buy_opportunities
            })
        
        return analysis
    
    def _load_existing_tracker_data(self) -> List[Dict[str, Any]]:
        """Load existing tracker data for comparison."""
        # This would normally load from localStorage or tracker export
        # For now, return empty list - in production, this would load real data
        return []


# Convenience functions for integration

def track_listing_update(listing_data: Dict[str, Any], is_new: bool = False) -> Dict[str, Any]:
    """Track a listing update and return price analysis."""
    tracker = PriceHistoryTracker()
    return tracker.process_listing_update(listing_data, is_new)

def get_current_price_alerts(min_drop: float = 10) -> List[Dict[str, Any]]:
    """Get current price drop alerts."""
    tracker = PriceHistoryTracker()
    return tracker.get_price_alerts(min_drop)

def get_market_intelligence() -> Dict[str, Any]:
    """Get overall market intelligence and trends."""
    tracker = PriceHistoryTracker()
    return tracker.get_market_insights()


if __name__ == "__main__":
    print("💰 Price History Tracker for Marketplace Listings")
    print("="*60)
    
    # Initialize system
    tracker = PriceHistoryTracker()
    
    # Demo the price tracking capabilities
    print("\n🧪 Testing price tracking system...")
    
    # Simulate a new listing
    new_listing = {
        "id": "demo123",
        "title": "2020 Yamaha VX Cruiser HO - Demo listing",
        "price": 12000,
        "url": "https://facebook.com/marketplace/item/demo123",
        "location": "Test City, CA"
    }
    
    result1 = tracker.process_listing_update(new_listing, is_new_listing=True)
    print(f"✅ New listing tracked: {result1}")
    
    # Simulate a price update
    updated_listing = new_listing.copy()
    updated_listing["price"] = 10500  # Price drop
    
    result2 = tracker.process_listing_update(updated_listing, is_new_listing=False)
    print(f"💰 Price update tracked: {result2}")
    
    # Get alerts
    alerts = tracker.get_price_alerts(min_drop_percentage=5)
    print(f"🔥 Current alerts: {len(alerts)}")
    
    # Get market insights
    insights = tracker.get_market_insights()
    print(f"📊 Market insights: {len(insights.get('insights', []))} trends detected")
    
    print("\n🎯 Price tracking system ready for production use!")
    print("📋 Integrates with your mobile-to-laptop workflow to track market changes.")
