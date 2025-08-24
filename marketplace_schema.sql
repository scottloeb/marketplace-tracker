-- Marketplace Intelligence Database Schema
-- Designed for 286+ listings with comprehensive analysis and real-time sync
-- Compatible with SQLite, PostgreSQL, and MySQL

-- ============================================================================
-- CORE TABLES
-- ============================================================================

-- Main listings table with comprehensive marketplace data
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
    status TEXT DEFAULT 'pending',
    added_date TEXT,
    updated_date TEXT,
    data_hash TEXT,
    raw_data TEXT,
    -- Enhanced fields
    condition_rating INTEGER CHECK (condition_rating >= 1 AND condition_rating <= 10),
    hours INTEGER,
    mileage INTEGER,
    description TEXT,
    seller_rating REAL,
    seller_verified BOOLEAN DEFAULT FALSE,
    -- Geographic data
    latitude REAL,
    longitude REAL,
    zip_code TEXT,
    state TEXT,
    country TEXT DEFAULT 'US',
    -- Marketplace metadata
    listing_platform TEXT,
    listing_id_external TEXT,
    posted_date TEXT,
    expires_date TEXT,
    view_count INTEGER DEFAULT 0,
    contact_count INTEGER DEFAULT 0,
    -- Analysis flags
    is_analyzed BOOLEAN DEFAULT FALSE,
    is_duplicate BOOLEAN DEFAULT FALSE,
    duplicate_of INTEGER,
    risk_score REAL,
    quality_score REAL,
    -- Sync metadata
    sync_source TEXT,
    sync_timestamp TEXT,
    sync_version INTEGER DEFAULT 1,
    device_captured TEXT,
    user_notes TEXT,
    tags TEXT, -- JSON array of tags
    FOREIGN KEY (duplicate_of) REFERENCES listings (id)
);

-- Price history for trend analysis and drop detection
CREATE TABLE IF NOT EXISTS price_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    listing_id INTEGER NOT NULL,
    price REAL NOT NULL,
    currency TEXT DEFAULT 'USD',
    recorded_date TEXT NOT NULL,
    source TEXT,
    price_change_amount REAL,
    price_change_percent REAL,
    is_price_drop BOOLEAN DEFAULT FALSE,
    alert_triggered BOOLEAN DEFAULT FALSE,
    confidence_score REAL,
    FOREIGN KEY (listing_id) REFERENCES listings (id) ON DELETE CASCADE
);

-- Comprehensive analysis results with AI insights
CREATE TABLE IF NOT EXISTS analysis_results (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    listing_id INTEGER NOT NULL,
    analysis_type TEXT NOT NULL,
    recommendation TEXT CHECK (recommendation IN ('BUY', 'CONSIDER', 'PASS', 'RESEARCH')),
    confidence REAL CHECK (confidence >= 0.0 AND confidence <= 1.0),
    potential_savings REAL,
    market_analysis TEXT, -- JSON object
    price_analysis TEXT,   -- JSON object
    risk_analysis TEXT,    -- JSON object
    comparable_listings TEXT, -- JSON array
    created_date TEXT NOT NULL,
    model_version TEXT,
    processing_time_ms INTEGER,
    data_quality_score REAL,
    FOREIGN KEY (listing_id) REFERENCES listings (id) ON DELETE CASCADE
);

-- Sync status tracking for multiple data sources
CREATE TABLE IF NOT EXISTS sync_status (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source TEXT NOT NULL,
    source_type TEXT, -- 'mobile', 'automation', 'manual', 'api'
    last_sync TEXT NOT NULL,
    record_count INTEGER,
    status TEXT CHECK (status IN ('success', 'error', 'partial', 'pending')),
    error_message TEXT,
    sync_duration_ms INTEGER,
    data_transferred_mb REAL,
    conflicts_resolved INTEGER DEFAULT 0,
    created_date TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Market trends aggregation for intelligence
CREATE TABLE IF NOT EXISTS market_trends (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    make TEXT,
    model TEXT,
    year INTEGER,
    avg_price REAL,
    min_price REAL,
    max_price REAL,
    median_price REAL,
    listing_count INTEGER,
    deal_count INTEGER,
    buy_recommendation_count INTEGER,
    trend_direction TEXT CHECK (trend_direction IN ('up', 'down', 'stable', 'volatile')),
    price_change_7d REAL,
    price_change_30d REAL,
    volume_change_7d REAL,
    seasonality_factor REAL,
    market_heat_score REAL, -- 0-10 scale
    data_quality INTEGER DEFAULT 10
);

-- ============================================================================
-- REFERENCE DATA TABLES
-- ============================================================================

-- Jet ski specifications and reference data
CREATE TABLE IF NOT EXISTS jetski_specs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    year INTEGER NOT NULL,
    horsepower INTEGER,
    engine_displacement_cc INTEGER,
    engine_type TEXT,
    fuel_capacity_gal REAL,
    dry_weight_lbs INTEGER,
    length_inches REAL,
    beam_width_inches REAL,
    top_speed_mph INTEGER,
    msrp_usd REAL,
    expected_engine_life_hours INTEGER,
    seating_capacity INTEGER,
    storage_capacity_gal REAL,
    fuel_consumption_gph REAL,
    reverse_available BOOLEAN DEFAULT FALSE,
    trim_system BOOLEAN DEFAULT FALSE,
    created_date TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_date TEXT,
    UNIQUE(make, model, year)
);

-- Image references for listings and stock photos
CREATE TABLE IF NOT EXISTS listing_images (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    listing_id INTEGER,
    image_url TEXT NOT NULL,
    image_type TEXT CHECK (image_type IN ('listing_photo', 'stock_photo', 'reference_photo')),
    image_order INTEGER DEFAULT 0,
    width INTEGER,
    height INTEGER,
    file_size_bytes INTEGER,
    alt_text TEXT,
    is_primary BOOLEAN DEFAULT FALSE,
    extracted_date TEXT,
    quality_score REAL,
    FOREIGN KEY (listing_id) REFERENCES listings (id) ON DELETE CASCADE
);

-- ============================================================================
-- USER INTERACTION TABLES
-- ============================================================================

-- User actions and interactions with listings
CREATE TABLE IF NOT EXISTS user_interactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id TEXT,
    user_id TEXT,
    listing_id INTEGER,
    action_type TEXT, -- 'view', 'favorite', 'contact', 'share', 'note'
    action_data TEXT, -- JSON object with action-specific data
    device_type TEXT,
    timestamp TEXT NOT NULL,
    ip_address TEXT,
    user_agent TEXT,
    FOREIGN KEY (listing_id) REFERENCES listings (id) ON DELETE CASCADE
);

-- User watchlists and favorites
CREATE TABLE IF NOT EXISTS user_watchlists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT NOT NULL,
    listing_id INTEGER NOT NULL,
    added_date TEXT NOT NULL,
    alert_on_price_drop BOOLEAN DEFAULT TRUE,
    alert_threshold_percent REAL DEFAULT 10.0,
    notes TEXT,
    priority INTEGER DEFAULT 5 CHECK (priority >= 1 AND priority <= 10),
    FOREIGN KEY (listing_id) REFERENCES listings (id) ON DELETE CASCADE,
    UNIQUE(user_id, listing_id)
);

-- ============================================================================
-- REAL-TIME SYNC TABLES
-- ============================================================================

-- Real-time sync sessions for cross-device coordination
CREATE TABLE IF NOT EXISTS sync_sessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id TEXT UNIQUE NOT NULL,
    user_id TEXT,
    device_type TEXT,
    device_id TEXT,
    started_date TEXT NOT NULL,
    last_activity TEXT,
    status TEXT DEFAULT 'active',
    sync_preferences TEXT, -- JSON object
    conflict_resolution_strategy TEXT DEFAULT 'timestamp'
);

-- Conflict resolution log for sync operations
CREATE TABLE IF NOT EXISTS sync_conflicts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    listing_id INTEGER,
    conflict_type TEXT, -- 'price_mismatch', 'data_divergence', 'duplicate_detection'
    client1_data TEXT, -- JSON object
    client2_data TEXT, -- JSON object
    resolved_data TEXT, -- JSON object
    resolution_strategy TEXT,
    resolved_date TEXT,
    resolved_by TEXT,
    confidence_score REAL,
    FOREIGN KEY (listing_id) REFERENCES listings (id) ON DELETE CASCADE
);

-- ============================================================================
-- PERFORMANCE AND MONITORING TABLES
-- ============================================================================

-- System performance metrics
CREATE TABLE IF NOT EXISTS performance_metrics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    metric_name TEXT NOT NULL,
    metric_value REAL NOT NULL,
    metric_unit TEXT,
    category TEXT, -- 'sync', 'analysis', 'database', 'network'
    timestamp TEXT NOT NULL,
    source_component TEXT,
    additional_data TEXT -- JSON object
);

-- Error logging for debugging and monitoring
CREATE TABLE IF NOT EXISTS error_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    error_type TEXT NOT NULL,
    error_message TEXT NOT NULL,
    stack_trace TEXT,
    component TEXT, -- 'sync_server', 'database_integration', 'analysis_engine'
    severity TEXT CHECK (severity IN ('low', 'medium', 'high', 'critical')),
    user_affected TEXT,
    listing_id INTEGER,
    timestamp TEXT NOT NULL,
    resolved BOOLEAN DEFAULT FALSE,
    resolved_date TEXT,
    resolution_notes TEXT,
    FOREIGN KEY (listing_id) REFERENCES listings (id) ON DELETE SET NULL
);

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Core performance indexes
CREATE INDEX IF NOT EXISTS idx_listings_url ON listings (url);
CREATE INDEX IF NOT EXISTS idx_listings_price ON listings (price);
CREATE INDEX IF NOT EXISTS idx_listings_make_model ON listings (make, model);
CREATE INDEX IF NOT EXISTS idx_listings_year ON listings (year);
CREATE INDEX IF NOT EXISTS idx_listings_location ON listings (location);
CREATE INDEX IF NOT EXISTS idx_listings_status ON listings (status);
CREATE INDEX IF NOT EXISTS idx_listings_added_date ON listings (added_date);
CREATE INDEX IF NOT EXISTS idx_listings_updated_date ON listings (updated_date);

-- Price history indexes
CREATE INDEX IF NOT EXISTS idx_price_history_listing_id ON price_history (listing_id);
CREATE INDEX IF NOT EXISTS idx_price_history_date ON price_history (recorded_date);
CREATE INDEX IF NOT EXISTS idx_price_history_price_drop ON price_history (is_price_drop);

-- Analysis results indexes
CREATE INDEX IF NOT EXISTS idx_analysis_listing_id ON analysis_results (listing_id);
CREATE INDEX IF NOT EXISTS idx_analysis_recommendation ON analysis_results (recommendation);
CREATE INDEX IF NOT EXISTS idx_analysis_confidence ON analysis_results (confidence);
CREATE INDEX IF NOT EXISTS idx_analysis_savings ON analysis_results (potential_savings);

-- Market trends indexes
CREATE INDEX IF NOT EXISTS idx_trends_date ON market_trends (date);
CREATE INDEX IF NOT EXISTS idx_trends_make_model ON market_trends (make, model);
CREATE INDEX IF NOT EXISTS idx_trends_year ON market_trends (year);

-- Reference data indexes
CREATE INDEX IF NOT EXISTS idx_jetski_specs_make_model_year ON jetski_specs (make, model, year);
CREATE INDEX IF NOT EXISTS idx_jetski_specs_msrp ON jetski_specs (msrp_usd);

-- User interaction indexes
CREATE INDEX IF NOT EXISTS idx_user_interactions_listing_id ON user_interactions (listing_id);
CREATE INDEX IF NOT EXISTS idx_user_interactions_user_id ON user_interactions (user_id);
CREATE INDEX IF NOT EXISTS idx_user_interactions_timestamp ON user_interactions (timestamp);

-- Performance indexes
CREATE INDEX IF NOT EXISTS idx_performance_metrics_timestamp ON performance_metrics (timestamp);
CREATE INDEX IF NOT EXISTS idx_performance_metrics_category ON performance_metrics (category);

-- ============================================================================
-- VIEWS FOR COMMON QUERIES
-- ============================================================================

-- Complete listing view with latest analysis
CREATE VIEW IF NOT EXISTS v_listings_with_analysis AS
SELECT 
    l.*,
    ar.recommendation,
    ar.confidence,
    ar.potential_savings,
    ar.market_analysis,
    ar.created_date as analysis_date,
    ph.price as current_price,
    ph.price_change_percent as latest_price_change
FROM listings l
LEFT JOIN analysis_results ar ON l.id = ar.listing_id 
    AND ar.created_date = (
        SELECT MAX(created_date) 
        FROM analysis_results ar2 
        WHERE ar2.listing_id = l.id
    )
LEFT JOIN price_history ph ON l.id = ph.listing_id 
    AND ph.recorded_date = (
        SELECT MAX(recorded_date) 
        FROM price_history ph2 
        WHERE ph2.listing_id = l.id
    );

-- Hot deals view for quick access to opportunities
CREATE VIEW IF NOT EXISTS v_hot_deals AS
SELECT 
    l.id,
    l.title,
    l.price,
    l.make,
    l.model,
    l.year,
    l.location,
    l.url,
    ar.recommendation,
    ar.confidence,
    ar.potential_savings,
    ar.market_analysis,
    CASE 
        WHEN ar.potential_savings > 5000 THEN 'urgent'
        WHEN ar.potential_savings > 2000 THEN 'high'
        WHEN ar.potential_savings > 1000 THEN 'medium'
        ELSE 'low'
    END as priority_level
FROM listings l
JOIN analysis_results ar ON l.id = ar.listing_id
WHERE ar.recommendation IN ('BUY', 'CONSIDER')
    AND ar.confidence > 0.7
    AND ar.potential_savings > 1000
ORDER BY ar.potential_savings DESC, ar.confidence DESC;

-- Market summary view for dashboard
CREATE VIEW IF NOT EXISTS v_market_summary AS
SELECT 
    COUNT(*) as total_listings,
    AVG(price) as avg_price,
    MIN(price) as min_price,
    MAX(price) as max_price,
    COUNT(CASE WHEN recommendation = 'BUY' THEN 1 END) as buy_recommendations,
    COUNT(CASE WHEN recommendation = 'CONSIDER' THEN 1 END) as consider_recommendations,
    SUM(CASE WHEN potential_savings IS NOT NULL THEN potential_savings ELSE 0 END) as total_potential_savings,
    COUNT(DISTINCT make) as unique_makes,
    COUNT(DISTINCT location) as unique_locations
FROM v_listings_with_analysis
WHERE price IS NOT NULL AND price > 0;

-- ============================================================================
-- TRIGGERS FOR DATA INTEGRITY
-- ============================================================================

-- Update timestamps on listing changes
CREATE TRIGGER IF NOT EXISTS tr_listings_updated_date 
    AFTER UPDATE ON listings
BEGIN
    UPDATE listings 
    SET updated_date = CURRENT_TIMESTAMP 
    WHERE id = NEW.id;
END;

-- Auto-calculate price changes in price history
CREATE TRIGGER IF NOT EXISTS tr_price_history_calculate_change
    AFTER INSERT ON price_history
BEGIN
    UPDATE price_history 
    SET 
        price_change_amount = NEW.price - (
            SELECT price 
            FROM price_history 
            WHERE listing_id = NEW.listing_id 
                AND recorded_date < NEW.recorded_date 
            ORDER BY recorded_date DESC 
            LIMIT 1
        ),
        price_change_percent = (
            (NEW.price - (
                SELECT price 
                FROM price_history 
                WHERE listing_id = NEW.listing_id 
                    AND recorded_date < NEW.recorded_date 
                ORDER BY recorded_date DESC 
                LIMIT 1
            )) / (
                SELECT price 
                FROM price_history 
                WHERE listing_id = NEW.listing_id 
                    AND recorded_date < NEW.recorded_date 
                ORDER BY recorded_date DESC 
                LIMIT 1
            )
        ) * 100,
        is_price_drop = CASE 
            WHEN NEW.price < (
                SELECT price 
                FROM price_history 
                WHERE listing_id = NEW.listing_id 
                    AND recorded_date < NEW.recorded_date 
                ORDER BY recorded_date DESC 
                LIMIT 1
            ) THEN TRUE 
            ELSE FALSE 
        END
    WHERE id = NEW.id;
END;

-- ============================================================================
-- SAMPLE DATA INSERTION (for testing)
-- ============================================================================

-- Insert sample jet ski specifications
INSERT OR IGNORE INTO jetski_specs (make, model, year, horsepower, engine_displacement_cc, engine_type, msrp_usd) VALUES
('Yamaha', 'VX Cruiser', 2023, 110, 1052, '4-stroke', 12199),
('Yamaha', 'VX Deluxe', 2023, 110, 1052, '4-stroke', 13699),
('Kawasaki', 'STX 160', 2023, 160, 1498, '4-stroke', 11399),
('Kawasaki', 'Ultra 310X', 2023, 310, 1498, '4-stroke_supercharged', 17799),
('Sea-Doo', 'Spark 2UP', 2023, 90, 899, '3-cylinder', 5699),
('Sea-Doo', 'GTX 170', 2023, 170, 1630, '4-stroke', 14999);

-- Insert sample performance metrics
INSERT INTO performance_metrics (metric_name, metric_value, metric_unit, category, timestamp, source_component) VALUES
('sync_operations_per_minute', 45.0, 'operations/min', 'sync', datetime('now'), 'sync_server'),
('average_analysis_time', 250.0, 'milliseconds', 'analysis', datetime('now'), 'analysis_engine'),
('database_query_time', 15.0, 'milliseconds', 'database', datetime('now'), 'database_integration'),
('active_connections', 12.0, 'connections', 'network', datetime('now'), 'sync_server');

-- ============================================================================
-- SCHEMA VERSION AND METADATA
-- ============================================================================

CREATE TABLE IF NOT EXISTS schema_metadata (
    version TEXT PRIMARY KEY,
    applied_date TEXT NOT NULL,
    description TEXT,
    migration_notes TEXT
);

INSERT OR REPLACE INTO schema_metadata VALUES 
('1.0.0', datetime('now'), 'Initial marketplace intelligence schema', 'Supports 286+ listings with full analysis and real-time sync capabilities');

-- ============================================================================
-- MAINTENANCE PROCEDURES
-- ============================================================================

-- Cleanup old price history (keep last 1000 records per listing)
-- Run periodically to maintain performance
-- DELETE FROM price_history WHERE id NOT IN (
--     SELECT id FROM (
--         SELECT id, ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY recorded_date DESC) as rn
--         FROM price_history
--     ) WHERE rn <= 1000
-- );

-- Cleanup old performance metrics (keep last 30 days)
-- DELETE FROM performance_metrics WHERE timestamp < date('now', '-30 days');

-- Update market trends (run daily)
-- INSERT INTO market_trends (date, make, avg_price, listing_count, deal_count)
-- SELECT 
--     date('now'),
--     make,
--     AVG(price),
--     COUNT(*),
--     COUNT(CASE WHEN recommendation = 'BUY' THEN 1 END)
-- FROM v_listings_with_analysis
-- WHERE make IS NOT NULL
-- GROUP BY make;
