# Dotfiles

Powered by [chezmoi](https://github.com/twpayne/chezmoi).

Initialize on Windows:
```powershell
Invoke-RestMethod -Uri https://raw.githubusercontent.com/mkolibaba/dotfiles/main/init.ps1 | Invoke-Expression
```

## Chezmoi Command Cheat Sheet
```
chezmoi add ~/.vimrc              # track an existing file
chezmoi add --encrypt ~/.env      # track encrypted
chezmoi edit ~/.zshrc             # edit the source file directly
chezmoi diff                      # show pending changes
chezmoi apply                     # write to $HOME
chezmoi apply --dry-run -v        # preview without writing
chezmoi cd                        # jump to source directory
chezmoi update                    # git pull + apply
chezmoi doctor                    # check environment health
```
