# ComfyUI Setup Scripts

高性能GPU向けのComfyUI環境セットアップスクリプト集

## 推奨環境

- **GPU**: VRAM 24GB以上（RTX 3090, 4090, A5000, 6000 Ada等）
- **Driver**: NVIDIA Driver 525+
- **OS**: Linux (Ubuntu 20.04/22.04)
- **CUDA**: 12.1+

## このセットアップの特徴

- 大容量VRAMを活かした高品質設定
- `--highvram`によるモデル常駐で高速切り替え
- FP32/BF16精度での最高品質生成
- マルチGPU対応（要カスタムノード）

## ⚠️ 注意

**このセットアップはVRAM 24GB以上を想定しています。**
- 8-16GB GPUの場合は起動オプションの変更が必要
- デフォルト設定ではメモリ不足になる可能性があります

## セットアップ

### 1. Pixiのインストール
```bash
curl -fsSL https://pixi.sh/install.sh | bash
```

### 2. クローンと環境構築
```bash
git clone https://github.com/YOUR_USERNAME/comfyui-setup.git
cd comfyui-setup
pixi install
pixi run install
```

## 起動モード（24GB+ VRAM向け）

```bash
pixi run start          # FP32最高品質
pixi run start-balanced # BF16バランス
pixi run start-fast     # FP8高速（RTX 40系）
```

## 少ないVRAMでの使用方法

### 16GB VRAM (RTX 4060 Ti 16GB等)
```bash
# pixi.tomlを編集
start = "cd ComfyUI && python main.py --listen 0.0.0.0 --port 8188"
# --highvramを削除
```

### 8-12GB VRAM (RTX 3060 12GB, 4070等)
```bash
# pixi.tomlに新しいタスクを追加
start-lowvram = "cd ComfyUI && python main.py --listen 0.0.0.0 --port 8188 --lowvram"
```

### 8GB未満
```bash
# CPU併用モード
start-minimal = "cd ComfyUI && python main.py --listen 0.0.0.0 --port 8188 --lowvram --cpu-vae"
```

## カスタマイズ例

### 自分のGPUに合わせた設定を追加

```toml
# pixi.tomlに追加
[tasks]
# RTX 3060 12GB向け
start-3060 = """cd ComfyUI && python main.py \
    --listen 0.0.0.0 \
    --port 8188 \
    --preview-method auto"""

# RTX 4070 12GB向け  
start-4070 = """cd ComfyUI && python main.py \
    --listen 0.0.0.0 \
    --port 8188 \
    --bf16-unet"""
```

## 主なコマンド

| コマンド | 説明 | 推奨VRAM |
|---------|------|----------|
| `pixi run start` | 最高品質モード | 24GB+ |
| `pixi run start-balanced` | バランスモード | 24GB+ |
| `pixi run download-model` | モデルダウンロード | - |
| `pixi run install-node` | カスタムノード追加 | - |
