// Marketplace Tracker - Content Script with Improved Location Detection
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
            
            // Extract data and create floating button
            setTimeout(() => {
                extractedData = extractListingData(marketplace);
                if (extractedData) {
                    console.log('📝 Extracted data:', extractedData);
                    createFloatingButton();
                } else {
                    console.log('⚠️ No listing data found on this page');
                }
            }, 1000);
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
        
        // Extract price - multiple selectors for different Craigslist layouts
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
        
        // Strategy 2: Extract from description - look for common location patterns
        const descriptionElement = document.querySelector('#postingbody, .postingbody, .userbody');
        if (descriptionElement) {
            const description = descriptionElement.textContent;
            
            // Look for "Located at/in/near" patterns
            const locationPatterns = [
                /(?:located|situated|found|available)\s+(?:at|in|near|around)\s+([^.!?]+?)(?:\.|!|\?|$)/i,
                /(?:at|in|near)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]*)*\s+(?:Marina|Harbor|Bay|Creek|River|Lake|Beach|Park))/i,
                /([A-Z][a-z]+(?:\s+[A-Z][a-z]*)*),?\s+[A-Z]{2}\b/i  // City, ST pattern
            ];
            
            for (const pattern of locationPatterns) {
                const match = description.match(pattern);
                if (match && match[1]) {
                    const location = match[1].trim();
                    // Filter out obvious non-locations
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
        
        // Strategy 3: Look in title for parentheses location (fallback)
        if (extractedData && extractedData.title) {
            const titleLocationMatch = extractedData.title.match(/\(([^)]+)\)/);
            if (titleLocationMatch && titleLocationMatch[1]) {
                const titleLocation = titleLocationMatch[1].trim();
                if (!titleLocation.toLowerCase().includes('loa') && 
                    !titleLocation.toLowerCase().includes('foot') &&
                    titleLocation.length > 2) {
                    console.log('📍 Found location in title:', titleLocation);
                    return titleLocation;
                }
            }
        }
        
        // Strategy 4: Extract from posting info elements (improved filtering)
        const postingInfoElements = document.querySelectorAll('.postinginfo, small, .postinginfos, .postinginfos small, .attrgroup span');
        for (const element of postingInfoElements) {
            const text = element.textContent || '';
            if (text.includes('(') && text.includes(')')) {
                const locationMatch = text.match(/\(([^)]+)\)/);
                if (locationMatch && locationMatch[1]) {
                    const candidate = locationMatch[1].trim();
                    // Filter out technical specs and keep only location-like text
                    if (!candidate.toLowerCase().includes('loa') &&
                        !candidate.toLowerCase().includes('foot') &&
                        !candidate.toLowerCase().includes('hp') &&
                        !candidate.toLowerCase().includes('engine') &&
                        !candidate.toLowerCase().includes('trailer') &&
                        candidate.length > 2 && 
                        candidate.length < 50) {
                        console.log('📍 Found location in posting info:', candidate);
                        return candidate;
                    }
                }
            }
        }
        
        // Strategy 5: Fall back to extracting from URL domain
        const urlMatch = window.location.href.match(/https?:\/\/([^.]+)\.craigslist\.org/);
        if (urlMatch && urlMatch[1]) {
            const cityCode = urlMatch[1];
            const cityMap = {
                'annapolis': 'Annapolis, MD',
                'baltimore': 'Baltimore, MD',
                'washingtondc': 'Washington, DC',
                'sfbay': 'San Francisco Bay Area, CA',
                'newyork': 'New York, NY',
                'losangeles': 'Los Angeles, CA',
                'chicago': 'Chicago, IL',
                'seattle': 'Seattle, WA',
                'boston': 'Boston, MA',
                'miami': 'Miami, FL'
            };
            
            if (cityMap[cityCode]) {
                console.log('📍 Found location from URL:', cityMap[cityCode]);
                return cityMap[cityCode];
            } else {
                console.log('📍 Found location code from URL:', cityCode);
                return cityCode;
            }
        }
        
        console.log('⚠️ No location found using any strategy');
        return null;
    }
    
    function extractFacebookData() {
        // Facebook Marketplace extraction
        const data = {
            url: window.location.href,
            marketplace: 'facebook',
            timestamp: new Date().toISOString()
        };
        
        // Facebook uses dynamic selectors, try multiple approaches
        const titleElement = document.querySelector('[data-testid="post-title"] span, h1');
        if (titleElement) {
            data.title = titleElement.textContent.trim();
        }
        
        const priceElement = document.querySelector('[data-testid="price"] span, [class*="price"]');
        if (priceElement) {
            data.price = extractPriceFromText(priceElement.textContent);
        }
        
        return data;
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
        
        // Remove all non-numeric characters except decimal points and commas
        const priceMatch = text.match(/[\$]?([0-9,]+\.?[0-9]*)/);
        if (priceMatch) {
            const priceStr = priceMatch[1].replace(/,/g, '');
            const price = parseFloat(priceStr);
            return isNaN(price) ? null : price;
        }
        return null;
    }
    
    function createFloatingButton() {
        // Remove existing button if present
        if (saveButton) {
            saveButton.remove();
        }
        
        // Make sure we have a document body to attach to
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
        
        // Add hover effect
        saveButton.addEventListener('mouseenter', () => {
            saveButton.style.transform = 'scale(1.1)';
            saveButton.style.boxShadow = '0 8px 25px rgba(102, 126, 234, 0.6)';
        });
        
        saveButton.addEventListener('mouseleave', () => {
            saveButton.style.transform = 'scale(1)';
            saveButton.style.boxShadow = '0 4px 20px rgba(102, 126, 234, 0.4)';
        });
        
        // Add click handler
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
        
        // Send data to background script to save to Google Forms
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
        // Make sure we have a document body
        if (!document.body) {
            console.log('Cannot show notification: no document body');
            return;
        }
        
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
        
        // Add animation
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
    
    // Handle messages from popup
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
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
})();