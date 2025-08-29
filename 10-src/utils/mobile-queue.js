// Missing Information Detector - analyzes listings to suggest questions for sellers
class MissingInfoDetector {
    constructor() {
        this.requiredFields = [
            { field: 'hours', label: 'Engine Hours', critical: true },
            { field: 'year', label: 'Year', critical: true },
            { field: 'condition', label: 'Condition Description', critical: true },
            { field: 'maintenance', label: 'Maintenance History', critical: false },
            { field: 'location', label: 'Location Details', critical: false },
            { field: 'trailer', label: 'Trailer Included', critical: false },
            { field: 'title', label: 'Clear Title', critical: true },
            { field: 'price_history', label: 'Previous Asking Price', critical: false }
        ];
    }

    analyzeListing(listing) {
        const missing = [];
        const questions = [];
        const content = (listing.title + ' ' + (listing.description || '')).toLowerCase();

        this.requiredFields.forEach(field => {
            const hasField = this.checkForField(content, field.field);
            if (!hasField) {
                missing.push(field);
                questions.push(this.generateQuestion(field));
            }
        });

        return {
            missingFields: missing,
            suggestedQuestions: questions,
            completenessScore: ((this.requiredFields.length - missing.length) / this.requiredFields.length * 100).toFixed(0),
            criticalMissing: missing.filter(f => f.critical).length
        };
    }

    checkForField(content, fieldType) {
        const patterns = {
            hours: /(\d+)\s*(hours|hrs|engine hours)/,
            year: /20\d{2}|19\d{2}/,
            condition: /condition|excellent|good|fair|needs work|runs great/,
            maintenance: /maintenance|service|rebuilt|winterized/,
            location: /miles?\s+(away|from)|pick\s*up|delivery/,
            trailer: /trailer|included|separate/,
            title: /title|clean title|clear title/,
            price_history: /was \$|reduced|price drop|obo/
        };
        
        return patterns[fieldType] ? patterns[fieldType].test(content) : false;
    }

    generateQuestion(field) {
        const questions = {
            hours: "How many hours are on the engine?",
            year: "What year is this PWC?",
            condition: "Can you describe the overall condition? Any known issues?",
            maintenance: "What's the maintenance history? When was it last serviced?",
            location: "Where is it located? Can you provide pickup details?",
            trailer: "Is a trailer included? What condition is the trailer in?",
            title: "Do you have a clear title in hand?",
            price_history: "How long has it been for sale? Any flexibility on price?"
        };
        
        return questions[field.field] || `Can you provide more details about ${field.label}?`;
    }
}

// Mobile Processing Queue - handles URL submissions for background processing
class MobileQueue {
    constructor() {
        this.queue = JSON.parse(localStorage.getItem('mobileQueue') || '[]');
        this.detector = new MissingInfoDetector();
    }

    addURL(url, source = 'manual') {
        const id = Date.now().toString();
        const queueItem = {
            id: id,
            url: url,
            source: source,
            status: 'pending',
            addedAt: new Date().toISOString(),
            priority: url.includes('facebook.com/marketplace') ? 'high' : 'normal'
        };
        
        this.queue.push(queueItem);
        this.saveQueue();
        return id;
    }

    getQueue() {
        return this.queue;
    }

    removeItem(id) {
        this.queue = this.queue.filter(item => item.id !== id);
        this.saveQueue();
    }

    updateStatus(id, status, data = null) {
        const item = this.queue.find(q => q.id === id);
        if (item) {
            item.status = status;
            item.processedAt = new Date().toISOString();
            if (data) {
                item.extractedData = data;
                item.missingInfo = this.detector.analyzeListing(data);
            }
        }
        this.saveQueue();
    }

    exportForProcessing() {
        const pendingItems = this.queue.filter(item => item.status === 'pending');
        return {
            items: pendingItems,
            format: 'enhanced_screenshot_collector',
            timestamp: new Date().toISOString()
        };
    }

    saveQueue() {
        localStorage.setItem('mobileQueue', JSON.stringify(this.queue));
    }
}

// Initialize mobile queue
window.mobileQueue = new MobileQueue();
window.missingInfoDetector = new MissingInfoDetector();

// Enhanced URL submission function
function submitURL() {
    const urlInput = document.getElementById('newListingURL');
    if (!urlInput) return;
    
    const url = urlInput.value.trim();
    if (!url) return;

    // Add to mobile queue for processing
    const queueId = window.mobileQueue.addURL(url, 'manual');
    
    // Also add to immediate listings for display
    const newListing = {
        id: Date.now().toString(),
        title: 'Processing...',
        url: url,
        price: 0,
        addedDate: new Date().toISOString().split('T')[0],
        queueId: queueId
    };
    
    listings.push(newListing);
    saveListings();
    updateDisplay();
    
    // Clear input and show success
    urlInput.value = '';
    showNotification(`URL added to processing queue (ID: ${queueId.slice(-4)})`);
}

// Show queue status in Data Sync tab
function showQueueStatus() {
    const queue = window.mobileQueue.getQueue();
    const queueHtml = queue.map(item => `
        <div class="queue-item" style="border: 1px solid #ddd; padding: 10px; margin: 5px 0; background: ${item.status === 'pending' ? '#fff3cd' : '#d4edda'};">
            <div><strong>ID:</strong> ${item.id.slice(-8)}</div>
            <div><strong>URL:</strong> <a href="${item.url}" target="_blank" style="color: #007bff;">${item.url.substring(0, 60)}...</a></div>
            <div><strong>Status:</strong> ${item.status}</div>
            <div><strong>Added:</strong> ${new Date(item.addedAt).toLocaleString()}</div>
            ${item.missingInfo ? `
                <div><strong>Completeness:</strong> ${item.missingInfo.completenessScore}%</div>
                ${item.missingInfo.criticalMissing > 0 ? `<div style="color: #dc3545;"><strong>Critical Missing:</strong> ${item.missingInfo.criticalMissing} fields</div>` : ''}
            ` : ''}
            <button onclick="window.mobileQueue.removeItem('${item.id}'); showQueueStatus();" style="background: #dc3545; color: white; border: none; padding: 5px 10px; cursor: pointer;">Remove</button>
        </div>
    `).join('');
    
    return `
        <div style="max-height: 400px; overflow-y: auto;">
            <h4>Processing Queue (${queue.length} items)</h4>
            ${queue.length === 0 ? '<p>No items in queue</p>' : queueHtml}
            <button onclick="exportQueueForProcessing()" style="background: #28a745; color: white; border: none; padding: 10px 20px; cursor: pointer; margin-top: 10px;">Export Queue for Processing</button>
        </div>
    `;
}

// Export queue for enhanced screenshot processing
function exportQueueForProcessing() {
    const exportData = window.mobileQueue.exportForProcessing();
    const blob = new Blob([JSON.stringify(exportData, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `queue_export_${Date.now()}.json`;
    a.click();
    URL.revokeObjectURL(url);
    showNotification('Queue exported for processing');
}

// Analyze existing listings for missing info
function analyzeAllListings() {
    const analysisResults = listings.map(listing => {
        const analysis = window.missingInfoDetector.analyzeListing(listing);
        return {
            ...listing,
            missingInfo: analysis
        };
    });
    
    // Show analysis summary
    const avgCompleteness = analysisResults.reduce((sum, item) => sum + parseInt(item.missingInfo.completenessScore), 0) / analysisResults.length;
    const criticalIssues = analysisResults.filter(item => item.missingInfo.criticalMissing > 0).length;
    
    showNotification(`Analysis complete: ${avgCompleteness.toFixed(0)}% avg completeness, ${criticalIssues} listings need critical info`);
    
    // Update display with analysis results
    updateDisplay();
    
    return analysisResults;
}

// Utility notification function
function showNotification(message) {
    // Create temporary notification
    const notification = document.createElement('div');
    notification.style.cssText = 'position: fixed; top: 20px; right: 20px; background: #28a745; color: white; padding: 15px; border-radius: 5px; z-index: 1000;';
    notification.textContent = message;
    document.body.appendChild(notification);
    setTimeout(() => document.body.removeChild(notification), 3000);
}
