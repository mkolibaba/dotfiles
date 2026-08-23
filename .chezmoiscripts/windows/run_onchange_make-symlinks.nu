print $"(ansi yellow)🔮 Setting symlinks...(ansi reset)"

mklink /d $'($env.LOCALAPPDATA)\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState' $'($env.USERPROFILE)\.config\wt'