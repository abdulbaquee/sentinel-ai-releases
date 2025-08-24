#!/bin/bash

# Sentinel AI v1.0.6 Uninstall Script
# This script removes Sentinel AI from Linux and macOS systems

set -e

echo "🗑️  Uninstalling Sentinel AI v1.0.6..."
echo "====================================="

# Check if sentinel is installed
INSTALL_PATH="/usr/local/bin/sentinel"
if [ ! -f "$INSTALL_PATH" ]; then
    echo "❌ Sentinel AI is not installed at $INSTALL_PATH"
    exit 1
fi

echo "✅ Found Sentinel AI installation"

# Remove the binary
echo "📦 Removing Sentinel AI binary..."
sudo rm -f "$INSTALL_PATH"

echo "✅ Uninstallation complete!"
echo "🎉 Sentinel AI has been removed from your system."
