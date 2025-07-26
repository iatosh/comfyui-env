#!/bin/bash
echo "📦 Installed Models:"
echo ""

# シンボリックリンク経由でアクセス
for category in checkpoints loras vae controlnet; do
    if [ -d "models/$category" ]; then
        count=$(find "models/$category" -name "*.safetensors" -o -name "*.ckpt" -o -name "*.pth" 2>/dev/null | wc -l)
        echo "[$category]: $count files"
        if [ $count -gt 0 ]; then
            find "models/$category" -name "*.safetensors" -o -name "*.ckpt" -o -name "*.pth" 2>/dev/null | head -5 | sed 's/^/  - /'
            [ $count -gt 5 ] && echo "  ... and $((count-5)) more"
        fi
        echo ""
    fi
done
