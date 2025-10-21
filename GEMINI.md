# Project Overview

This project is a PowerShell module for managing the Windows Subsystem for Linux (WSL) Service. It provides a set of cmdlets to control the WSL service, making it easy to start, stop, and check the status of the service from the PowerShell command line.

The main technologies used are:
- **PowerShell 7.0:** The module is written in PowerShell and requires version 7.0 or higher.
- **WSL (Windows Subsystem for Linux):** The module interacts with the WSL service on Windows.

The architecture is a simple PowerShell module consisting of a module manifest (`.psd1`) and a module file (`.psm1`) containing the functions.

# Building and Running

There is no build process for this module. To run the module, you need to import it into your PowerShell session.

## Installation

### Option 1: Manual Installation

1.  Clone or download this repository.
2.  Copy the `WSLServiceManager` directory to your PowerShell modules directory.

For the current user:
```powershell
Copy-Item -Path .\WSLServiceManager -Destination "$env:USERPROFILE\Documents\PowerShell\Modules\" -Recurse
```

For all users (requires administrator privileges):
```powershell
Copy-Item -Path .\WSLServiceManager -Destination "$env:ProgramFiles\PowerShell\Modules\" -Recurse
```

### Option 2: Import from Directory

```powershell
Import-Module .\WSLServiceManager.psd1
```

## Usage

All commands that modify the service require administrator privileges.

- **Get the WSL Service Status:**
  ```powershell
  Get-WSLService
  ```

- **Start the WSL Service:**
  ```powershell
  Start-WSLService
  ```

- **Stop the WSL Service:**
  ```powershell
  Stop-WSLService
  ```

- **Suspend (Pause) the WSL Service:**
  ```powershell
  Suspend-WSLService
  ```

- **Resume the WSL Service:**
  ```powershell
  Resume-WSLService
  ```

# Development Conventions

- **Coding Style:** The PowerShell code follows standard PowerShell conventions, with clear and descriptive function names and comments. The code uses `try...catch` blocks for error handling.
- **Testing:** There are no explicit tests in the repository.
- **Contribution:** The `README.md` mentions that contributions are welcome via issues or pull requests.
- **License:** The project is licensed under the Mozilla Public License 2.0.
