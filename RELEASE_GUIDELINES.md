# 📋 Sentinel AI Release Guidelines

> **Comprehensive guide for AI assistants and developers to follow best practices for Sentinel AI releases**

## 🎯 **Purpose**

This document provides clear guidelines for AI assistants (like Cursor AI) and developers to:
- Understand the proper repository structure
- Follow consistent release practices
- Maintain version management
- Ensure proper file organization
- Create professional releases

## 📁 **Repository Structure Standards**

### **✅ Correct Structure (ALWAYS FOLLOW THIS):**

```
sentinel-ai-releases/
├── 📄 README.md                    # Main documentation (root level)
├── 📄 LICENSE                      # License file (root level)
├── 📄 CHANGELOG.md                 # Change history (root level)
├── 📄 SECURITY.md                  # Security policy (root level)
├── 📄 CONTRIBUTING.md              # Contribution guidelines (root level)
├── 📄 INSTALL.md                   # Installation guide (root level)
├── 📄 PLATFORM_COMPATIBILITY.md    # Platform support (root level)
├── 📄 RELEASE_GUIDELINES.md        # This file (root level)
├── 📁 releases/                    # ✅ VERSIONED RELEASES ONLY
│   ├── 📁 v1.0.4/                 # Previous release
│   ├── 📁 v1.0.5/                 # Previous release
│   └── 📁 v1.0.6/                 # ✅ Latest release
│       ├── 📄 sentinel.phar        # PHAR file
│       ├── sentinel-linux-x86_64    # Linux wrapper
│       ├── sentinel-macos-x86_64    # macOS wrapper
│       ├── sentinel-windows-x86_64.bat # Windows wrapper
│       ├── install.sh           # Linux/macOS installer
│       ├── 📄 install.ps1          # Windows installer
│       ├── 📄 uninstall.sh         # Linux/macOS uninstaller
│       ├── 📄 uninstall.ps1        # Windows uninstaller
│       ├── RELEASE_NOTES.md     # Release notes
│       ├── 📄 QUICK_START.md       # Quick start guide
│       └── 📄 v{version}-checksums.txt # File checksums
└── 📁 .git/                        # Git repository
```

### **❌ NEVER DO THIS (Avoid Redundancy):**

```
sentinel-ai-releases/
├── 📄 sentinel.phar                # ❌ DON'T put binaries in root
├── 📄 sentinel-linux-x86_64        # ❌ DON'T put binaries in root
├── 📄 install.sh                   # ❌ DON'T put installers in root
├── 📁 releases/                    # ✅ ONLY put versioned files here
│   └── 📁 v1.0.6/
│       └── 📄 sentinel.phar        # ✅ CORRECT location
```

## 🚀 **Release Process for AI Assistants**

### **Step 1: Version Planning**
```bash
# Check current version in main repository
cd /path/to/sentinel-ai
php -r "require 'src/Version.php'; echo Sentinel\Version::VERSION;"
```

### **Step 2: Create Release Directory**
```bash
# Create new version directory
mkdir -p /Users/abdul/Sites/sentinel-ai-releases/releases/v{new-version}
```

### **Step 3: Copy Latest PHAR**
```bash
# Copy from main repository
cp /path/to/sentinel-ai/sentinel.phar /Users/abdul/Sites/sentinel-ai-releases/releases/v{new-version}/
```

### **Step 4: Create Platform Wrappers**
Create these files in the new version directory:

#### **Linux Wrapper (`sentinel-linux-x86_64`):**
```bash
#!/bin/bash
# Sentinel AI Native-like Wrapper for Linux

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PHAR_FILE="$SCRIPT_DIR/sentinel.phar"

# Check if PHAR exists
if [ ! -f "$PHAR_FILE" ]; then
    echo "Error: Sentinel AI PHAR not found at $PHAR_FILE"
    exit 1
fi

# Check if PHP is available
if ! command -v php >/dev/null 2>&1; then
    echo "Error: PHP is required to run Sentinel AI"
    echo "Please install PHP 8.2 or higher"
    exit 1
fi

# Check PHP version
PHP_VERSION=$(php -r "echo PHP_VERSION;" 2>/dev/null)
if [ $? -ne 0 ] || ! php -r "exit(version_compare(PHP_VERSION, '8.2.0', '<') ? 1 : 0);" 2>/dev/null; then
    echo "Error: PHP 8.2 or higher is required. Current version: $PHP_VERSION"
    exit 1
fi

# Run the PHAR with all arguments
exec php "$PHAR_FILE" "$@"
```

#### **macOS Wrapper (`sentinel-macos-x86_64`):**
```bash
#!/bin/bash
# Sentinel AI Native-like Wrapper for macOS

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PHAR_FILE="$SCRIPT_DIR/sentinel.phar"

# Check if PHAR exists
if [ ! -f "$PHAR_FILE" ]; then
    echo "Error: Sentinel AI PHAR not found at $PHAR_FILE"
    exit 1
fi

# Check if PHP is available
if ! command -v php >/dev/null 2>&1; then
    echo "Error: PHP is required to run Sentinel AI"
    echo "Please install PHP 8.2 or higher"
    echo "You can install PHP using Homebrew: brew install php"
    exit 1
fi

# Check PHP version
PHP_VERSION=$(php -r "echo PHP_VERSION;" 2>/dev/null)
if [ $? -ne 0 ] || ! php -r "exit(version_compare(PHP_VERSION, '8.2.0', '<') ? 1 : 0);" 2>/dev/null; then
    echo "Error: PHP 8.2 or higher is required. Current version: $PHP_VERSION"
    echo "You can update PHP using Homebrew: brew upgrade php"
    exit 1
fi

# Run the PHAR with all arguments
exec php "$PHAR_FILE" "$@"
```

#### **Windows Wrapper (`sentinel-windows-x86_64.bat`):**
```batch
@echo off
REM Sentinel AI Native-like Wrapper for Windows

set SCRIPT_DIR=%~dp0
set PHAR_FILE=%SCRIPT_DIR%sentinel.phar

REM Check if PHAR exists
if not exist "%PHAR_FILE%" (
    echo Error: Sentinel AI PHAR not found at %PHAR_FILE%
    exit /b 1
)

REM Check if PHP is available
php --version >nul 2>&1
if errorlevel 1 (
    echo Error: PHP is required to run Sentinel AI
    echo Please install PHP 8.2 or higher
    echo You can download PHP from https://windows.php.net/download/
    exit /b 1
)

REM Run the PHAR with all arguments
php "%PHAR_FILE%" %*
```

### **Step 5: Create Installation Scripts**

#### **Linux/macOS Installer (`install.sh`):**
```bash
#!/bin/bash

# Sentinel AI v{version} Installation Script
# This script installs Sentinel AI on Linux and macOS systems

set -e

echo "🚀 Installing Sentinel AI v{version}..."
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
    echo "🎉 Sentinel AI v{version} is ready to use!"
else
    echo "❌ Installation test failed"
    exit 1
fi
```

#### **Windows Installer (`install.ps1`):**
```powershell
# Sentinel AI v{version} Installation Script for Windows
# This script installs Sentinel AI on Windows systems

param(
    [switch]$Force
)

Write-Host "🚀 Installing Sentinel AI v{version}..." -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ This script requires administrator privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    exit 1
}

# Check if PHP is available
try {
    $phpVersion = php --version 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "PHP not found"
    }
    Write-Host "✅ PHP is available" -ForegroundColor Green
} catch {
    Write-Host "❌ PHP is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install PHP 8.2 or higher first:" -ForegroundColor Yellow
    Write-Host "  Download from: https://windows.php.net/download/" -ForegroundColor Cyan
    Write-Host "  Or use Chocolatey: choco install php" -ForegroundColor Cyan
    exit 1
}

# Check PHP version
try {
    $version = php -r "echo PHP_VERSION;" 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Cannot get PHP version"
    }
    
    $requiredVersion = "8.2.0"
    $currentVersion = [Version]$version
    $requiredVersionObj = [Version]$requiredVersion
    
    if ($currentVersion -lt $requiredVersionObj) {
        Write-Host "❌ PHP 8.2 or higher is required. Current version: $version" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✅ PHP version: $version" -ForegroundColor Green
} catch {
    Write-Host "❌ Error checking PHP version" -ForegroundColor Red
    exit 1
}

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$binaryPath = Join-Path $scriptDir "sentinel-windows-x86_64.bat"
$pharPath = Join-Path $scriptDir "sentinel.phar"

# Check if files exist
if (-not (Test-Path $binaryPath)) {
    Write-Host "❌ Binary not found: $binaryPath" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $pharPath)) {
    Write-Host "❌ PHAR file not found: $pharPath" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Found Sentinel AI files" -ForegroundColor Green

# Install to a directory in PATH
$installDir = "$env:ProgramFiles\SentinelAI"
$installPath = Join-Path $installDir "sentinel.bat"

Write-Host "📦 Installing to $installPath..." -ForegroundColor Yellow

# Create installation directory
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

# Copy files
Copy-Item $binaryPath $installPath -Force
Copy-Item $pharPath (Join-Path $installDir "sentinel.phar") -Force

# Add to PATH if not already there
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($currentPath -notlike "*$installDir*") {
    $newPath = "$currentPath;$installDir"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
    Write-Host "✅ Added Sentinel AI to system PATH" -ForegroundColor Green
} else {
    Write-Host "✅ Sentinel AI is already in system PATH" -ForegroundColor Green
}

Write-Host "✅ Installation complete!" -ForegroundColor Green

# Test installation
Write-Host "🧪 Testing installation..." -ForegroundColor Yellow
try {
    $testResult = & $installPath --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Sentinel AI is now available as 'sentinel'" -ForegroundColor Green
        Write-Host ""
        Write-Host "Usage examples:" -ForegroundColor Cyan
        Write-Host "  sentinel --version                    # Check version" -ForegroundColor White
        Write-Host "  sentinel analyze src/                 # Analyze code" -ForegroundColor White
        Write-Host "  sentinel autofix src/ --interactive   # Interactive fixes" -ForegroundColor White
        Write-Host "  sentinel --help                      # Show all commands" -ForegroundColor White
        Write-Host ""
        Write-Host "🎉 Sentinel AI v{version} is ready to use!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Note: You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Yellow
    } else {
        throw "Installation test failed"
    }
} catch {
    Write-Host "❌ Installation test failed" -ForegroundColor Red
    exit 1
}
```

### **Step 6: Create Uninstall Scripts**

#### **Linux/macOS Uninstaller (`uninstall.sh`):**
```bash
#!/bin/bash

# Sentinel AI v{version} Uninstall Script
# This script removes Sentinel AI from Linux and macOS systems

set -e

echo "🗑️  Uninstalling Sentinel AI v{version}..."
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
```

#### **Windows Uninstaller (`uninstall.ps1`):**
```powershell
# Sentinel AI v{version} Uninstall Script for Windows
# This script removes Sentinel AI from Windows systems

param(
    [switch]$Force
)

Write-Host "🗑️  Uninstalling Sentinel AI v{version}..." -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Yellow

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ This script requires administrator privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    exit 1
}

# Check if Sentinel AI is installed
$installDir = "$env:ProgramFiles\SentinelAI"
$installPath = Join-Path $installDir "sentinel.bat"

if (-not (Test-Path $installPath)) {
    Write-Host "❌ Sentinel AI is not installed at $installPath" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Found Sentinel AI installation" -ForegroundColor Green

# Remove from PATH
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($currentPath -like "*$installDir*") {
    $newPath = ($currentPath -split ';' | Where-Object { $_ -ne $installDir }) -join ';'
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
    Write-Host "✅ Removed Sentinel AI from system PATH" -ForegroundColor Green
}

# Remove installation directory
Write-Host "📦 Removing Sentinel AI files..." -ForegroundColor Yellow
Remove-Item -Path $installDir -Recurse -Force

Write-Host "✅ Uninstallation complete!" -ForegroundColor Green
Write-Host "🎉 Sentinel AI has been removed from your system." -ForegroundColor Green
Write-Host ""
Write-Host "Note: You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Yellow
```

### **Step 7: Create Documentation**

#### **Release Notes (`RELEASE_NOTES.md`):**
Create comprehensive release notes following the template from `v1.0.6/RELEASE_NOTES.md`

#### **Quick Start Guide (`QUICK_START.md`):**
Create a quick start guide following the template from `v1.0.6/QUICK_START.md`

### **Step 8: Generate Checksums**
```bash
cd /Users/abdul/Sites/sentinel-ai-releases/releases/v{new-version}
sha256sum * > v{new-version}-checksums.txt
```

### **Step 9: Make Scripts Executable**
```bash
chmod +x install.sh uninstall.sh sentinel-linux-x86_64 sentinel-macos-x86_64
```

### **Step 10: Update Main README**
Update the main `README.md` to point to the new version:

```markdown
### **Automated Installation (Recommended)**

```bash
# Latest version (v{new-version})
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/releases/v{new-version}/install.sh | bash
```
```

### **Step 11: Commit and Push**
```bash
cd /Users/abdul/Sites/sentinel-ai-releases
git add .
git commit -m "feat: add v{new-version} release with all platform binaries and installation scripts"
git push origin main
```

## 🔧 **File Naming Conventions**

### **✅ Correct Naming:**
- `sentinel.phar` - PHAR file (always lowercase)
- `sentinel-linux-x86_64` - Linux wrapper (lowercase with hyphens)
- `sentinel-macos-x86_64` - macOS wrapper (lowercase with hyphens)
- `sentinel-windows-x86_64.bat` - Windows wrapper (lowercase with hyphens)
- `install.sh` - Linux/macOS installer (lowercase)
- `install.ps1` - Windows installer (lowercase)
- `uninstall.sh` - Linux/macOS uninstaller (lowercase)
- `uninstall.ps1` - Windows uninstaller (lowercase)
- `RELEASE_NOTES.md` - Release notes (UPPERCASE)
- `QUICK_START.md` - Quick start guide (UPPERCASE)
- `v{version}-checksums.txt` - Checksums (lowercase with version)

### **❌ Avoid These:**
- `Sentinel.phar` - Don't use uppercase
- `sentinel_linux` - Don't use underscores
- `install.bat` - Use .ps1 for Windows PowerShell
- `README.md` - Use specific names for version-specific files

## 📋 **Checklist for AI Assistants**

Before creating a new release, ensure:

- [ ] **Version directory** exists: `releases/v{new-version}/`
- [ ] **PHAR file** is copied from main repository
- [ ] **Platform wrappers** are created for all OS
- [ ] **Installation scripts** are created for all platforms
- [ ] **Uninstall scripts** are created for all platforms
- [ ] **Documentation** is created (release notes, quick start)
- [ ] **Checksums** are generated
- [ ] **Scripts are executable** (chmod +x)
- [ ] **Main README** is updated to point to new version
- [ ] **No redundant files** in root directory
- [ ] **All files committed** and pushed

## 🚨 **Common Mistakes to Avoid**

### **❌ Don't Put Files in Root Directory:**
- Never put `sentinel.phar` in root
- Never put installers in root
- Never put wrappers in root

### **❌ Don't Skip Version Directory:**
- Always create `releases/v{version}/` directory
- Never put files directly in `releases/`

### **❌ Don't Forget Executable Permissions:**
- Always run `chmod +x` on shell scripts
- Always run `chmod +x` on binary wrappers

### **❌ Don't Forget Documentation:**
- Always create release notes
- Always create quick start guide
- Always update main README

## 🎯 **Summary for AI Assistants**

When creating a new Sentinel AI release:

1. **ALWAYS** use the `releases/v{version}/` directory structure
2. **NEVER** put binaries or installers in the root directory
3. **ALWAYS** create platform-specific wrappers and installers
4. **ALWAYS** include comprehensive documentation
5. **ALWAYS** generate checksums for file integrity
6. **ALWAYS** update the main README to point to the new version
7. **ALWAYS** make scripts executable
8. **ALWAYS** commit and push all changes

Following these guidelines ensures consistent, professional releases that are easy for users to download and install.

---

**Last Updated:** August 24, 2025  
**Version:** 1.0  
**For AI Assistants:** Follow this guide strictly for all future releases
