$requiredTools = @(
    @{Name = "chezmoi"; Package = "twpayne.chezmoi"}
    @{Name = "git"; Package = "Git.Git"}
    @{Name = "pwsh"; Package = "Microsoft.PowerShell"}
    @{Name = "wt"; Package = "Microsoft.WindowsTerminal"}
    @{Name = "difft"; Package = "Wilfred.difftastic"}
    @{Name = "nu"; Package = "Nushell.Nushell"}
    @{Name = "bw"; Package = "Bitwarden.CLI"}
    @{Name = "mise"; Package = "jdx.mise"}
)

foreach ($tool in $requiredTools) {
    if (!(Get-Command $tool.Name -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $($tool.Name)..." -ForegroundColor Yellow
        try {
            winget install --source winget --accept-package-agreements $tool.Package
        }
        catch {
            Write-Error "Failed to install $($tool.Name): $($_.Exception.Message)"
            exit 1
        }
    } else {
        Write-Host "$($tool.Name) is already installed" -ForegroundColor Green
    }
}

setx "BW_SESSION" (bw unlock --raw)

nu -c '(bw get item "chezmoi age key") | from json | get notes | save -f ~/.config/chezmoi/key.txt'

mise install
