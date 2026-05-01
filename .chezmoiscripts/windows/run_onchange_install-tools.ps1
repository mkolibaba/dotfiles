$requiredTools = @(
    @{Name = "mise"; Package = "jdx.mise"}
    @{Name = "oh-my-posh"; Package = "JanDeDobbeleer.OhMyPosh"}
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
