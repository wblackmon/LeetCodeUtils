<#
Check-In Script (Automatic Commit & Push)
=========================================

This script performs a clean, deterministic check-in workflow:

• Builds and tests the solution (fail-fast)
• Automatically stages all changes
• Automatically generates a commit message (unless provided)
• Creates the commit
• Pushes to the current branch

NOTES:
• This script does NOT require a clean working tree
• This script does NOT modify files (no formatting, no linting)
• This script does NOT tag or publish
• Use tag-release.ps1 for versioning and releases
#>

param(
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"

# Ensure inside a Git repo
$insideRepo = git rev-parse --is-inside-work-tree 2>$null
if (-not $insideRepo) {
    Write-Host "ERROR: Not inside a git repository."
    exit 1
}

Write-Host "=== Building ==="
dotnet build LeetCodeUtils.sln -c Release --no-restore

Write-Host "=== Testing ==="
dotnet test LeetCodeUtils.sln -c Release --no-build

# Stage all changes (even if working tree was dirty)
git add -A

# Auto-generate commit message if none provided
if (-not $Message) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Message = "Check-in: build/test passed at $timestamp"
}

git commit -m "$Message"

# Push to current branch
$currentBranch = git rev-parse --abbrev-ref HEAD
git push origin $currentBranch

Write-Host "=== Check-in complete on branch '$currentBranch' ==="
