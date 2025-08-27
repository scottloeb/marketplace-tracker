#!/usr/bin/env python3
"""
Script to automatically update README files with dynamic folder structure
"""

import os
import re

def scan_folder_structure():
    """Scan the repository and generate folder structure data"""
    structure = []
    
    # Define folders to document (with semantic numbering)
    folders = [
        '10-src/',
        '20-reference/',
        '30-docs/', 
        '40-automation/',
        '50-scripts/',
        '60-assets/',
        '70-guides/',
        '80-harbor/'
    ]
    
    for folder in folders:
        if os.path.exists(folder):
            readme_path = os.path.join(folder, 'README.md')
            if os.path.exists(readme_path):
                # Read purpose from folder README
                with open(readme_path, 'r') as f:
                    content = f.read()
                    # Extract first line after title as purpose
                    lines = content.split('\n')
                    purpose = "Folder description"
                    for line in lines[1:]:
                        if line.strip() and not line.startswith('#'):
                            purpose = line.strip()
                            break
                
                # Determine dependencies
                deps = "None"
                if 'automation' in folder:
                    deps = "Python 3.x"
                elif 'harbor' in folder:
                    deps = "None (reference)"
                elif 'scripts' in folder:
                    deps = "Python 3.x"
                elif content and 'Dependencies' in content:
                    # Extract dependencies from README
                    for line in lines:
                        if 'Dependencies' in line and ':' in line:
                            deps = line.split(':')[1].strip()
                            break
                
                structure.append({
                    'folder': folder,
                    'purpose': purpose,
                    'dependencies': deps
                })
    
    return structure

def update_main_readme(structure):
    """Update the main README.md with current folder structure"""
    
    # Generate table rows
    table_rows = []
    for item in structure:
        folder_link = f"[`{item['folder']}`]({item['folder']}README.md)"
        table_rows.append(f"| {folder_link} | {item['purpose']} | {item['dependencies']} |")
    
    table_content = "\n".join(table_rows)
    
    # Read current README
    with open('README.md', 'r') as f:
        content = f.read()
    
    # Replace the table section
    start_marker = "<!--FOLDER_STRUCTURE_START-->"
    end_marker = "<!--FOLDER_STRUCTURE_END-->"
    
    if start_marker in content and end_marker in content:
        before = content.split(start_marker)[0]
        after = content.split(end_marker)[1]
        
        new_table = f"""{start_marker}
| Folder | Purpose | Dependencies |
|--------|---------|--------------|
{table_content}
{end_marker}"""
        
        new_content = before + new_table + after
        
        # Write updated content
        with open('README.md', 'w') as f:
            f.write(new_content)
        
        print("✅ Updated main README.md with current folder structure")
    else:
        print("❌ Could not find folder structure markers in README.md")

def validate_readmes():
    """Validate that all folder READMEs are under 50 words"""
    issues = []
    
    folders = ['10-src', '20-reference', '30-docs', '40-automation', '50-scripts', '60-assets', '70-guides', '80-harbor']
    
    for folder in folders:
        readme_path = os.path.join(folder, 'README.md')
        if os.path.exists(readme_path):
            with open(readme_path, 'r') as f:
                content = f.read()
                # Count words (excluding markdown syntax)
                text = re.sub(r'[#*`\[\]()]', '', content)
                words = len(text.split())
                
                if words > 50:
                    issues.append(f"{folder}/README.md: {words} words (should be ≤50)")
                else:
                    print(f"✅ {folder}/README.md: {words} words")
        else:
            issues.append(f"{folder}/README.md: Missing")
    
    if issues:
        print("\n❌ Issues found:")
        for issue in issues:
            print(f"  - {issue}")
    else:
        print("\n🎉 All README files validated successfully!")
    
    return len(issues) == 0

def main():
    """Main function"""
    print("🔍 Scanning folder structure...")
    structure = scan_folder_structure()
    
    print("📝 Updating main README...")
    update_main_readme(structure)
    
    print("✅ Validating README files...")
    validate_readmes()
    
    print("\n🎯 Dynamic README system updated!")

if __name__ == "__main__":
    main()
