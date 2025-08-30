// Mobile Bookmarklet for Marketplace Tracker
// This JavaScript runs when you tap the bookmark while viewing a marketplace listing

(function() {
    'use strict';
    
    // Your Google Form URL (replace /viewform with /formResponse for submission)
    const FORM_URL = 'https://docs.google.com/forms/d/e/1FAIpQLSdAsSdHy8fv42wN4CgWkBMVf5i8jNCAkFY9T1Qsn4CUUFI7Pg/formResponse';
    
    // Your form field mappings
    const FIELDS = {
        title: 'entry.1881962373',
        price: 'entry.1877802964', 
        location: 'entry.834272314',
        marketplace: 'entry.131515250',
        url: 'entry.956587300',
        description: 'entry.1652758391'
    };
    
    // Show loading indicator
    showNotification('🔍 Extracting listing data...', 'info');
    
    // Extract data from current page
    const data = extractListingData();
    
    if (!data.title && !data.price) {
        showNotification('❌ No listing data found on this page', 'error');
        return;
    }
    
    // Submit to Google Form
    submitToGoogleForm(data);
    
    function extractListingData() {
        const url = window.location.href.toLowerCase();
        const data = {
            url: window.location.href,
            timestamp: new Date().toISOString()
        };
        
        // Detect marketplace
        if (url.includes('craigslist.org')) {
            data.marketplace = 'craigslist';
            extractCraigslistData(data);
        } else if (url.includes('facebook.com/marketplace')) {
            data.marketplace = 'facebook';
            extractFacebookData(data);
        } else if (url.includes('ebay.com')) {
            data.marketplace = 'ebay';
            extractEbayData(data);
        } else if (url.includes('offerup.com')) {
            data.marketplace = 'offerup';
            extractOfferUpData(data);
        } else {
            data.marketplace = 'other';
            extractGenericData(data);
        }
        
        return data;
    }
    
    function extractCraigslistData(data) {
        // Title
        const titleEl = document.querySelector('#titletextonly, .postingtitletext #titletextonly, h1.postingtitle #titletextonly');
        if (titleEl) data.title = titleEl.textContent.trim();
        
        // Price
        const priceEl = document.querySelector('.price, .postinginfo .price, .postinginfos .price, .postingtitle .price');
        if (priceEl) data.price = extractPriceFromText(priceEl.textContent);
        
        // Location - try URL first for mobile
        const urlMatch = window.location.href.match(/https?:\\/\\/([^.]+)\\.craigslist\\.org/);
        if (urlMatch) {
            const cityMap = {
                'annapolis': 'Annapolis, MD',
                'baltimore': 'Baltimore, MD', 
                'washingtondc': 'Washington, DC',
                'sfbay': 'San Francisco Bay Area, CA'
            };
            data.location = cityMap[urlMatch[1]] || urlMatch[1];
        }
        
        // Description
        const descEl = document.querySelector('#postingbody, .postingbody, .userbody');
        if (descEl) data.description = descEl.textContent.trim().substring(0, 500);
    }
    
    function extractFacebookData(data) {
        // Title - look for h1 spans first
        const titleSelectors = ['h1 span', '[role="main"] h1', 'span[dir="auto"]'];
        for (const selector of titleSelectors) {
            const el = document.querySelector(selector);
            if (el && el.textContent.trim().length > 10) {
                data.title = el.textContent.trim();
                break;
            }
        }
        
        // Price - look for $ symbols
        const spans = document.querySelectorAll('span');
        for (const span of spans) {
            const text = span.textContent.trim();
            if (text.includes('$') && text.length < 50) {
                const price = extractPriceFromText(text);
                if (price) {
                    data.price = price;
                    break;
                }
            }
        }
        
        // Location - look for city patterns or "miles away"
        const textNodes = getAllTextNodes();
        for (const text of textNodes) {
            if (text.includes('miles away') || text.match(/^[A-Z][a-z]+,\\s*[A-Z]{2}$/)) {
                data.location = text.replace(/\\s*\\d+\\s*(miles|km)\\s*away/, '').trim();
                if (data.location.length > 2 && data.location.length < 50) break;
            }
        }
        
        // Description - look for long text mentioning "selling"
        const divs = document.querySelectorAll('div[dir="auto"]');
        for (const div of divs) {
            const text = div.textContent.trim();
            if (text.length > 50 && text.toLowerCase().includes('selling')) {
                data.description = text.substring(0, 500);
                break;
            }
        }
    }
    
    function extractEbayData(data) {
        const titleEl = document.querySelector('#x-title-label-lbl, h1');
        if (titleEl) data.title = titleEl.textContent.trim();
        
        const priceEl = document.querySelector('.u-flL.condText, .notranslate, [data-testid="price"]');
        if (priceEl) data.price = extractPriceFromText(priceEl.textContent);
    }
    
    function extractOfferUpData(data) {
        const titleEl = document.querySelector('[data-testid="title"], h1');
        if (titleEl) data.title = titleEl.textContent.trim();
        
        const priceEl = document.querySelector('[data-testid="price"]');
        if (priceEl) data.price = extractPriceFromText(priceEl.textContent);
    }
    
    function extractGenericData(data) {
        // Generic extraction for other sites
        const titleEl = document.querySelector('h1, .title, [class*="title"]');
        if (titleEl) data.title = titleEl.textContent.trim();
        
        // Look for price patterns in the page
        const allText = document.body.textContent;
        const priceMatch = allText.match(/\\$([0-9,]+(?:\\.[0-9]{2})?)/);
        if (priceMatch) data.price = parseFloat(priceMatch[1].replace(/,/g, ''));
    }
    
    function extractPriceFromText(text) {
        if (!text) return null;
        const match = text.match(/[\\$]?([0-9,]+\\.?[0-9]*)/);
        if (match) {
            const price = parseFloat(match[1].replace(/,/g, ''));
            return isNaN(price) ? null : price;
        }
        return null;
    }
    
    function getAllTextNodes() {
        const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
        const textNodes = [];
        let node;
        while (node = walker.nextNode()) {
            const text = node.textContent.trim();
            if (text.length > 5 && text.length < 100) {
                textNodes.push(text);
            }
        }
        return textNodes;
    }
    
    function submitToGoogleForm(data) {
        console.log('Submitting to Google Form:', data);
        
        const formData = new FormData();
        if (data.title) formData.append(FIELDS.title, data.title);
        if (data.price) formData.append(FIELDS.price, data.price.toString());
        if (data.location) formData.append(FIELDS.location, data.location);
        if (data.marketplace) formData.append(FIELDS.marketplace, data.marketplace);
        if (data.url) formData.append(FIELDS.url, data.url);
        if (data.description) formData.append(FIELDS.description, data.description);
        
        fetch(FORM_URL, {
            method: 'POST',
            body: formData,
            mode: 'no-cors'
        }).then(() => {
            showNotification('✅ Saved to marketplace tracker!', 'success');
        }).catch((error) => {
            showNotification('❌ Save failed: ' + error.message, 'error');
        });
    }
    
    function showNotification(message, type) {
        // Remove existing notifications
        const existing = document.querySelectorAll('.marketplace-tracker-notification');
        existing.forEach(el => el.remove());
        
        const notification = document.createElement('div');
        notification.className = 'marketplace-tracker-notification';
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 999999;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            max-width: 90%;
            text-align: center;
            background: ${type === 'success' ? '#4CAF50' : type === 'error' ? '#f44336' : '#2196F3'};
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 4000);
    }
})();
