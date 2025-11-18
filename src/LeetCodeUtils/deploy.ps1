param(
    [string]$Configuration = "Release",
    [string]$Version = "1.0.0",
    [string]$ApiKey = "",
    [string]$Source = "https://api.nuget.org/v3/index.json",
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
    -ApiKey <string>                 NuGet API key (optional, required for publish)
    -Source <url>                    NuGet source (default: https://api.nuget.org/v3/index.json)
    -Help                            Show this usage information

Examples:
    ./deploy.ps1
        Build, test, and pack with default settings.

    ./deploy.ps1 -Version 1.0.1
        Build, test, and pack version 1.0.1.

    ./deploy.ps1 -Version 1.0.1 -ApiKey "YOUR_NUGET_API_KEY"
        Build, test, pack, and publish version 1.0.1 to NuGet.org.
"@
}

if ($Help) {
    Show-Usage
    exit 0
}

Write-Host "=== Deploying LeetCodeUtils ==="

# Step 1: Restore dependencies
dotnet restore LeetCodeUtils.sln

# Step 2: Build solution
dotnet build LeetCodeUtils.sln -c $Configuration --no-restore

# Step 3: Run tests
dotnet test LeetCodeUtils.sln -c $Configuration --no-build

# Step 4: Pack NuGet package
dotnet pack src/LeetCodeUtils/LeetCodeUtils.csproj `
    -c $Configuration `
    -p:PackageVersion=$Version `
    -o ./artifacts

Write-Host "=== Package created in ./artifacts ==="

# Step 5: Push to NuGet (if API key provided)
if (![string]::IsNullOrEmpty($ApiKey)) {
    $nupkg = Get-ChildItem ./artifacts/*.nupkg | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($nupkg) {
        Write-Host "=== Publishing $($nupkg.Name) to NuGet ==="
        dotnet nuget push $nupkg.FullName --api-key $ApiKey --source $Source
    } else {
        Write-Host "No .nupkg file found in ./artifacts"
    }
} else {
    Write-Host "Skipping NuGet publish (no API key provided)"
}

Write-Host "=== Deploy script finished ==="
