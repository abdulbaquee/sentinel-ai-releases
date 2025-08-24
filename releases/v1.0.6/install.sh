#!/bin/bash

# Sentinel AI v1.0.6 Installation Script (Fixed Version)
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

# Create temporary directory for downloads
TEMP_DIR=$(mktemp -d)
echo "📁 Using temporary directory: $TEMP_DIR"

# Download required files
echo "📥 Downloading Sentinel AI files..."

# Download binary
echo "  - Downloading $BINARY..."
curl -L "https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/releases/v1.0.6/$BINARY" -o "$TEMP_DIR/$BINARY"

# Download PHAR
echo "  - Downloading sentinel.phar..."
curl -L "https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/releases/v1.0.6/sentinel.phar" -o "$TEMP_DIR/sentinel.phar"

# Verify downloads
if [ ! -f "$TEMP_DIR/$BINARY" ]; then
    echo "❌ Failed to download binary: $BINARY"
    rm -rf "$TEMP_DIR"
    exit 1
fi

if [ ! -f "$TEMP_DIR/sentinel.phar" ]; then
    echo "❌ Failed to download PHAR file"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "✅ All files downloaded successfully"

# Make binary executable
chmod +x "$TEMP_DIR/$BINARY"

# Install to /usr/local/bin
INSTALL_PATH="/usr/local/bin/sentinel"
echo "📦 Installing to $INSTALL_PATH..."

# Check if sentinel is already installed
if [ -f "$INSTALL_PATH" ]; then
    echo "⚠️  Sentinel AI is already installed. Updating..."
    sudo rm -f "$INSTALL_PATH"
fi

# Copy binary to /usr/local/bin
sudo cp "$TEMP_DIR/$BINARY" "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

# Clean up temporary files
echo "🧹 Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

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
