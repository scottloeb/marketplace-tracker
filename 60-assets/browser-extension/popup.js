// Marketplace Tracker - Popup Script (Simplified)
// Handles the extension popup interface and data management

document.addEventListener('DOMContentLoaded', function() {
    initializePopup();
});

let currentListingData = null;

function initializePopup() {
    console.log('🚀 Popup initialized');
    
    // Set up event listeners first
    setupEventListeners();
    
    // Load configuration with delay to ensure DOM is ready
    setTimeout(() => {
        loadConfiguration();
    }, 100);
    
    // Try to get listing data from content script
    setTimeout(() => {
        getListingDataFromPage();
    }, 200);
}

function setupEventListeners() {
    console.log('Setting up event listeners...');
    
    // Tab switching - only capture and setup tabs now
    const tabButtons = document.querySelectorAll('.tab');
    console.log('Found tab buttons:', tabButtons.length);
    
    tabButtons.forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            const targetTab = this.getAttribute('data-tab');
            console.log('Tab clicked:', targetTab);
            switchTab(targetTab);
        });
    });
    
    // Configuration buttons
    const testBtn = document.getElementById('testConnection');
    if (testBtn) {
        testBtn.addEventListener('click', function(e) {
            e.preventDefault();
            testGoogleFormsConnection();
        });
        console.log('Test connection button listener added');
    }
    
    const saveBtn = document.getElementById('saveConfig');
    if (saveBtn) {
        saveBtn.addEventListener('click', function(e) {
            e.preventDefault();
            saveConfiguration();
        });
        console.log('Save config button listener added');
    }
    
    // Form submission
    const form = document.getElementById('listingForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            saveReviewedData();
        });
        console.log('Form submit listener added');
    }
    
    console.log('✅ Event listeners set up complete');
}

function switchTab(tabName) {
    console.log('Switching to tab:', tabName);
    
    // Hide all tab contents
    const allTabs = document.querySelectorAll('.tab-content');
    allTabs.forEach(tab => {
        tab.classList.remove('active');
        tab.style.display = 'none';
    });
    
    // Show selected tab
    const targetTab = document.getElementById(tabName + '-tab');
    if (targetTab) {
        targetTab.classList.add('active');
        targetTab.style.display = 'block';
        console.log('✅ Switched to tab:', tabName);
    } else {
        console.error('❌ Could not find tab element:', tabName + '-tab');
    }
    
    // Update tab button states
    const allTabBtns = document.querySelectorAll('.tab');
    allTabBtns.forEach(btn => {
        btn.classList.remove('active');
    });
    
    const activeBtn = document.querySelector(`[data-tab="${tabName}"]`);
    if (activeBtn) {
        activeBtn.classList.add('active');
    }
}

function getListingDataFromPage() {
    console.log('📡 Getting listing data from page...');
    
    showLoadingState();
    
    chrome.tabs.query({ active: true, currentWindow: true }, function(tabs) {
        if (tabs[0]) {
            sendMessageWithRetry(tabs[0].id, { action: 'getListingData' }, function(response) {
                console.log('📨 Received response from content script:', response);
                
                if (response && response.success && response.hasData && response.data) {
                    console.log('✅ Got listing data:', response.data);
                    currentListingData = response.data;
                    showDataForm(response.data);
                } else {
                    console.log('⚠️ No listing data available');
                    showNoListing();
                }
            });
        }
    });
}

function showLoadingState() {
    const loading = document.getElementById('loading');
    const formContainer = document.getElementById('form-container');
    const noListing = document.getElementById('no-listing');
    
    if (loading) {
        loading.style.display = 'block';
        loading.innerHTML = '🔍 Scanning page for listing data...';
    }
    if (formContainer) formContainer.style.display = 'none';
    if (noListing) noListing.style.display = 'none';
}

function showDataForm(data) {
    const loading = document.getElementById('loading');
    const formContainer = document.getElementById('form-container');
    const noListing = document.getElementById('no-listing');
    
    if (loading) loading.style.display = 'none';
    if (formContainer) formContainer.style.display = 'block';
    if (noListing) noListing.style.display = 'none';
    
    populateDataForm(data);
}

function showNoListing() {
    const loading = document.getElementById('loading');
    const formContainer = document.getElementById('form-container');
    const noListing = document.getElementById('no-listing');
    
    if (loading) loading.style.display = 'none';
    if (formContainer) formContainer.style.display = 'none';
    if (noListing) noListing.style.display = 'block';
}

function sendMessageWithRetry(tabId, message, callback, maxRetries = 3) {
    let attempts = 0;
    
    function attemptSend() {
        attempts++;
        console.log(`📡 Attempt ${attempts}/${maxRetries} to contact content script...`);
        
        chrome.tabs.sendMessage(tabId, message, function(response) {
            if (chrome.runtime.lastError) {
                console.log(`⚠️ Attempt ${attempts} failed:`, chrome.runtime.lastError.message);
                
                if (attempts < maxRetries) {
                    setTimeout(attemptSend, 500 * attempts);
                } else {
                    console.log('❌ All retry attempts failed');
                    callback({ success: false, error: 'Cannot communicate with content script' });
                }
            } else {
                console.log(`✅ Content script responded on attempt ${attempts}`);
                callback(response);
            }
        });
    }
    
    attemptSend();
}

function populateDataForm(data) {
    console.log('📝 Populating form with data:', data);
    
    const fields = {
        'title': data.title || '',
        'price': data.price || '',
        'location': data.location || '',
        'marketplace': data.marketplace || '',
        'url': data.url || ''
    };
    
    Object.keys(fields).forEach(fieldId => {
        const field = document.getElementById(fieldId);
        if (field) {
            field.value = fields[fieldId];
            console.log(`Set ${fieldId} = ${fields[fieldId]}`);
        } else {
            console.warn(`Field not found: ${fieldId}`);
        }
    });
    
    console.log('✅ Form populated');
}

function saveReviewedData() {
    console.log('📝 Saving reviewed data...');
    
    const reviewedData = {
        title: document.getElementById('title')?.value || '',
        price: parseFloat(document.getElementById('price')?.value || '0') || 0,
        location: document.getElementById('location')?.value || '',
        marketplace: document.getElementById('marketplace')?.value || '',
        url: document.getElementById('url')?.value || '',
        timestamp: new Date().toISOString()
    };
    
    console.log('Reviewed data to save:', reviewedData);
    saveListing(reviewedData);
}

function saveListing(data) {
    console.log('💾 Saving listing to background script:', data);
    
    showStatus('💾 Saving to Google Form...', 'loading');
    
    chrome.runtime.sendMessage({
        action: 'saveListing',
        data: data
    }, function(response) {
        console.log('📨 Background script response:', response);
        
        if (chrome.runtime.lastError) {
            console.error('❌ Runtime error:', chrome.runtime.lastError);
            showStatus('❌ Extension error: ' + chrome.runtime.lastError.message, 'error');
        } else if (response && response.success) {
            showStatus('✅ ' + (response.message || 'Saved to tracker!'), 'success');
        } else {
            showStatus('❌ ' + (response?.error || 'Save failed'), 'error');
        }
    });
}

function testGoogleFormsConnection() {
    console.log('🧪 Testing Google Form connection...');
    
    const formUrl = document.getElementById('formUrl')?.value;
    
    console.log('Config values:', { 
        hasFormUrl: !!formUrl,
        formUrlLength: formUrl?.length 
    });
    
    if (!formUrl) {
        showSetupStatus('❌ Please enter the Google Form URL', 'error');
        return;
    }
    
    if (!formUrl.includes('docs.google.com/forms')) {
        showSetupStatus('❌ Please enter a valid Google Forms URL', 'error');
        return;
    }
    
    showSetupStatus('🔄 Testing connection...', 'loading');
    
    // First save the config, then test
    chrome.runtime.sendMessage({
        action: 'saveConfig',
        formUrl: formUrl
    }, function(saveResponse) {
        console.log('📨 Save config response:', saveResponse);
        
        if (saveResponse && saveResponse.success) {
            // Now test the connection
            chrome.runtime.sendMessage({
                action: 'testConnection'
            }, function(testResponse) {
                console.log('📨 Test connection response:', testResponse);
                
                if (testResponse && testResponse.success) {
                    showSetupStatus('✅ ' + (testResponse.message || 'Connection successful!'), 'success');
                } else {
                    showSetupStatus('❌ ' + (testResponse?.error || 'Connection failed'), 'error');
                }
            });
        } else {
            showSetupStatus('❌ Failed to save configuration', 'error');
        }
    });
}

function saveConfiguration() {
    console.log('💾 Saving configuration...');
    
    const formUrl = document.getElementById('formUrl')?.value;
    
    console.log('Saving config:', { hasFormUrl: !!formUrl });
    
    if (!formUrl) {
        showSetupStatus('❌ Please enter the Google Form URL', 'error');
        return;
    }
    
    if (!formUrl.includes('docs.google.com/forms')) {
        showSetupStatus('❌ Please enter a valid Google Forms URL', 'error');
        return;
    }
    
    showSetupStatus('💾 Saving configuration...', 'loading');
    
    chrome.runtime.sendMessage({
        action: 'saveConfig',
        formUrl: formUrl
    }, function(response) {
        console.log('📨 Save config response:', response);
        
        if (response && response.success) {
            showSetupStatus('✅ Configuration saved!', 'success');
        } else {
            showSetupStatus('❌ Failed to save configuration', 'error');
        }
    });
}

function loadConfiguration() {
    console.log('📁 Loading configuration...');
    
    chrome.storage.sync.get(['formUrl'], function(result) {
        console.log('📨 Loaded from storage:', { hasFormUrl: !!result.formUrl });
        
        if (result.formUrl) {
            const formField = document.getElementById('formUrl');
            if (formField) {
                formField.value = result.formUrl;
                console.log('✅ Loaded Form URL');
            }
        }
        
        console.log('✅ Configuration loading complete');
    });
}

function showStatus(message, type = 'info') {
    console.log(`Status [${type}]: ${message}`);
    
    const statusElement = document.getElementById('status-message');
    
    if (statusElement) {
        statusElement.innerHTML = message;
        statusElement.className = 'status ' + type;
        statusElement.style.display = 'block';
        
        if (type !== 'loading') {
            setTimeout(() => {
                statusElement.style.display = 'none';
            }, 5000);
        }
    }
}

function showSetupStatus(message, type = 'info') {
    console.log(`Setup Status [${type}]: ${message}`);
    
    const statusElement = document.getElementById('setup-status');
    
    if (statusElement) {
        statusElement.innerHTML = message;
        statusElement.className = 'status ' + type;
        statusElement.style.display = 'block';
        
        if (type !== 'loading') {
            setTimeout(() => {
                statusElement.style.display = 'none';
            }, 5000);
        }
    }
}

// Debug: Log when popup is opened
console.log('🚀 Popup script loaded');
