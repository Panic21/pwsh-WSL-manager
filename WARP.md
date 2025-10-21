# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Overview

WSLServiceManager is a PowerShell 7 module that manages the Windows Subsystem for Linux (WSL) Service. It provides five cmdlets: `Get-WSLService`, `Start-WSLService`, `Stop-WSLService`, `Suspend-WSLService`, and `Resume-WSLService`. State-changing operations require administrator privileges and include safety features like `-WhatIf` and `-Confirm` support.

## Common Development Commands

### Module Import and Reload
```powershell
# Remove existing module and reload from source
Remove-Module WSLServiceManager -ErrorAction SilentlyContinue
Import-Module (Resolve-Path .\WSLServiceManager.psd1) -Force -Verbose
Get-Command -Module WSLServiceManager
```

### Checking Service Status
```powershell
# Get current WSL service status
Get-WSLService

# Use the returned object
$service = Get-WSLService
$service.Status
$service.Name
```

### Safe Testing with -WhatIf
```powershell
# Test cmdlets without making changes
Start-WSLService -Verbose -WhatIf
Stop-WSLService -Verbose -WhatIf
Suspend-WSLService -Verbose -WhatIf
Resume-WSLService -Verbose -WhatIf

# Skip confirmation prompts
Stop-WSLService -Confirm:$false
```

### Module Validation
```powershell
# Validate module manifest
Test-ModuleManifest -Path .\WSLServiceManager.psd1

# Check for PowerShell best practices (install PSScriptAnalyzer if needed)
if (-not (Get-Module -ListAvailable PSScriptAnalyzer)) { 
    Install-Module PSScriptAnalyzer -Scope CurrentUser -Force 
}
Invoke-ScriptAnalyzer -Path . -Recurse -Severity Error,Warning -ReportSummary
```

### Service Diagnostics
```powershell
# Use module cmdlet to check status
Get-WSLService

# Check service status and capabilities (using service name)
Get-Service WSLService | Format-List Name,DisplayName,Status,CanPauseAndContinue,DependentServices,ServicesDependedOn

# Service details via sc.exe
sc.exe query WSLService

# WSL status and distributions
wsl.exe --status
wsl.exe --list --running

# Check WSL operational logs
Get-WinEvent -LogName "Microsoft-Windows-Lxss/Operational" -MaxEvents 50 | Format-Table TimeCreated,Id,LevelDisplayName,Message -AutoSize
```

## High-Level Architecture

### Module Structure
- **WSLServiceManager.psd1**: Module manifest defining metadata, exports (`Get-WSLService`, `Start-WSLService`, `Stop-WSLService`, `Suspend-WSLService`, `Resume-WSLService`), and PowerShell 7+ requirement
- **WSLServiceManager.psm1**: Core implementation containing all five cmdlets and explicit export statements

### Core Service Management Pattern

#### Read-Only Cmdlets (Get-WSLService)
- **No ShouldProcess**: Read-only cmdlets do not use `[CmdletBinding(SupportsShouldProcess)]`
- **Service Resolution**: Use `Get-Service -Name $ServiceName -ErrorAction Stop` (where `$ServiceName = 'WSLService'`)
- **Return Object**: Return a `[PSCustomObject]` with Name, DisplayName, and Status for pipeline use
- **Interactive Output**: Also `Write-Host` colored status for interactive visibility
- **Error Handling**: Use try/catch with `Write-Error` for service not found scenarios

#### State-Changing Cmdlets (Start/Stop/Suspend/Resume)
All state-changing cmdlets follow a consistent pattern:

1. **Service Resolution**: Use `Get-Service -Name $ServiceName -ErrorAction Stop` to locate the service
2. **Idempotency Check**: Verify current state and exit early with `Write-Verbose` if already in target state
3. **ShouldProcess Gating**: Wrap state changes in `$PSCmdlet.ShouldProcess($ServiceName, "action")` for `-WhatIf`/`-Confirm` support
4. **State Transition**: Call appropriate service cmdlet (`Start-Service`, `Stop-Service`, `Suspend-Service`, `Resume-Service`)
5. **Error Handling**: Use try/catch blocks with `Write-Error` for meaningful error messages

### WSL Service Interaction
- **Service Name**: The module uses the service name `WSLService` (not the display name "WSL Service")
- Uses PowerShell's built-in service cmdlets (backed by .NET ServiceController)
- **Pause Support**: The module checks service status before suspend/resume operations; not all services support pausing
- **Impact Warning**: Stopping or pausing the service interrupts running WSL distributions
- **Dependencies**: WSL Service may have dependent services that are also affected

### Error Handling and Verbose Output
- Consistent use of `-ErrorAction Stop` within try blocks to catch service operation failures
- `Write-Verbose` messages for state discovery and transitions
- `Write-Warning` for invalid state transitions (e.g., trying to resume a stopped service)
- `Write-Host` with color coding for successful operations

### SupportsShouldProcess Implementation
Each cmdlet is declared with `[CmdletBinding(SupportsShouldProcess)]` and uses:
```powershell
if ($PSCmdlet.ShouldProcess($ServiceName, "Start service")) {
    Start-Service -Name $ServiceName -ErrorAction Stop
    Write-Host "WSL Service started successfully." -ForegroundColor Green
}
```

This enables `-WhatIf` (preview changes) and `-Confirm` (prompt before execution) parameters on all cmdlets.