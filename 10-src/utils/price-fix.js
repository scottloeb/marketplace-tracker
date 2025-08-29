// 🔧 MARKETPLACE TRACKER PRICE PARSING FIX
// This addresses the $0 average price issue by properly parsing string prices

// Enhanced price parsing function
function parsePrice(price) {
    if (!price) return 0;
    if (typeof price === 'number') return price;
    // Convert string price to number, removing any non-numeric characters except decimal
    const cleaned = String(price).replace(/[^0-9.]/g, '');
    return parseFloat(cleaned) || 0;
}

// Updated price calculations
function calculateAveragePrice(listings) {
    if (!listings || listings.length === 0) return 0;
    const validPrices = listings.map(listing => parsePrice(listing.price)).filter(price => price > 0);
    if (validPrices.length === 0) return 0;
    return validPrices.reduce((sum, price) => sum + price, 0) / validPrices.length;
}

// Format price for display
function formatPrice(price) {
    const numPrice = parsePrice(price);
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        maximumFractionDigits: 0
    }).format(numPrice);
}

// Get price statistics
function getPriceStats(listings) {
    const validPrices = listings.map(listing => parsePrice(listing.price)).filter(price => price > 0);
    
    if (validPrices.length === 0) {
        return {
            count: 0,
            average: 0,
            min: 0,
            max: 0,
            total: 0
        };
    }
    
    return {
        count: validPrices.length,
        average: validPrices.reduce((sum, p) => sum + p, 0) / validPrices.length,
        min: Math.min(...validPrices),
        max: Math.max(...validPrices),
        total: validPrices.reduce((sum, p) => sum + p, 0)
    };
}

// Direct DOM update function
function updateStatsDisplay(listings) {
    if (!listings || !Array.isArray(listings)) {
        console.log('⚠️ No listings data available for display update');
        return;
    }
    
    console.log('📊 Updating stats display with', listings.length, 'listings');
    
    const stats = getPriceStats(listings);
    console.log('📊 Stats calculated:', stats);
    
    // Find and update stat elements by looking for stat-value elements
    const statValues = document.querySelectorAll('.stat-value');
    console.log('🔍 Found stat-value elements:', statValues.length);
    
    // Log all stat elements for debugging
    statValues.forEach((element, index) => {
        console.log(`Stat ${index}:`, element.textContent, element.className);
    });
    
    if (statValues.length >= 4) {
        // Update Total Listings (first stat)
        statValues[0].textContent = listings.length;
        
        // Count recommendations
        const considerCount = listings.filter(l => l.market_analysis === 'CONSIDER').length;
        const buyCount = listings.filter(l => l.market_analysis === 'BUY').length;
        
        // Update Consider count (second stat)
        statValues[1].textContent = considerCount;
        
        // Update BUY NOW count (third stat)
        statValues[2].textContent = buyCount;
        
        // Update Average Price (fourth stat)
        const avgPrice = Math.round(stats.average);
        statValues[3].textContent = `$${avgPrice.toLocaleString()}`;
        
        console.log('✅ Stats display updated:', {
            totalListings: listings.length,
            consider: considerCount,
            buyNow: buyCount,
            avgPrice: `$${avgPrice.toLocaleString()}`
        });
    } else if (statValues.length > 0) {
        console.log('⚠️ Found', statValues.length, 'stat-value elements, but need at least 4');
        
        // Update what we can find
        if (statValues[0]) {
            statValues[0].textContent = listings.length;
            console.log('✅ Updated first stat to:', listings.length);
        }
        
        // Alternative: try to find elements by text content
        updateStatsByTextSearch(listings, stats);
    } else {
        console.log('⚠️ Could not find any stat-value elements');
        
        // Try alternative approaches
        updateStatsByTextSearch(listings, stats);
        updateStatsByInnerHTML(listings, stats);
    }
}

// Fallback method to update stats by searching for text
function updateStatsByTextSearch(listings, stats) {
    console.log('🔍 Trying updateStatsByTextSearch fallback...');
    
    // Find elements containing the current values and update them
    const allElements = document.querySelectorAll('*');
    let updated = 0;
    
    for (let element of allElements) {
        if (element.textContent === '0' && element.classList.contains('stat-value')) {
            // Check parent or sibling elements to determine which stat this is
            const parent = element.parentElement;
            const label = parent.querySelector('.stat-label');
            
            if (label && label.textContent.includes('Total Listings')) {
                element.textContent = listings.length;
                console.log('✅ Updated total listings to', listings.length);
                updated++;
            } else if (label && label.textContent.includes('Avg Price')) {
                const avgPrice = Math.round(stats.average);
                element.textContent = `$${avgPrice.toLocaleString()}`;
                console.log('✅ Updated average price to $' + avgPrice.toLocaleString());
                updated++;
            }
        }
    }
    
    console.log('📊 updateStatsByTextSearch updated', updated, 'elements');
}

// Another fallback method using innerHTML search
function updateStatsByInnerHTML(listings, stats) {
    console.log('🔍 Trying updateStatsByInnerHTML fallback...');
    
    // Look for common patterns in the HTML
    const htmlContent = document.body.innerHTML;
    
    // Find and replace specific patterns
    if (htmlContent.includes('Total Listings')) {
        // Try to find the structure and update it
        const statsBar = document.querySelector('.stats-bar');
        if (statsBar) {
            console.log('📊 Found stats-bar element');
            
            // Look for stat cards within the stats bar
            const statCards = statsBar.querySelectorAll('.stat-card');
            console.log('📊 Found', statCards.length, 'stat-card elements');
            
            if (statCards.length >= 4) {
                // Update each stat card
                const avgPrice = Math.round(stats.average);
                
                // Update the values directly
                const values = statsBar.querySelectorAll('.stat-value');
                if (values.length >= 4) {
                    values[0].textContent = listings.length;
                    values[3].textContent = `$${avgPrice.toLocaleString()}`;
                    console.log('✅ Updated stats via innerHTML method');
                }
            }
        }
    }
}

// Load enhanced extraction data
async function loadEnhancedExtractionData() {
    try {
        console.log('🔍 Attempting to load enhanced extraction data from: ./data/enhanced_extraction_20250829_001201.json');
        
        // Try to load the latest enhanced extraction data
        const response = await fetch('./data/enhanced_extraction_20250829_001201.json');
        
        console.log('📡 Fetch response status:', response.status, response.statusText);
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        
        const data = await response.json();
        console.log('📊 Raw data loaded:', { total_processed: data.total_processed, data_length: data.data?.length });
        
        if (!data.data || !Array.isArray(data.data)) {
            throw new Error('Invalid data structure - missing data array');
        }
        
        // Transform the data structure to match expected format
        const transformedListings = data.data.map((item, index) => ({
            id: item.listing_id || `extracted_${index}`,
            title: item.title,
            url: item.url,
            price: parsePrice(item.price), // Parse price immediately
            make: extractMake(item.title),
            year: extractYear(item.title),
            location: '', // Not available in extraction data
            seller: '',
            source: 'Enhanced Facebook Extraction',
            status: 'active',
            addedDate: new Date().toISOString(),
            mobileAdded: false,
            notes: `Extracted: ${item.extraction_timestamp}`,
            images: item.images || [],
            screenshot: item.screenshot || ''
        }));
        
        console.log(`✅ Loaded ${transformedListings.length} listings from enhanced extraction`);
        const stats = getPriceStats(transformedListings);
        console.log(`💰 Price stats: Average $${stats.average.toFixed(2)}, Range $${stats.min}-$${stats.max}`);
        
        return transformedListings;
        
    } catch (error) {
        console.error('❌ Failed to load enhanced extraction data:', error);
        
        // Fallback to existing data if available
        if (typeof listings !== 'undefined' && listings.length > 0) {
            console.log('📊 Using existing listings data with price parsing');
            return listings.map(listing => ({
                ...listing,
                price: parsePrice(listing.price)
            }));
        }
        
        return [];
    }
}

// Extract make from title
function extractMake(title) {
    if (!title) return 'Unknown';
    const titleLower = title.toLowerCase();
    if (titleLower.includes('yamaha')) return 'Yamaha';
    if (titleLower.includes('sea-doo') || titleLower.includes('seadoo')) return 'Sea-Doo';
    if (titleLower.includes('kawasaki')) return 'Kawasaki';
    if (titleLower.includes('jet ski')) return 'Jet Ski';
    return 'Unknown';
}

// Extract year from title
function extractYear(title) {
    if (!title) return '';
    const yearMatch = title.match(/\b(19|20)\d{2}\b/);
    return yearMatch ? yearMatch[0] : '';
}

// Initialize with enhanced data
async function initializeEnhancedMarketplaceTracker() {
    try {
        console.log('🚀 Starting enhanced marketplace tracker initialization...');
        
        // Clear any existing localStorage data that might interfere
        try {
            localStorage.removeItem('marketplaceListings');
            localStorage.removeItem('listings');
            console.log('🧹 Cleared cached listing data from localStorage');
        } catch (e) {
            console.log('📝 No localStorage access or data to clear');
        }
        
        // Load the enhanced extraction data
        window.listings = await loadEnhancedExtractionData();
        
        // Update the display
        console.log('🔍 Checking for updateDisplay function:', typeof updateDisplay);
        
        if (typeof updateDisplay === 'function') {
            console.log('📞 Calling existing updateDisplay function');
            updateDisplay();
            
            // FORCE our correct data to display after the old function runs
            setTimeout(() => {
                console.log('🔄 Overriding with correct data after existing updateDisplay');
                updateStatsDisplay(window.listings);
            }, 100);
        } else {
            console.log('⚠️ updateDisplay function not found - updating display directly');
            setTimeout(() => {
                updateStatsDisplay(window.listings);
            }, 500);
        }
        
        console.log('🚀 Enhanced Marketplace Tracker initialized successfully');
        
    } catch (error) {
        console.error('❌ Failed to initialize enhanced marketplace tracker:', error);
    }
}

// Auto-initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeEnhancedMarketplaceTracker);
} else {
    initializeEnhancedMarketplaceTracker();
}

// Export functions for global use
window.parsePrice = parsePrice;
window.calculateAveragePrice = calculateAveragePrice;
window.formatPrice = formatPrice;
window.getPriceStats = getPriceStats;
window.loadEnhancedExtractionData = loadEnhancedExtractionData;
window.updateStatsDisplay = updateStatsDisplay;

console.log('🔧 Price parsing fix loaded - all prices will now be properly calculated!');
