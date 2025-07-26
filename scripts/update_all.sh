#!/bin/bash
set -e
echo "🔄 Updating ComfyUI..."
cd ComfyUI && git pull && cd ..
echo "🔧 Updating custom nodes..."
cd ComfyUI/custom_nodes
for dir in */; do
    if [ -d "$dir/.git" ]; then
        echo "Updating $dir..."
        cd "$dir" && git pull && cd ..
    fi
done
cd ../..
echo "✅ Update completed!"
