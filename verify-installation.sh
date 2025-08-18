#!/bin/bash

# Sentinel AI Installation Verification Script
# Tests all installation methods and platform scripts

set -e

echo "🔍 Sentinel AI Installation Verification"
echo "========================================"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

success() { echo -e "${GREEN}✅ $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }
info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }

ERRORS=0

# Test 1: Check all required files exist
info "Checking required files..."
REQUIRED_FILES=(
    "sentinel.phar"
    "install.sh"
    "install.ps1"
    "uninstall.sh"
    "sentinel-macos-x86_64"
    "sentinel-linux-x86_64"
    "sentinel-windows-x86_64.bat"
    "INSTALL.md"
    "README.md"
    "VERSION"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        success "Found: $file"
    else
        error "Missing: $file"
        ((ERRORS++))
    fi
done

# Test 2: Verify PHAR is executable and shows correct version
info "Testing PHAR binary..."
if [[ -f "sentinel.phar" ]]; then
    if php sentinel.phar --version >/dev/null 2>&1; then
        VERSION=$(php sentinel.phar --version 2>/dev/null)
        success "PHAR is executable: $VERSION"
    else
        error "PHAR is not executable or PHP not available"
        ((ERRORS++))
    fi
else
    error "sentinel.phar not found"
    ((ERRORS++))
fi

# Test 3: Test macOS wrapper script
info "Testing macOS wrapper script..."
if [[ -f "sentinel-macos-x86_64" && -x "sentinel-macos-x86_64" ]]; then
    if ./sentinel-macos-x86_64 --version >/dev/null 2>&1; then
        MACOS_VERSION=$(./sentinel-macos-x86_64 --version 2>/dev/null)
        success "macOS script works: $MACOS_VERSION"
    else
        error "macOS script failed to execute"
        ((ERRORS++))
    fi
else
    error "macOS script not found or not executable"
    ((ERRORS++))
fi

# Test 4: Test installation script syntax
info "Testing installation script syntax..."
if bash -n install.sh; then
    success "install.sh syntax is valid"
else
    error "install.sh has syntax errors"
    ((ERRORS++))
fi

# Test 5: Test uninstall script syntax
info "Testing uninstall script syntax..."
if bash -n uninstall.sh; then
    success "uninstall.sh syntax is valid"
else
    error "uninstall.sh has syntax errors"
    ((ERRORS++))
fi

# Test 6: Check GitHub API accessibility
info "Testing GitHub API accessibility..."
if curl -s "https://api.github.com/repos/abdulbaquee/sentinel-ai-releases/releases/latest" >/dev/null; then
    API_VERSION=$(curl -s "https://api.github.com/repos/abdulbaquee/sentinel-ai-releases/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    success "GitHub API accessible, latest version: $API_VERSION"
    
    # Check if our current version matches the API
    CURRENT_VERSION=$(cat VERSION 2>/dev/null || echo "unknown")
    if [[ "$API_VERSION" == "$CURRENT_VERSION" ]]; then
        success "Version consistency: API and local VERSION file match"
    else
        warning "Version mismatch: API=$API_VERSION, Local=$CURRENT_VERSION"
    fi
else
    error "GitHub API not accessible"
    ((ERRORS++))
fi

# Test 7: Check release directory structure
info "Checking release directory structure..."
for version_dir in releases/*/; do
    if [[ -d "$version_dir" ]]; then
        version=$(basename "$version_dir")
        info "Found release: $version"
        
        # Check for required files in release directory
        RELEASE_FILES=("sentinel.phar" "*checksums*")
        for pattern in "${RELEASE_FILES[@]}"; do
            if ls "$version_dir"$pattern >/dev/null 2>&1; then
                success "  Found: $pattern in $version"
            else
                warning "  Missing: $pattern in $version"
            fi
        done
    fi
done

# Test 8: Verify checksums if available
info "Verifying checksums..."
if [[ -f "releases/v1.0.6/v1.0.6-checksums.txt" ]]; then
    cd releases/v1.0.6
    if sha256sum -c v1.0.6-checksums.txt >/dev/null 2>&1; then
        success "Checksums verified for v1.0.6"
    else
        error "Checksum verification failed for v1.0.6"
        ((ERRORS++))
    fi
    cd ../..
fi

# Test 9: Check file permissions
info "Checking file permissions..."
EXECUTABLE_FILES=(
    "sentinel.phar"
    "install.sh"
    "uninstall.sh"
    "sentinel-macos-x86_64"
    "sentinel-linux-x86_64"
)

for file in "${EXECUTABLE_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        if [[ -x "$file" ]]; then
            success "Executable: $file"
        else
            warning "Not executable: $file (this might be OK)"
        fi
    fi
done

# Test 10: Check documentation completeness
info "Checking documentation..."
DOC_FILES=("README.md" "INSTALL.md" "CHANGELOG.md")
for doc in "${DOC_FILES[@]}"; do
    if [[ -f "$doc" ]]; then
        if [[ -s "$doc" ]]; then
            success "Documentation present: $doc"
        else
            warning "Documentation empty: $doc"
        fi
    else
        warning "Documentation missing: $doc"
    fi
done

# Summary
echo ""
echo "📊 Verification Summary"
echo "======================"

if [[ $ERRORS -eq 0 ]]; then
    success "All tests passed! Installation repository is ready for distribution."
    echo ""
    info "Installation URLs:"
    echo "  Bash: curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash"
    echo "  PowerShell: iwr -useb https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.ps1 | iex"
    echo "  Direct PHAR: https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar"
else
    error "Found $ERRORS issues that need to be addressed."
    exit 1
fi

echo ""
info "Verification completed successfully! 🎉"
