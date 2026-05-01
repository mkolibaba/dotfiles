# config.nu
#
# Installed by:
# version = "0.112.2"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

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

print $"Loading personal and system profiles took (((date now) - $start_date) | format duration ms)."