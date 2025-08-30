// Marketplace Tracker - Content Script with Improved Facebook Support
// Extracts listing data from marketplace pages and provides floating save button

(function() {
    'use strict';
    
    console.log('🛥️ Marketplace Tracker content script loaded');
    
    let extractedData = null;
    let saveButton = null;
    
    // Initialize content script
    function init() {
        const url = window.location.href.toLowerCase();
        console.log('📍 Current URL:', url);
        
        if (isSupportedMarketplace(url)) {
            const marketplace = detectMarketplace(url);
            console.log('🎯 Marketplace detected:', marketplace);
            
            // For Facebook, wait longer for dynamic content to load
            const delay = marketplace === 'facebook' ? 3000 : 1000;
            
            // Extract data and create floating button
            setTimeout(() => {
                extractedData = extractListingData(marketplace);
                if (extractedData) {
                    console.log('📝 Extracted data:', extractedData);
                    createFloatingButton();
                } else {
                    console.log('⚠️ No listing data found on this page');
                }
            }, delay);
        }
    }
    
    function isSupportedMarketplace(url) {
        return url.includes('craigslist.org') || 
               url.includes('facebook.com/marketplace') ||
               url.includes('ebay.com') ||
               url.includes('offerup.com');
    }
    
    function detectMarketplace(url) {
        if (url.includes('craigslist.org')) return 'craigslist';
        if (url.includes('facebook.com/marketplace')) return 'facebook';
        if (url.includes('ebay.com')) return 'ebay';
        if (url.includes('offerup.com')) return 'offerup';
        return 'unknown';
    }
    
    function extractListingData(marketplace) {
        console.log('🔍 Starting data extraction for:', marketplace);
        
        switch (marketplace) {
            case 'craigslist':
                return extractCraigslistData();
            case 'facebook':
                return extractFacebookData();
            case 'ebay':
                return extractEbayData();
            case 'offerup':
                return extractOfferUpData();
            default:
                return null;
        }
    }
    
    function extractFacebookData() {
        const data = {
            url: window.location.href,
            marketplace: 'facebook',
            timestamp: new Date().toISOString()
        };
        
        console.log('🔍 Facebook: Starting extraction...');
        
        // Facebook title - try multiple strategies
        const titleSelectors = [
            '[data-testid="post-title"] span',
            'h1 span',
            '[role="main"] h1',
            'span[dir="auto"]', // Facebook often uses this for titles
            '.x1heor9g', // Common Facebook class pattern
            '.x1i10hfl span' // Another common pattern
        ];
        
        for (const selector of titleSelectors) {
            const element = document.querySelector(selector);
            if (element && element.textContent.trim().length > 10) {
                data.title = element.textContent.trim();
                console.log('📝 Facebook title found:', data.title, 'using selector:', selector);
                break;
            }
        }
        
        // If no good title found, try broader search
        if (!data.title) {
            const allSpans = document.querySelectorAll('span');
            for (const span of allSpans) {
                const text = span.textContent.trim();
                if (text.length > 10 && text.length < 200 && !text.includes('$') && !text.includes('Facebook')) {
                    // Check if this looks like a listing title
                    if (text.match(/\b(boat|car|truck|bike|house|apartment|for sale|motor|trailer)\b/i)) {
                        data.title = text;
                        console.log('📝 Facebook title found via heuristic:', data.title);
                        break;
                    }
                }
            }
        }
        
        // Facebook price - very tricky due to dynamic classes
        const priceSelectors = [
            '[data-testid="price"] span',
            'span[dir="auto"]', // Often used for price
            '.x193iq5w', // Common price class
            'span[role="text"]'
        ];
        
        // Look for $ symbol in spans
        const allSpans = document.querySelectorAll('span');
        for (const span of allSpans) {
            const text = span.textContent.trim();
            if (text.includes('$') && !text.includes('Facebook') && text.length < 50) {
                const price = extractPriceFromText(text);
                if (price && price > 0) {
                    data.price = price;
                    console.log('💰 Facebook price found:', data.price, 'from text:', text);
                    break;
                }
            }
        }
        
        // Facebook location - extract from various possible places
        data.location = extractFacebookLocation();
        if (data.location) {
            console.log('📍 Facebook location found:', data.location);
        }
        
        // Facebook photos - look for images in the listing
        data.photos = [];
        const imageElements = document.querySelectorAll('img[src*="scontent"], img[src*="fbcdn"]');
        imageElements.forEach((img, index) => {
            if (img.src && img.src.includes('scontent') && !img.src.includes('profile')) {
                data.photos.push(img.src);
            }
        });
        console.log('📸 Facebook photos found:', data.photos.length);
        
        // Facebook description - try to find description text
        const descriptionElements = document.querySelectorAll('[data-ad-preview="message"], [data-testid="post-message"], .x11i5rnm');
        for (const element of descriptionElements) {
            if (element.textContent.trim().length > 20) {
                data.description = element.textContent.trim();
                console.log('📄 Facebook description found:', data.description.substring(0, 100) + '...');
                break;
            }
        }
        
        console.log('✅ Facebook extraction complete:', data);
        return data;
    }
    
    function extractFacebookLocation() {
        // Look for location indicators on Facebook
        const locationIndicators = [
            'Miles away',
            'km away',
            'Local pickup',
            'Pickup available'
        ];
        
        // Search all text nodes for location patterns
        const walker = document.createTreeWalker(
            document.body,
            NodeFilter.SHOW_TEXT,
            null,
            false
        );
        
        const textNodes = [];
        let node;
        while (node = walker.nextNode()) {
            const text = node.textContent.trim();
            if (text.length > 5 && text.length < 100) {
                textNodes.push(text);
            }
        }
        
        // Look for location patterns
        for (const text of textNodes) {
            // Check for "X miles away" pattern
            if (text.includes('miles away') || text.includes('km away')) {
                const locationMatch = text.match(/(.+?)\s+\d+\s+(?:miles|km)\s+away/i);
                if (locationMatch) {
                    return locationMatch[1].trim();
                }
            }
            
            // Check for city patterns
            if (text.match(/^[A-Z][a-z]+,\s*[A-Z]{2}$/) || text.match(/^[A-Z][a-z]+\s+[A-Z][a-z]+,\s*[A-Z]{2}$/)) {
                return text;
            }
        }
        
        return null;
    }
    
    function extractCraigslistData() {
        const data = {
            url: window.location.href,
            marketplace: 'craigslist',
            timestamp: new Date().toISOString()
        };
        
        // Extract title
        const titleElement = document.querySelector('#titletextonly, .postingtitletext #titletextonly, h1.postingtitle #titletextonly');
        if (titleElement) {
            data.title = titleElement.textContent.trim();
            console.log('📝 Title found:', data.title);
        }
        
        // Extract price
        const priceSelectors = [
            '.price',
            '.postinginfo .price',
            '.postinginfos .price',
            '.postingtitle .price',
            '[class*="price"]'
        ];
        
        for (const selector of priceSelectors) {
            const priceElement = document.querySelector(selector);
            if (priceElement) {
                const priceText = priceElement.textContent.trim();
                data.price = extractPriceFromText(priceText);
                console.log('💰 Price found:', data.price, 'from text:', priceText);
                break;
            }
        }
        
        // Improved location extraction
        data.location = extractLocationFromCraigslist();
        if (data.location) {
            console.log('📍 Location found:', data.location);
        }
        
        // Extract photos
        data.photos = [];
        const photoElements = document.querySelectorAll('#thumbs img, .slide img, .gallery img, .images img, .iw img');
        photoElements.forEach((img, index) => {
            if (img.src && !img.src.includes('data:') && img.src.includes('craigslist')) {
                data.photos.push(img.src);
            }
        });
        console.log('📸 Photos found:', data.photos.length);
        
        // Extract description
        const descriptionElement = document.querySelector('#postingbody, .postingbody, .userbody');
        if (descriptionElement) {
            data.description = descriptionElement.textContent.trim();
            console.log('📄 Description found:', data.description.substring(0, 100) + '...');
        }
        
        // Extract seller info if available
        const sellerElement = document.querySelector('.replylink, .reply-link');
        if (sellerElement) {
            data.seller = 'Contact via Craigslist';
        }
        
        return data;
    }
    
    function extractLocationFromCraigslist() {
        // Strategy 1: Look for map location text
        const mapElements = document.querySelectorAll('.mapaddress, .mapAndAttrs .mapaddress, [class*="map"]');
        for (const element of mapElements) {
            const mapText = element.textContent.trim();
            if (mapText && mapText.length > 2 && mapText.length < 100 && !mapText.includes('craigslist')) {
                console.log('📍 Found map location:', mapText);
                return mapText;
            }
        }
        
        // Strategy 2: Extract from description
        const descriptionElement = document.querySelector('#postingbody, .postingbody, .userbody');
        if (descriptionElement) {
            const description = descriptionElement.textContent;
            
            const locationPatterns = [
                /(?:located|situated|found|available)\s+(?:at|in|near|around)\s+([^.!?]+?)(?:\.|!|\?|$)/i,
                /(?:at|in|near)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]*)*\s+(?:Marina|Harbor|Bay|Creek|River|Lake|Beach|Park))/i,
                /([A-Z][a-z]+(?:\s+[A-Z][a-z]*)*),?\s+[A-Z]{2}\b/i
            ];
            
            for (const pattern of locationPatterns) {
                const match = description.match(pattern);
                if (match && match[1]) {
                    const location = match[1].trim();
                    if (!location.toLowerCase().includes('loa') && 
                        !location.toLowerCase().includes('foot') &&
                        !location.toLowerCase().includes('hp') &&
                        location.length > 3) {
                        console.log('📍 Found location in description:', location);
                        return location;
                    }
                }
            }
        }
        
        // Strategy 3: URL fallback
        const urlMatch = window.location.href.match(/https?:\/\/([^.]+)\.craigslist\.org/);
        if (urlMatch && urlMatch[1]) {
            const cityCode = urlMatch[1];
            const cityMap = {
                'annapolis': 'Annapolis, MD',
                'baltimore': 'Baltimore, MD',
                'washingtondc': 'Washington, DC',
                'sfbay': 'San Francisco Bay Area, CA'
            };
            
            return cityMap[cityCode] || cityCode;
        }
        
        return null;
    }
    
    function extractEbayData() {
        const data = {
            url: window.location.href,
            marketplace: 'ebay',
            timestamp: new Date().toISOString()
        };
        
        const titleElement = document.querySelector('#x-title-label-lbl, h1');
        if (titleElement) {
            data.title = titleElement.textContent.trim();
        }
        
        const priceElement = document.querySelector('.u-flL.condText, .notranslate');
        if (priceElement) {
            data.price = extractPriceFromText(priceElement.textContent);
        }
        
        return data;
    }
    
    function extractOfferUpData() {
        const data = {
            url: window.location.href,
            marketplace: 'offerup',
            timestamp: new Date().toISOString()
        };
        
        const titleElement = document.querySelector('[data-testid="title"], h1');
        if (titleElement) {
            data.title = titleElement.textContent.trim();
        }
        
        const priceElement = document.querySelector('[data-testid="price"]');
        if (priceElement) {
            data.price = extractPriceFromText(priceElement.textContent);
        }
        
        return data;
    }
    
    function extractPriceFromText(text) {
        if (!text) return null;
        
        const priceMatch = text.match(/[\$]?([0-9,]+\.?[0-9]*)/);
        if (priceMatch) {
            const priceStr = priceMatch[1].replace(/,/g, '');
            const price = parseFloat(priceStr);
            return isNaN(price) ? null : price;
        }
        return null;
    }
    
    function createFloatingButton() {
        if (saveButton) {
            saveButton.remove();
        }
        
        if (!document.body) {
            console.log('⚠️ Document body not ready, retrying...');
            setTimeout(createFloatingButton, 500);
            return;
        }
        
        saveButton = document.createElement('div');
        saveButton.innerHTML = '🛥️';
        saveButton.title = 'Save to Marketplace Tracker';
        saveButton.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
            z-index: 999999;
            user-select: none;
        `;
        
        saveButton.addEventListener('mouseenter', () => {
            saveButton.style.transform = 'scale(1.1)';
            saveButton.style.boxShadow = '0 8px 25px rgba(102, 126, 234, 0.6)';
        });
        
        saveButton.addEventListener('mouseleave', () => {
            saveButton.style.transform = 'scale(1)';
            saveButton.style.boxShadow = '0 4px 20px rgba(102, 126, 234, 0.4)';
        });
        
        saveButton.addEventListener('click', handleFloatingButtonClick);
        
        document.body.appendChild(saveButton);
        console.log('✅ Floating save button added');
    }
    
    function handleFloatingButtonClick() {
        console.log('🎯 Floating button clicked');
        
        if (!extractedData) {
            showNotification('❌ No listing data found', 'error');
            return;
        }
        
        chrome.runtime.sendMessage({
            action: 'saveListing',
            data: extractedData
        }, (response) => {
            if (response && response.success) {
                showNotification('✅ Saved to tracker!', 'success');
            } else {
                showNotification('❌ ' + (response?.error || 'Save failed'), 'error');
            }
        });
    }
    
    function showNotification(message, type = 'info') {
        if (!document.body) return;
        
        const notification = document.createElement('div');
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 80px;
            right: 20px;
            padding: 12px 20px;
            background: ${type === 'success' ? '#4CAF50' : type === 'error' ? '#f44336' : '#2196F3'};
            color: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            z-index: 999999;
            font-size: 14px;
            max-width: 300px;
            animation: slideIn 0.3s ease;
        `;
        
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
        `;
        document.head.appendChild(style);
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            if (notification && notification.parentNode) {
                notification.remove();
            }
            if (style && style.parentNode) {
                style.remove();
            }
        }, 3000);
    }
    
    chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
        console.log('📨 Content script received message:', request);
        
        if (request.action === 'getListingData') {
            sendResponse({ 
                success: true, 
                data: extractedData,
                hasData: !!extractedData
            });
            return true;
        }
        
        if (request.action === 'ping') {
            sendResponse({ success: true, message: 'Content script responding' });
            return true;
        }
    });
    
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
})();