// 🌊 Unified Marketplace Tracker - Main Application
// Global variables
let listings = [];
let filteredListings = [];
let charts = {};

// Initialize the application
async function initApp() {
    try {
        // Initialize Supabase client
        if (!initializeSupabase()) {
            console.warn('Supabase library not loaded yet, retrying...');
            setTimeout(initApp, 1000);
            return;
        }
        
        // Initialize Supabase
        await DatabaseService.initRealtimeSubscriptions();
        
        // Load existing listings
        await loadListings();
        
        // Update UI
        updateAllPanels();
        
        console.log('App initialized successfully');
    } catch (error) {
        console.error('Error initializing app:', error);
        showSyncStatus('Error connecting to database', 'error');
    }
}

// Panel navigation
function showPanel(panelName) {
    // Hide all panels
    document.querySelectorAll('.content-panel').forEach(panel => {
        panel.classList.remove('active');
    });
    
    // Remove active class from all tabs
    document.querySelectorAll('.nav-tab').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // Show selected panel
    document.getElementById(panelName + '-panel').classList.add('active');
    
    // Add active class to clicked tab
    event.target.classList.add('active');
    
    // Update panel content
    updatePanelContent(panelName);
}

// Add new listing
async function addListing(event) {
    event.preventDefault();
    
    const url = document.getElementById('listingUrl').value;
    const title = document.getElementById('listingTitle').value;
    const price = parseFloat(document.getElementById('listingPrice').value) || null;
    const location = document.getElementById('listingLocation').value;
    
    const listingData = {
        url: url,
        title: title || null,
        price: price,
        location: location || null,
        status: 'active'
    };
    
    try {
        showSyncStatus('Adding listing...', 'success');
        
        const newListing = await DatabaseService.addListing(listingData);
        
        // Queue for enhancement
        await DatabaseService.queueEnhancement(newListing.id);
        
        // Reset form
        document.getElementById('listingForm').reset();
        
        showSyncStatus('Listing added successfully!', 'success');
        
        // Update listings
        await loadListings();
        
    } catch (error) {
        console.error('Error adding listing:', error);
        showSyncStatus('Error adding listing: ' + error.message, 'error');
    }
}

// Load listings from database
async function loadListings() {
    try {
        listings = await DatabaseService.getListings();
        filteredListings = [...listings];
        updateAllPanels();
    } catch (error) {
        console.error('Error loading listings:', error);
        showSyncStatus('Error loading listings', 'error');
    }
}

// Update all panels
function updateAllPanels() {
    updateListingsPanel();
    updateAnalyticsPanel();
    updateDealsPanel();
    updateExplorerPanel();
}

// Update specific panel content
function updatePanelContent(panelName) {
    switch (panelName) {
        case 'listings':
            updateListingsPanel();
            break;
        case 'analytics':
            updateAnalyticsPanel();
            break;
        case 'deals':
            updateDealsPanel();
            break;
        case 'explorer':
            updateExplorerPanel();
            break;
    }
}

// Update listings panel
function updateListingsPanel() {
    const container = document.getElementById('listingsContainer');
    
    if (listings.length === 0) {
        container.innerHTML = '<div class="loading">No listings found. Add your first listing!</div>';
        return;
    }
    
    const listingsHtml = filteredListings.map(listing => {
        const analysis = listing.market_analysis;
        let cardClass = 'listing-card';
        let statusIcon = '📊';
        
        if (analysis) {
            if (analysis.includes('BUY')) {
                cardClass += ' buy';
                statusIcon = '🔥';
            } else if (analysis.includes('CONSIDER')) {
                cardClass += ' consider';
                statusIcon = '💰';
            } else if (analysis.includes('PASS')) {
                cardClass += ' pass';
                statusIcon = '❌';
            }
        }
        
        return `
            <div class="${cardClass}">
                <div class="listing-title">${listing.title || 'Untitled Listing'}</div>
                <div class="listing-details">
                    <div class="listing-price">$${(listing.price || 0).toLocaleString()}</div>
                    <div class="listing-analysis">
                        ${statusIcon} ${analysis || 'Pending analysis'}
                    </div>
                </div>
                <div style="margin-top: 10px; font-size: 0.9rem; color: #666;">
                    ${listing.location || 'No location'} • ${new Date(listing.created_at).toLocaleDateString()}
                </div>
            </div>
        `;
    }).join('');
    
    container.innerHTML = listingsHtml;
}

// Update analytics panel
function updateAnalyticsPanel() {
    updateStats();
    updateCharts();
    updateMarketInsights();
}

// Update stats
function updateStats() {
    const stats = calculateStats();
    const statsHtml = `
        <div class="stat-card">
            <div class="stat-value">${stats.totalListings}</div>
            <div class="stat-label">Total Listings</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">$${stats.avgPrice.toLocaleString()}</div>
            <div class="stat-label">Average Price</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${stats.buyDeals}</div>
            <div class="stat-label">BUY Deals</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">$${stats.potentialSavings.toLocaleString()}</div>
            <div class="stat-label">Potential Savings</div>
        </div>
    `;
    document.getElementById('statsGrid').innerHTML = statsHtml;
}

// Calculate stats
function calculateStats() {
    const totalListings = listings.length;
    const avgPrice = listings.reduce((sum, item) => sum + (item.price || 0), 0) / totalListings || 0;
    const buyDeals = listings.filter(item => 
        item.market_analysis && item.market_analysis.includes('BUY')
    ).length;
    
    const potentialSavings = listings.reduce((sum, item) => {
        if (item.market_analysis && item.market_analysis.includes('BUY') && item.price) {
            // Simplified calculation - in real app would use MSRP data
            return sum + (item.price * 0.2); // Assume 20% potential savings
        }
        return sum;
    }, 0);

    return { totalListings, avgPrice, buyDeals, potentialSavings };
}

// Update charts
function updateCharts() {
    createPriceChart();
    createMakeChart();
}

// Create price chart
function createPriceChart() {
    const ctx = document.getElementById('priceChart');
    if (!ctx) return;

    if (charts.priceChart) {
        charts.priceChart.destroy();
    }

    const prices = listings.map(item => item.price || 0).filter(price => price > 0);
    const priceRanges = ['$0-5k', '$5k-10k', '$10k-15k', '$15k-20k', '$20k+'];
    const priceData = [
        prices.filter(p => p < 5000).length,
        prices.filter(p => p >= 5000 && p < 10000).length,
        prices.filter(p => p >= 10000 && p < 15000).length,
        prices.filter(p => p >= 15000 && p < 20000).length,
        prices.filter(p => p >= 20000).length
    ];

    charts.priceChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: priceRanges,
            datasets: [{
                label: 'Number of Listings',
                data: priceData,
                backgroundColor: 'rgba(102, 126, 234, 0.8)',
                borderColor: 'rgba(102, 126, 234, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Create make chart
function createMakeChart() {
    const ctx = document.getElementById('makeChart');
    if (!ctx) return;

    if (charts.makeChart) {
        charts.makeChart.destroy();
    }

    const makes = listings.map(item => item.make).filter(Boolean);
    const makeCounts = {};
    makes.forEach(make => {
        makeCounts[make] = (makeCounts[make] || 0) + 1;
    });

    charts.makeChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: Object.keys(makeCounts),
            datasets: [{
                data: Object.values(makeCounts),
                backgroundColor: [
                    'rgba(102, 126, 234, 0.8)',
                    'rgba(118, 75, 162, 0.8)',
                    'rgba(255, 193, 7, 0.8)',
                    'rgba(40, 167, 69, 0.8)',
                    'rgba(220, 53, 69, 0.8)'
                ]
            }]
        },
        options: {
            responsive: true
        }
    });
}

// Update market insights
function updateMarketInsights() {
    const insights = generateInsights();
    const insightsHtml = insights.map(insight => `<li>${insight}</li>`).join('');
    document.getElementById('marketInsights').innerHTML = insightsHtml;
}

// Generate insights
function generateInsights() {
    const insights = [];
    const buyDeals = listings.filter(item => 
        item.market_analysis && item.market_analysis.includes('BUY')
    );

    if (buyDeals.length > 0) {
        insights.push(`🔥 ${buyDeals.length} urgent buying opportunities identified`);
    }

    const makes = [...new Set(listings.map(item => item.make).filter(Boolean))];
    insights.push(`🏍️ ${makes.length} different makes represented`);

    const avgPrice = listings.reduce((sum, item) => sum + (item.price || 0), 0) / listings.length;
    insights.push(`📊 Average listing price: $${avgPrice.toLocaleString()}`);

    return insights;
}

// Update deals panel
function updateDealsPanel() {
    const deals = listings.filter(item => 
        item.market_analysis && (item.market_analysis.includes('BUY') || item.market_analysis.includes('CONSIDER'))
    );

    const dealsHtml = deals.map(deal => {
        const analysis = deal.market_analysis;
        const isUrgent = analysis && analysis.includes('BUY');
        const cardClass = isUrgent ? 'listing-card buy' : 'listing-card consider';
        const icon = isUrgent ? '🔥' : '💰';
        
        return `
            <div class="${cardClass}">
                <div class="listing-title">${icon} ${deal.title || 'Untitled Listing'}</div>
                <div class="listing-details">
                    <div class="listing-price">$${(deal.price || 0).toLocaleString()}</div>
                    <div class="listing-analysis">
                        ${analysis || 'No analysis available'}
                    </div>
                </div>
            </div>
        `;
    }).join('');

    document.getElementById('dealsContainer').innerHTML = dealsHtml || '<p>No deals found. Add listings to see opportunities!</p>';
}

// Update explorer panel
function updateExplorerPanel() {
    const tbody = document.getElementById('explorerTbody');
    const tableHtml = filteredListings.map(item => {
        const analysis = item.market_analysis;
        const recommendation = analysis ? analysis.split(' - ')[0] : 'N/A';
        const valueScore = analysis ? '85' : '0';
        
        let statusIcon = '📊';
        if (analysis && analysis.includes('BUY')) statusIcon = '🔥';
        else if (analysis && analysis.includes('CONSIDER')) statusIcon = '💰';
        else if (analysis && analysis.includes('PASS')) statusIcon = '❌';

        return `
            <tr>
                <td>${item.title || 'Untitled'}</td>
                <td>$${(item.price || 0).toLocaleString()}</td>
                <td>${statusIcon} ${recommendation}</td>
                <td>${valueScore}%</td>
                <td>
                    <a href="${item.url}" target="_blank" style="color: #667eea;">View</a>
                </td>
            </tr>
        `;
    }).join('');

    tbody.innerHTML = tableHtml;
}

// Filter functions
function filterListings() {
    const searchTerm = document.getElementById('searchFilter').value.toLowerCase();
    const statusFilter = document.getElementById('statusFilter').value;

    filteredListings = listings.filter(item => {
        const matchesSearch = !searchTerm || 
            (item.title && item.title.toLowerCase().includes(searchTerm));
        const matchesStatus = statusFilter === 'all' || 
            (statusFilter === 'buy' && item.market_analysis && item.market_analysis.includes('BUY')) ||
            (statusFilter === 'consider' && item.market_analysis && item.market_analysis.includes('CONSIDER')) ||
            (statusFilter === 'pass' && item.market_analysis && item.market_analysis.includes('PASS'));

        return matchesSearch && matchesStatus;
    });

    updateListingsPanel();
}

function filterDeals() {
    // Implement deal filtering
    updateDealsPanel();
}

function filterExplorer() {
    const searchTerm = document.getElementById('explorerSearch').value.toLowerCase();
    const makeFilter = document.getElementById('explorerMakeFilter').value;

    filteredListings = listings.filter(item => {
        const matchesSearch = !searchTerm || 
            (item.title && item.title.toLowerCase().includes(searchTerm));
        const matchesMake = makeFilter === 'all' || item.make === makeFilter;

        return matchesSearch && matchesMake;
    });

    updateExplorerPanel();
}

// Show sync status
function showSyncStatus(message, type) {
    const statusDiv = document.getElementById('syncStatus');
    statusDiv.textContent = message;
    statusDiv.className = `sync-status ${type}`;
    statusDiv.style.display = 'block';
    
    setTimeout(() => {
        statusDiv.style.display = 'none';
    }, 5000);
}

// Initialize app when page loads
window.onload = initApp;
