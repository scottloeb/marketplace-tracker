#!/usr/bin/env python3
"""
Mobile Integration Server
Handles URL submissions from phone and queues them for processing
"""

import json
import os
from datetime import datetime
from flask import Flask, request, jsonify, render_template_string
import threading
import asyncio
import subprocess

app = Flask(__name__)

# Mobile landing page HTML
MOBILE_LANDING_PAGE = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Add Listing - Marketplace Tracker</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container { 
            max-width: 400px; 
            margin: 0 auto; 
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        .header { text-align: center; margin-bottom: 30px; }
        .emoji { font-size: 48px; margin-bottom: 10px; }
        h1 { color: #333; font-size: 24px; margin-bottom: 10px; }
        .subtitle { color: #666; font-size: 16px; }
        
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #333; font-weight: 500; }
        
        input[type="url"] { 
            width: 100%; 
            padding: 16px; 
            border: 2px solid #e1e5e9; 
            border-radius: 12px; 
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        input[type="url"]:focus { 
            outline: none; 
            border-color: #667eea; 
        }
        
        .btn-primary { 
            width: 100%; 
            padding: 16px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            color: white; 
            border: none; 
            border-radius: 12px; 
            font-size: 16px; 
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        .btn-primary:hover { transform: translateY(-2px); }
        .btn-primary:disabled { 
            opacity: 0.6; 
            transform: none; 
            cursor: not-allowed; 
        }
        
        .status { 
            padding: 16px; 
            border-radius: 12px; 
            margin-top: 20px; 
            font-weight: 500;
            text-align: center;
        }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
        .loading { background: #fff3cd; color: #856404; }
        
        .how-it-works {
            margin-top: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
        }
        .how-it-works h3 { color: #333; margin-bottom: 15px; font-size: 18px; }
        .step { 
            display: flex; 
            align-items: center; 
            margin-bottom: 12px;
            font-size: 14px;
            color: #666;
        }
        .step-number { 
            background: #667eea; 
            color: white; 
            width: 24px; 
            height: 24px; 
            border-radius: 50%; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            margin-right: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .stats { 
            margin-top: 20px; 
            text-align: center; 
            color: #666; 
            font-size: 14px; 
        }
        
        @media (max-width: 480px) {
            .container { margin: 10px; padding: 20px; }
            .emoji { font-size: 40px; }
            h1 { font-size: 20px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="emoji">🏍️</div>
            <h1>Add Listing</h1>
            <div class="subtitle">Marketplace Tracker</div>
        </div>
        
        <form onsubmit="addListing(event)">
            <div class="form-group">
                <label for="url">Facebook Marketplace URL</label>
                <input type="url" 
                       id="url" 
                       placeholder="https://www.facebook.com/marketplace/item/..." 
                       required>
            </div>
            
            <button type="submit" class="btn-primary" id="submitBtn">
                Add to Queue
            </button>
        </form>
        
        <div id="status"></div>
        
        <div class="how-it-works">
            <h3>How it works:</h3>
            <div class="step">
                <div class="step-number">1</div>
                Share URL from your phone
            </div>
            <div class="step">
                <div class="step-number">2</div>
                Automatic screenshot & data extraction
            </div>
            <div class="step">
                <div class="step-number">3</div>
                Market analysis & pricing
            </div>
            <div class="step">
                <div class="step-number">4</div>
                Real-time sync across devices
            </div>
        </div>
        
        <div class="stats">
            <div>Queue Status: <span id="queueCount">0</span> pending</div>
        </div>
    </div>
    
    <script>
        // Load queue status on page load
        loadQueueStatus();
        
        async function addListing(event) {
            event.preventDefault();
            
            const url = document.getElementById('url').value;
            const status = document.getElementById('status');
            const submitBtn = document.getElementById('submitBtn');
            
            // Validate Facebook Marketplace URL
            if (!url.includes('facebook.com/marketplace')) {
                status.innerHTML = '<div class="status error">Please enter a Facebook Marketplace URL</div>';
                return;
            }
            
            // Show loading state
            submitBtn.disabled = true;
            submitBtn.textContent = 'Adding...';
            status.innerHTML = '<div class="status loading">Adding to processing queue...</div>';
            
            try {
                const response = await fetch('/api/add-listing', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ 
                        url: url, 
                        source: 'mobile',
                        timestamp: new Date().toISOString()
                    })
                });
                
                const result = await response.json();
                
                if (response.ok) {
                    status.innerHTML = '<div class="status success">✅ Added to processing queue! Processing will begin shortly.</div>';
                    document.getElementById('url').value = '';
                    loadQueueStatus(); // Refresh queue count
                } else {
                    throw new Error(result.error || 'Failed to add listing');
                }
            } catch (error) {
                status.innerHTML = '<div class="status error">❌ Failed to add listing. Please try again.</div>';
                console.error('Error:', error);
            } finally {
                submitBtn.disabled = false;
                submitBtn.textContent = 'Add to Queue';
            }
        }
        
        async function loadQueueStatus() {
            try {
                const response = await fetch('/api/queue-status');
                const data = await response.json();
                document.getElementById('queueCount').textContent = data.pending_count || 0;
            } catch (error) {
                console.error('Failed to load queue status:', error);
            }
        }
        
        // Refresh queue status every 30 seconds
        setInterval(loadQueueStatus, 30000);
    </script>
</body>
</html>
"""

class MobileQueue:
    def __init__(self):
        self.queue_file = 'mobile_processing_queue.json'
        
    def load_queue(self):
        try:
            with open(self.queue_file, 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            return []
    
    def save_queue(self, queue_data):
        with open(self.queue_file, 'w') as f:
            json.dump(queue_data, f, indent=2)
    
    def add_to_queue(self, url, source='mobile'):
        queue_data = self.load_queue()
        
        # Check for duplicates
        for item in queue_data:
            if item['url'] == url and item['status'] != 'failed':
                return {'success': False, 'error': 'URL already in queue'}
        
        new_item = {
            'id': int(datetime.now().timestamp() * 1000),
            'url': url,
            'source': source,
            'status': 'pending',
            'added_date': datetime.now().isoformat(),
            'processing_attempts': 0
        }
        
        queue_data.append(new_item)
        self.save_queue(queue_data)
        
        return {'success': True, 'id': new_item['id']}
    
    def get_queue_status(self):
        queue_data = self.load_queue()
        
        status_counts = {}
        for item in queue_data:
            status = item['status']
            status_counts[status] = status_counts.get(status, 0) + 1
        
        return {
            'total': len(queue_data),
            'pending_count': status_counts.get('pending', 0),
            'processing_count': status_counts.get('processing', 0),
            'completed_count': status_counts.get('completed', 0),
            'failed_count': status_counts.get('failed', 0),
            'recent_items': queue_data[-5:]  # Last 5 items
        }

# Initialize queue manager
mobile_queue = MobileQueue()

@app.route('/')
def mobile_landing():
    """Mobile-friendly landing page"""
    return MOBILE_LANDING_PAGE

@app.route('/api/add-listing', methods=['POST'])
def add_listing():
    """Add URL to processing queue"""
    try:
        data = request.json
        url = data.get('url')
        source = data.get('source', 'mobile')
        
        if not url:
            return jsonify({'error': 'URL is required'}), 400
        
        if 'facebook.com/marketplace' not in url:
            return jsonify({'error': 'Must be a Facebook Marketplace URL'}), 400
        
        result = mobile_queue.add_to_queue(url, source)
        
        if result['success']:
            # Trigger background processing (optional)
            threading.Thread(target=trigger_processing, daemon=True).start()
            
            return jsonify({
                'success': True, 
                'id': result['id'],
                'message': 'Added to processing queue'
            })
        else:
            return jsonify({'error': result['error']}), 400
            
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/queue-status')
def queue_status():
    """Get current queue status"""
    try:
        status = mobile_queue.get_queue_status()
        return jsonify(status)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/process-queue', methods=['POST'])
def process_queue():
    """Manual trigger for queue processing"""
    try:
        # This could trigger the enhanced screenshot collector
        # For now, just return success
        return jsonify({'success': True, 'message': 'Queue processing triggered'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

def trigger_processing():
    """Background processing trigger"""
    # This would run the enhanced screenshot collector on queued items
    # Implementation depends on your preferred workflow
    pass

if __name__ == '__main__':
    print("🚀 Starting Mobile Integration Server...")
    print("📱 Mobile interface: http://localhost:5000")
    print("🔄 Processing queue: http://localhost:5000/api/queue-status")
    
    # Create initial queue file if it doesn't exist
    if not os.path.exists('mobile_processing_queue.json'):
        with open('mobile_processing_queue.json', 'w') as f:
            json.dump([], f)
    
    app.run(debug=True, host='0.0.0.0', port=5000)
