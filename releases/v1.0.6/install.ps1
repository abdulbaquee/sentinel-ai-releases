# Sentinel AI v1.0.6 Installation Script for Windows
# This script installs Sentinel AI on Windows systems

param(
    [switch]$Force
)

Write-Host "🚀 Installing Sentinel AI v1.0.6..." -ForegroundColor Green
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
        Write-Host "🎉 Sentinel AI v1.0.6 is ready to use!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Note: You may need to restart your terminal for PATH changes to take effect." -ForegroundColor Yellow
    } else {
        throw "Installation test failed"
    }
} catch {
    Write-Host "❌ Installation test failed" -ForegroundColor Red
    exit 1
}
