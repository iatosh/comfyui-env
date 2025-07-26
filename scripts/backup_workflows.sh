#!/bin/bash
BACKUP_DIR="workflow_backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# ワークフローをバックアップ
if [ -d "workflows" ]; then
    cp -r workflows/* "$BACKUP_DIR/" 2>/dev/null || true
fi

# お気に入りもバックアップ（シンボリックリンク経由）
if [ -d "outputs/favorites" ]; then
    cp -r outputs/favorites "$BACKUP_DIR/" 2>/dev/null || true
fi

echo "✅ Backed up to: $BACKUP_DIR"
