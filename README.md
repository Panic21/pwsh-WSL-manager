# WSL Service Manager

A PowerShell 7 module for managing the Windows Subsystem for Linux (WSL) Service.

## Features

- **Get-WSLService**: Get the status of the WSL Service
- **Start-WSLService**: Start the WSL Service
- **Stop-WSLService**: Stop the WSL Service
- **Suspend-WSLService**: Pause the WSL Service
- **Resume-WSLService**: Resume the WSL Service from a paused state

## Requirements

- PowerShell 7.0 or higher
- Windows with WSL installed
- Administrator privileges

## Installation

### Option 1: Manual Installation

1. Clone or download this repository
2. Copy the module to your PowerShell modules directory:

```powershell
# For current user
Copy-Item -Path .\WSLServiceManager -Destination "$env:USERPROFILE\Documents\PowerShell\Modules\" -Recurse

# For all users (requires admin)
Copy-Item -Path .\WSLServiceManager -Destination "$env:ProgramFiles\PowerShell\Modules\" -Recurse
```

### Option 2: Import from Directory

```powershell
Import-Module .\WSLServiceManager.psd1
```

## Usage

**Important**: All commands (except `Get-WSLService`) require administrator privileges. Run PowerShell as Administrator before using these cmdlets.

### Get the WSL Service Status

```powershell
Get-WSLService
```

Returns an object with `Name`, `DisplayName`, and `Status` properties:

```powershell
# Check status and conditionally start
$service = Get-WSLService
if ($service.Status -ne 'Running') {
    Start-WSLService
}
```

### Start the WSL Service

```powershell
Start-WSLService
```

### Stop the WSL Service

```powershell
Stop-WSLService
```

### Suspend (Pause) the WSL Service

```powershell
Suspend-WSLService
```

### Resume the WSL Service

```powershell
Resume-WSLService
```

### Using WhatIf and Confirm

All cmdlets support `-WhatIf` and `-Confirm` parameters:

```powershell
# See what would happen without actually doing it
Stop-WSLService -WhatIf

# Prompt for confirmation before executing
Stop-WSLService -Confirm
```

### Using Verbose Output

```powershell
Start-WSLService -Verbose
```

## Examples

### Example 1: Restart WSL Service

```powershell
Stop-WSLService
Start-Sleep -Seconds 2
Start-WSLService
```

### Example 2: Temporarily Pause WSL Service

```powershell
# Pause the service
Suspend-WSLService

# Do some work...

# Resume the service
Resume-WSLService
```

### Example 3: Check Status Before and After

```powershell
Get-WSLService
Start-WSLService
Get-WSLService
```

## Troubleshooting

### Service Not Found

If you receive an error that the service cannot be found, ensure WSL is installed on your system:

```powershell
wsl --status
```

### Permission Denied

Ensure you are running PowerShell as Administrator. Right-click PowerShell and select "Run as Administrator".

### Service Cannot Be Paused

Not all services support pausing. If the WSL Service does not support pause/resume operations, you will see an appropriate error message. In such cases, use `Stop-WSLService` and `Start-WSLService` instead.

## License

This project is provided as-is without warranty.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.
