# Environments
$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.Path = ($env.Path | prepend r#'~\AppData\Local\mise\shims'#) # mise activate nu --shims

# Aliases
alias cm = chezmoi
alias cma = chezmoi apply
alias cme = chezmoi edit
alias e = hx (fzf --preview "open --raw {}")

# Print custom banner
print $"Nushell (version | get version)"
let $start_date = date now

# Autoload
const autoload_dir = $nu.data-dir | path join "vendor" "autoload"
mkdir $autoload_dir
mise activate nu | save -f ($autoload_dir | path join "mise.nu")

# TODO: can it be autoloaded?
source $"($nu.cache-dir)/carapace.nu"
source ~/.local/share/atuin/init.nu

print $"Loading personal and system profiles took (((date now) - $start_date) | format duration ms)."

# Git
def "git select" [] {
  git status -s | gum filter --no-limit | lines | str replace -r '(.+)\s+(.+)' '$2' | each {|it| git add $it} | ignore
}

# commands
def posh [...params: string] {
    $params | str join " " | pwsh -c $in
}

def search-replace [
  pattern: glob,
  old: string,
  new: string
] {
  ls $pattern | each { |it| open --raw $it.name | str replace --all $old $new | save -f $it.name } | ignore
}

def --env refreshenv [] {
    let user_path = registry query --hkcu environment | where name == Path | get value | split row ';' |
         where { |x| $x != '' }
    let sys_path = registry query --hklm 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | where name == Path | get value | 
        split row ';' | where { |x| $x != '' }

    let out = $user_path ++ $sys_path ++ $env.path | uniq --ignore-case
    $env.path = $out
}

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}

def pill [] {
    print "💊 This is your memory pill
💻 Nushell commands
- Alt+C - change directory (fzf supported)
- Ctrl+R - history (fzf supported)
- Ctrl+T - search files in current directory recursively (fzf supported)
🏡 Chezmoi commands:
cm - alias for chezmoi
chezmoi edit <file> (cme <file>) - edit file
chezmoi edit - open source directory in editor"}
