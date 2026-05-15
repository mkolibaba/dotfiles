# Disable default banner
$env.config.show_banner = false
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

print $"Loading personal and system profiles took (((date now) - $start_date) | format duration ms)."

# aliases
alias cm = chezmoi

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