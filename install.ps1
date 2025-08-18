# Sentinel AI Official PowerShell Installer for Windows
# Downloads and installs Sentinel AI for Windows systems

param(
    [switch]$Force,
    [string]$InstallPath = "$env:LOCALAPPDATA\Programs\SentinelAI",
    [switch]$Global
)

# Colors for output
$ErrorColor = "Red"
$SuccessColor = "Green"  
$InfoColor = "Cyan"
$WarningColor = "Yellow"

# Configuration
$RepoOwner = "abdulbaquee"
$ReleasesRepo = "sentinel-ai-releases"
$GitHubAPI = "https://api.github.com/repos/$RepoOwner/$ReleasesRepo"

function Write-Info { param($Message) Write-Host "[INFO] $Message" -ForegroundColor $InfoColor }
function Write-Success { param($Message) Write-Host "[SUCCESS] $Message" -ForegroundColor $SuccessColor }
function Write-Warning { param($Message) Write-Host "[WARNING] $Message" -ForegroundColor $WarningColor }
function Write-Error { param($Message) Write-Host "[ERROR] $Message" -ForegroundColor $ErrorColor }

Write-Host "🚀 Sentinel AI Official Windows Installer" -ForegroundColor $InfoColor
Write-Host "=========================================" -ForegroundColor $InfoColor

# Check PowerShell version
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Error "PowerShell 5.0 or higher is required. Current version: $($PSVersionTable.PSVersion)"
    exit 1
}

# Check internet connectivity
Write-Info "Checking internet connectivity..."
try {
    $null = Invoke-WebRequest -Uri "https://github.com" -UseBasicParsing -TimeoutSec 5
} catch {
    Write-Error "No internet connection. Please check your network and try again."
    exit 1
}

# Get latest release version
Write-Info "Fetching latest release information..."
try {
    $releaseInfo = Invoke-RestMethod -Uri "$GitHubAPI/releases/latest" -UseBasicParsing
    $Version = $releaseInfo.tag_name -replace '^v', ''
} catch {
    Write-Warning "Failed to fetch latest version from API, using fallback..."
    $Version = "1.0.6"  # Fallback version
}

Write-Host "Latest version: $Version" -ForegroundColor $InfoColor
Write-Host "Repository: github.com/$RepoOwner/$ReleasesRepo" -ForegroundColor $InfoColor
Write-Host ""

# Check if PHP is installed
Write-Info "Checking PHP installation..."
try {
    $phpVersion = & php --version 2>$null | Select-Object -First 1
    Write-Success "PHP is available: $phpVersion"
} catch {
    Write-Error "PHP is not installed or not in PATH"
    Write-Info "Please install PHP 8.2+ from: https://windows.php.net/download/"
    Write-Info "Or use Chocolatey: choco install php"
    exit 1
}

# Download and install
$PharUrl = "https://github.com/$RepoOwner/$ReleasesRepo/releases/download/v$Version/sentinel.phar"
Write-Info "Downloading Sentinel AI v$Version..."

try {
    $InstallDir = "$env:LOCALAPPDATA\Programs\SentinelAI"
    if (!(Test-Path $InstallDir)) { New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null }
    
    Invoke-WebRequest -Uri $PharUrl -OutFile "$InstallDir\sentinel.phar" -UseBasicParsing
    
    # Create wrapper batch file
    $WrapperContent = '@echo off
php "%~dp0sentinel.phar" %*'
    Set-Content -Path "$InstallDir\sentinel.bat" -Value $WrapperContent
    
    Write-Success "Installation completed to: $InstallDir"
    Write-Info "Run: $InstallDir\sentinel.bat --version"
    
} catch {
    Write-Error "Installation failed: $($_.Exception.Message)"
    exit 1
}
