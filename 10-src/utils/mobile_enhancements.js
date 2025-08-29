        // Enhanced mobile capture with processing queue
        function quickCapture() {
            const url = document.getElementById('urlInput').value.trim();
            
            if (!url) {
                alert('Please enter a URL');
                return;
            }
            
            if (!url.includes('facebook.com/marketplace')) {
                alert('Please enter a Facebook Marketplace URL');
                return;
            }
            
            // Create listing with processing queue status
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
                status: 'processing_queue',
                addedDate: new Date().toISOString(),
                mobileAdded: true,
                notes: 'Added via mobile capture - queued for processing',
                photos: [],
                enhanced: false,
                enhancement_status: 'pending'
            };
            
            listings.push(listing);
            saveListings();
            
            // Clear input
            document.getElementById('urlInput').value = '';
            
            // Update display
            updateStats();
            displayListings();
            
            // Show success message
            showMobileSuccessMessage();
            
            // Add to processing queue for later enhancement
            addToProcessingQueue(listing);
        }
        
        function extractTitleFromUrl(url) {
            // Extract item ID or basic title from Facebook URL
            const match = url.match(/item\/(\d+)/);
            if (match) {
                return `Facebook Listing ${match[1]}`;
            }
            return 'Facebook Marketplace Listing';
        }
        
        function showMobileSuccessMessage() {
            // Create mobile-friendly success notification
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%);
                background: #28a745;
                color: white;
                padding: 15px 25px;
                border-radius: 25px;
                z-index: 1000;
                font-weight: bold;
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
                animation: slideDown 0.3s ease;
            `;
            notification.textContent = 'Added to processing queue!';
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }
        
        function addToProcessingQueue(listing) {
            // Get existing queue
            let queue = JSON.parse(localStorage.getItem('processing-queue') || '[]');
            
            // Add to queue
            queue.push({
                id: listing.id,
                url: listing.url,
                status: 'pending',
                added_date: new Date().toISOString(),
                source: 'mobile'
            });
            
            // Save queue
            localStorage.setItem('processing-queue', JSON.stringify(queue));
            
            // Update queue status in UI
            updateQueueStatus();
        }
        
        function updateQueueStatus() {
            const queue = JSON.parse(localStorage.getItem('processing-queue') || '[]');
            const pendingCount = queue.filter(item => item.status === 'pending').length;
            
            // Update any queue status displays
            const queueElements = document.querySelectorAll('.queue-status');
            queueElements.forEach(el => {
                el.textContent = `${pendingCount} queued for processing`;
            });
        }
        
        function getProcessingQueue() {
            return JSON.parse(localStorage.getItem('processing-queue') || '[]');
        }
        
        function markQueueItemProcessed(itemId) {
            let queue = JSON.parse(localStorage.getItem('processing-queue') || '[]');
            const item = queue.find(q => q.id === itemId);
            if (item) {
                item.status = 'completed';
                item.processed_date = new Date().toISOString();
                localStorage.setItem('processing-queue', JSON.stringify(queue));
                updateQueueStatus();
            }
        }
        
        // Enhanced mobile URL detection and parsing
        function isMobileDevice() {
            return window.innerWidth <= 768 || /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
        }
        
        function optimizeForMobile() {
            if (isMobileDevice()) {
                // Enhance mobile experience
                const urlInput = document.getElementById('urlInput');
                if (urlInput) {
                    urlInput.placeholder = 'Paste Facebook URL here';
                    urlInput.style.fontSize = '16px'; // Prevent zoom on iOS
                }
                
                // Make capture button more prominent on mobile
                const captureTab = document.querySelector('[onclick="showTab(\'capture\')"]');
                if (captureTab && !captureTab.textContent.includes('📱')) {
                    captureTab.innerHTML = '📱 Quick Add';
                }
                
                // Add mobile-specific styling
                const style = document.createElement('style');
                style.textContent = `
                    @media (max-width: 768px) {
                        .add-form h3 {
                            font-size: 1.1rem;
                            margin-bottom: 15px;
                        }
                        
                        .form-row button {
                            width: 100%;
                            margin-top: 10px;
                            padding: 15px;
                            font-size: 16px;
                        }
                        
                        .quick-add-mobile {
                            position: sticky;
                            top: 0;
                            background: rgba(255,255,255,0.95);
                            backdrop-filter: blur(10px);
                            margin: -20px -20px 20px -20px;
                            padding: 20px;
                            border-radius: 0 0 15px 15px;
                        }
                        
                        .mobile-success {
                            animation: slideDown 0.3s ease;
                        }
                        
                        @keyframes slideDown {
                            from { transform: translateX(-50%) translateY(-20px); opacity: 0; }
                            to { transform: translateX(-50%) translateY(0); opacity: 1; }
                        }
                    }
                `;
                document.head.appendChild(style);
            }
        }
        
        // Initialize mobile optimizations
        document.addEventListener('DOMContentLoaded', () => {
            optimizeForMobile();
            updateQueueStatus();
        });
        
        // Enhanced paste detection for mobile
        document.addEventListener('paste', (e) => {
            const pastedText = (e.clipboardData || window.clipboardData).getData('text');
            
            if (pastedText.includes('facebook.com/marketplace')) {
                const urlInput = document.getElementById('urlInput');
                if (urlInput && document.activeElement === urlInput) {
                    // Auto-process after paste
                    setTimeout(() => {
                        if (urlInput.value.includes('facebook.com/marketplace')) {
                            // Show quick capture button highlight
                            const captureBtn = urlInput.parentElement.nextElementSibling;
                            if (captureBtn && captureBtn.tagName === 'BUTTON') {
                                captureBtn.style.animation = 'pulse 1s';
                                captureBtn.style.transform = 'scale(1.05)';
                                setTimeout(() => {
                                    captureBtn.style.animation = '';
                                    captureBtn.style.transform = '';
                                }, 1000);
                            }
                        }
                    }, 100);
                }
            }
        });
        
        // Add pulse animation for mobile feedback
        const pulseStyle = document.createElement('style');
        pulseStyle.textContent = `
            @keyframes pulse {
                0% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.7); }
                70% { box-shadow: 0 0 0 10px rgba(102, 126, 234, 0); }
                100% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0); }
            }
        `;
        document.head.appendChild(pulseStyle);