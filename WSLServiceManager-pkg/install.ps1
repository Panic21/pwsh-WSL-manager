# install.ps1

# Set the source and destination paths
$moduleName = 'WSLServiceManager'
$sourcePath = Join-Path $PSScriptRoot $moduleName
$destinationPath = Join-Path $env:USERPROFILE "Documents\PowerShell\Modules"

# Create the destination directory if it doesn't exist
if (-not (Test-Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory -Force
}

# Copy the module files
Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force

Write-Host "WSLServiceManager module installed successfully!"
Write-Host "You can now use the cmdlets in a new PowerShell session."