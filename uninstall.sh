#!/bin/bash

# Sentinel AI Global Uninstallation Script
# This script removes Sentinel AI from global installation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="/usr/local/bin"
SENTINEL_BINARY="sentinel"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Sentinel AI is installed
check_installation() {
    if [ -f "$INSTALL_DIR/$SENTINEL_BINARY" ]; then
        print_status "Sentinel AI found at: $INSTALL_DIR/$SENTINEL_BINARY"
        return 0
    else
        print_warning "Sentinel AI is not installed globally"
        return 1
    fi
}

# Function to uninstall Sentinel AI
uninstall_sentinel() {
    print_status "Uninstalling Sentinel AI..."
    
    # Remove the binary
    sudo rm -f "$INSTALL_DIR/$SENTINEL_BINARY"
    
    if [ $? -eq 0 ]; then
        print_success "Sentinel AI uninstalled successfully"
    else
        print_error "Failed to uninstall Sentinel AI"
        exit 1
    fi
}

# Function to verify uninstallation
verify_uninstallation() {
    print_status "Verifying uninstallation..."
    
    if [ ! -f "$INSTALL_DIR/$SENTINEL_BINARY" ]; then
        print_success "Sentinel AI has been completely removed"
    else
        print_error "Uninstallation verification failed"
        exit 1
    fi
}

# Main uninstallation process
main() {
    echo "Sentinel AI Global Uninstallation Script"
    echo "========================================"
    echo
    
    # Check if Sentinel AI is installed
    if ! check_installation; then
        print_status "Nothing to uninstall"
        exit 0
    fi
    
    # Confirm uninstallation
    read -p "Are you sure you want to uninstall Sentinel AI? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Uninstallation cancelled"
        exit 0
    fi
    
    # Uninstall
    uninstall_sentinel
    
    # Verify
    verify_uninstallation
    
    print_success "Uninstallation completed successfully!"
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Sentinel AI Global Uninstallation Script"
        echo
        echo "Usage: $0 [OPTIONS]"
        echo
        echo "Options:"
        echo "  --help, -h    Show this help message"
        echo "  --version     Show version information"
        echo
        echo "This script removes Sentinel AI from global installation."
        exit 0
        ;;
    --version)
        echo "Sentinel AI Uninstallation Script v1.0.0"
        exit 0
        ;;
    "")
        main
        ;;
    *)
        print_error "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
esac 