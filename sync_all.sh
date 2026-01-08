#!/bin/bash

# Source folder (your template)
SOURCE="uwu-alcohol"

# All target folders (list all 30 folders here)
TARGETS=(
    "uwu-thetacofarmer"
    # ... add all your folder names
)

# Folders to sync (everything except 'shared')
SYNC_DIRS=("build" "client" "install" "locales" "server" "sql" "stream" "web")

# Files to sync
SYNC_FILES=("fxmanifest.lua" "README.md" "uwucafelogo.png")

echo "Starting sync from $SOURCE to ${#TARGETS[@]} folders..."

for target in "${TARGETS[@]}"; do
    echo "Syncing to $target..."
    
    # Sync directories
    for dir in "${SYNC_DIRS[@]}"; do
        if [ -d "$SOURCE/$dir" ]; then
            rsync -av --delete "$SOURCE/$dir/" "$target/$dir/"
        fi
    done
    
    # Sync individual files
    for file in "${SYNC_FILES[@]}"; do
        if [ -f "$SOURCE/$file" ]; then
            cp "$SOURCE/$file" "$target/$file"
        fi
    done
done

echo "Sync complete!"