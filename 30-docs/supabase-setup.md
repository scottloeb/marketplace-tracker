# Supabase Setup for Marketplace Tracker

## Database Schema

### Tables

#### 1. listings
```sql
CREATE TABLE listings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT,
  price DECIMAL(10,2),
  url TEXT UNIQUE,
  location TEXT,
  seller TEXT,
  photos JSONB,
  make TEXT,
  model TEXT,
  year INTEGER,
  engine_hours INTEGER,
  condition TEXT,
  description TEXT,
  market_analysis JSONB,
  status TEXT DEFAULT 'active',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### 2. price_history
```sql
CREATE TABLE price_history (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  listing_id UUID REFERENCES listings(id) ON DELETE CASCADE,
  price DECIMAL(10,2),
  change_amount DECIMAL(10,2),
  change_percentage DECIMAL(5,2),
  recorded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### 3. enhancement_queue
```sql
CREATE TABLE enhancement_queue (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  listing_id UUID REFERENCES listings(id) ON DELETE CASCADE,
  status TEXT DEFAULT 'pending',
  priority INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  processed_at TIMESTAMP WITH TIME ZONE
);
```

## Row Level Security (RLS)
```sql
-- Enable RLS
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE price_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE enhancement_queue ENABLE ROW LEVEL SECURITY;

-- Allow all operations for now (we can add auth later)
CREATE POLICY "Allow all operations" ON listings FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON price_history FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON enhancement_queue FOR ALL USING (true);
```

## Functions

### Update timestamp trigger
```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_listings_updated_at 
    BEFORE UPDATE ON listings 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### Price change tracking
```sql
CREATE OR REPLACE FUNCTION track_price_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.price IS DISTINCT FROM NEW.price THEN
        INSERT INTO price_history (listing_id, price, change_amount, change_percentage)
        VALUES (
            NEW.id,
            NEW.price,
            COALESCE(NEW.price, 0) - COALESCE(OLD.price, 0),
            CASE 
                WHEN OLD.price > 0 THEN 
                    ((COALESCE(NEW.price, 0) - COALESCE(OLD.price, 0)) / OLD.price) * 100
                ELSE 0
            END
        );
    END IF;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER track_listing_price_changes
    AFTER UPDATE ON listings
    FOR EACH ROW EXECUTE FUNCTION track_price_change();
```

## Environment Variables
Create a `.env` file:
```
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
```

## Next Steps
1. Create Supabase project at https://supabase.com
2. Run the SQL commands in the SQL editor
3. Get API keys from Settings > API
4. Update environment variables
5. Test connection
