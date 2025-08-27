# 🚀 Supabase Setup Guide for Unified Marketplace Tracker

## Overview
This guide will help you set up Supabase as your cloud database for the unified marketplace tracker, enabling real-time sync between your phone and laptop.

## Step 1: Create Supabase Project

1. **Go to [Supabase.com](https://supabase.com)**
2. **Sign up/Login** with your GitHub account
3. **Create New Project**
   - Click "New Project"
   - Choose your organization
   - Enter project name: `marketplace-tracker`
   - Enter database password (save this!)
   - Choose region closest to you
   - Click "Create new project"

## Step 2: Set Up Database Schema

1. **Open SQL Editor** in your Supabase dashboard
2. **Copy and paste** the following SQL commands:

```sql
-- Create listings table
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

-- Create price_history table
CREATE TABLE price_history (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  listing_id UUID REFERENCES listings(id) ON DELETE CASCADE,
  price DECIMAL(10,2),
  change_amount DECIMAL(10,2),
  change_percentage DECIMAL(5,2),
  recorded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create enhancement_queue table
CREATE TABLE enhancement_queue (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  listing_id UUID REFERENCES listings(id) ON DELETE CASCADE,
  status TEXT DEFAULT 'pending',
  priority INTEGER DEFAULT 1,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  processed_at TIMESTAMP WITH TIME ZONE
);

-- Enable Row Level Security
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE price_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE enhancement_queue ENABLE ROW LEVEL SECURITY;

-- Create policies (allow all operations for now)
CREATE POLICY "Allow all operations" ON listings FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON price_history FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON enhancement_queue FOR ALL USING (true);

-- Create update timestamp trigger
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

-- Create price change tracking trigger
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

3. **Click "Run"** to execute the SQL

## Step 3: Get API Keys

1. **Go to Settings > API** in your Supabase dashboard
2. **Copy the following values:**
   - **Project URL** (looks like: `https://your-project-id.supabase.co`)
   - **anon public key** (starts with `eyJ...`)

## Step 4: Update Configuration

1. **Open `js/supabase-client.js`**
2. **Replace the placeholder values:**

```javascript
const SUPABASE_URL = 'https://your-project-id.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key-here';
```

## Step 5: Test the Connection

1. **Open `unified-marketplace-tracker.html`** in your browser
2. **Open browser developer tools** (F12)
3. **Check the console** for any connection errors
4. **Try adding a test listing** to verify everything works

## Step 6: Deploy for Mobile Access

### Option A: Local Network (Quick Test)
```bash
# In your marketplace-tracker directory
python3 -m http.server 8000
```
Then access from your phone at: `http://your-laptop-ip:8000/unified-marketplace-tracker.html`

### Option B: GitHub Pages (Recommended)
1. **Push your code to GitHub**
2. **Go to Settings > Pages** in your GitHub repo
3. **Select source branch** (usually `main`)
4. **Your site will be available at:** `https://your-username.github.io/marketplace-tracker/unified-marketplace-tracker.html`

### Option C: Netlify/Vercel (Production)
1. **Connect your GitHub repo** to Netlify or Vercel
2. **Deploy automatically** on every push
3. **Get a custom domain** if desired

## Step 7: Data Migration (Optional)

If you have existing data from the old system:

1. **Export your existing data** as JSON
2. **Use the Supabase dashboard** to import via CSV or JSON
3. **Or use the API** to programmatically import

## Troubleshooting

### Connection Issues
- **Check API keys** are correct
- **Verify CORS settings** in Supabase dashboard
- **Check browser console** for error messages

### Real-time Issues
- **Ensure RLS policies** are set correctly
- **Check network connectivity**
- **Verify Supabase project** is active

### Mobile Issues
- **Use HTTPS** for production deployments
- **Test on different browsers**
- **Check mobile browser console**

## Security Considerations

### For Production Use
1. **Add authentication** (Supabase Auth)
2. **Implement proper RLS policies**
3. **Use environment variables** for API keys
4. **Enable rate limiting**

### Current Setup (Development)
- **All operations allowed** for easy testing
- **No authentication required**
- **Suitable for personal use**

## Next Steps

Once Supabase is set up:

1. **Test real-time sync** between devices
2. **Add your existing 286 listings** to the database
3. **Configure the enhancement pipeline** to work with Supabase
4. **Set up automated price tracking**

## Support

- **Supabase Documentation:** https://supabase.com/docs
- **Supabase Community:** https://github.com/supabase/supabase/discussions
- **Project Issues:** Create an issue in your GitHub repo

---

🎉 **Congratulations!** Your unified marketplace tracker is now ready for real-time sync across all your devices!
