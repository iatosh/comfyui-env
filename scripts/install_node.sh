#!/bin/bash
set -e

if [ $# -eq 0 ]; then
    echo "Usage: pixi run install-node <GitHub URL>"
    echo "Example: pixi run install-node https://github.com/ltdrdata/ComfyUI-Manager.git"
    exit 1
fi

URL=$1
NODE_NAME=$(basename $URL .git)

cd ComfyUI/custom_nodes

if [ -d "$NODE_NAME" ]; then
    echo "📦 Updating $NODE_NAME..."
    cd $NODE_NAME
    git pull
else
    echo "📦 Installing $NODE_NAME..."
    git clone $URL
    cd $NODE_NAME
fi

if [ -f "requirements.txt" ]; then
    echo "📚 Adding dependencies..."
    grep -v '^#' requirements.txt | grep -v '^$' | xargs -I {} pixi add --pypi "{}" || true
fi

echo "✅ Installed: $NODE_NAME"
