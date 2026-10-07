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

# 4. Prompt the user for the key or file path
$ageIdentity = Read-Host "Enter age identity file location OR the key itself"

# Define destination paths using platform-agnostic constants
$chezmoiConfigDir = Join-Path $HOME ".config\chezmoi"
$keyPath = Join-Path $chezmoiConfigDir "key.txt"

# Ensure the destination directory exists before writing the file
if (!(Test-Path $chezmoiConfigDir)) {
    New-Item -ItemType Directory -Path $chezmoiConfigDir -Force | Out-Null
}

# 5. Robust input validation logic
# Check if the input points to an existing file on the disk
if (Test-Path $ageIdentity -PathType Leaf) {
    # If it's a file, read its content and save it to key.txt
    Get-Content -Path $ageIdentity -Raw | Out-File -FilePath $keyPath -Encoding utf8
    Write-Host "Key successfully copied from file to $keyPath" -ForegroundColor Green
} 
# Check if the input points to a directory (user error)
elseif (Test-Path $ageIdentity -PathType Container) {
    Throw "The specified path is a directory, not a key file!"
} 
# Treat the input strictly as a plaintext string key if no physical file matches
else {
    $ageIdentity | Out-File -FilePath $keyPath -Encoding utf8
    Write-Host "Plaintext key successfully written to $keyPath" -ForegroundColor Green
}
