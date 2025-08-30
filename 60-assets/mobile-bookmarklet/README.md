# Mobile Bookmarklet for iPhone Safari

## What is this?
A JavaScript bookmark that works on any marketplace site in Safari. Tap it while viewing a listing to extract data and save it to your Google Sheet.

## Installation Instructions (5 minutes)

### Step 1: Copy the Bookmarklet Code
Copy this entire line (starts with `javascript:`):

```
javascript:(function(){const FORM_URL='https://docs.google.com/forms/d/e/1FAIpQLSdAsSdHy8fv42wN4CgWkBMVf5i8jNCAkFY9T1Qsn4CUUFI7Pg/formResponse';const FIELDS={title:'entry.1881962373',price:'entry.1877802964',location:'entry.834272314',marketplace:'entry.131515250',url:'entry.956587300',description:'entry.1652758391'};function showNotification(msg,type){document.querySelectorAll('.mt-notification').forEach(el=>el.remove());const n=document.createElement('div');n.className='mt-notification';n.textContent=msg;n.style.cssText=`position:fixed;top:20px;left:50%;transform:translateX(-50%);z-index:999999;padding:12px 20px;border-radius:8px;font-size:16px;font-weight:bold;color:white;box-shadow:0 4px 20px rgba(0,0,0,0.3);max-width:90%;text-align:center;background:${type==='success'?'#4CAF50':type==='error'?'#f44336':'#2196F3'}`;document.body.appendChild(n);setTimeout(()=>n.remove(),4000)}function extractPrice(text){if(!text)return null;const match=text.match(/[\$]?([0-9,]+\.?[0-9]*)/);return match?parseFloat(match[1].replace(/,/g,''))||null:null}showNotification('🔍 Extracting listing data...','info');const url=window.location.href.toLowerCase();const data={url:window.location.href,timestamp:new Date().toISOString()};if(url.includes('craigslist.org')){data.marketplace='craigslist';const titleEl=document.querySelector('#titletextonly, .postingtitletext #titletextonly, h1.postingtitle #titletextonly');if(titleEl)data.title=titleEl.textContent.trim();const priceEl=document.querySelector('.price, .postinginfo .price, .postinginfos .price');if(priceEl)data.price=extractPrice(priceEl.textContent);const urlMatch=url.match(/https?:\/\/([^.]+)\.craigslist\.org/);if(urlMatch){const cityMap={'annapolis':'Annapolis, MD','baltimore':'Baltimore, MD','washingtondc':'Washington, DC','sfbay':'San Francisco Bay Area, CA'};data.location=cityMap[urlMatch[1]]||urlMatch[1]}const descEl=document.querySelector('#postingbody, .postingbody, .userbody');if(descEl)data.description=descEl.textContent.trim().substring(0,500)}else if(url.includes('facebook.com/marketplace')){data.marketplace='facebook';const titleSels=['h1 span','[role="main"] h1','span[dir="auto"]'];for(const sel of titleSels){const el=document.querySelector(sel);if(el&&el.textContent.trim().length>10){data.title=el.textContent.trim();break}}const spans=document.querySelectorAll('span');for(const span of spans){const text=span.textContent.trim();if(text.includes('$')&&text.length<50){const price=extractPrice(text);if(price){data.price=price;break}}}const divs=document.querySelectorAll('div[dir="auto"]');for(const div of divs){const text=div.textContent.trim();if(text.length>50&&text.toLowerCase().includes('selling')){data.description=text.substring(0,500);break}}}else{data.marketplace='other';const titleEl=document.querySelector('h1, .title, [class*="title"]');if(titleEl)data.title=titleEl.textContent.trim();const allText=document.body.textContent;const priceMatch=allText.match(/\$([0-9,]+(?:\.[0-9]{2})?)/);if(priceMatch)data.price=parseFloat(priceMatch[1].replace(/,/g,''))}if(!data.title&&!data.price){showNotification('❌ No listing data found','error');return}console.log('Submitting:',data);const formData=new FormData();if(data.title)formData.append(FIELDS.title,data.title);if(data.price)formData.append(FIELDS.price,data.price.toString());if(data.location)formData.append(FIELDS.location,data.location);if(data.marketplace)formData.append(FIELDS.marketplace,data.marketplace);if(data.url)formData.append(FIELDS.url,data.url);if(data.description)formData.append(FIELDS.description,data.description);fetch(FORM_URL,{method:'POST',body:formData,mode:'no-cors'}).then(()=>showNotification('✅ Saved to tracker!','success')).catch(e=>showNotification('❌ Save failed','error'))})();
```

### Step 2: Create a New Bookmark in Safari
1. Open Safari on your iPhone
2. Go to any website (like google.com)
3. Tap the Share button (square with arrow up)
4. Tap "Add Bookmark"
5. Name it: "🛥️ Marketplace Tracker" 
6. Save to Favorites (for easy access)

### Step 3: Edit the Bookmark
1. Open Safari bookmarks (book icon in toolbar)
2. Find "🛥️ Marketplace Tracker" bookmark
3. Tap "Edit"
4. Tap on the bookmark you just created
5. **Delete the current URL completely**
6. **Paste the entire bookmarklet code** (starting with `javascript:`)
7. Tap "Done" → "Done"

## How to Use

### On any marketplace listing:
1. Navigate to a Craigslist, Facebook Marketplace, eBay, or OfferUp listing
2. Tap the bookmarks button
3. Tap "🛥️ Marketplace Tracker"
4. Wait 2-3 seconds
5. You'll see a notification: "✅ Saved to tracker!"
6. Check your Google Sheet - new row should appear

### Supported Sites:
- **Craigslist**: Full extraction (title, price, location, description)
- **Facebook Marketplace**: Title, price, some descriptions  
- **eBay**: Title and price
- **OfferUp**: Title and price
- **Other sites**: Basic title and price detection

### What gets extracted:
- Title of the listing
- Price 
- Location (when available)
- Marketplace name
- Full URL
- Description (when available)
- Timestamp

## Troubleshooting

### "Script not working"
- Make sure you copied the ENTIRE bookmarklet code including `javascript:` at the start
- Try deleting and recreating the bookmark

### "No data found" 
- The page might not be a marketplace listing
- Try refreshing the page and running it again

### "Save failed"
- Check your internet connection
- The form submission might still work (check your Google Sheet)

## How it works
The bookmarklet runs JavaScript directly on the webpage to extract listing information, then submits it to your Google Form using the same field mappings as your desktop extension. It works entirely in Safari without requiring any app installation.
