$requiredTools = @(
    @{Name = "mise"; Package = "jdx.mise"}
    @{Name = "oh-my-posh"; Package = "JanDeDobbeleer.OhMyPosh"}
    @{Name = "zoxide"; Package = "ajeetdsouza.zoxide"}
    @{Name = "C:\Program Files\Everything\Everything"; Package = "voidtools.Everything"}
    @{Name = "code"; Package = "Microsoft.VisualStudioCode"}
    @{Name = "age"; Package = "FiloSottile.age"}
    @{Name = "hx"; Package = "Helix.Helix"}
)

foreach ($tool in $requiredTools) {
    if (!(Get-Command $tool.Name -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $($tool.Name)..." -ForegroundColor Yellow
        try {
            winget install --source winget --accept-package-agreements $tool.Package
        }
        catch {
            Write-Error "❌ Failed to install $($tool.Name): $($_.Exception.Message)"
            exit 1
        }
    } else {
        Write-Host "✅ $($tool.Name) is already installed" -ForegroundColor Green
    }
}

# VS Code extensions
$vsCodeExtensions = @(
    "andrewbutson.vscode-openapi-viewer",
    "bcwsea.theme-saga",
    "beardedbear.beardedicons",
    "davidmarek.jsonpath-extract",
    "docker.docker",
    "dracula-theme.theme-dracula",
    "editorconfig.editorconfig",
    "fabianreyes.smart-json-schema",
    "github.github-vscode-theme",
    "golang.go",
    "grapecity.gc-excelviewer",
    "k--kato.intellij-idea-keybindings",
    "maattdd.gitless",
    "pkief.material-icon-theme",
    "redhat.vscode-xml",
    "redhat.vscode-yaml",
    "richie5um2.vscode-statusbar-json-path",
    "sangsoonam.vscode-extension-quick-grep",
    "tamasfe.even-better-toml",
    "thenuprojectcontributors.vscode-nushell-lang",
    "tinkertrain.theme-panda",
    "weijunyu.vscode-json-path"
)

foreach ($ext in $vsCodeExtensions) {
    code --install-extension $ext
}