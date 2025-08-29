# Marketplace Tracker - Project Instructions

## Repository Structure
Uses semantic numbering system:
- `10-src/` - Core application (zero dependencies)
- `20-reference/` - Data and specifications
- `30-docs/` - Documentation  
- `40-automation/` - Python processing scripts
- `50-scripts/` - Repository maintenance
- `90-archive/` - Processed data (excluded from project knowledge)

## Key Files to Reference
1. `CITs/CURRENT_STATE.md` - Complete current status
2. `index.html` - Main application (Vercel deployment)
3. `90-archive/current-data/` - Latest processed marketplace data
4. `10-src/utils/mobile-queue.js` - Mobile queue and missing info detector

## Core Functionality
- Facebook Marketplace URL extraction with real price detection
- Mobile queue system for phone URL submissions
- Missing information detector that suggests seller questions
- Statistical market analysis for deal identification
- Export capability for Ocean Explorer integration

## Development Rules
- Core application has zero build dependencies
- All external libraries via CDN only (Supabase, Chart.js)
- Python automation scripts use minimal dependencies
- All data files in 90-archive/ directory

## Deployment Configuration
- Entry point: `index.html` in root
- Deployed at: https://ski-shopper.vercel.app/
- Local development: `python3 -m http.server 8080`

## Current Data Status
- 166 Facebook listings extracted with real pricing data
- Price range: $150-$25,000, average $9,659
- 91.7% extraction success rate
- 4 statistical outliers identified as potential deals

## Mobile Workflow
1. User shares Facebook URL from phone to https://ski-shopper.vercel.app/
2. URL added to processing queue via mobile-queue.js
3. Queue exports to JSON for enhanced_screenshot_collector.py
4. Results sync back to main application

## Missing Info Detector
Analyzes listings for missing critical information:
- Engine hours, year, condition, maintenance history
- Generates specific questions to ask sellers
- Provides completeness score for each listing

## Cleanup and Maintenance
- Run `comprehensive_cleanup.sh` to organize repository
- All README files auto-generated and kept under 50 words
- Regular archive of processed data to prevent project knowledge overflow

## File Access Paths
When project knowledge is overloaded:
- Repository root: `/Users/scottloeb/Desktop/marketplace-tracker/`
- Current data: `90-archive/current-data/enhanced_extraction_20250829_001201.json`
- Scripts: `40-automation/scripts/enhanced_screenshot_collector.py`
