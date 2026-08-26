# Environments
$env.config.show_banner = false
$env.config.buffer_editor = "hx"

# Aliases
alias cm = chezmoi
alias cme = chezmoi edit --watch

# and print custom banner
print $"Nushell (version | get version)"
let $start_date = date now

# Mise
mkdir ($nu.data-dir | path join "vendor/autoload")
^mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/mise.nu")

# oh-my-posh
oh-my-posh init nu --config ~/.config/oh-my-posh/themes/spaceship_customized.omp.yaml

# zoxide
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

# snip
# source 'C:\Users\maksim.kolibaba\.amasia\nushell\config.nu'

print $"Loading personal and system profiles took (((date now) - $start_date) | format duration ms)."

# commands
def posh [...params: string] {
    $params | str join " " | pwsh -c $in
}

def --env refreshenv [] {
    let user_path = registry query --hkcu environment | where name == Path | get value | split row ';' |
         where { |x| $x != '' }
    let sys_path = registry query --hklm 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | where name == Path | get value | 
        split row ';' | where { |x| $x != '' }

    let out = $user_path ++ $sys_path ++ $env.path | uniq --ignore-case
    $env.path = $out
}

def gitgone [] {
    # gently try to delete merged branches, excluding the checked out one
    git branch --merged | lines | where $it !~ '\*' | str trim | where $it != 'master' and $it != 'main' | each { |it| git branch -d $it }
}

def pill [] {
    print "💊 This is your memory pill
💻 Nushell commands
- Alt+C - change directory (fzf supported)
- Ctrl+R - history (fzf supported)
- Ctrl+T - search files in current directory recursively (fzf supported)
🏡 Chezmoi commands:
cm - alias for chezmoi
chezmoi edit --watch <file> (cme <file>) - edit file and apply changes whenever it saved
chezmoi edit - open source directory in editor"}
