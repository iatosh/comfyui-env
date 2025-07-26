#!/bin/bash
set -e

echo "📁 Setting up directory structure..."

# ComfyUI内
cd ComfyUI
mkdir -p models/{checkpoints/{sd15,sdxl,flux,other},vae,loras/{sd15,sdxl,flux},controlnet/{sd15,sdxl},embeddings,clip,unet}
mkdir -p output/{images/{txt2img,img2img,inpaint,controlnet,upscale},videos,favorites}
mkdir -p input
cd ..

# シンボリックリンク
ln -sfn ComfyUI/models models
ln -sfn ComfyUI/output outputs  
ln -sfn ComfyUI/input inputs

# ワークフロー
mkdir -p workflows workflow_backups

echo "✅ Done!"
