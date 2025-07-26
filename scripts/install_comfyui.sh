#!/bin/bash
set -e

echo "🚀 Installing ComfyUI..."

# ComfyUIをクローン
if [ ! -d "ComfyUI" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git
fi

# 依存関係を追加
cd ComfyUI
echo "📦 Adding Python dependencies..."
grep -v '^#' requirements.txt | grep -v '^$' | xargs -I {} pixi add --pypi "{}"

cd ..

# ディレクトリ構造のセットアップ
bash scripts/setup_directories.sh

# 必須カスタムノードをインストール
echo "📌 Installing ComfyUI-Manager..."
cd ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
cd ../..

echo "✅ ComfyUI installed successfully!"
