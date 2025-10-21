@{
    # Module Loader File
    RootModule = 'WSLServiceManager.psm1'

    # Version Number
    ModuleVersion = '1.1.0'

    # Supported PSEditions
    CompatiblePSEditions = @('Core', 'Desktop')

    # ID used to uniquely identify this module
    GUID = 'a7d8e4f1-3b9c-4d2e-8f6a-1c5b7d9e2a4f'

    # Author
    Author = 'WSL Service Manager'

    # Company
    CompanyName = 'Unknown'

    # Copyright
    Copyright = '(c) 2025. All rights reserved.'

    # Module Description
    Description = 'PowerShell module for managing the Windows Subsystem for Linux (WSL) Service. Provides cmdlets to start, stop, suspend, and resume the WSL Service.'

    # Minimum PowerShell Version
    PowerShellVersion = '6.0'

    # Functions to Export
    FunctionsToExport = @(
        'Start-WSLService',
        'Stop-WSLService',
        'Suspend-WSLService',
        'Resume-WSLService',
        'Get-WSLService'
    )

    # Cmdlets to Export
    CmdletsToExport = @()

    # Variables to Export
    VariablesToExport = @()

    # Aliases to Export
    AliasesToExport = @()

    # Private Data
    PrivateData = @{
        PSData = @{
            Tags = @('WSL', 'Windows', 'Service', 'Management', 'Linux')
            LicenseUri = ''
            ProjectUri = ''
            IconUri = ''
            ReleaseNotes = 'v1.1.0: Added Get-WSLService cmdlet to query service status. Fixed service name from "WSL Service" string to "WSLService" service name.'
        }
    }

    # HelpInfo URI
    HelpInfoURI = ''

    # Default Prefix for Commands
    # DefaultCommandPrefix = ''
}
