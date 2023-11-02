# My dotfiles

### Load configurations locally:
```bash
./load.sh 
```

### Save current configurations:
```bash
./save.sh
```

### Load WSL-only configurations(exclude the wm and visual resources dotfiles):
```bash
./load-wsl.sh
```
This only loads neovim, tmux and zsh

### Remove all saved dotfiles:
```bash
./clean.sh
```
This is usefull if you are editing the scripts since all scripts and dotfiles are in the same directory

You may need to give execution permission to the scripts:
```bash
chmod +x ./load.sh
chmod +x ./save.sh
chmod +x ./load-wsl.sh
chmod +x ./clean.sh
```

## Dependencies

* Neovim
* zsh + oh-my-zsh
* i3 + polybar + Picom + rofi
