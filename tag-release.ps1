<#
Tag & Release Script
====================

This script automates semantic versioning and release tagging for the
LeetCodeUtils project. It generates a version tag (vX.Y.Z), pushes it to
GitHub, and triggers the GitHub Actions pipeline that builds, tests,
packs, and publishes the package to NuGet via Trusted Publishing.

USAGE:
    ./tag-release.ps1 -Patch
        Automatically bumps the patch version.
        Example: v1.4.2 → v1.4.3

    ./tag-release.ps1 -Version 1.5.0
        Creates and pushes tag v1.5.0.

BEHAVIOR:
    • Ensures the script is run inside a Git repository.
    • Ensures the working tree is clean (no uncommitted changes).
    • Reads the latest Git tag (or defaults to 0.0.0).
    • Computes the new version (auto or manual).
    • Creates a Git tag in the format: vMAJOR.MINOR.PATCH
    • Pushes the tag to origin.
    • GitHub Actions detects the tag and:
        - Builds the solution
        - Runs all tests
        - Packs the NuGet package
        - Publishes to NuGet.org (Trusted Publishing)
        - Creates a GitHub Release with the .nupkg attached

NOTES:
    • This script does NOT build or publish locally.
    • All publishing happens inside GitHub Actions.
    • Tags must follow the format: vX.Y.Z
#>
param(
    [string]$Version = "",
    [switch]$Patch
)

$ErrorActionPreference = "Stop"

if (-not (& git rev-parse --is-inside-work-tree 2 -gt $null)) {
    Write-Host "ERROR: Not inside a git repository."
    exit 1
}

# Ensure clean working tree
$status = git status --porcelain
if ($status) {
    Write-Host "ERROR: Working tree is not clean. Commit or stash changes first."
    exit 1
}

# Determine version
if ($Version -eq "" -and -not $Patch) {
    Write-Host "Usage: ./tag-release.ps1 -Version 1.2.3  OR  ./tag-release.ps1 -Patch"
    exit 1
}

function Get-CurrentVersion {
    $tag = git describe --tags --abbrev=0 2>$null
    if (-not $tag) {
        return "0.0.0"
    }
    return $tag.TrimStart("v")
}

function New-PatchVersion([string]$v) {
    $parts = $v.Split(".")
    if ($parts.Count -ne 3) {
        throw "Invalid version format: $v"
    }
    $major = [int]$parts[0]
    $minor = [int]$parts[1]
    $patch = [int]$parts[2] + 1
    return "$major.$minor.$patch"
}

if ($Patch) {
    $current = Get-CurrentVersion
    $Version = New-PatchVersion $current
}

$tagName = "v$Version"

Write-Host "Creating tag: $tagName"

git tag $tagName
git push origin $tagName

Write-Host "Tag $tagName pushed. GitHub Actions will build, test, pack, and publish."
