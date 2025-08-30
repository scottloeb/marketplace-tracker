#!/usr/bin/env python3
"""
Quick Icon Generator for Chrome Extension
Creates simple placeholder icons in multiple sizes
"""

import os
from pathlib import Path

def create_placeholder_icons():
    """
    Creates simple HTML files that can be screenshot for icons
    Run this script, then screenshot the HTML files and save as PNG
    """
    
    # Icon sizes needed
    sizes = [16, 32, 48, 128]
    
    # Icon directory
    icon_dir = Path(__file__).parent / "icons"
    icon_dir.mkdir(exist_ok=True)
    
    for size in sizes:
        html_content = f"""
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style>
        body {{
            margin: 0;
            padding: 0;
            width: {size}px;
            height: {size}px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: system-ui;
            font-size: {size // 2}px;
            border-radius: {size // 8}px;
        }}
    </style>
</head>
<body>
    🛥️
</body>
</html>
        """
        
        # Save HTML file for screenshotting
        html_file = icon_dir / f"icon{size}_template.html"
        html_file.write_text(html_content.strip())
        
        print(f"Created template: {html_file}")
        print(f"  → Open in browser and screenshot as icon{size}.png")
    
    print("\nTo create actual PNG icons:")
    print("1. Open each HTML template in your browser")
    print("2. Screenshot the icon (or use browser dev tools to capture element)")
    print("3. Save as icon16.png, icon32.png, icon48.png, icon128.png")
    print("4. Place PNG files in the icons/ directory")
    print("\nThe extension will work without icons (shows default Chrome icon)")

if __name__ == "__main__":
    create_placeholder_icons()
