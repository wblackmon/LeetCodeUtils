<#
LeetCodeUtils Deploy Script (Trusted Publishing Edition)
========================================================

This script performs a deterministic local build pipeline:

• Restore
• Build
• Test
• Pack

NOTES:
• This script does NOT publish to NuGet (Trusted Publishing handles that)
• This script does NOT modify version numbers
• This script does NOT create tags
• Use tag-release.ps1 to create version tags that trigger CI/CD
#>

param(
    [string]$Configuration = "Release",
    [string]$Version = "1.0.0",
    [switch]$Help
)

function Show-Usage {
    Write-Host @"
LeetCodeUtils Deploy Script
===========================

Usage:
    ./deploy.ps1 [options]

Options:
    -Configuration <Debug|Release>   Build configuration (default: Release)
    -Version <string>                Package version (default: 1.0.0)
    -Help                            Show this usage information

NOTES:
    • This script does NOT publish
    • Version is only used for local packing
    • GitHub Actions uses the Git tag version for real publishing
"@
}

if ($Help) {
    Show-Usage
    exit 0
}

$ErrorActionPreference = "Stop"

Write-Host "=== Deploying LeetCodeUtils (Local Only) ==="
Write-Host "Configuration: $Configuration"
Write-Host "Version:       $Version"
Write-Host ""

# Ensure artifacts directory exists
if (-not (Test-Path "./artifacts")) {
    New-Item -ItemType Directory -Path "./artifacts" | Out-Null
}

# Clear old packages
Remove-Item ./artifacts/*.nupkg -ErrorAction Ignore

# Step 1: Restore
Write-Host "=== Restoring ==="
dotnet restore LeetCodeUtils.sln

# Step 2: Build
Write-Host "=== Building ==="
dotnet build LeetCodeUtils.sln -c $Configuration --no-restore

# Step 3: Test
Write-Host "=== Testing ==="
dotnet test LeetCodeUtils.sln -c $Configuration --no-build

# Step 4: Pack
Write-Host "=== Packing ==="
dotnet pack src/LeetCodeUtils/LeetCodeUtils.csproj `
    -c $Configuration `
    -p:PackageVersion=$Version `
    -o ./artifacts

Write-Host "=== Local package created in ./artifacts ==="
Write-Host "=== Trusted Publishing will publish when you push a version tag ==="
