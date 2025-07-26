#!/bin/bash
echo "🧹 Cleaning cache..."
find ComfyUI -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
find ComfyUI -name "*.pyc" -delete 2>/dev/null || true
echo "✅ Cache cleaned!"
