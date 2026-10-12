const autoload_dir = $nu.data-dir | path join "vendor" "autoload"
mkdir $autoload_dir
mise activate nu | save -f ($autoload_dir | path join "mise.nu")

fzf --nushell | save -f ($nu.data-dir | path join vendor autoload _fzf_integration.nu)

oh-my-posh init nu --config ~/.config/oh-my-posh/themes/mkolibaba.omp.yaml

zoxide init nushell | save -f ($nu.data-dir | path join vendor autoload zoxide.nu)
