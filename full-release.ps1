<#
Full Release Script
===================
Performs:
1. Check-in (auto-stage + auto-commit)
2. Version bump (Patch/Minor/Major or explicit)
3. Tag creation
4. Push commit + tag
5. Trigger GitHub Actions NuGet publish

Deterministic, idempotent, safe.
#>

param(
    [string]$Version = "",
    [switch]$Patch,
    [switch]$Minor,
    [switch]$Major,
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"

# Ensure inside a Git repo
$isRepo = & git rev-parse --is-inside-work-tree 2>$null
if (-not $isRepo) {
    Write-Host "ERROR: Not inside a git repository."
    exit 1
}

# Always fetch tags so version detection is correct
git fetch --tags --force

# Auto-stage everything
git add -A

# Auto-generate commit message if none provided
if (-not $Message) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Message = "Release prep: auto-commit at $timestamp"
}

# Commit only if needed
try {
    git commit -m "$Message"
} catch {
    Write-Host "No changes to commit. Continuing..."
}

# Version helpers
function Get-CurrentVersion {
    $tags = git tag --list | Where-Object { $_ -match '^v?\d+\.\d+\.\d+$' }
    if (-not $tags) { return "0.0.0" }

    $latestTag = $tags |
        ForEach-Object {
            [pscustomobject]@{
                Raw = $_
                Version = $_.TrimStart('v')
                Parts = [int[]]($_.TrimStart('v').Split('.'))
            }
        } |
        Sort-Object -Property @{ Expression = { $_.Parts[0] } }, @{ Expression = { $_.Parts[1] } }, @{ Expression = { $_.Parts[2] } } |
        Select-Object -Last 1

    return $latestTag.Version
}

function New-PatchVersion([string]$v) {
    $parts = $v.Split(".")
    return "$($parts[0]).$($parts[1]).$([int]$parts[2] + 1)"
}

function New-MinorVersion([string]$v) {
    $parts = $v.Split(".")
    return "$($parts[0]).$([int]$parts[1] + 1).0"
}

function New-MajorVersion([string]$v) {
    $parts = $v.Split(".")
    return "$([int]$parts[0] + 1).0.0"
}

# Determine version
$current = Get-CurrentVersion

if ($Patch) {
    $Version = New-PatchVersion $current
}
elseif ($Minor) {
    $Version = New-MinorVersion $current
}
elseif ($Major) {
    $Version = New-MajorVersion $current
}
elseif (-not $Version) {
    Write-Host "ERROR: Must specify -Version or -Patch or -Minor or -Major"
    exit 1
}

# Validate version format
if ($Version -notmatch '^\d+\.\d+\.\d+$') {
    Write-Host "ERROR: Invalid version format. Expected X.Y.Z"
    exit 1
}

$tagName = "v$Version"

# Prevent duplicate tags
$existing = git tag --list $tagName
if ($existing) {
    Write-Host "ERROR: Tag $tagName already exists. Aborting."
    exit 1
}

Write-Host "Creating tag: $tagName"
git tag $tagName

Write-Host "Pushing commit + tag"
git push origin HEAD
git push origin $tagName

Write-Host "Tag $tagName pushed. GitHub Actions will publish via Trusted Publishing or API key."
