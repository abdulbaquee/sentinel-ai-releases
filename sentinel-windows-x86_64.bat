@echo off
REM Sentinel AI Windows Binary
REM This script provides a native binary experience for Windows

setlocal

set "SCRIPT_DIR=%~dp0"
set "PHAR_FILE=%SCRIPT_DIR%sentinel.phar"

REM Check if PHAR exists
if not exist "%PHAR_FILE%" (
    echo Error: Sentinel AI PHAR not found at %PHAR_FILE%
    exit /b 1
)

REM Check if PHP is available
php --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: PHP is required to run Sentinel AI
    echo Please install PHP 8.2 or higher from https://windows.php.net/download/
    exit /b 1
)

REM Check PHP version (simplified check for Windows)
for /f "tokens=2" %%a in ('php -r "echo PHP_VERSION;"') do set PHP_VERSION=%%a

REM Run the PHAR with all arguments
php "%PHAR_FILE%" %*
