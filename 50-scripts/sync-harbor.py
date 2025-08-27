#!/usr/bin/env python3
"""
Script to maintain a full Harbor repository mirror for marketplace-tracker reference
This creates a one-way sync: Harbor → marketplace-tracker/80-harbor
"""

import os
import shutil
import subprocess
from datetime import datetime

HARBOR_SOURCE = "/Users/scottloeb/Documents/NeurOasis/GitHub/harbor"
HARBOR_LOCAL = "./80-harbor"
MARKETPLACE_README = "README.md"  # Our custom README to preserve

def full_harbor_sync():
    """Sync the entire Harbor repository while preserving our custom README"""
    
    print("🔄 Performing full Harbor repository sync...")
    
    # Backup our custom README
    local_readme = os.path.join(HARBOR_LOCAL, MARKETPLACE_README)
    readme_backup = None
    if os.path.exists(local_readme):
        with open(local_readme, 'r') as f:
            readme_backup = f.read()
        print("  💾 Backed up marketplace-tracker README")
    
    # Remove existing Harbor content (except our README and sync metadata)
    preserve_files = {MARKETPLACE_README, 'sync.log', 'sync-info.json', 'harbor-git-info.json'}
    if os.path.exists(HARBOR_LOCAL):
        for item in os.listdir(HARBOR_LOCAL):
            if item not in preserve_files:
                item_path = os.path.join(HARBOR_LOCAL, item)
                try:
                    if os.path.isdir(item_path):
                        shutil.rmtree(item_path)
                    else:
                        os.remove(item_path)
                except Exception as e:
                    print(f"  ⚠️  Could not remove {item}: {e}")
        print("  🧹 Cleared existing Harbor content (preserved metadata)")
    else:
        os.makedirs(HARBOR_LOCAL)
        print(f"  📁 Created {HARBOR_LOCAL} directory")
    
    # Sync entire Harbor repository
    synced_count = 0
    errors = []
    
    for item in os.listdir(HARBOR_SOURCE):
        # Skip git, virtual envs, and hidden files
        if item.startswith('.') or item in ['venv', 'harbor_env', '__pycache__']:
            continue
            
        source_path = os.path.join(HARBOR_SOURCE, item)
        dest_path = os.path.join(HARBOR_LOCAL, item)
        
        try:
            if os.path.isdir(source_path):
                # Use dirs_exist_ok=True to prevent errors when destination exists
                shutil.copytree(source_path, dest_path, 
                              ignore=shutil.ignore_patterns('__pycache__', '*.pyc', '.git*', 'venv*', '*_env'),
                              dirs_exist_ok=True)
            else:
                shutil.copy2(source_path, dest_path)
            
            synced_count += 1
            print(f"  ✅ {item}")
            
        except Exception as e:
            errors.append(f"{item}: {e}")
            print(f"  ❌ {item}: {e}")
    
    # Restore our custom README (overwrite Harbor's README)
    if readme_backup:
        with open(local_readme, 'w') as f:
            f.write(readme_backup)
        print("  ✅ Restored marketplace-tracker README")
    
    # Create sync metadata
    sync_info = {
        'timestamp': datetime.now().isoformat(),
        'synced_items': synced_count,
        'errors': len(errors),
        'harbor_source': HARBOR_SOURCE,
        'sync_type': 'full_repository'
    }
    
    # Write sync log
    log_entry = f"{sync_info['timestamp']}: Full sync - {synced_count} items, {len(errors)} errors\n"
    with open(os.path.join(HARBOR_LOCAL, "sync.log"), 'a') as f:
        f.write(log_entry)
    
    # Write detailed sync info
    import json
    with open(os.path.join(HARBOR_LOCAL, "sync-info.json"), 'w') as f:
        json.dump(sync_info, f, indent=2)
    
    if errors:
        print(f"\n⚠️  {len(errors)} errors occurred:")
        for error in errors[:5]:  # Show first 5 errors
            print(f"    {error}")
        if len(errors) > 5:
            print(f"    ... and {len(errors) - 5} more")
    
    print(f"\n🎉 Full Harbor sync completed!")
    print(f"  📦 Synced: {synced_count} items")
    print(f"  ❌ Errors: {len(errors)}")
    
    return synced_count, errors

def check_harbor_updates():
    """Check if Harbor source has updates"""
    if not os.path.exists(HARBOR_SOURCE):
        print(f"❌ Harbor source not found: {HARBOR_SOURCE}")
        return False
    
    try:
        # Get last modified time of Harbor directory
        harbor_mtime = max(
            os.path.getmtime(os.path.join(HARBOR_SOURCE, item))
            for item in os.listdir(HARBOR_SOURCE)
            if not item.startswith('.')
        )
        
        # Get last sync time
        sync_log = os.path.join(HARBOR_LOCAL, "sync.log")
        if os.path.exists(sync_log):
            sync_mtime = os.path.getmtime(sync_log)
            if harbor_mtime > sync_mtime:
                print("🔔 Harbor has updates available")
                return True
            else:
                print("✅ Harbor reference is up to date")
                return False
        else:
            print("🆕 First time sync needed")
            return True
            
    except Exception as e:
        print(f"❌ Error checking updates: {e}")
        return False

def get_harbor_git_info():
    """Get Harbor repository git information"""
    try:
        os.chdir(HARBOR_SOURCE)
        
        # Get current branch
        branch_result = subprocess.run(['git', 'branch', '--show-current'], 
                                     capture_output=True, text=True, check=True)
        current_branch = branch_result.stdout.strip()
        
        # Get latest commit hash
        commit_result = subprocess.run(['git', 'rev-parse', 'HEAD'], 
                                     capture_output=True, text=True, check=True)
        latest_commit = commit_result.stdout.strip()
        
        # Get last commit date
        date_result = subprocess.run(['git', 'log', '-1', '--format=%ci'], 
                                   capture_output=True, text=True, check=True)
        last_commit_date = date_result.stdout.strip()
        
        return {
            'branch': current_branch,
            'commit': latest_commit,
            'last_commit_date': last_commit_date,
            'source_path': HARBOR_SOURCE
        }
    
    except subprocess.CalledProcessError as e:
        print(f"⚠️  Could not get Harbor git info: {e}")
        return None
    finally:
        # Return to marketplace-tracker directory
        os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def cleanup_duplicates():
    """Remove duplicate files created by interrupted syncs or merges"""
    print("🧹 Checking for duplicate files...")
    
    duplicate_patterns = [' 2.', ' 3.', ' 4.', ' (1)', ' (2)', ' copy', '.bak']
    cleaned_files = []
    
    for root, dirs, files in os.walk(HARBOR_LOCAL):
        for file in files:
            for pattern in duplicate_patterns:
                if pattern in file:
                    file_path = os.path.join(root, file)
                    try:
                        os.remove(file_path)
                        cleaned_files.append(file_path)
                        print(f"  🗑️  Removed duplicate: {file}")
                    except Exception as e:
                        print(f"  ❌ Could not remove {file}: {e}")
    
    if cleaned_files:
        print(f"  ✅ Cleaned {len(cleaned_files)} duplicate files")
    else:
        print("  ✅ No duplicate files found")
    
    return len(cleaned_files)

def main():
    """Main function - Full Harbor repository mirror"""
    print("🏗️ Harbor Repository Mirror Tool")
    print("=" * 50)
    print("🔄 One-way sync: Harbor → marketplace-tracker/80-harbor")
    print("=" * 50)
    
    # Get Harbor git information
    harbor_info = get_harbor_git_info()
    if harbor_info:
        print(f"📍 Harbor Branch: {harbor_info['branch']}")
        print(f"📝 Latest Commit: {harbor_info['commit'][:8]}")
        print(f"📅 Last Update: {harbor_info['last_commit_date']}")
        print("")
    
    if not os.path.exists(HARBOR_LOCAL):
        os.makedirs(HARBOR_LOCAL)
        print(f"📁 Created {HARBOR_LOCAL} directory")
    
    # Clean up any existing duplicates first
    cleanup_duplicates()
    
    if check_harbor_updates():
        synced_count, errors = full_harbor_sync()
        
        # Write Harbor git info to local reference
        if harbor_info:
            import json
            with open(os.path.join(HARBOR_LOCAL, "harbor-git-info.json"), 'w') as f:
                json.dump(harbor_info, f, indent=2)
            print("  📋 Saved Harbor git reference info")
    
    # Update main README
    try:
        subprocess.run(['python3', '50-scripts/update-readmes.py'], check=True)
        print("📝 Updated README files")
    except subprocess.CalledProcessError:
        print("⚠️  Could not update README files")

if __name__ == "__main__":
    main()
