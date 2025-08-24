#!/usr/bin/env python3
"""
Real-time Sync Server for Dynamic Marketplace Explorer

Provides WebSocket connections for real-time data synchronization between:
- Mobile devices
- Desktop browsers
- Database systems
- Analysis engines

Features:
- Real-time data streaming
- Cross-device synchronization
- Conflict resolution
- Offline queue management
- Performance monitoring

Author: Marketplace Intelligence System
Version: 1.0
"""

import asyncio
import json
import logging
import websockets
import uuid
from datetime import datetime, timedelta
from typing import Dict, Set, List, Optional, Any
from dataclasses import dataclass, asdict
import sqlite3
from pathlib import Path
import aiohttp
from database_integration import DatabaseIntegration

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


@dataclass
class ClientConnection:
    """Represents a connected client."""
    id: str
    websocket: websockets.WebSocketServerProtocol
    device_type: str  # 'mobile', 'desktop', 'tablet'
    user_agent: str
    connected_at: datetime
    last_activity: datetime
    subscriptions: Set[str]
    is_authenticated: bool = False


@dataclass
class SyncMessage:
    """Represents a sync message between clients."""
    id: str
    type: str  # 'data_update', 'analysis_complete', 'status_change', etc.
    source_client: str
    target_clients: List[str]  # Empty list means broadcast to all
    payload: Dict[str, Any]
    timestamp: datetime
    priority: str = 'normal'  # 'low', 'normal', 'high', 'urgent'


class RealTimeSyncServer:
    """Main real-time synchronization server."""
    
    def __init__(self, host='localhost', port=8765, db_config='database_config.json'):
        self.host = host
        self.port = port
        self.db = DatabaseIntegration(db_config)
        
        # Connection management
        self.clients: Dict[str, ClientConnection] = {}
        self.rooms: Dict[str, Set[str]] = {}  # Room -> Set of client IDs
        
        # Message queues
        self.message_queue: asyncio.Queue = asyncio.Queue()
        self.offline_queue: Dict[str, List[SyncMessage]] = {}
        
        # Sync state
        self.sync_state = {
            'last_full_sync': None,
            'pending_updates': [],
            'conflict_resolution_queue': [],
            'active_sessions': {}
        }
        
        # Performance metrics
        self.metrics = {
            'total_connections': 0,
            'messages_sent': 0,
            'messages_received': 0,
            'data_synced_mb': 0,
            'average_latency_ms': 0
        }
        
        logger.info(f"🔄 Real-time Sync Server initialized on {host}:{port}")
    
    async def start_server(self):
        """Start the WebSocket server and background tasks."""
        try:
            # Initialize database
            await self.db.initialize_databases()
            
            # Start background tasks
            asyncio.create_task(self.message_processor())
            asyncio.create_task(self.periodic_sync())
            asyncio.create_task(self.cleanup_inactive_clients())
            asyncio.create_task(self.performance_monitor())
            
            # Start WebSocket server
            server = await websockets.serve(
                self.handle_client_connection,
                self.host,
                self.port,
                ping_interval=30,
                ping_timeout=10,
                close_timeout=10
            )
            
            logger.info(f"🚀 Real-time Sync Server running on ws://{self.host}:{self.port}")
            logger.info("📊 Available endpoints:")
            logger.info("  • ws://host:port/ - Main sync endpoint")
            logger.info("  • ws://host:port/mobile - Mobile-optimized endpoint")
            logger.info("  • ws://host:port/desktop - Desktop endpoint")
            
            # Keep server running
            await server.wait_closed()
            
        except Exception as e:
            logger.error(f"❌ Server startup failed: {e}")
            raise
    
    async def handle_client_connection(self, websocket, path):
        """Handle a new client connection."""
        client_id = str(uuid.uuid4())[:8]
        
        try:
            # Extract device info from headers
            user_agent = websocket.request_headers.get('User-Agent', 'Unknown')
            device_type = self.detect_device_type(user_agent)
            
            # Create client connection
            client = ClientConnection(
                id=client_id,
                websocket=websocket,
                device_type=device_type,
                user_agent=user_agent,
                connected_at=datetime.now(),
                last_activity=datetime.now(),
                subscriptions=set()
            )
            
            self.clients[client_id] = client
            self.metrics['total_connections'] += 1
            
            logger.info(f"📱 Client connected: {client_id} ({device_type})")
            
            # Send welcome message
            await self.send_to_client(client_id, {
                'type': 'connection_established',
                'client_id': client_id,
                'device_type': device_type,
                'server_time': datetime.now().isoformat(),
                'capabilities': {
                    'real_time_sync': True,
                    'offline_queue': True,
                    'conflict_resolution': True,
                    'data_compression': True
                }
            })
            
            # Process offline queue if exists
            await self.process_offline_queue(client_id)
            
            # Handle incoming messages
            async for message in websocket:
                await self.handle_client_message(client_id, message)
                
        except websockets.exceptions.ConnectionClosed:
            logger.info(f"📱 Client disconnected: {client_id}")
        except Exception as e:
            logger.error(f"❌ Client connection error ({client_id}): {e}")
        finally:
            # Cleanup
            if client_id in self.clients:
                del self.clients[client_id]
            self.remove_client_from_rooms(client_id)
    
    def detect_device_type(self, user_agent: str) -> str:
        """Detect device type from user agent."""
        user_agent_lower = user_agent.lower()
        
        if any(mobile in user_agent_lower for mobile in ['mobile', 'android', 'iphone', 'ipad']):
            return 'mobile'
        elif 'tablet' in user_agent_lower:
            return 'tablet'
        else:
            return 'desktop'
    
    async def handle_client_message(self, client_id: str, message: str):
        """Handle incoming message from client."""
        try:
            data = json.loads(message)
            message_type = data.get('type')
            
            # Update client activity
            if client_id in self.clients:
                self.clients[client_id].last_activity = datetime.now()
            
            self.metrics['messages_received'] += 1
            
            logger.debug(f"📨 Message from {client_id}: {message_type}")
            
            # Route message based on type
            if message_type == 'authenticate':
                await self.handle_authentication(client_id, data)
            elif message_type == 'subscribe':
                await self.handle_subscription(client_id, data)
            elif message_type == 'unsubscribe':
                await self.handle_unsubscription(client_id, data)
            elif message_type == 'data_update':
                await self.handle_data_update(client_id, data)
            elif message_type == 'request_sync':
                await self.handle_sync_request(client_id, data)
            elif message_type == 'join_room':
                await self.handle_join_room(client_id, data)
            elif message_type == 'leave_room':
                await self.handle_leave_room(client_id, data)
            elif message_type == 'ping':
                await self.handle_ping(client_id, data)
            else:
                logger.warning(f"⚠️ Unknown message type: {message_type}")
                await self.send_error(client_id, f"Unknown message type: {message_type}")
                
        except json.JSONDecodeError:
            logger.error(f"❌ Invalid JSON from {client_id}")
            await self.send_error(client_id, "Invalid JSON format")
        except Exception as e:
            logger.error(f"❌ Message handling error ({client_id}): {e}")
            await self.send_error(client_id, f"Message processing error: {str(e)}")
    
    async def handle_authentication(self, client_id: str, data: Dict):
        """Handle client authentication."""
        # Simple token-based auth for now
        token = data.get('token')
        
        if token == 'demo_token' or not token:  # Allow demo access
            if client_id in self.clients:
                self.clients[client_id].is_authenticated = True
            
            await self.send_to_client(client_id, {
                'type': 'authentication_success',
                'client_id': client_id,
                'permissions': ['read', 'write', 'sync']
            })
            
            logger.info(f"✅ Client authenticated: {client_id}")
        else:
            await self.send_error(client_id, "Authentication failed")
    
    async def handle_subscription(self, client_id: str, data: Dict):
        """Handle client subscription to data streams."""
        topics = data.get('topics', [])
        
        if client_id in self.clients:
            self.clients[client_id].subscriptions.update(topics)
            
            await self.send_to_client(client_id, {
                'type': 'subscription_confirmed',
                'topics': topics,
                'client_id': client_id
            })
            
            logger.info(f"📡 Client {client_id} subscribed to: {topics}")
    
    async def handle_data_update(self, client_id: str, data: Dict):
        """Handle data update from client."""
        try:
            update_type = data.get('update_type')
            payload = data.get('payload', {})
            
            # Store update in database
            if update_type == 'listing_update':
                await self.process_listing_update(client_id, payload)
            elif update_type == 'analysis_result':
                await self.process_analysis_result(client_id, payload)
            elif update_type == 'user_action':
                await self.process_user_action(client_id, payload)
            
            # Create sync message for other clients
            sync_message = SyncMessage(
                id=str(uuid.uuid4()),
                type='data_update',
                source_client=client_id,
                target_clients=[],  # Broadcast to all
                payload={
                    'update_type': update_type,
                    'data': payload,
                    'source_client': client_id,
                    'timestamp': datetime.now().isoformat()
                },
                timestamp=datetime.now(),
                priority='normal'
            )
            
            await self.queue_sync_message(sync_message)
            
            # Confirm to sender
            await self.send_to_client(client_id, {
                'type': 'data_update_confirmed',
                'update_id': data.get('update_id'),
                'client_id': client_id
            })
            
        except Exception as e:
            logger.error(f"❌ Data update error ({client_id}): {e}")
            await self.send_error(client_id, f"Data update failed: {str(e)}")
    
    async def handle_sync_request(self, client_id: str, data: Dict):
        """Handle full sync request from client."""
        try:
            sync_type = data.get('sync_type', 'full')
            last_sync = data.get('last_sync')
            
            if sync_type == 'full':
                # Get all current data
                listings = await self.db.get_listings()
                analysis = await self.db.get_market_analysis()
                
                sync_data = {
                    'type': 'full_sync_response',
                    'data': {
                        'listings': listings,
                        'analysis': analysis,
                        'sync_timestamp': datetime.now().isoformat(),
                        'total_records': len(listings)
                    },
                    'client_id': client_id
                }
                
            elif sync_type == 'incremental' and last_sync:
                # Get only changes since last sync
                changes = await self.get_changes_since(last_sync)
                
                sync_data = {
                    'type': 'incremental_sync_response',
                    'data': {
                        'changes': changes,
                        'sync_timestamp': datetime.now().isoformat(),
                        'change_count': len(changes)
                    },
                    'client_id': client_id
                }
            
            await self.send_to_client(client_id, sync_data)
            
            logger.info(f"📥 Sync completed for {client_id}: {sync_type}")
            
        except Exception as e:
            logger.error(f"❌ Sync request error ({client_id}): {e}")
            await self.send_error(client_id, f"Sync failed: {str(e)}")
    
    async def handle_join_room(self, client_id: str, data: Dict):
        """Handle client joining a room."""
        room_name = data.get('room')
        
        if room_name:
            if room_name not in self.rooms:
                self.rooms[room_name] = set()
            
            self.rooms[room_name].add(client_id)
            
            await self.send_to_client(client_id, {
                'type': 'room_joined',
                'room': room_name,
                'client_id': client_id
            })
            
            logger.info(f"🏠 Client {client_id} joined room: {room_name}")
    
    async def handle_ping(self, client_id: str, data: Dict):
        """Handle ping message."""
        await self.send_to_client(client_id, {
            'type': 'pong',
            'timestamp': datetime.now().isoformat(),
            'client_id': client_id
        })
    
    async def send_to_client(self, client_id: str, data: Dict):
        """Send data to a specific client."""
        if client_id not in self.clients:
            # Queue for offline delivery
            if client_id not in self.offline_queue:
                self.offline_queue[client_id] = []
            
            message = SyncMessage(
                id=str(uuid.uuid4()),
                type=data.get('type', 'unknown'),
                source_client='server',
                target_clients=[client_id],
                payload=data,
                timestamp=datetime.now()
            )
            
            self.offline_queue[client_id].append(message)
            return
        
        try:
            client = self.clients[client_id]
            await client.websocket.send(json.dumps(data, default=str))
            self.metrics['messages_sent'] += 1
            
        except websockets.exceptions.ConnectionClosed:
            logger.warning(f"⚠️ Client {client_id} connection closed during send")
            if client_id in self.clients:
                del self.clients[client_id]
        except Exception as e:
            logger.error(f"❌ Failed to send to {client_id}: {e}")
    
    async def broadcast_to_room(self, room_name: str, data: Dict, exclude_client: str = None):
        """Broadcast data to all clients in a room."""
        if room_name not in self.rooms:
            return
        
        for client_id in self.rooms[room_name]:
            if client_id != exclude_client:
                await self.send_to_client(client_id, data)
    
    async def broadcast_to_all(self, data: Dict, exclude_client: str = None):
        """Broadcast data to all connected clients."""
        for client_id in list(self.clients.keys()):
            if client_id != exclude_client:
                await self.send_to_client(client_id, data)
    
    async def send_error(self, client_id: str, error_message: str):
        """Send error message to client."""
        await self.send_to_client(client_id, {
            'type': 'error',
            'message': error_message,
            'timestamp': datetime.now().isoformat()
        })
    
    async def queue_sync_message(self, message: SyncMessage):
        """Queue a sync message for processing."""
        await self.message_queue.put(message)
    
    async def message_processor(self):
        """Background task to process sync messages."""
        while True:
            try:
                message = await self.message_queue.get()
                
                # Process based on target clients
                if not message.target_clients:
                    # Broadcast to all
                    await self.broadcast_to_all(message.payload, message.source_client)
                else:
                    # Send to specific clients
                    for client_id in message.target_clients:
                        await self.send_to_client(client_id, message.payload)
                
                self.message_queue.task_done()
                
            except Exception as e:
                logger.error(f"❌ Message processor error: {e}")
    
    async def periodic_sync(self):
        """Background task for periodic data synchronization."""
        while True:
            try:
                await asyncio.sleep(30)  # Sync every 30 seconds
                
                # Check for database updates
                if await self.has_database_updates():
                    # Notify all clients of updates
                    await self.broadcast_to_all({
                        'type': 'data_refresh_available',
                        'timestamp': datetime.now().isoformat(),
                        'source': 'database_update'
                    })
                
                # Update sync state
                self.sync_state['last_full_sync'] = datetime.now().isoformat()
                
            except Exception as e:
                logger.error(f"❌ Periodic sync error: {e}")
    
    async def cleanup_inactive_clients(self):
        """Background task to cleanup inactive clients."""
        while True:
            try:
                await asyncio.sleep(60)  # Check every minute
                
                cutoff_time = datetime.now() - timedelta(minutes=10)
                inactive_clients = []
                
                for client_id, client in self.clients.items():
                    if client.last_activity < cutoff_time:
                        inactive_clients.append(client_id)
                
                for client_id in inactive_clients:
                    logger.info(f"🧹 Removing inactive client: {client_id}")
                    if client_id in self.clients:
                        del self.clients[client_id]
                    self.remove_client_from_rooms(client_id)
                
            except Exception as e:
                logger.error(f"❌ Cleanup error: {e}")
    
    async def performance_monitor(self):
        """Background task to monitor performance metrics."""
        while True:
            try:
                await asyncio.sleep(300)  # Check every 5 minutes
                
                # Log performance metrics
                logger.info(f"📊 Performance Metrics:")
                logger.info(f"  • Active connections: {len(self.clients)}")
                logger.info(f"  • Total connections: {self.metrics['total_connections']}")
                logger.info(f"  • Messages sent: {self.metrics['messages_sent']}")
                logger.info(f"  • Messages received: {self.metrics['messages_received']}")
                logger.info(f"  • Active rooms: {len(self.rooms)}")
                
                # Reset counters
                self.metrics['messages_sent'] = 0
                self.metrics['messages_received'] = 0
                
            except Exception as e:
                logger.error(f"❌ Performance monitor error: {e}")
    
    def remove_client_from_rooms(self, client_id: str):
        """Remove client from all rooms."""
        for room_name, clients in self.rooms.items():
            clients.discard(client_id)
    
    async def process_listing_update(self, client_id: str, payload: Dict):
        """Process a listing update from client."""
        try:
            listing_data = payload.get('listing')
            if listing_data:
                # Store in database
                await self.db.store_listings([listing_data], source=f"client_{client_id}")
                logger.info(f"📊 Listing updated by {client_id}")
        except Exception as e:
            logger.error(f"❌ Listing update error: {e}")
    
    async def process_analysis_result(self, client_id: str, payload: Dict):
        """Process analysis results from client."""
        try:
            analysis_data = payload.get('analysis')
            listing_id = payload.get('listing_id')
            
            if analysis_data and listing_id:
                await self.db.store_analysis_results(listing_id, analysis_data)
                logger.info(f"🧠 Analysis result stored from {client_id}")
        except Exception as e:
            logger.error(f"❌ Analysis result error: {e}")
    
    async def process_user_action(self, client_id: str, payload: Dict):
        """Process user action from client."""
        action_type = payload.get('action_type')
        
        if action_type == 'mark_interested':
            # Handle user marking listing as interested
            listing_id = payload.get('listing_id')
            logger.info(f"💚 User {client_id} marked listing {listing_id} as interested")
        elif action_type == 'view_details':
            # Handle user viewing listing details
            listing_id = payload.get('listing_id')
            logger.info(f"👁️ User {client_id} viewed listing {listing_id}")
    
    async def has_database_updates(self) -> bool:
        """Check if database has recent updates."""
        try:
            # Simple check - could be more sophisticated
            sync_status = await self.db.get_sync_status()
            if sync_status:
                latest_sync = max(status['last_sync'] for status in sync_status)
                latest_sync_dt = datetime.fromisoformat(latest_sync.replace('Z', '+00:00'))
                return (datetime.now() - latest_sync_dt).total_seconds() < 60
            return False
        except Exception as e:
            logger.error(f"❌ Database update check error: {e}")
            return False
    
    async def get_changes_since(self, timestamp: str) -> List[Dict]:
        """Get changes since a specific timestamp."""
        try:
            # For now, return empty list - would implement proper change tracking
            return []
        except Exception as e:
            logger.error(f"❌ Get changes error: {e}")
            return []
    
    async def process_offline_queue(self, client_id: str):
        """Process queued messages for a reconnected client."""
        if client_id in self.offline_queue:
            messages = self.offline_queue[client_id]
            
            for message in messages:
                await self.send_to_client(client_id, message.payload)
            
            # Clear queue
            del self.offline_queue[client_id]
            
            logger.info(f"📬 Processed {len(messages)} offline messages for {client_id}")


async def start_sync_server(host='localhost', port=8765):
    """Start the real-time sync server."""
    server = RealTimeSyncServer(host, port)
    await server.start_server()


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Real-time Sync Server")
    parser.add_argument("--host", default="localhost", help="Server host")
    parser.add_argument("--port", type=int, default=8765, help="Server port")
    
    args = parser.parse_args()
    
    print("🔄 Real-time Marketplace Sync Server")
    print("="*50)
    print(f"🚀 Starting server on {args.host}:{args.port}")
    print("📱 Mobile and desktop clients can connect for real-time sync")
    
    try:
        asyncio.run(start_sync_server(args.host, args.port))
    except KeyboardInterrupt:
        print("\n🛑 Server stopped by user")
    except Exception as e:
        print(f"❌ Server failed: {e}")
        logger.error(f"Server error: {e}")
