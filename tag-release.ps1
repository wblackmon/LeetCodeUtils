<#
Tag & Release Script (Automatic Commit + Tag)
============================================

This script:

• Auto-stages all changes
• Auto-commits with a generated message (unless provided)
• Determines the next version (patch bump or manual)
• Creates the tag vX.Y.Z
• Pushes commit + tag to origin
• Triggers GitHub Actions Trusted Publishing

NOTES:
• Does NOT require a clean working tree
• Does NOT modify source files
• Versioning is tag-driven only
#>

param(
    [string]$Version = "",
    [switch]$Patch,
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"

# Ensure inside a Git repo
if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
    Write-Host "ERROR: Not inside a git repository."
    exit 1
}

# Auto-stage everything
git add -A

# Auto-generate commit message if none provided
if (-not $Message) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Message = "Release prep: auto-commit at $timestamp"
}

git commit -m "$Message"

# Determine version
function Get-CurrentVersion {
    $tag = git describe --tags --abbrev=0 2>$null
    if (-not $tag) { return "0.0.0" }
    return $tag.TrimStart("v")
}

function New-PatchVersion([string]$v) {
    $parts = $v.Split(".")
    $major = [int]$parts[0]
    $minor = [int]$parts[1]
    $patch = [int]$parts[2] + 1
    return "$major.$minor.$patch"
}

if ($Patch) {
    $current = Get-CurrentVersion
    $Version = New-PatchVersion $current
}

if (-not $Version) {
    Write-Host "ERROR: Must specify -Version or -Patch"
    exit 1
}

$tagName = "v$Version"

Write-Host "Creating tag: $tagName"
git tag $tagName

Write-Host "Pushing commit + tag"
git push origin HEAD
git push origin $tagName

Write-Host "Tag $tagName pushed. GitHub Actions will publish via Trusted Publishing."
