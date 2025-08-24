#!/bin/bash

# Sentinel AI v1.0.6 Installation Script
# This script installs Sentinel AI on Linux and macOS systems

set -e

echo "🚀 Installing Sentinel AI v1.0.6..."
echo "=================================="

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    BINARY="sentinel-linux-x86_64"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    BINARY="sentinel-macos-x86_64"
else
    echo "❌ Unsupported operating system: $OSTYPE"
    echo "Please download the appropriate binary manually."
    exit 1
fi

echo "✅ Detected OS: $OS"

# Check if PHP is available
if ! command -v php >/dev/null 2>&1; then
    echo "❌ PHP is not installed or not in PATH"
    echo "Please install PHP 8.2 or higher first:"
    if [[ "$OS" == "macos" ]]; then
        echo "  brew install php"
    else
        echo "  sudo apt-get install php8.2-cli php8.2-mbstring php8.2-json php8.2-phar php8.2-sodium php8.2-intl"
    fi
    exit 1
fi

# Check PHP version
PHP_VERSION=$(php -r "echo PHP_VERSION;" 2>/dev/null)
if [ $? -ne 0 ] || ! php -r "exit(version_compare(PHP_VERSION, '8.2.0', '<') ? 1 : 0);" 2>/dev/null; then
    echo "❌ PHP 8.2 or higher is required. Current version: $PHP_VERSION"
    exit 1
fi

echo "✅ PHP version: $PHP_VERSION"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BINARY_PATH="$SCRIPT_DIR/$BINARY"
PHAR_PATH="$SCRIPT_DIR/sentinel.phar"

# Check if binary exists
if [ ! -f "$BINARY_PATH" ]; then
    echo "❌ Binary not found: $BINARY_PATH"
    exit 1
fi

# Check if PHAR exists
if [ ! -f "$PHAR_PATH" ]; then
    echo "❌ PHAR file not found: $PHAR_PATH"
    exit 1
fi

echo "✅ Found Sentinel AI files"

# Make binary executable
chmod +x "$BINARY_PATH"

# Install to /usr/local/bin
INSTALL_PATH="/usr/local/bin/sentinel"
echo "📦 Installing to $INSTALL_PATH..."

# Check if sentinel is already installed
if [ -f "$INSTALL_PATH" ]; then
    echo "⚠️  Sentinel AI is already installed. Updating..."
    sudo rm -f "$INSTALL_PATH"
fi

# Copy binary to /usr/local/bin
sudo cp "$BINARY_PATH" "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

echo "✅ Installation complete!"

# Test installation
echo "🧪 Testing installation..."
if command -v sentinel >/dev/null 2>&1; then
    echo "✅ Sentinel AI is now available as 'sentinel'"
    echo ""
    echo "Usage examples:"
    echo "  sentinel --version                    # Check version"
    echo "  sentinel analyze src/                 # Analyze code"
    echo "  sentinel autofix src/ --interactive   # Interactive fixes"
    echo "  sentinel --help                      # Show all commands"
    echo ""
    echo "🎉 Sentinel AI v1.0.6 is ready to use!"
else
    echo "❌ Installation test failed"
    exit 1
fi
