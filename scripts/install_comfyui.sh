#!/bin/bash
set -e

echo "🚀 Installing ComfyUI..."

# ComfyUIをクローン
if [ ! -d "ComfyUI" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git
fi

cd ComfyUI

# Condaで既にインストール済みのパッケージのみ除外
EXCLUDE_PATTERN="^(torch|torchvision|torchaudio|numpy|scipy|pillow|opencv|git)$"

echo "📦 Adding PyPI dependencies from requirements.txt..."
grep -v '^#' requirements.txt | grep -v '^$' | while read -r line; do
    # パッケージ名を抽出
    pkg_name=$(echo "$line" | sed 's/[<>=!].*//' | tr -d ' ')
    
    # 除外パターンに完全一致するものだけスキップ
    if echo "$pkg_name" | grep -qE "$EXCLUDE_PATTERN"; then
        echo "  Skipping: $pkg_name (already in conda)"
    else
        echo "  Adding: $line"
        pixi add --pypi "$line" || echo "  ⚠️  Failed: $line (may already exist)"
    fi
done

cd ..
bash scripts/setup_directories.sh

echo "✅ Installation completed!"
