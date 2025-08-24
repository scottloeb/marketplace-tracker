#!/usr/bin/env python3
"""
Database Integration Layer for Dynamic Marketplace Explorer

Connects the marketplace tracker with:
1. Harbor/Nodepad database system
2. Neo4j graph database
3. Local SQLite for caching
4. Real-time sync capabilities

Author: Marketplace Intelligence System
Version: 1.0
"""

import json
import sqlite3
import asyncio
import aiohttp
import logging
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any
from pathlib import Path
import hashlib
import os

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


class DatabaseIntegration:
    """Main database integration class for marketplace data."""
    
    def __init__(self, config_file="database_config.json"):
        self.config = self.load_config(config_file)
        self.sqlite_db = self.config.get('sqlite_db', 'marketplace_intelligence.db')
        self.neo4j_config = self.config.get('neo4j', {})
        self.nodepad_config = self.config.get('nodepad', {})
        
        # Initialize connections
        self.sqlite_conn = None
        self.neo4j_driver = None
        self.session_cache = {}
        
        logger.info("🗃️ Database Integration initialized")
        
    def load_config(self, config_file):
        """Load database configuration."""
        default_config = {
            "sqlite_db": "marketplace_intelligence.db",
            "neo4j": {
                "uri": "bolt://localhost:7687",
                "username": "neo4j",
                "password": "password",
                "database": "marketplace"
            },
            "nodepad": {
                "host": "localhost",
                "port": 5000,
                "endpoint": "/api/marketplace"
            },
            "ocean_explorer": {
                "host": "localhost", 
                "port": 5000,
                "username": "demo",
                "password": "demo123"
            },
            "sync_settings": {
                "enable_real_time": True,
                "sync_interval_seconds": 30,
                "batch_size": 100,
                "auto_backup": True
            }
        }
        
        config_path = Path(config_file)
        if config_path.exists():
            try:
                with open(config_path, 'r') as f:
                    user_config = json.load(f)
                    default_config.update(user_config)
            except Exception as e:
                logger.warning(f"Could not load config file: {e}")
        else:
            # Save default config
            with open(config_path, 'w') as f:
                json.dump(default_config, f, indent=2)
            logger.info(f"Created default config: {config_path}")
        
        return default_config
    
    async def initialize_databases(self):
        """Initialize all database connections."""
        logger.info("🔌 Initializing database connections...")
        
        # Initialize SQLite
        await self.init_sqlite()
        
        # Try to connect to Neo4j (optional)
        await self.init_neo4j()
        
        # Try to connect to Nodepad (optional)
        await self.init_nodepad()
        
        logger.info("✅ Database initialization complete")
    
    async def init_sqlite(self):
        """Initialize SQLite database for local caching and analysis."""
        try:
            self.sqlite_conn = sqlite3.connect(self.sqlite_db)
            self.sqlite_conn.row_factory = sqlite3.Row
            
            # Create tables
            await self.create_sqlite_schema()
            
            logger.info(f"✅ SQLite connected: {self.sqlite_db}")
            
        except Exception as e:
            logger.error(f"❌ SQLite initialization failed: {e}")
            raise
    
    async def create_sqlite_schema(self):
        """Create SQLite schema for marketplace data."""
        cursor = self.sqlite_conn.cursor()
        
        # Listings table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS listings (
                id INTEGER PRIMARY KEY,
                url TEXT UNIQUE NOT NULL,
                title TEXT,
                price REAL,
                make TEXT,
                model TEXT,
                year INTEGER,
                location TEXT,
                seller TEXT,
                source TEXT,
                status TEXT,
                added_date TEXT,
                updated_date TEXT,
                data_hash TEXT,
                raw_data TEXT
            )
        ''')
        
        # Price history table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS price_history (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                listing_id INTEGER,
                price REAL,
                recorded_date TEXT,
                source TEXT,
                FOREIGN KEY (listing_id) REFERENCES listings (id)
            )
        ''')
        
        # Analysis results table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS analysis_results (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                listing_id INTEGER,
                analysis_type TEXT,
                recommendation TEXT,
                confidence REAL,
                potential_savings REAL,
                market_analysis TEXT,
                created_date TEXT,
                FOREIGN KEY (listing_id) REFERENCES listings (id)
            )
        ''')
        
        # Sync status table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS sync_status (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                source TEXT,
                last_sync TEXT,
                record_count INTEGER,
                status TEXT,
                error_message TEXT
            )
        ''')
        
        # Market trends table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS market_trends (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                date TEXT,
                make TEXT,
                avg_price REAL,
                listing_count INTEGER,
                deal_count INTEGER,
                trend_direction TEXT
            )
        ''')
        
        self.sqlite_conn.commit()
        logger.info("📊 SQLite schema created/updated")
    
    async def init_neo4j(self):
        """Initialize Neo4j connection for graph database analysis."""
        try:
            # Try to import neo4j driver
            try:
                from neo4j import GraphDatabase
            except ImportError:
                logger.warning("Neo4j driver not installed. Graph features will be limited.")
                return
            
            config = self.neo4j_config
            self.neo4j_driver = GraphDatabase.driver(
                config['uri'], 
                auth=(config['username'], config['password'])
            )
            
            # Test connection
            with self.neo4j_driver.session(database=config.get('database', 'neo4j')) as session:
                result = session.run("RETURN 1 as test")
                test_value = result.single()['test']
                
            if test_value == 1:
                logger.info("✅ Neo4j connected successfully")
                await self.create_neo4j_schema()
            
        except Exception as e:
            logger.warning(f"⚠️ Neo4j connection failed: {e}")
            self.neo4j_driver = None
    
    async def create_neo4j_schema(self):
        """Create Neo4j schema for marketplace graph."""
        if not self.neo4j_driver:
            return
        
        try:
            with self.neo4j_driver.session() as session:
                # Create constraints and indexes
                constraints = [
                    "CREATE CONSTRAINT listing_url IF NOT EXISTS FOR (l:Listing) REQUIRE l.url IS UNIQUE",
                    "CREATE CONSTRAINT make_name IF NOT EXISTS FOR (m:Make) REQUIRE m.name IS UNIQUE",
                    "CREATE CONSTRAINT model_name IF NOT EXISTS FOR (mo:Model) REQUIRE mo.name IS UNIQUE",
                    "CREATE CONSTRAINT location_name IF NOT EXISTS FOR (loc:Location) REQUIRE loc.name IS UNIQUE"
                ]
                
                for constraint in constraints:
                    try:
                        session.run(constraint)
                    except Exception as e:
                        # Constraint might already exist
                        pass
                
                # Create indexes
                indexes = [
                    "CREATE INDEX listing_price IF NOT EXISTS FOR (l:Listing) ON (l.price)",
                    "CREATE INDEX listing_year IF NOT EXISTS FOR (l:Listing) ON (l.year)",
                    "CREATE INDEX listing_added_date IF NOT EXISTS FOR (l:Listing) ON (l.added_date)"
                ]
                
                for index in indexes:
                    try:
                        session.run(index)
                    except Exception as e:
                        # Index might already exist
                        pass
                        
            logger.info("📊 Neo4j schema created/updated")
            
        except Exception as e:
            logger.error(f"❌ Neo4j schema creation failed: {e}")
    
    async def init_nodepad(self):
        """Initialize connection to Nodepad application."""
        try:
            config = self.nodepad_config
            nodepad_url = f"http://{config['host']}:{config['port']}"
            
            async with aiohttp.ClientSession() as session:
                async with session.get(f"{nodepad_url}/health", timeout=5) as response:
                    if response.status == 200:
                        logger.info("✅ Nodepad connection successful")
                        self.nodepad_connected = True
                    else:
                        logger.warning("⚠️ Nodepad responded but not healthy")
                        self.nodepad_connected = False
                        
        except Exception as e:
            logger.warning(f"⚠️ Nodepad connection failed: {e}")
            self.nodepad_connected = False
    
    async def import_full_dataset(self, data_source="automation_exports"):
        """Import the full 286+ dataset from various sources."""
        logger.info(f"📥 Importing full dataset from {data_source}...")
        
        imported_count = 0
        
        try:
            if data_source == "automation_exports":
                imported_count = await self.import_from_automation_exports()
            elif data_source == "mobile_tracker":
                imported_count = await self.import_from_mobile_tracker()
            elif data_source == "ocean_explorer":
                imported_count = await self.import_from_ocean_explorer()
            else:
                raise ValueError(f"Unknown data source: {data_source}")
            
            # Update sync status
            await self.update_sync_status(data_source, imported_count, "success")
            
            logger.info(f"✅ Imported {imported_count} listings from {data_source}")
            return imported_count
            
        except Exception as e:
            logger.error(f"❌ Import failed: {e}")
            await self.update_sync_status(data_source, 0, "error", str(e))
            raise
    
    async def import_from_automation_exports(self):
        """Import data from automation export files."""
        imported_count = 0
        
        # Try different export files
        export_files = [
            "automation/full_286_export.json",
            "automation/complete_286_export.json",
            "automation/enhanced_tracker_data_*.json"
        ]
        
        for file_pattern in export_files:
            if '*' in file_pattern:
                # Handle glob patterns
                import glob
                files = glob.glob(file_pattern)
                files.sort(reverse=True)  # Get most recent first
                if files:
                    file_path = files[0]
                else:
                    continue
            else:
                file_path = file_pattern
            
            if Path(file_path).exists():
                try:
                    with open(file_path, 'r') as f:
                        data = json.load(f)
                    
                    # Handle different data formats
                    if isinstance(data, dict) and 'data' in data:
                        listings = data['data']
                    elif isinstance(data, list):
                        listings = data
                    else:
                        listings = [data]
                    
                    count = await self.store_listings(listings, source="automation_export")
                    imported_count += count
                    
                    logger.info(f"📁 Imported {count} listings from {file_path}")
                    
                except Exception as e:
                    logger.error(f"❌ Failed to import {file_path}: {e}")
                    continue
        
        return imported_count
    
    async def import_from_mobile_tracker(self):
        """Import data from mobile tracker."""
        try:
            tracker_url = "https://marketplace-tracker-omega.vercel.app"
            
            async with aiohttp.ClientSession() as session:
                # Try to get data from mobile tracker API
                async with session.get(f"{tracker_url}/api/listings", timeout=10) as response:
                    if response.status == 200:
                        data = await response.json()
                        listings = data.get('data', data)
                        count = await self.store_listings(listings, source="mobile_tracker")
                        return count
                    else:
                        logger.warning(f"Mobile tracker returned status {response.status}")
                        return 0
                        
        except Exception as e:
            logger.error(f"❌ Mobile tracker import failed: {e}")
            return 0
    
    async def import_from_ocean_explorer(self):
        """Import data from Ocean Explorer."""
        try:
            config = self.config['ocean_explorer']
            base_url = f"http://{config['host']}:{config['port']}"
            
            async with aiohttp.ClientSession() as session:
                # Login to Ocean Explorer
                login_data = {
                    'username': config['username'],
                    'password': config['password']
                }
                
                async with session.post(f"{base_url}/login", data=login_data) as response:
                    if response.status == 200:
                        # Get marketplace data
                        async with session.get(f"{base_url}/api/marketplace/listings") as data_response:
                            if data_response.status == 200:
                                data = await data_response.json()
                                listings = data.get('listings', [])
                                count = await self.store_listings(listings, source="ocean_explorer")
                                return count
            
            return 0
            
        except Exception as e:
            logger.error(f"❌ Ocean Explorer import failed: {e}")
            return 0
    
    async def store_listings(self, listings: List[Dict], source: str = "unknown"):
        """Store listings in SQLite database."""
        if not listings:
            return 0
        
        cursor = self.sqlite_conn.cursor()
        stored_count = 0
        
        for listing in listings:
            try:
                # Create data hash for change detection
                data_hash = hashlib.md5(json.dumps(listing, sort_keys=True).encode()).hexdigest()
                
                # Extract key fields
                listing_id = listing.get('id')
                url = listing.get('url', '')
                title = listing.get('title', '')
                price = listing.get('price')
                make = listing.get('make', '')
                model = listing.get('model', '')
                year = listing.get('year')
                location = listing.get('location', '')
                seller = listing.get('seller', '')
                status = listing.get('status', 'pending')
                added_date = listing.get('addedDate', datetime.now().isoformat())
                
                if not url:
                    continue  # Skip listings without URLs
                
                # Check if listing exists
                cursor.execute("SELECT id, data_hash FROM listings WHERE url = ?", (url,))
                existing = cursor.fetchone()
                
                if existing:
                    # Update if data has changed
                    if existing['data_hash'] != data_hash:
                        cursor.execute('''
                            UPDATE listings SET
                                title = ?, price = ?, make = ?, model = ?, year = ?,
                                location = ?, seller = ?, status = ?, updated_date = ?,
                                data_hash = ?, raw_data = ?
                            WHERE url = ?
                        ''', (title, price, make, model, year, location, seller, 
                              status, datetime.now().isoformat(), data_hash, 
                              json.dumps(listing), url))
                        
                        # Record price change if applicable
                        if price and existing:
                            await self.record_price_change(existing['id'], price, source)
                        
                        stored_count += 1
                else:
                    # Insert new listing
                    cursor.execute('''
                        INSERT INTO listings 
                        (id, url, title, price, make, model, year, location, seller, 
                         source, status, added_date, updated_date, data_hash, raw_data)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ''', (listing_id, url, title, price, make, model, year, location, 
                          seller, source, status, added_date, datetime.now().isoformat(), 
                          data_hash, json.dumps(listing)))
                    
                    stored_count += 1
                    
                    # Record initial price
                    if price:
                        new_listing_id = cursor.lastrowid
                        await self.record_price_change(new_listing_id, price, source)
                
            except Exception as e:
                logger.error(f"❌ Failed to store listing {listing.get('id', 'unknown')}: {e}")
                continue
        
        self.sqlite_conn.commit()
        return stored_count
    
    async def record_price_change(self, listing_id: int, price: float, source: str):
        """Record a price change in the price history table."""
        cursor = self.sqlite_conn.cursor()
        
        cursor.execute('''
            INSERT INTO price_history (listing_id, price, recorded_date, source)
            VALUES (?, ?, ?, ?)
        ''', (listing_id, price, datetime.now().isoformat(), source))
    
    async def store_analysis_results(self, listing_id: int, analysis: Dict):
        """Store analysis results for a listing."""
        cursor = self.sqlite_conn.cursor()
        
        try:
            cursor.execute('''
                INSERT OR REPLACE INTO analysis_results 
                (listing_id, analysis_type, recommendation, confidence, 
                 potential_savings, market_analysis, created_date)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            ''', (
                listing_id,
                analysis.get('analysis_type', 'market_analysis'),
                analysis.get('recommendation', 'RESEARCH'),
                analysis.get('confidence', 0.0),
                analysis.get('potential_savings', 0.0),
                json.dumps(analysis),
                datetime.now().isoformat()
            ))
            
            self.sqlite_conn.commit()
            
        except Exception as e:
            logger.error(f"❌ Failed to store analysis for listing {listing_id}: {e}")
    
    async def get_listings(self, filters: Dict = None, limit: int = None) -> List[Dict]:
        """Get listings with optional filters."""
        cursor = self.sqlite_conn.cursor()
        
        query = "SELECT * FROM listings"
        params = []
        
        if filters:
            conditions = []
            
            if filters.get('make'):
                conditions.append("make = ?")
                params.append(filters['make'])
            
            if filters.get('price_min'):
                conditions.append("price >= ?")
                params.append(filters['price_min'])
                
            if filters.get('price_max'):
                conditions.append("price <= ?")
                params.append(filters['price_max'])
            
            if filters.get('year_min'):
                conditions.append("year >= ?")
                params.append(filters['year_min'])
            
            if conditions:
                query += " WHERE " + " AND ".join(conditions)
        
        query += " ORDER BY updated_date DESC"
        
        if limit:
            query += f" LIMIT {limit}"
        
        cursor.execute(query, params)
        rows = cursor.fetchall()
        
        # Convert to dictionaries
        listings = []
        for row in rows:
            listing = dict(row)
            # Parse raw_data if available
            if listing['raw_data']:
                try:
                    raw_data = json.loads(listing['raw_data'])
                    listing.update(raw_data)
                except:
                    pass
            listings.append(listing)
        
        return listings
    
    async def get_market_analysis(self, days: int = 30) -> Dict:
        """Get comprehensive market analysis."""
        cursor = self.sqlite_conn.cursor()
        
        # Get date range
        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)
        
        analysis = {
            'period': f"Last {days} days",
            'start_date': start_date.isoformat(),
            'end_date': end_date.isoformat(),
            'total_listings': 0,
            'make_breakdown': {},
            'price_analysis': {},
            'deal_opportunities': [],
            'trends': {}
        }
        
        # Total listings
        cursor.execute("SELECT COUNT(*) as count FROM listings")
        analysis['total_listings'] = cursor.fetchone()['count']
        
        # Make breakdown
        cursor.execute('''
            SELECT make, COUNT(*) as count, AVG(price) as avg_price
            FROM listings 
            WHERE make IS NOT NULL AND make != ''
            GROUP BY make
            ORDER BY count DESC
        ''')
        
        make_data = cursor.fetchall()
        analysis['make_breakdown'] = {
            row['make']: {
                'count': row['count'],
                'avg_price': round(row['avg_price'] or 0, 2)
            }
            for row in make_data
        }
        
        # Price analysis
        cursor.execute('''
            SELECT 
                MIN(price) as min_price,
                MAX(price) as max_price,
                AVG(price) as avg_price,
                COUNT(CASE WHEN price < 10000 THEN 1 END) as under_10k,
                COUNT(CASE WHEN price BETWEEN 10000 AND 20000 THEN 1 END) as ten_to_twenty_k,
                COUNT(CASE WHEN price > 20000 THEN 1 END) as over_20k
            FROM listings 
            WHERE price IS NOT NULL AND price > 0
        ''')
        
        price_data = cursor.fetchone()
        analysis['price_analysis'] = {
            'min_price': price_data['min_price'] or 0,
            'max_price': price_data['max_price'] or 0,
            'avg_price': round(price_data['avg_price'] or 0, 2),
            'distribution': {
                'under_10k': price_data['under_10k'],
                'ten_to_twenty_k': price_data['ten_to_twenty_k'],
                'over_20k': price_data['over_20k']
            }
        }
        
        # Deal opportunities (from analysis results)
        cursor.execute('''
            SELECT l.title, l.price, l.url, a.recommendation, a.confidence, a.potential_savings
            FROM listings l
            JOIN analysis_results a ON l.id = a.listing_id
            WHERE a.recommendation IN ('BUY', 'CONSIDER')
            ORDER BY a.potential_savings DESC
            LIMIT 20
        ''')
        
        deal_data = cursor.fetchall()
        analysis['deal_opportunities'] = [
            {
                'title': row['title'],
                'price': row['price'],
                'url': row['url'],
                'recommendation': row['recommendation'],
                'confidence': row['confidence'],
                'potential_savings': row['potential_savings']
            }
            for row in deal_data
        ]
        
        return analysis
    
    async def sync_to_neo4j(self, batch_size: int = 100):
        """Sync listings to Neo4j graph database."""
        if not self.neo4j_driver:
            logger.warning("⚠️ Neo4j not available for sync")
            return 0
        
        try:
            # Get listings that need syncing
            listings = await self.get_listings(limit=batch_size)
            
            with self.neo4j_driver.session() as session:
                synced_count = 0
                
                for listing in listings:
                    try:
                        # Create or update listing node
                        result = session.run('''
                            MERGE (l:Listing {url: $url})
                            SET l.title = $title,
                                l.price = $price,
                                l.year = $year,
                                l.status = $status,
                                l.added_date = $added_date,
                                l.updated_date = $updated_date
                            RETURN l
                        ''', {
                            'url': listing['url'],
                            'title': listing['title'],
                            'price': listing['price'],
                            'year': listing['year'],
                            'status': listing['status'],
                            'added_date': listing['added_date'],
                            'updated_date': listing['updated_date']
                        })
                        
                        # Create make node and relationship
                        if listing.get('make'):
                            session.run('''
                                MATCH (l:Listing {url: $url})
                                MERGE (m:Make {name: $make})
                                MERGE (l)-[:IS_MAKE]->(m)
                            ''', {'url': listing['url'], 'make': listing['make']})
                        
                        # Create model node and relationship
                        if listing.get('model'):
                            session.run('''
                                MATCH (l:Listing {url: $url})
                                MERGE (mo:Model {name: $model})
                                MERGE (l)-[:IS_MODEL]->(mo)
                            ''', {'url': listing['url'], 'model': listing['model']})
                        
                        # Create location node and relationship
                        if listing.get('location'):
                            session.run('''
                                MATCH (l:Listing {url: $url})
                                MERGE (loc:Location {name: $location})
                                MERGE (l)-[:LOCATED_IN]->(loc)
                            ''', {'url': listing['url'], 'location': listing['location']})
                        
                        synced_count += 1
                        
                    except Exception as e:
                        logger.error(f"❌ Failed to sync listing to Neo4j: {e}")
                        continue
                
                logger.info(f"🕸️ Synced {synced_count} listings to Neo4j")
                return synced_count
                
        except Exception as e:
            logger.error(f"❌ Neo4j sync failed: {e}")
            return 0
    
    async def update_sync_status(self, source: str, record_count: int, status: str, error_message: str = None):
        """Update sync status in database."""
        cursor = self.sqlite_conn.cursor()
        
        cursor.execute('''
            INSERT OR REPLACE INTO sync_status 
            (source, last_sync, record_count, status, error_message)
            VALUES (?, ?, ?, ?, ?)
        ''', (source, datetime.now().isoformat(), record_count, status, error_message))
        
        self.sqlite_conn.commit()
    
    async def get_sync_status(self) -> List[Dict]:
        """Get current sync status for all sources."""
        cursor = self.sqlite_conn.cursor()
        
        cursor.execute('''
            SELECT source, last_sync, record_count, status, error_message
            FROM sync_status
            ORDER BY last_sync DESC
        ''')
        
        return [dict(row) for row in cursor.fetchall()]
    
    async def cleanup_old_data(self, days: int = 90):
        """Clean up old data to maintain performance."""
        cursor = self.sqlite_conn.cursor()
        
        cutoff_date = (datetime.now() - timedelta(days=days)).isoformat()
        
        # Delete old price history records
        cursor.execute('''
            DELETE FROM price_history 
            WHERE recorded_date < ?
        ''', (cutoff_date,))
        
        deleted_count = cursor.rowcount
        
        self.sqlite_conn.commit()
        
        logger.info(f"🧹 Cleaned up {deleted_count} old price history records")
        return deleted_count
    
    async def export_data(self, format_type: str = "json", include_analysis: bool = True) -> str:
        """Export data in various formats."""
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        filename = f"marketplace_export_{timestamp}.{format_type}"
        
        # Get all data
        listings = await self.get_listings()
        
        export_data = {
            'timestamp': datetime.now().isoformat(),
            'total_listings': len(listings),
            'export_type': format_type,
            'include_analysis': include_analysis,
            'listings': listings
        }
        
        if include_analysis:
            export_data['market_analysis'] = await self.get_market_analysis()
            export_data['sync_status'] = await self.get_sync_status()
        
        if format_type == "json":
            with open(filename, 'w') as f:
                json.dump(export_data, f, indent=2, default=str)
        
        logger.info(f"📁 Exported {len(listings)} listings to {filename}")
        return filename
    
    async def close_connections(self):
        """Close all database connections."""
        if self.sqlite_conn:
            self.sqlite_conn.close()
        
        if self.neo4j_driver:
            self.neo4j_driver.close()
        
        logger.info("🔌 Database connections closed")


# Convenience functions for external use
async def initialize_marketplace_db(config_file="database_config.json"):
    """Initialize the marketplace database system."""
    db = DatabaseIntegration(config_file)
    await db.initialize_databases()
    return db


async def quick_import(source="automation_exports"):
    """Quick import from specified source."""
    db = await initialize_marketplace_db()
    try:
        count = await db.import_full_dataset(source)
        return count
    finally:
        await db.close_connections()


async def get_market_insights():
    """Get current market insights."""
    db = await initialize_marketplace_db()
    try:
        analysis = await db.get_market_analysis()
        return analysis
    finally:
        await db.close_connections()


if __name__ == "__main__":
    import asyncio
    
    async def main():
        print("🗃️ Marketplace Database Integration")
        print("="*50)
        
        # Initialize database
        db = await initialize_marketplace_db()
        
        try:
            # Import full dataset
            count = await db.import_full_dataset("automation_exports")
            print(f"📥 Imported {count} listings")
            
            # Get market analysis
            analysis = await db.get_market_analysis()
            print(f"📊 Total listings: {analysis['total_listings']}")
            print(f"💰 Average price: ${analysis['price_analysis']['avg_price']:,.2f}")
            print(f"🔥 Deal opportunities: {len(analysis['deal_opportunities'])}")
            
            # Sync to Neo4j if available
            neo4j_count = await db.sync_to_neo4j()
            if neo4j_count > 0:
                print(f"🕸️ Synced {neo4j_count} listings to Neo4j")
            
            # Export data
            export_file = await db.export_data()
            print(f"📁 Exported data to {export_file}")
            
        finally:
            await db.close_connections()
    
    asyncio.run(main())
