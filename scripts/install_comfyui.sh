#!/bin/bash
set -e

echo "🚀 Installing ComfyUI..."

# ComfyUIをクローン
if [ ! -d "ComfyUI" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git
fi

cd ComfyUI

# Condaで既にインストール済みのパッケージを除外
EXCLUDE_PATTERN="^(torch|torchvision|torchaudio|numpy|scipy|pillow|git)"

echo "📦 Adding PyPI dependencies from requirements.txt..."
grep -v '^#' requirements.txt | grep -v '^$' | grep -vE "$EXCLUDE_PATTERN" | while read -r line; do
    echo "  Adding: $line"
    pixi add --pypi "$line" || echo "  ⚠️  Failed: $line (may already exist)"
done

cd ..
bash scripts/setup_directories.sh

# ComfyUI-Manager
echo "📌 Installing ComfyUI-Manager..."
cd ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
cd ../..

echo "✅ Installation completed!"
