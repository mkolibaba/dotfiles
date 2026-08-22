let vsCodeExtensions = [
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
    "sangsoonam.vscode-extension-quick-grep",
    "tamasfe.even-better-toml",
    "thenuprojectcontributors.vscode-nushell-lang",
    "tinkertrain.theme-panda",
    "weijunyu.vscode-json-path"
]

let installed = ^code --list-extensions | lines

print $"(ansi yellow)🔮 Installing VS Code extensions...(ansi reset)"

$vsCodeExtensions | each { |e|
    if $e in $installed {
        print $"✅ (ansi green)($e) is already installed(ansi reset)"
    } else {
        ^code --install-extension $e
    }
}
