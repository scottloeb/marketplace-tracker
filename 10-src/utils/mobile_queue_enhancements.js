        // Enhanced quickCapture function with processing queue
        function quickCapture() {
            const url = document.getElementById('urlInput').value.trim();
            
            if (!url) {
                showStatus('Please enter a URL', 'error');
                return;
            }
            
            if (!url.includes('facebook.com/marketplace')) {
                showStatus('Please enter a Facebook Marketplace URL', 'error');
                return;
            }
            
            // Create listing with queue status
            const listing = {
                id: Date.now(),
                title: extractTitleFromUrl(url),
                url: url,
                price: 0,
                make: '',
                year: '',
                location: '',
                seller: '',
                source: 'mobile_capture',
                status: 'queued_for_processing',
                addedDate: new Date().toISOString(),
                mobileAdded: true,
                notes: 'Queued for enhanced processing',
                photos: [],
                enhanced: false,
                enhancement_status: 'pending'
            };
            
            listings.push(listing);
            saveListings();
            
            // Add to processing queue
            addToMobileQueue(listing);
            
            // Clear input and update display
            document.getElementById('urlInput').value = '';
            updateDisplay();
            
            showStatus('Added to processing queue', 'success');
        }
        
        function extractTitleFromUrl(url) {
            const match = url.match(/item\/(\d+)/);
            return match ? `Listing ${match[1]}` : 'Facebook Marketplace Listing';
        }
        
        function addToMobileQueue(listing) {
            let queue = JSON.parse(localStorage.getItem('mobile-processing-queue') || '[]');
            
            // Check for duplicates
            const exists = queue.find(item => item.url === listing.url);
            if (exists) return;
            
            queue.push({
                id: listing.id,
                url: listing.url,
                title: listing.title,
                status: 'pending',
                added_date: new Date().toISOString(),
                source: 'mobile'
            });
            
            localStorage.setItem('mobile-processing-queue', JSON.stringify(queue));
            updateQueueDisplay();
        }
        
        function getMobileQueue() {
            return JSON.parse(localStorage.getItem('mobile-processing-queue') || '[]');
        }
        
        function updateQueueDisplay() {
            const queue = getMobileQueue();
            const pendingCount = queue.filter(item => item.status === 'pending').length;
            
            // Update queue status in capture tab
            let queueStatus = document.getElementById('queue-status');
            if (!queueStatus) {
                queueStatus = document.createElement('div');
                queueStatus.id = 'queue-status';
                queueStatus.style.cssText = 'margin-top: 10px; padding: 10px; background: #f0f0f0; border-radius: 8px; text-align: center;';
                document.querySelector('.add-form').appendChild(queueStatus);
            }
            
            queueStatus.innerHTML = pendingCount > 0 
                ? `<strong>${pendingCount}</strong> items queued for enhanced processing`
                : 'Processing queue empty';
        }
        
        function showStatus(message, type) {
            const statusDiv = document.createElement('div');
            statusDiv.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                border-radius: 8px;
                color: white;
                font-weight: bold;
                z-index: 1000;
                ${type === 'success' ? 'background: #28a745;' : 'background: #dc3545;'}
            `;
            statusDiv.textContent = message;
            document.body.appendChild(statusDiv);
            
            setTimeout(() => statusDiv.remove(), 3000);
        }
        
        // Export mobile queue for processing
        function exportMobileQueue() {
            const queue = getMobileQueue();
            const pendingItems = queue.filter(item => item.status === 'pending');
            
            const exportData = {
                export_timestamp: new Date().toISOString(),
                total_pending: pendingItems.length,
                data: pendingItems
            };
            
            const filename = `mobile_queue_${new Date().toISOString().split('T')[0]}.json`;
            downloadJSON(exportData, filename);
        }
        
        function downloadJSON(data, filename) {
            const blob = new Blob([JSON.stringify(data, null, 2)], {type: 'application/json'});
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = filename;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
        }
        
        // Add mobile queue section to Data Sync tab
        function enhanceDataSyncTab() {
            const syncTab = document.getElementById('sync-tab');
            const queueSection = document.createElement('div');
            queueSection.className = 'add-form';
            queueSection.innerHTML = `
                <h3>Mobile Processing Queue</h3>
                <p>URLs submitted from mobile are queued for enhanced processing</p>
                <div style="display: flex; gap: 10px; margin-top: 15px;">
                    <button onclick="exportMobileQueue()" class="btn-success">Export Queue</button>
                    <button onclick="clearProcessedQueue()" class="btn-secondary">Clear Processed</button>
                    <button onclick="showQueueDetails()" class="btn-secondary">View Details</button>
                </div>
                <div id="queue-details" style="display: none; margin-top: 15px;"></div>
            `;
            
            syncTab.insertBefore(queueSection, syncTab.firstChild);
        }
        
        function clearProcessedQueue() {
            let queue = getMobileQueue();
            queue = queue.filter(item => item.status === 'pending');
            localStorage.setItem('mobile-processing-queue', JSON.stringify(queue));
            updateQueueDisplay();
            showStatus('Processed items cleared', 'success');
        }
        
        function showQueueDetails() {
            const queue = getMobileQueue();
            const detailsDiv = document.getElementById('queue-details');
            
            if (detailsDiv.style.display === 'none') {
                detailsDiv.style.display = 'block';
                detailsDiv.innerHTML = `
                    <h4>Queue Status</h4>
                    <div style="max-height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 10px; border-radius: 5px;">
                        ${queue.map(item => `
                            <div style="margin-bottom: 10px; padding: 8px; background: ${item.status === 'pending' ? '#fff3cd' : '#d4edda'}; border-radius: 4px;">
                                <strong>${item.title}</strong><br>
                                <small>Status: ${item.status} | Added: ${new Date(item.added_date).toLocaleString()}</small>
                            </div>
                        `).join('') || '<p>Queue is empty</p>'}
                    </div>
                `;
            } else {
                detailsDiv.style.display = 'none';
            }
        }
        
        // Initialize mobile queue on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateQueueDisplay();
            enhanceDataSyncTab();
        });