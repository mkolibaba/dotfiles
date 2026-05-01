$requiredTools = @(
    @{Name = "chezmoi"; Package = "twpayne.chezmoi"}
    @{Name = "git"; Package = "Git.Git"}
    @{Name = "pwsh"; Package = "Microsoft.PowerShell"}
    @{Name = "wt"; Package = "Microsoft.WindowsTerminal"}
    @{Name = "difft"; Package = "Wilfred.difftastic"}
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
