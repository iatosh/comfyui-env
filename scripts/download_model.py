#!/usr/bin/env python3
import os
import sys
import requests
from pathlib import Path

def download_from_url(url, dest_dir):
    """URLからモデルをダウンロード"""
    filename = url.split('/')[-1].split('?')[0]
    filepath = Path(dest_dir) / filename
    
    print(f"📥 Downloading: {filename}")
    print(f"📁 To: {dest_dir}")
    
    response = requests.get(url, stream=True)
    total_size = int(response.headers.get('content-length', 0))
    
    with open(filepath, 'wb') as f:
        downloaded = 0
        for chunk in response.iter_content(chunk_size=8192):
            f.write(chunk)
            downloaded += len(chunk)
            if total_size > 0:
                percent = (downloaded / total_size) * 100
                print(f"\rProgress: {percent:.1f}%", end='', flush=True)
    
    print(f"\n✅ Downloaded: {filename}")

def detect_model_type(url):
    """URLからモデルタイプを推測"""
    lower = url.lower()
    
    # シンボリックリンク経由のパスを使用
    if 'controlnet' in lower or 'control_' in lower:
        return 'models/controlnet/sdxl' if 'sdxl' in lower else 'models/controlnet/sd15'
    elif 'lora' in lower:
        if 'sdxl' in lower:
            return 'models/loras/sdxl'
        elif 'flux' in lower:
            return 'models/loras/flux'
        else:
            return 'models/loras/sd15'
    elif 'vae' in lower:
        return 'models/vae'
    else:
        if 'sdxl' in lower:
            return 'models/checkpoints/sdxl'
        elif 'sd15' in lower or 'sd-1' in lower:
            return 'models/checkpoints/sd15'
        elif 'flux' in lower:
            return 'models/checkpoints/flux'
        else:
            return 'models/checkpoints/other'

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: pixi run download-model <URL>")
        sys.exit(1)
    
    url = sys.argv[1]
    dest_dir = sys.argv[2] if len(sys.argv) > 2 else detect_model_type(url)
    
    os.makedirs(dest_dir, exist_ok=True)
    download_from_url(url, dest_dir)
