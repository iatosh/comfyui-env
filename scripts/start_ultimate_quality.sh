#!/bin/bash

# PyTorchの最適化設定
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb=512,expandable_segments:True
export CUDA_VISIBLE_DEVICES=0,1,2
export PYTORCH_CUDNN_V8_API_ENABLED=1
export TORCH_CUDNN_SDPA_ENABLED=1

# TensorFloat-32を無効化（最高精度）
export NVIDIA_TF32_OVERRIDE=0

echo "🎨 Starting ComfyUI - Ultimate Quality Mode"
echo "💎 RTX 6000 Ada × 3 (144GB VRAM)"
echo "🎯 Full FP32 precision for maximum quality"

cd ComfyUI

python main.py \
    --listen 0.0.0.0 \
    --port 8188 \
    --highvram \
    --force-fp32 \
    --fp32-vae \
    --fp32-text-enc \
    --fp32-unet \
    --cuda-malloc \
    --use-pytorch-cross-attention \
    --force-channels-last
