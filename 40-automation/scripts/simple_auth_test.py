#!/usr/bin/env python3
"""
Simple Google Sheets test using OAuth flow
Alternative to gcloud authentication for testing.
"""

import gspread
from google.auth.transport.requests import Request
from google_auth_oauthlib.flow import InstalledAppFlow
import json
from pathlib import Path

# Define the scope
SCOPES = ['https://spreadsheets.google.com/feeds',
          'https://www.googleapis.com/auth/drive']

def setup_oauth_credentials():
    """Set up OAuth credentials for Google Sheets access."""
    
    # You need to create these credentials in Google Cloud Console
    # Go to: https://console.cloud.google.com/apis/credentials
    # Create "OAuth 2.0 Client IDs" for Desktop application
    # Download the JSON file and put it here
    
    client_config = {
        "installed": {
            "client_id": "YOUR_CLIENT_ID.apps.googleusercontent.com",
            "project_id": "your-project-id",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_secret": "YOUR_CLIENT_SECRET",
            "redirect_uris": ["http://localhost"]
        }
    }
    
    print("To use this method:")
    print("1. Go to https://console.cloud.google.com/apis/credentials")
    print("2. Create 'OAuth 2.0 Client IDs' for Desktop application")
    print("3. Download the JSON and replace client_config above")
    print("4. Or use gcloud CLI instead (easier)")
    
    return None

def test_simple_connection():
    """Test connection with default service account approach."""
    try:
        # This tries the default service account method
        gc = gspread.service_account()
        
        sheet_id = "1_d4d01IACg0kSDzsAaCWUFiTEgkMjOPsii_GOSGgsv0"
        spreadsheet = gc.open_by_key(sheet_id)
        worksheet = spreadsheet.sheet1
        
        print(f"✅ Connected to: {spreadsheet.title}")
        records = worksheet.get_all_records()
        print(f"📊 Found {len(records)} records")
        
        return True
        
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        return False

if __name__ == "__main__":
    print("🔐 Testing Google Sheets authentication...")
    
    if not test_simple_connection():
        print("\n💡 Authentication options:")
        print("1. Install gcloud CLI: brew install google-cloud-sdk")
        print("2. Run: gcloud auth application-default login")
        print("3. Or set up OAuth credentials (more complex)")
