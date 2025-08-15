#!/bin/bash

# Sentinel AI Official Release Installer
# Downloads from public releases repository
# Auto-detects latest version

set -e

# Configuration
REPO_OWNER="abdulbaquee"
RELEASES_REPO="sentinel-ai-releases"
GITHUB_API="https://api.github.com/repos/${REPO_OWNER}/${RELEASES_REPO}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

echo "🚀 Sentinel AI Official Installer"
echo "=================================="

# Check internet connectivity
info "Checking internet connectivity..."
if ! curl -s --connect-timeout 5 https://github.com >/dev/null; then
    error "No internet connection. Please check your network and try again."
    exit 1
fi

# Get latest release version
info "Fetching latest release information..."
VERSION=$(curl -s "$GITHUB_API/releases/latest" 2>/dev/null | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/' || echo "")

if [[ -z "$VERSION" ]]; then
    warning "Failed to fetch latest version from API, using fallback..."
    VERSION="1.0.4"  # Fallback version
fi

echo "Latest version: $VERSION"
echo "Repository: github.com/${REPO_OWNER}/${RELEASES_REPO}"
echo ""

# Detect platform
case "$(uname -s)" in
    Linux*)     PLATFORM="linux-x86_64"; BINARY_EXT="";;
    Darwin*)    PLATFORM="macos-x86_64"; BINARY_EXT="";;
    CYGWIN*|MINGW*|MSYS*) PLATFORM="windows-x86_64"; BINARY_EXT=".bat";;
    *)          error "Unsupported platform: $(uname -s)"; exit 1;;
esac

info "Detected platform: $PLATFORM"

# Check if running as root (not recommended)
if [[ $EUID -eq 0 ]]; then
    warning "Running as root is not recommended"
    warning "Consider running as a regular user with sudo when needed"
fi

# Installation directory
if [[ $PLATFORM == "windows-x86_64" ]]; then
    # Windows installation path
    INSTALL_DIR="$USERPROFILE/bin"
    BINARY_PATH="$INSTALL_DIR/sentinel$BINARY_EXT"
else
    # Unix installation path
    if [[ -w "/usr/local/bin" ]] || [[ $EUID -eq 0 ]]; then
        INSTALL_DIR="/usr/local/bin"
    else
        INSTALL_DIR="$HOME/.local/bin"
        mkdir -p "$INSTALL_DIR"
    fi
    BINARY_PATH="$INSTALL_DIR/sentinel$BINARY_EXT"
fi

info "Installation directory: $INSTALL_DIR"

# Check if already installed
if command -v sentinel >/dev/null 2>&1; then
    CURRENT_VERSION=$(sentinel --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
    warning "Sentinel AI is already installed"
    info "Current version: Sentinel AI $CURRENT_VERSION"
    
    if [[ "$CURRENT_VERSION" == "$VERSION" ]]; then
        info "You already have the latest version ($VERSION)"
        echo -n "Do you want to reinstall? (y/N): "
    else
        echo -n "Do you want to update to version $VERSION? (y/N): "
    fi
    
    read -r REPLY
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Installation cancelled"
        exit 0
    fi
fi

# Create install directory
if [[ ! -d "$INSTALL_DIR" ]]; then
    info "Creating installation directory: $INSTALL_DIR"
    if [[ "$INSTALL_DIR" == "/usr/local/bin" ]]; then
        sudo mkdir -p "$INSTALL_DIR"
    else
        mkdir -p "$INSTALL_DIR"
    fi
fi

# Download URLs
BINARY_URL="https://github.com/${REPO_OWNER}/${RELEASES_REPO}/releases/download/v${VERSION}/sentinel-${PLATFORM}${BINARY_EXT}"
PHAR_URL="https://github.com/${REPO_OWNER}/${RELEASES_REPO}/releases/download/v${VERSION}/sentinel.phar"

info "Downloading Sentinel AI v$VERSION for $PLATFORM..."

# Download with progress
TEMP_FILE=$(mktemp)
if curl -L --fail --progress-bar "$BINARY_URL" -o "$TEMP_FILE" 2>/dev/null; then
    info "Download completed successfully"
    
    # Install the binary
    if [[ "$INSTALL_DIR" == "/usr/local/bin" ]] && [[ $EUID -ne 0 ]]; then
        info "Installing to system directory (requires sudo)..."
        sudo mv "$TEMP_FILE" "$BINARY_PATH"
        sudo chmod +x "$BINARY_PATH"
    else
        mv "$TEMP_FILE" "$BINARY_PATH"
        chmod +x "$BINARY_PATH"
    fi
    
    success "Successfully installed Sentinel AI v$VERSION"
    info "📍 Installed to: $BINARY_PATH"
    
else
    warning "Failed to download platform-specific binary. Trying PHAR fallback..."
    
    # Fallback to PHAR
    if curl -L --fail --progress-bar "$PHAR_URL" -o "$TEMP_FILE" 2>/dev/null; then
        if [[ "$INSTALL_DIR" == "/usr/local/bin" ]] && [[ $EUID -ne 0 ]]; then
            sudo mv "$TEMP_FILE" "$BINARY_PATH"
            sudo chmod +x "$BINARY_PATH"
        else
            mv "$TEMP_FILE" "$BINARY_PATH"
            chmod +x "$BINARY_PATH"
        fi
        
        success "Successfully installed Sentinel AI PHAR v$VERSION"
        info "📍 Installed to: $BINARY_PATH"
    else
        rm -f "$TEMP_FILE"
        error "Failed to download Sentinel AI"
        error "Please check: https://github.com/${REPO_OWNER}/${RELEASES_REPO}/releases"
        exit 1
    fi
fi

# Verify installation
echo ""
info "Verifying installation..."
if command -v sentinel >/dev/null 2>&1; then
    INSTALLED_VERSION=$(sentinel --version 2>/dev/null || echo "Version check failed")
    success "Installation verified: $INSTALLED_VERSION"
    
    echo ""
    success "🎉 Installation complete!"
    echo ""
    echo "📖 Quick Start:"
    echo "  sentinel analyze src/              # Analyze PHP code"
    echo "  sentinel autofix src/ --interactive # Fix issues interactively"
    echo "  sentinel --help                    # Show all commands"
    echo ""
    echo "📚 Documentation:"
    echo "  https://github.com/${REPO_OWNER}/${RELEASES_REPO}#documentation"
    echo ""
    echo "🐛 Support:"
    echo "  https://github.com/${REPO_OWNER}/sentinel-ai/issues"
    
else
    warning "Installation completed but 'sentinel' not found in PATH"
    
    if [[ "$INSTALL_DIR" != "/usr/local/bin" ]]; then
        echo ""
        warning "Please add $INSTALL_DIR to your PATH:"
        if [[ "$SHELL" == *"zsh"* ]]; then
            echo "  echo 'export PATH=\"$INSTALL_DIR:\$PATH\"' >> ~/.zshrc"
            echo "  source ~/.zshrc"
        else
            echo "  echo 'export PATH=\"$INSTALL_DIR:\$PATH\"' >> ~/.bashrc"
            echo "  source ~/.bashrc"
        fi
        echo ""
        echo "Or run directly: $BINARY_PATH --version"
    else
        echo ""
        warning "You may need to restart your terminal or shell"
    fi
fi

echo ""
info "Thank you for using Sentinel AI! 🚀"
