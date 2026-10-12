# 1. Install base dependencies using Winget
winget install Git.Git --silent
winget install jdx.mise --silent
winget install Microsoft.PowerShell --silent

# 2. Safely check for Scoop and install if missing
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://scoop.sh | Invoke-Expression
    
    # Refresh PATH in the current session so PowerShell can locate scoop shims immediately
    $env:PATH = "$env:USERPROFILE\scoop\shims;$env:PATH"
}

# 3. Install chezmoi via Scoop
scoop install chezmoi

# 4. Run chezmoi
chezmoi init --apply mkolibaba
