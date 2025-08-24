#!/bin/bash

# Sentinel AI v1.0.6 Uninstall Script
# This script removes Sentinel AI from Linux and macOS systems

set -e

echo "🗑️  Uninstalling Sentinel AI v1.0.6..."
echo "====================================="

# Check multiple possible installation locations
POSSIBLE_PATHS=(
    "/usr/local/bin/sentinel"
    "/usr/bin/sentinel"
    "$HOME/.local/bin/sentinel"
    "$HOME/bin/sentinel"
)

INSTALL_PATH=""
for path in "${POSSIBLE_PATHS[@]}"; do
    if [ -f "$path" ]; then
        INSTALL_PATH="$path"
        break
    fi
done

# If not found in common locations, try to find it using 'which'
if [ -z "$INSTALL_PATH" ]; then
    if command -v sentinel >/dev/null 2>&1; then
        INSTALL_PATH=$(which sentinel)
    fi
fi

# Check if sentinel is installed
if [ -z "$INSTALL_PATH" ] || [ ! -f "$INSTALL_PATH" ]; then
    echo "❌ Sentinel AI is not installed or not found in common locations"
    echo "Checked locations:"
    for path in "${POSSIBLE_PATHS[@]}"; do
        echo "  - $path"
    done
    exit 1
fi

echo "✅ Found Sentinel AI installation at: $INSTALL_PATH"

# Remove the binary
echo "📦 Removing Sentinel AI binary..."
if [[ "$INSTALL_PATH" == /usr/local/bin/* ]] || [[ "$INSTALL_PATH" == /usr/bin/* ]]; then
    # System-wide installation requires sudo
    sudo rm -f "$INSTALL_PATH"
else
    # User installation doesn't need sudo
    rm -f "$INSTALL_PATH"
fi

echo "✅ Uninstallation complete!"
echo "🎉 Sentinel AI has been removed from your system."
