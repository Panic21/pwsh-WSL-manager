#Requires -Version 6.0
#Requires -RunAsAdministrator

<#
.SYNOPSIS
    PowerShell module for managing the WSL Service.

.DESCRIPTION
    This module provides cmdlets to start, stop, suspend (pause), and resume the WSL Service.
#>

$ServiceName = 'WSLService'

<#
.SYNOPSIS
    Starts the WSL Service.

.DESCRIPTION
    Starts the Windows Subsystem for Linux (WSL) service if it is not already running.

.EXAMPLE
    Start-WSLService
    Starts the WSL Service.

.NOTES
    Requires administrator privileges.
#>
function Start-WSLService {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    try {
        $service = Get-Service -Name $ServiceName -ErrorAction Stop
        
        if ($service.Status -eq 'Running') {
            Write-Verbose "WSL Service is already running."
            return
        }

        if ($PSCmdlet.ShouldProcess($ServiceName, "Start service")) {
            Start-Service -Name $ServiceName -ErrorAction Stop
            Write-Host "WSL Service started successfully." -ForegroundColor Green
        }
    }
    catch {
        Write-Error "Failed to start WSL Service: $_"
    }
}

<#
.SYNOPSIS
    Stops the WSL Service.

.DESCRIPTION
    Stops the Windows Subsystem for Linux (WSL) service if it is currently running.

.EXAMPLE
    Stop-WSLService
    Stops the WSL Service.

.NOTES
    Requires administrator privileges.
#>
function Stop-WSLService {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    try {
        $service = Get-Service -Name $ServiceName -ErrorAction Stop
        
        if ($service.Status -eq 'Stopped') {
            Write-Verbose "WSL Service is already stopped."
            return
        }

        if ($PSCmdlet.ShouldProcess($ServiceName, "Stop service")) {
            Stop-Service -Name $ServiceName -Force -ErrorAction Stop
            Write-Host "WSL Service stopped successfully." -ForegroundColor Green
        }
    }
    catch {
        Write-Error "Failed to stop WSL Service: $_"
    }
}

<#
.SYNOPSIS
    Suspends (pauses) the WSL Service.

.DESCRIPTION
    Pauses the Windows Subsystem for Linux (WSL) service if it is currently running.

.EXAMPLE
    Suspend-WSLService
    Pauses the WSL Service.

.NOTES
    Requires administrator privileges.
#>
function Suspend-WSLService {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    try {
        $service = Get-Service -Name $ServiceName -ErrorAction Stop
        
        if ($service.Status -eq 'Paused') {
            Write-Verbose "WSL Service is already paused."
            return
        }

        if ($service.Status -ne 'Running') {
            Write-Warning "WSL Service must be running to pause it. Current status: $($service.Status)"
            return
        }

        if ($PSCmdlet.ShouldProcess($ServiceName, "Pause service")) {
            Suspend-Service -Name $ServiceName -ErrorAction Stop
            Write-Host "WSL Service suspended successfully." -ForegroundColor Green
        }
    }
    catch {
        Write-Error "Failed to suspend WSL Service: $_"
    }
}

<#
.SYNOPSIS
    Resumes the WSL Service.

.DESCRIPTION
    Resumes the Windows Subsystem for Linux (WSL) service if it is currently paused.

.EXAMPLE
    Resume-WSLService
    Resumes the WSL Service.

.NOTES
    Requires administrator privileges.
#>
function Resume-WSLService {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    try {
        $service = Get-Service -Name $ServiceName -ErrorAction Stop
        
        if ($service.Status -eq 'Running') {
            Write-Verbose "WSL Service is already running."
            return
        }

        if ($service.Status -ne 'Paused') {
            Write-Warning "WSL Service must be paused to resume it. Current status: $($service.Status)"
            return
        }

        if ($PSCmdlet.ShouldProcess($ServiceName, "Resume service")) {
            Resume-Service -Name $ServiceName -ErrorAction Stop
            Write-Host "WSL Service resumed successfully." -ForegroundColor Green
        }
    }
    catch {
        Write-Error "Failed to resume WSL Service: $_"
    }
}

<#
.SYNOPSIS
    Gets the status of the WSL Service.

.DESCRIPTION
    Retrieves the current status of the Windows Subsystem for Linux (WSL) service.
    Returns an object with Name, DisplayName, and Status properties.

.EXAMPLE
    Get-WSLService
    Displays the current status of the WSL Service.

.EXAMPLE
    $service = Get-WSLService
    if ($service.Status -ne 'Running') { Start-WSLService }
    Checks if the WSL Service is running and starts it if not.

.NOTES
    This is a read-only operation and does not require confirmation.
#>
function Get-WSLService {
    [CmdletBinding()]
    param()

    try {
        $service = Get-Service -Name $ServiceName -ErrorAction Stop
        Write-Host "$($service.DisplayName): $($service.Status)" -ForegroundColor Yellow
        
        [PSCustomObject]@{
            Name        = $service.Name
            DisplayName = $service.DisplayName
            Status      = $service.Status
        }
    }
    catch {
        Write-Error "Failed to get WSL Service status: $_"
    }
}

# Export module members
Export-ModuleMember -Function @(
    'Start-WSLService',
    'Stop-WSLService',
    'Suspend-WSLService',
    'Resume-WSLService',
    'Get-WSLService'
)
