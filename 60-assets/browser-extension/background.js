// Marketplace Tracker - Background Script with Correct Field Mapping
console.log('🚀 Marketplace Tracker background script starting');

class GoogleFormsAPI {
  constructor() {
    this.formUrl = null;
    this.submitUrl = null;
    this.offlineQueue = [];
    this.isProcessing = false;
    
    // Your actual Google Form field mappings
    this.fieldMapping = {
      title: 'entry.1881962373',       // Field 1: Title
      price: 'entry.1877802964',       // Field 2: Price  
      location: 'entry.834272314',     // Field 3: Location
      marketplace: 'entry.131515250',  // Field 4: Marketplace
      url: 'entry.956587300',          // Field 5: URL
      description: 'entry.1652758391'  // Field 6: Description
    };
    
    // Load configuration on startup
    this.loadConfig();
  }
  
  async loadConfig() {
    try {
      const result = await chrome.storage.sync.get(['formUrl']);
      this.formUrl = result.formUrl;
      
      // Convert viewform URL to formResponse URL for submission
      if (this.formUrl) {
        this.submitUrl = this.formUrl.replace('/viewform', '/formResponse');
        console.log('📋 Config loaded - Submit URL:', this.submitUrl);
      }
      
      if (!this.formUrl) {
        console.warn('⚠️ Google Form not configured');
      }
      
      // Load offline queue
      const queueResult = await chrome.storage.local.get(['offlineQueue']);
      this.offlineQueue = queueResult.offlineQueue || [];
      
      if (this.offlineQueue.length > 0) {
        console.log(`📤 Found ${this.offlineQueue.length} items in offline queue`);
      }
      
    } catch (error) {
      console.error('❌ Failed to load configuration:', error);
    }
  }
  
  async saveConfig(formUrl) {
    console.log('💾 Saving configuration:', formUrl);
    
    this.formUrl = formUrl;
    this.submitUrl = formUrl.replace('/viewform', '/formResponse');
    
    await chrome.storage.sync.set({
      formUrl: formUrl
    });
    
    console.log('✅ Configuration saved');
  }
  
  async saveListing(listingData) {
    console.log('💾 Saving listing:', listingData);
    
    if (!this.submitUrl) {
      console.warn('⚠️ Google Form not configured');
      return {
        success: false,
        error: 'Google Form not configured. Click extension icon to set up.'
      };
    }
    
    try {
      // Create form data with correct field mapping
      const formData = new FormData();
      
      // Map listing data to your specific form fields
      if (listingData.title) {
        formData.append(this.fieldMapping.title, listingData.title);
        console.log(`📝 Adding title: ${listingData.title}`);
      }
      
      if (listingData.price) {
        formData.append(this.fieldMapping.price, listingData.price.toString());
        console.log(`💰 Adding price: ${listingData.price}`);
      }
      
      if (listingData.location) {
        formData.append(this.fieldMapping.location, listingData.location);
        console.log(`📍 Adding location: ${listingData.location}`);
      }
      
      if (listingData.marketplace) {
        formData.append(this.fieldMapping.marketplace, listingData.marketplace);
        console.log(`🏪 Adding marketplace: ${listingData.marketplace}`);
      }
      
      if (listingData.url) {
        formData.append(this.fieldMapping.url, listingData.url);
        console.log(`🔗 Adding URL: ${listingData.url}`);
      }
      
      if (listingData.description) {
        const description = listingData.description.length > 500 ? 
          listingData.description.substring(0, 500) + '...' : 
          listingData.description;
        formData.append(this.fieldMapping.description, description);
        console.log(`📄 Adding description: ${description.substring(0, 100)}...`);
      }
      
      console.log('📊 Submitting to Google Form:', this.submitUrl);
      
      const success = await this.submitToForm(formData);
      
      if (success) {
        console.log('✅ Successfully saved to Google Form');
        return {
          success: true,
          message: 'Saved to your marketplace tracker!'
        };
      } else {
        // Add to offline queue for retry
        await this.addToOfflineQueue(listingData);
        return {
          success: false,
          error: 'Form submission may have failed - check your Google Form for new entries'
        };
      }
      
    } catch (error) {
      console.error('❌ Save failed:', error);
      
      // Add to offline queue
      await this.addToOfflineQueue(listingData);
      
      return {
        success: false,
        error: 'Save failed: ' + error.message
      };
    }
  }
  
  async submitToForm(formData) {
    try {
      const response = await fetch(this.submitUrl, {
        method: 'POST',
        body: formData,
        mode: 'no-cors' // Google Forms requires this
      });
      
      // With no-cors, we can't read the response, but if no error is thrown, it likely succeeded
      console.log('✅ Form submission completed (no-cors mode)');
      return true;
      
    } catch (error) {
      console.error('❌ Form submission error:', error);
      throw error;
    }
  }
  
  async addToOfflineQueue(listingData) {
    this.offlineQueue.push({
      data: listingData,
      timestamp: new Date().toISOString(),
      retries: 0
    });
    
    await chrome.storage.local.set({ offlineQueue: this.offlineQueue });
    console.log('📝 Added to offline queue. Items queued:', this.offlineQueue.length);
  }
  
  async testConnection() {
    console.log('🔍 Testing connection...');
    
    if (!this.submitUrl) {
      return { success: false, error: 'Form URL not configured' };
    }
    
    try {
      // Test with dummy data using correct field names
      const testData = new FormData();
      
      testData.append(this.fieldMapping.title, 'Test Connection - Marketplace Tracker Extension');
      testData.append(this.fieldMapping.price, '999');
      testData.append(this.fieldMapping.location, 'Test Location');
      testData.append(this.fieldMapping.marketplace, 'test');
      testData.append(this.fieldMapping.url, 'https://test-connection.com');
      testData.append(this.fieldMapping.description, 'This is a test submission from the Marketplace Tracker extension to verify connectivity with the correct field mapping.');
      
      await this.submitToForm(testData);
      
      console.log('✅ Connection test completed');
      return { 
        success: true, 
        message: 'Test submitted with correct field mapping! Check your Google Sheet for the test entry.' 
      };
      
    } catch (error) {
      console.error('❌ Connection test failed:', error);
      return { 
        success: false, 
        error: 'Connection test failed: ' + error.message 
      };
    }
  }
  
  getQueueStatus() {
    return {
      queueLength: this.offlineQueue.length,
      configured: !!this.formUrl,
      processing: this.isProcessing
    };
  }
}

// Initialize API
console.log('🔧 Initializing Google Forms API with correct field mapping');
const formsAPI = new GoogleFormsAPI();

// Handle messages from content script and popup
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  console.log('📨 Message received:', request.action, request);
  
  const handleAsync = async () => {
    try {
      switch (request.action) {
        case 'saveListing':
          const saveResult = await formsAPI.saveListing(request.data);
          console.log('💾 Save result:', saveResult);
          return saveResult;
          
        case 'saveConfig':
          await formsAPI.saveConfig(request.formUrl);
          return { success: true };
          
        case 'testConnection':
          const testResult = await formsAPI.testConnection();
          console.log('🔍 Test result:', testResult);
          return testResult;
          
        case 'getQueueStatus':
          const status = formsAPI.getQueueStatus();
          console.log('📊 Queue status:', status);
          return status;
          
        default:
          console.warn('⚠️ Unknown action:', request.action);
          return { success: false, error: 'Unknown action' };
      }
    } catch (error) {
      console.error('❌ Message handler error:', error);
      return { success: false, error: error.message };
    }
  };
  
  // Handle async operations
  handleAsync().then(result => {
    console.log('📤 Sending response:', result);
    sendResponse(result);
  }).catch(error => {
    console.error('❌ Handler error:', error);
    sendResponse({ success: false, error: error.message });
  });
  
  return true; // Keep message channel open for async response
});

console.log('✅ Background script initialized with correct field mapping');
