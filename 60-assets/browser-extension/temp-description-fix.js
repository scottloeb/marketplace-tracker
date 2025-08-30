        // Facebook description - improved selectors for long descriptions
        const descriptionSelectors = [
            '[data-ad-preview="message"]',
            '[data-testid="post-message"]', 
            '.x11i5rnm',
            '[data-testid="seller-description"]',
            '.xdj266r', // Common Facebook text class
            '.x1iorvi4', // Another Facebook text class
            'div[dir="auto"]' // Generic auto-direction divs that often contain descriptions
        ];
        
        for (const selector of descriptionSelectors) {
            const elements = document.querySelectorAll(selector);
            for (const element of elements) {
                const text = element.textContent.trim();
                // Look for description-like text (longer content that mentions selling/listing items)
                if (text.length > 50 && 
                    (text.toLowerCase().includes('selling') || 
                     text.toLowerCase().includes('available') || 
                     text.toLowerCase().includes('listed') ||
                     text.toLowerCase().includes('asking') ||
                     text.length > 200)) { // Or just long text
                    data.description = text;
                    console.log('📄 Facebook description found:', text.substring(0, 100) + '...');
                    break;
                }
            }
            if (data.description) break;
        }
        
        // If still no description found, try broader search
        if (!data.description) {
            const allDivs = document.querySelectorAll('div[dir="auto"]');
            for (const div of allDivs) {
                const text = div.textContent.trim();
                if (text.length > 100 && text.toLowerCase().includes('selling')) {
                    data.description = text;
                    console.log('📄 Facebook description found via broad search:', text.substring(0, 100) + '...');
                    break;
                }
            }
        }