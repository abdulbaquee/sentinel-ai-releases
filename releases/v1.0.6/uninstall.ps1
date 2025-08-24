# Sentinel AI v1.0.6 Uninstall Script for Windows
# This script removes Sentinel AI from Windows systems

param(
    [switch]$Force
)

Write-Host "🗑️  Uninstalling Sentinel AI v1.0.6..." -ForegroundColor Yellow
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
