#!/usr/bin/env python3
"""
Test Google Sheets Bridge Connection
Quick test to verify the bridge can read from your Google Sheets queue.
"""

import asyncio
import json
from datetime import datetime
from pathlib import Path

# Simple test without full dependencies
def test_sheets_connection():
    """Test Google Sheets connection (simplified version)."""
    try:
        import gspread
        
        # Use default credentials (requires: gcloud auth application-default login)
        gc = gspread.service_account()
        
        # Your sheet ID
        sheet_id = "1_d4d01IACg0kSDzsAaCWUFiTEgkMjOPsii_GOSGgsv0"
        
        # Open spreadsheet
        spreadsheet = gc.open_by_key(sheet_id)
        worksheet = spreadsheet.sheet1
        
        print(f"Connected to sheet: {spreadsheet.title}")
        
        # Get all records
        records = worksheet.get_all_records()
        print(f"Found {len(records)} total records")
        
        # Show pending records (no status or empty status)
        pending = [r for r in records if not r.get('status') or r.get('status').strip() == '']
        print(f"Found {len(pending)} pending records")
        
        if pending:
            print("\nSample pending record:")
            print(json.dumps(pending[0], indent=2))
        
        return True
        
    except ImportError:
        print("Error: gspread not installed. Run: pip install gspread google-auth")
        return False
    except Exception as e:
        print(f"Error connecting to Google Sheets: {e}")
        return False

def test_automation_imports():
    """Test if automation scripts can be imported."""
    import sys
    import os
    
    # Add scripts directory to path
    scripts_dir = Path(__file__).parent
    sys.path.insert(0, str(scripts_dir))
    
    try:
        from detail_enhancer import MarketplaceDetailEnhancer
        print("✅ Detail enhancer available")
        enhancer_available = True
    except ImportError as e:
        print(f"⚠️ Detail enhancer not available: {e}")
        enhancer_available = False
    
    try:
        from database_integration import DatabaseIntegration  
        print("✅ Database integration available")
        db_available = True
    except ImportError as e:
        print(f"⚠️ Database integration not available: {e}")
        db_available = False
    
    return enhancer_available, db_available

def main():
    """Run connection tests."""
    print("🧪 Testing Google Sheets Bridge Components...\n")
    
    # Test 1: Google Sheets connection
    print("1. Testing Google Sheets connection:")
    sheets_ok = test_sheets_connection()
    print()
    
    # Test 2: Automation imports
    print("2. Testing automation imports:")
    enhancer_ok, db_ok = test_automation_imports()
    print()
    
    # Summary
    print("📊 Test Summary:")
    print(f"   Google Sheets: {'✅' if sheets_ok else '❌'}")
    print(f"   Detail Enhancer: {'✅' if enhancer_ok else '⚠️'}")
    print(f"   Database Integration: {'✅' if db_ok else '⚠️'}")
    
    if sheets_ok:
        print("\n🚀 Ready to run the bridge script!")
        print("Run: python google_sheets_bridge.py --sheet-id 1_d4d01IACg0kSDzsAaCWUFiTEgkMjOPsii_GOSGgsv0")
    else:
        print("\n⚠️ Fix Google Sheets connection first.")
        print("1. Install: pip install gspread google-auth")
        print("2. Authenticate: gcloud auth application-default login")

if __name__ == "__main__":
    main()
