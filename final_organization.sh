#!/bin/bash

# Final repository organization
echo "Completing repository organization..."

# Remove empty js directory if it exists and is empty
if [ -d "js" ]; then
    if [ -z "$(ls -A js)" ]; then
        rmdir js
        echo "Removed empty js directory"
    else
        echo "js directory not empty, contents:"
        ls -la js/
    fi
fi

# Consolidate cleanup scripts - keep only the comprehensive one
if [ -f "cleanup_repository.sh" ]; then
    rm cleanup_repository.sh
    echo "Removed cleanup_repository.sh"
fi

if [ -f "final_cleanup.sh" ]; then
    rm final_cleanup.sh
    echo "Removed final_cleanup.sh"
fi

# Update index.html to reference moved supabase-client.js
if [ -f "index.html" ]; then
    # Check if index.html references the old js/supabase-client.js path
    if grep -q "js/supabase-client.js" index.html; then
        echo "Updating supabase-client.js reference in index.html"
        sed -i.bak 's|js/supabase-client.js|10-src/utils/supabase-client.js|g' index.html
        rm index.html.bak
    fi
fi

echo "Repository organization complete"
echo "Ready for deployment to GitHub and Vercel"
