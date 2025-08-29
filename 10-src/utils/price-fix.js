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

// Load enhanced extraction data
async function loadEnhancedExtractionData() {
    try {
        // Try to load the latest enhanced extraction data
        const response = await fetch('./90-archive/current-data/enhanced_extraction_20250829_001201.json');
        if (!response.ok) {
            throw new Error('Failed to load enhanced extraction data');
        }
        const data = await response.json();
        
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
    const titleLower = title.toLowerCase();
    if (titleLower.includes('yamaha')) return 'Yamaha';
    if (titleLower.includes('sea-doo') || titleLower.includes('seadoo')) return 'Sea-Doo';
    if (titleLower.includes('kawasaki')) return 'Kawasaki';
    if (titleLower.includes('jet ski')) return 'Jet Ski';
    return 'Unknown';
}

// Extract year from title
function extractYear(title) {
    const yearMatch = title.match(/\b(19|20)\d{2}\b/);
    return yearMatch ? yearMatch[0] : '';
}

// Initialize with enhanced data
async function initializeEnhancedMarketplaceTracker() {
    try {
        // Load the enhanced extraction data
        window.listings = await loadEnhancedExtractionData();
        
        // Update the display
        if (typeof updateDisplay === 'function') {
            updateDisplay();
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

console.log('🔧 Price parsing fix loaded - all prices will now be properly calculated!');
