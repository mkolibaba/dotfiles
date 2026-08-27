print $"(ansi yellow)🔮 Setting environment variables...(ansi reset)"

setx "ZELLIJ_CONFIG_DIR" $'($env.USERPROFILE)\.config\zellij'

print $"(ansi yellow)🔮 Setting fzf config...(ansi reset)"

