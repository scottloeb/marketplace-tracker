#!/usr/bin/env python3
"""
Market Intelligence Engine
Detects patterns, trends, clusters, and market opportunities
Extensible for any product category beyond jet skis
"""

import json
import re
from datetime import datetime, timedelta
from collections import defaultdict, Counter
import statistics
import logging
from dataclasses import dataclass
from typing import List, Dict, Any, Optional
import geopy.distance

logger = logging.getLogger(__name__)

@dataclass
class MarketPattern:
    """Represents a detected market pattern"""
    pattern_type: str
    confidence: float
    description: str
    affected_listings: List[str]
    potential_value: Optional[float] = None
    actionable_insight: Optional[str] = None
    supporting_data: Optional[Dict] = None

class MarketIntelligenceEngine:
    """
    Advanced market analysis that detects:
    1. Seasonal patterns and clusters
    2. Geographic price variations
    3. Seller behavior patterns  
    4. Fleet liquidation events
    5. Market timing opportunities
    6. Price manipulation detection
    7. Emerging trends
    """
    
    def __init__(self):
        self.patterns_db = "market_patterns.json"
        self.intelligence_cache = "market_intelligence_cache.json"
        
    def analyze_market_patterns(self, listings_data: List[Dict]) -> List[MarketPattern]:
        """
        Main analysis method - detects all market patterns
        """
        patterns = []
        
        # Geographic analysis
        patterns.extend(self._detect_geographic_clusters(listings_data))
        
        # Seasonal patterns
        patterns.extend(self._detect_seasonal_patterns(listings_data))
        
        # Seller behavior analysis
        patterns.extend(self._detect_seller_patterns(listings_data))
        
        # Fleet liquidation detection
        patterns.extend(self._detect_fleet_liquidation(listings_data))
        
        # Price anomaly detection
        patterns.extend(self._detect_price_anomalies(listings_data))
        
        # Market timing analysis
        patterns.extend(self._detect_market_timing_opportunities(listings_data))
        
        # Trend analysis
        patterns.extend(self._detect_emerging_trends(listings_data))
        
        # Save patterns for historical analysis
        self._save_patterns(patterns)
        
        return sorted(patterns, key=lambda x: x.confidence, reverse=True)
    
    def _detect_geographic_clusters(self, listings: List[Dict]) -> List[MarketPattern]:
        """Detect geographic price clustering and arbitrage opportunities"""
        patterns = []
        
        # Group listings by location
        location_groups = defaultdict(list)
        for listing in listings:
            location = self._normalize_location(listing.get('location', ''))
            if location:
                location_groups[location].append(listing)
        
        # Analyze price variations by location
        location_stats = {}
        for location, loc_listings in location_groups.items():
            if len(loc_listings) >= 3:  # Need minimum for statistical significance
                prices = [l.get('price', 0) for l in loc_listings if l.get('price')]
                if prices:
                    location_stats[location] = {
                        'avg_price': statistics.mean(prices),
                        'median_price': statistics.median(prices),
                        'count': len(loc_listings),
                        'listings': loc_listings
                    }
        
        # Find arbitrage opportunities
        if len(location_stats) >= 2:
            sorted_locations = sorted(location_stats.items(), key=lambda x: x[1]['avg_price'])
            
            lowest = sorted_locations[0]
            highest = sorted_locations[-1]
            
            price_diff = highest[1]['avg_price'] - lowest[1]['avg_price']
            price_diff_pct = (price_diff / lowest[1]['avg_price']) * 100 if lowest[1]['avg_price'] > 0 else 0
            
            if price_diff_pct > 15:  # Significant price difference
                patterns.append(MarketPattern(
                    pattern_type="geographic_arbitrage",
                    confidence=0.8,
                    description=f"Geographic price arbitrage: {highest[0]} averages ${highest[1]['avg_price']:,.0f} vs {lowest[0]} at ${lowest[1]['avg_price']:,.0f}",
                    affected_listings=[l['id'] for l in lowest[1]['listings']],
                    potential_value=price_diff,
                    actionable_insight=f"Consider buying in {lowest[0]} area and selling in {highest[0]} area",
                    supporting_data={
                        'low_price_location': lowest[0],
                        'high_price_location': highest[0],
                        'price_difference': price_diff,
                        'percentage_difference': price_diff_pct
                    }
                ))
        
        # Detect high-density clusters (potential fleet sales)
        for location, stats in location_stats.items():
            if stats['count'] >= 5:  # High concentration
                similar_models = self._find_similar_models(stats['listings'])
                
                if len(similar_models) >= 3:
                    patterns.append(MarketPattern(
                        pattern_type="high_density_cluster",
                        confidence=0.7,
                        description=f"High concentration cluster in {location}: {stats['count']} listings with similar models",
                        affected_listings=[l['id'] for l in stats['listings']],
                        actionable_insight="Investigate for potential fleet liquidation or dealer inventory",
                        supporting_data={
                            'location': location,
                            'count': stats['count'],
                            'similar_models': similar_models
                        }
                    ))
        
        return patterns
    
    def _detect_seasonal_patterns(self, listings: List[Dict]) -> List[MarketPattern]:
        """Detect seasonal listing patterns and timing opportunities"""
        patterns = []
        
        # Analyze listing dates and prices by month
        monthly_data = defaultdict(list)
        current_date = datetime.now()
        
        for listing in listings:
            added_date = listing.get('addedDate') or listing.get('first_seen')
            if added_date:
                try:
                    date_obj = datetime.fromisoformat(added_date.replace('Z', '+00:00'))
                    month = date_obj.month
                    monthly_data[month].append(listing)
                except:
                    continue
        
        # Analyze seasonal trends
        if len(monthly_data) >= 3:  # Need data from multiple months
            monthly_stats = {}
            for month, month_listings in monthly_data.items():
                prices = [l.get('price', 0) for l in month_listings if l.get('price')]
                if prices:
                    monthly_stats[month] = {
                        'avg_price': statistics.mean(prices),
                        'count': len(month_listings),
                        'listings': month_listings
                    }
            
            # Detect end-of-season dumps (typically fall months)
            fall_months = [9, 10, 11]  # Sept, Oct, Nov
            spring_months = [3, 4, 5]   # Mar, Apr, May
            
            fall_data = [stats for month, stats in monthly_stats.items() if month in fall_months]
            spring_data = [stats for month, stats in monthly_stats.items() if month in spring_months]
            
            if fall_data and spring_data:
                fall_avg = statistics.mean([d['avg_price'] for d in fall_data])
                spring_avg = statistics.mean([d['avg_price'] for d in spring_data])
                
                price_diff_pct = ((spring_avg - fall_avg) / fall_avg) * 100 if fall_avg > 0 else 0
                
                if price_diff_pct > 10:  # Significant seasonal variation
                    patterns.append(MarketPattern(
                        pattern_type="seasonal_pricing",
                        confidence=0.75,
                        description=f"Seasonal price variation detected: Fall avg ${fall_avg:,.0f} vs Spring avg ${spring_avg:,.0f}",
                        affected_listings=[l['id'] for month_data in fall_data for l in month_data['listings']],
                        potential_value=spring_avg - fall_avg,
                        actionable_insight="Buy in fall/winter months, sell in spring/summer for seasonal arbitrage",
                        supporting_data={
                            'fall_average': fall_avg,
                            'spring_average': spring_avg,
                            'seasonal_premium': price_diff_pct
                        }
                    ))
        
        return patterns
    
    def _detect_seller_patterns(self, listings: List[Dict]) -> List[MarketPattern]:
        """Detect seller behavior patterns"""
        patterns = []
        
        # Group by seller
        seller_groups = defaultdict(list)
        for listing in listings:
            seller = listing.get('seller', 'Unknown')
            if seller and seller != 'Unknown':
                seller_groups[seller].append(listing)
        
        # Analyze seller patterns
        for seller, seller_listings in seller_groups.items():
            if len(seller_listings) >= 3:  # Multiple listings from same seller
                
                # Check for rapid listing pattern (potential dealer/flipper)
                dates = []
                for listing in seller_listings:
                    date_str = listing.get('addedDate') or listing.get('first_seen')
                    if date_str:
                        try:
                            dates.append(datetime.fromisoformat(date_str.replace('Z', '+00:00')))
                        except:
                            continue
                
                if len(dates) >= 3:
                    date_range = max(dates) - min(dates)
                    
                    if date_range <= timedelta(days=30):  # Multiple listings within 30 days
                        patterns.append(MarketPattern(
                            pattern_type="high_volume_seller",
                            confidence=0.6,
                            description=f"High-volume seller pattern: {seller} listed {len(seller_listings)} items within {date_range.days} days",
                            affected_listings=[l['id'] for l in seller_listings],
                            actionable_insight="Investigate for potential dealer pricing or bulk purchase opportunities",
                            supporting_data={
                                'seller': seller,
                                'listing_count': len(seller_listings),
                                'time_span_days': date_range.days
                            }
                        ))
                
                # Check for similar descriptions (copy-paste pattern)
                descriptions = [l.get('description', '') for l in seller_listings]
                if len(descriptions) >= 2:
                    similar_desc_count = 0
                    for i, desc1 in enumerate(descriptions):
                        for desc2 in descriptions[i+1:]:
                            if self._text_similarity(desc1, desc2) > 0.8:
                                similar_desc_count += 1
                    
                    if similar_desc_count >= 2:
                        patterns.append(MarketPattern(
                            pattern_type="template_seller",
                            confidence=0.7,
                            description=f"Template/dealer pattern: {seller} uses similar descriptions across multiple listings",
                            affected_listings=[l['id'] for l in seller_listings],
                            actionable_insight="Likely commercial seller - may have negotiation flexibility",
                            supporting_data={
                                'seller': seller,
                                'similar_descriptions': similar_desc_count
                            }
                        ))
        
        return patterns
    
    def _detect_fleet_liquidation(self, listings: List[Dict]) -> List[MarketPattern]:
        """Detect potential fleet liquidation events"""
        patterns = []
        
        # Look for clusters of similar year/make/model with similar conditions
        model_clusters = defaultdict(list)
        
        for listing in listings:
            title = listing.get('title', '').lower()
            
            # Extract key identifiers
            make_match = re.search(r'(yamaha|sea-?doo|kawasaki|honda|polaris)', title)
            year_match = re.search(r'(20\d{2}|19\d{2})', title)
            
            if make_match and year_match:
                key = f"{make_match.group(1)}_{year_match.group(1)}"
                model_clusters[key].append(listing)
        
        # Analyze clusters for fleet patterns
        for model_key, cluster_listings in model_clusters.items():
            if len(cluster_listings) >= 4:  # Threshold for potential fleet
                
                # Check for fleet indicators
                fleet_indicators = []
                
                # Similar descriptions mentioning fleet/rental/commercial
                fleet_keywords = ['fleet', 'rental', 'commercial', 'business', 'rebuilt', 'refurbished', 'hours']
                fleet_desc_count = 0
                
                for listing in cluster_listings:
                    desc = (listing.get('description', '') + ' ' + listing.get('title', '')).lower()
                    if any(keyword in desc for keyword in fleet_keywords):
                        fleet_desc_count += 1
                
                if fleet_desc_count >= 2:
                    fleet_indicators.append(f"{fleet_desc_count} listings mention fleet/rental keywords")
                
                # Similar pricing pattern
                prices = [l.get('price', 0) for l in cluster_listings if l.get('price')]
                if len(prices) >= 3:
                    price_cv = statistics.stdev(prices) / statistics.mean(prices) if statistics.mean(prices) > 0 else 0
                    if price_cv < 0.15:  # Low price variation (similar pricing)
                        fleet_indicators.append(f"Similar pricing pattern (CV: {price_cv:.2f})")
                
                # Geographic clustering
                locations = [self._normalize_location(l.get('location', '')) for l in cluster_listings]
                location_counter = Counter([loc for loc in locations if loc])
                if location_counter and location_counter.most_common(1)[0][1] >= 3:
                    fleet_indicators.append(f"Geographic clustering in {location_counter.most_common(1)[0][0]}")
                
                # Seller clustering
                sellers = [l.get('seller', '') for l in cluster_listings]
                seller_counter = Counter([seller for seller in sellers if seller])
                if seller_counter and seller_counter.most_common(1)[0][1] >= 2:
                    fleet_indicators.append(f"Multiple listings from {seller_counter.most_common(1)[0][0]}")
                
                if len(fleet_indicators) >= 2:  # Multiple indicators suggest fleet liquidation
                    avg_price = statistics.mean(prices) if prices else 0
                    
                    patterns.append(MarketPattern(
                        pattern_type="fleet_liquidation",
                        confidence=0.8,
                        description=f"Potential fleet liquidation: {len(cluster_listings)} similar {model_key.replace('_', ' ')} units",
                        affected_listings=[l['id'] for l in cluster_listings],
                        potential_value=avg_price * 0.15,  # Estimate 15% below market discount
                        actionable_insight="Investigate bulk purchase opportunity or expect below-market pricing",
                        supporting_data={
                            'model': model_key.replace('_', ' '),
                            'count': len(cluster_listings),
                            'indicators': fleet_indicators,
                            'average_price': avg_price
                        }
                    ))
        
        return patterns
    
    def _detect_price_anomalies(self, listings: List[Dict]) -> List[MarketPattern]:
        """Detect pricing anomalies and potential deals/overpricing"""
        patterns = []
        
        # Group similar models
        model_groups = defaultdict(list)
        
        for listing in listings:
            title = listing.get('title', '').lower()
            
            # Create model signature
            make_match = re.search(r'(yamaha|sea-?doo|kawasaki|honda|polaris)', title)
            year_match = re.search(r'(20\d{2}|19\d{2})', title)
            model_match = re.search(r'(vx|fx|gp|gtr|gtx|gti|rxt|svho|cruiser|deluxe)', title)
            
            if make_match and year_match:
                key = f"{make_match.group(1)}_{year_match.group(1)}"
                if model_match:
                    key += f"_{model_match.group(1)}"
                
                if listing.get('price'):
                    model_groups[key].append(listing)
        
        # Analyze pricing within each model group
        for model_key, model_listings in model_groups.items():
            if len(model_listings) >= 3:  # Need minimum for comparison
                prices = [l['price'] for l in model_listings]
                
                mean_price = statistics.mean(prices)
                median_price = statistics.median(prices)
                std_dev = statistics.stdev(prices) if len(prices) > 1 else 0
                
                # Find outliers (beyond 2 standard deviations)
                for listing in model_listings:
                    price = listing['price']
                    z_score = (price - mean_price) / std_dev if std_dev > 0 else 0
                    
                    if abs(z_score) > 2:  # Significant outlier
                        if z_score < -2:  # Underpriced
                            discount_pct = ((mean_price - price) / mean_price) * 100
                            patterns.append(MarketPattern(
                                pattern_type="underpriced_opportunity",
                                confidence=0.85,
                                description=f"Underpriced {model_key.replace('_', ' ')}: ${price:,} vs market avg ${mean_price:,.0f} ({discount_pct:.0f}% below market)",
                                affected_listings=[listing['id']],
                                potential_value=mean_price - price,
                                actionable_insight=f"Strong buy opportunity - {discount_pct:.0f}% below market price",
                                supporting_data={
                                    'model': model_key.replace('_', ' '),
                                    'listed_price': price,
                                    'market_average': mean_price,
                                    'discount_percentage': discount_pct,
                                    'z_score': z_score
                                }
                            ))
                        
                        elif z_score > 2:  # Overpriced
                            premium_pct = ((price - mean_price) / mean_price) * 100
                            patterns.append(MarketPattern(
                                pattern_type="overpriced_listing",
                                confidence=0.75,
                                description=f"Overpriced {model_key.replace('_', ' ')}: ${price:,} vs market avg ${mean_price:,.0f} ({premium_pct:.0f}% above market)",
                                affected_listings=[listing['id']],
                                actionable_insight=f"Avoid - {premium_pct:.0f}% above market price",
                                supporting_data={
                                    'model': model_key.replace('_', ' '),
                                    'listed_price': price,
                                    'market_average': mean_price,
                                    'premium_percentage': premium_pct,
                                    'z_score': z_score
                                }
                            ))
        
        return patterns
    
    def _detect_market_timing_opportunities(self, listings: List[Dict]) -> List[MarketPattern]:
        """Detect market timing and investment opportunities"""
        patterns = []
        
        # Analyze age vs price depreciation patterns
        age_price_data = []
        current_year = datetime.now().year
        
        for listing in listings:
            title = listing.get('title', '').lower()
            price = listing.get('price')
            
            year_match = re.search(r'(20\d{2}|19\d{2})', title)
            
            if year_match and price:
                year = int(year_match.group(1))
                age = current_year - year
                age_price_data.append({'age': age, 'price': price, 'listing': listing})
        
        if len(age_price_data) >= 10:  # Need sufficient data
            # Find sweet spot ages (best value retention)
            age_groups = defaultdict(list)
            for item in age_price_data:
                age_groups[item['age']].append(item['price'])
            
            # Calculate price per year depreciation
            age_avg_prices = {}
            for age, prices in age_groups.items():
                if len(prices) >= 2:  # Need multiple data points
                    age_avg_prices[age] = statistics.mean(prices)
            
            if len(age_avg_prices) >= 3:
                # Find ages with best value (slowest depreciation)
                depreciation_rates = []
                for age in sorted(age_avg_prices.keys())[1:]:  # Skip age 0
                    prev_age = age - 1
                    if prev_age in age_avg_prices:
                        depreciation = age_avg_prices[prev_age] - age_avg_prices[age]
                        depreciation_rate = depreciation / age_avg_prices[prev_age] if age_avg_prices[prev_age] > 0 else 0
                        depreciation_rates.append({
                            'age': age,
                            'depreciation_rate': depreciation_rate,
                            'avg_price': age_avg_prices[age]
                        })
                
                # Find sweet spot (low depreciation rate + reasonable age)
                if depreciation_rates:
                    sweet_spot = min([d for d in depreciation_rates if 2 <= d['age'] <= 5], 
                                   key=lambda x: x['depreciation_rate'], default=None)
                    
                    if sweet_spot:
                        patterns.append(MarketPattern(
                            pattern_type="value_sweet_spot",
                            confidence=0.7,
                            description=f"Value sweet spot identified: {sweet_spot['age']}-year-old units show lowest depreciation ({sweet_spot['depreciation_rate']:.1%} annually)",
                            affected_listings=[item['listing']['id'] for item in age_price_data if item['age'] == sweet_spot['age']],
                            actionable_insight=f"Target {sweet_spot['age']}-year-old models for best value retention",
                            supporting_data=sweet_spot
                        ))
        
        return patterns
    
    def _detect_emerging_trends(self, listings: List[Dict]) -> List[MarketPattern]:
        """Detect emerging market trends and model preferences"""
        patterns = []
        
        # Analyze model popularity trends
        model_mentions = defaultdict(int)
        recent_listings = []
        
        cutoff_date = datetime.now() - timedelta(days=90)  # Last 90 days
        
        for listing in listings:
            added_date = listing.get('addedDate') or listing.get('first_seen')
            if added_date:
                try:
                    date_obj = datetime.fromisoformat(added_date.replace('Z', '+00:00'))
                    if date_obj >= cutoff_date:
                        recent_listings.append(listing)
                except:
                    continue
        
        # Extract model patterns from recent listings
        for listing in recent_listings:
            title = listing.get('title', '').lower()
            
            # Count specific model mentions
            models = ['svho', 'cruiser', 'deluxe', 'wake', 'gtr', 'gtx', 'rxt', 'gti']
            for model in models:
                if model in title:
                    model_mentions[model] += 1
        
        # Identify trending models (high recent activity)
        total_recent = len(recent_listings)
        if total_recent >= 10:
            trending_models = []
            for model, count in model_mentions.items():
                popularity_rate = count / total_recent
                if popularity_rate > 0.15:  # Model appears in >15% of recent listings
                    trending_models.append({
                        'model': model,
                        'count': count,
                        'popularity_rate': popularity_rate
                    })
            
            if trending_models:
                top_trend = max(trending_models, key=lambda x: x['popularity_rate'])
                patterns.append(MarketPattern(
                    pattern_type="trending_model",
                    confidence=0.65,
                    description=f"Trending model: {top_trend['model'].upper()} appears in {top_trend['popularity_rate']:.1%} of recent listings",
                    affected_listings=[l['id'] for l in recent_listings if top_trend['model'] in l.get('title', '').lower()],
                    actionable_insight=f"High market activity in {top_trend['model'].upper()} models - investigate demand drivers",
                    supporting_data=top_trend
                ))
        
        return patterns
    
    # Helper methods
    def _normalize_location(self, location: str) -> str:
        """Normalize location for comparison"""
        if not location:
            return ''
        
        # Clean up common location formats
        location = location.lower().strip()
        location = re.sub(r'\d+\s*miles?\s*away', '', location)
        location = location.replace(',', ' ').strip()
        
        # Extract city/state
        parts = location.split()
        if len(parts) >= 2:
            return f"{parts[0]} {parts[-1]}"  # First word + last word (likely city + state)
        
        return location
    
    def _find_similar_models(self, listings: List[Dict]) -> List[str]:
        """Find similar models within a list of listings"""
        models = []
        for listing in listings:
            title = listing.get('title', '').lower()
            
            model_match = re.search(r'(vx|fx|gp|gtr|gtx|gti|rxt|svho|cruiser|deluxe|wake)', title)
            if model_match:
                models.append(model_match.group(1))
        
        # Count occurrences and return models with multiple instances
        model_counts = Counter(models)
        return [model for model, count in model_counts.items() if count >= 2]
    
    def _text_similarity(self, text1: str, text2: str) -> float:
        """Calculate text similarity between two strings"""
        if not text1 or not text2:
            return 0.0
        
        # Simple Jaccard similarity
        words1 = set(text1.lower().split())
        words2 = set(text2.lower().split())
        
        intersection = words1.intersection(words2)
        union = words1.union(words2)
        
        return len(intersection) / len(union) if union else 0.0
    
    def _save_patterns(self, patterns: List[MarketPattern]):
        """Save detected patterns for historical analysis"""
        try:
            # Load existing patterns
            try:
                with open(self.patterns_db, 'r') as f:
                    historical_patterns = json.load(f)
            except FileNotFoundError:
                historical_patterns = []
            
            # Add new patterns with timestamp
            for pattern in patterns:
                historical_patterns.append({
                    'timestamp': datetime.now().isoformat(),
                    'pattern_type': pattern.pattern_type,
                    'confidence': pattern.confidence,
                    'description': pattern.description,
                    'potential_value': pattern.potential_value,
                    'actionable_insight': pattern.actionable_insight,
                    'supporting_data': pattern.supporting_data
                })
            
            # Save updated patterns
            with open(self.patterns_db, 'w') as f:
                json.dump(historical_patterns, f, indent=2)
                
        except Exception as e:
            logger.error(f"Error saving patterns: {e}")

# Usage example
if __name__ == "__main__":
    engine = MarketIntelligenceEngine()
    
    # Load sample data (your 181 listings)
    with open("complete_csv_import_20250828_222849.json", 'r') as f:
        data = json.load(f)
    
    listings = data['data'] if 'data' in data else data
    
    # Run market analysis
    patterns = engine.analyze_market_patterns(listings)
    
    print(f"🧠 Market Intelligence Analysis Complete!")
    print(f"📊 Detected {len(patterns)} market patterns")
    
    for i, pattern in enumerate(patterns[:5], 1):  # Show top 5 patterns
        print(f"\n{i}. {pattern.pattern_type.replace('_', ' ').title()}")
        print(f"   Confidence: {pattern.confidence:.1%}")
        print(f"   Description: {pattern.description}")
        if pattern.actionable_insight:
            print(f"   💡 Insight: {pattern.actionable_insight}")
        if pattern.potential_value:
            print(f"   💰 Potential Value: ${pattern.potential_value:,.0f}")
