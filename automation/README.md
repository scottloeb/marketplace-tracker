# Jet Ski Marketplace Automation Tools

🏍️ **Automated data extraction and intelligent market analysis for jet ski listings**

## 🎯 Overview

This automation suite solves the tedious problem of manually entering 286+ Facebook Marketplace listings by providing intelligent, automated data extraction with built-in market analysis.

### What This Solves
- ❌ **Before**: Manual entry of 286 listings (hours of work)
- ✅ **After**: Automated extraction in minutes with intelligent analysis

### Key Features
- 🤖 **Automated Facebook Marketplace scraping**
- 🧠 **Intelligent price analysis** using reference data
- 💡 **Buy/sell recommendations** based on market value
- 📊 **Real-time extraction progress** with detailed logging
- 🔄 **Direct integration** with existing marketplace tracker

## 🛠️ Available Tools

### 1. Browser Scraper (Standalone)
**File**: `browser_scraper.py`
**Best For**: Quick extractions, one-time imports

```bash
# Basic usage
python browser_scraper.py "https://www.facebook.com/marketplace/search/?query=jet%20ski"

# Advanced usage
python browser_scraper.py "https://facebook.com/marketplace/..." \
  --max-listings 100 \
  --output my_jetskis.json \
  --no-headless
```

### 2. MCP Server (Advanced)
**File**: `marketplace_mcp_server.py`
**Best For**: Integration with AI tools, continuous monitoring

```bash
# Start MCP server
python marketplace_mcp_server.py

# Use with Claude via MCP integration
# Server provides tools for extraction, enhancement, and analysis
```

### 3. Web Interface (User-Friendly)
**File**: `web_interface.html`
**Best For**: Non-technical users, visual feedback

- Open `web_interface.html` in your browser
- Paste Facebook Marketplace search URL
- Click "Start Extraction"
- Copy results to marketplace tracker

## 🚀 Quick Start

### Step 1: Setup
```bash
cd /workspace/automation
python setup.py  # Installs all dependencies
```

### Step 2: Get Facebook Marketplace URL
1. Go to [Facebook Marketplace](https://www.facebook.com/marketplace)
2. Search for "jet ski" or "personal watercraft"
3. Apply filters (location, price range, date posted)
4. Copy the URL from your browser

### Step 3: Extract Data
```bash
# Extract 50 jet ski listings
python browser_scraper.py "YOUR_FACEBOOK_URL" --max-listings 50
```

### Step 4: Import to Tracker
1. Copy the contents of `extracted_listings.json`
2. Open your marketplace tracker
3. Click "📥 Paste Data" 
4. Paste and import

## 🧠 Intelligent Features

### Reference Data Integration
- **93+ jet ski models** from Kawasaki, Sea-Doo, Yamaha (2010-2025)
- **Automatic MSRP lookup** for price validation
- **Depreciation calculations** based on model year
- **Market value assessment** with confidence scores

### Smart Price Analysis
```json
{
  "market_analysis": {
    "status": "underpriced",
    "recommendation": "BUY",
    "confidence": 0.8,
    "reason": "$7,500 is 35% below expected $11,500",
    "potential_savings": 4000
  }
}
```

### Listing Enhancement
**Input**: Raw marketplace title
```
"2019 seadoo gtx 155 low hours excellent condition"
```

**Output**: Enhanced structured data
```json
{
  "title": "2019 seadoo gtx 155 low hours excellent condition",
  "make": "SeaDoo",
  "model": "GTX",
  "year": "2019",
  "condition": "Excellent",
  "reference_specs": {
    "Horsepower": "155",
    "MSRP_USD": "10799",
    "Engine_Type": "4-stroke_NA"
  },
  "market_analysis": {
    "recommendation": "BUY",
    "potential_savings": 2500
  }
}
```

## 📋 Command Reference

### Browser Scraper Options
```bash
python browser_scraper.py [URL] [OPTIONS]

Required:
  URL                    Facebook Marketplace search URL

Options:
  --max-listings N       Maximum listings to extract (default: 50)
  --output FILE          Output file name (default: extracted_listings.json)
  --headless            Run browser in background (default: true)
  --no-headless         Show browser window for debugging
```

### Usage Examples
```bash
# Extract 25 listings quickly
python browser_scraper.py "https://facebook.com/marketplace/..." --max-listings 25

# Comprehensive extraction with visible browser
python browser_scraper.py "https://facebook.com/marketplace/..." \
  --max-listings 200 \
  --no-headless \
  --output comprehensive_jetskis.json

# Target specific location
python browser_scraper.py "https://facebook.com/marketplace/california/search/?query=jet%20ski"
```

## 🎯 Integration Workflow

### Complete Automation Pipeline
```
1. Facebook Marketplace Search URL
   ↓
2. Browser Automation Extraction
   ↓
3. Reference Data Enhancement  
   ↓
4. Intelligent Price Analysis
   ↓
5. JSON Export (ready for tracker import)
   ↓
6. Direct import to your tracker
   ↓
7. Graph database analysis (existing pipeline)
```

### Data Flow
```
Raw Marketplace Listing → Parser → Reference Lookup → Price Analysis → Enhanced JSON
```

## 🔧 Technical Details

### Dependencies
- **Playwright**: Browser automation
- **Pandas**: Data processing
- **MCP**: Model Context Protocol integration
- **BeautifulSoup**: HTML parsing
- **aiohttp**: Async HTTP requests

### Browser Compatibility
- ✅ **Chrome/Chromium**: Primary browser for automation
- ✅ **Cross-platform**: Linux, macOS, Windows
- ✅ **Headless mode**: For background processing
- ✅ **Anti-detection**: Realistic user agent and behavior

### Data Safety
- 🔒 **No data storage**: Tools don't store your data
- 📊 **Local processing**: All analysis happens locally
- 🔄 **Duplicate protection**: Won't create duplicate entries
- ✅ **Validation**: Ensures data integrity before export

## 🚨 Important Notes

### Facebook Terms Compliance
- ⚠️ **Respect rate limits**: Don't overwhelm Facebook's servers
- 📖 **Terms of service**: Ensure compliance with Facebook's ToS
- 🤝 **Ethical use**: Only extract public marketplace data
- 🔄 **Reasonable usage**: Use sparingly and responsibly

### Troubleshooting

#### Common Issues
1. **"No listings found"**
   - Check that URL contains actual jet ski listings
   - Try different search terms or filters
   - Ensure URL is for marketplace, not groups/pages

2. **"Login required"**
   - Facebook may require login for some searches
   - Try running with `--no-headless` to handle manually
   - Use more general search terms

3. **"Slow extraction"**
   - Facebook intentionally limits scraping speed
   - Reduce `max-listings` for faster results
   - Check your internet connection

#### Debugging
```bash
# Run with visible browser to see what's happening
python browser_scraper.py "URL" --no-headless

# Check the generated JSON
python -m json.tool extracted_listings.json | head -50
```

## 🎯 Success Metrics

### Expected Results
- **Extraction Rate**: 80%+ of visible listings
- **Data Accuracy**: 95%+ correct price/title parsing
- **Enhancement Rate**: 60%+ listings matched with reference data
- **Analysis Quality**: Intelligent recommendations for underpriced items

### Performance
- **Speed**: ~1-2 seconds per listing
- **Reliability**: Handles Facebook's anti-bot measures
- **Scalability**: Can process 50-200 listings in one session

## 🔮 Next Steps

### Immediate Use
1. **Run setup.py** to install dependencies
2. **Test with small batch** (25 listings)
3. **Import to tracker** and verify data quality
4. **Scale up** to full 286 listings

### Future Enhancements
- 📱 **Mobile app integration**: Direct mobile extraction
- 🔔 **Alert system**: Notifications for new underpriced listings
- 📈 **Market tracking**: Historical price trend analysis
- 🤖 **AI refinement**: Improved analysis algorithms

---

**Ready to transform your marketplace hunting from manual drudgery to intelligent automation!** 🚀
