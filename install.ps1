# One-Click Zed Configuration Installer for Windows
# Run with: powershell -ExecutionPolicy Bypass -File .\install.ps1

$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ZedConfigDir = "$env:APPDATA\Zed"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   Installing Zed Custom Configuration...   " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# 1. Ensure Zed config folder exists
if (-not (Test-Path $ZedConfigDir)) {
    New-Item -ItemType Directory -Force -Path $ZedConfigDir | Out-Null
}

# 2. Backup existing configurations if present
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupDir = "$env:APPDATA\Zed_backup_$timestamp"
$existingFiles = Get-ChildItem -Path $ZedConfigDir -File -ErrorAction SilentlyContinue
if ($existingFiles.Count -gt 0) {
    Write-Host "[i] Backing up current Zed config to: $backupDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    Copy-Item "$ZedConfigDir\*" $backupDir -Recurse -Force
}

# 3. Copy config files
$filesToCopy = @('settings.json', 'keymap.json', 'tasks.json', 'debug.json')
foreach ($f in $filesToCopy) {
    $src = Join-Path $ScriptDir $f
    if (Test-Path $src) {
        Copy-Item $src $ZedConfigDir -Force
        Write-Host "[+] Installed $f" -ForegroundColor Green
    }
}

# 4. Copy snippets
$snippetsSrc = Join-Path $ScriptDir 'snippets'
$snippetsDest = Join-Path $ZedConfigDir 'snippets'
if (Test-Path $snippetsSrc) {
    New-Item -ItemType Directory -Force -Path $snippetsDest | Out-Null
    Copy-Item "$snippetsSrc\*" $snippetsDest -Force -Recurse
    Write-Host "[+] Installed custom snippets (java / cpp)" -ForegroundColor Green
}

# 5. Check JAVA_HOME
$javaHome = [System.Environment]::GetEnvironmentVariable('JAVA_HOME', 'User')
if (-not $javaHome) {
    $javaHome = [System.Environment]::GetEnvironmentVariable('JAVA_HOME', 'Machine')
}

if ($javaHome) {
    Write-Host "[+] Detected JAVA_HOME: $javaHome" -ForegroundColor Green
} else {
    Write-Host "[!] JAVA_HOME is not set on this machine." -ForegroundColor Yellow
    Write-Host "    Ensure JDK is installed and JAVA_HOME is added to environment variables." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   Installation Complete! Restart Zed.      " -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
