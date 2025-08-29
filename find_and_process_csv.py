#!/usr/bin/env python3
"""
Find and Process CSV - Flexible CSV finder and processor
Searches common locations for the marketplace CSV file
"""

import json
import csv
import re
import os
import glob
from datetime import datetime

def extract_make(title):
    """Extract make from title"""
    title_lower = title.lower()
    if 'yamaha' in title_lower:
        return 'Yamaha'
    elif any(x in title_lower for x in ['sea-doo', 'seadoo', 'sea doo']):
        return 'Sea-Doo'
    elif 'kawasaki' in title_lower:
        return 'Kawasaki'
    elif 'polaris' in title_lower:
        return 'Polaris'
    return 'Unknown'

def extract_year(title):
    """Extract year from title"""
    years = re.findall(r'\b(20[0-2][0-9])\b', title)
    return years[0] if years else ''

def find_csv_files():
    """Find potential CSV files"""
    search_locations = [
        "/Users/scottloeb/Desktop/marketplace-tracker",
        "/Users/scottloeb/Desktop",
        "/Users/scottloeb/Downloads",
        "/Users/scottloeb/Documents"
    ]
    
    potential_files = []
    
    for location in search_locations:
        if os.path.exists(location):
            # Look for FB Marketplace CSV files
            patterns = [
                "FB Marketplace*.csv",
                "FB*Marketplace*.csv", 
                "*marketplace*.csv",
                "*Marketplace*.csv"
            ]
            
            for pattern in patterns:
                matches = glob.glob(os.path.join(location, pattern))
                potential_files.extend(matches)
    
    return list