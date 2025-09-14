.PHONY: help
help:
	@echo "Commands available"
	@echo "[install]: replace all your settings with this repo's"
	@echo "[fetch]: fetch your current config files to the repo"

.PHONY: install-full
install-full:
	@echo "Installing full distribution..."
	mkdir -p ~/.config

	cp ./src/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	cp -r ./src/.config/nvim ~/.config
	cp -r ./src/.config/sway ~/.config
	cp -r ./src/.config/wofi ~/.config
	cp -r ./src/.config/kitty ~/.config
	cp -r ./src/.config/waybar ~/.config
	cp -r ./src/.config/eww ~/.config
	cp -r ./src/.config/hypr ~/.config
	cp ./src/.zshrc ~/.zshrc
	cp ./src/.p10k.zsh ~/.p10k.zsh


.PHONY: install-cli
install-cli:
	@echo "Installing command line distribution..."
	mkdir -p ~/.config

	cp ./src/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	cp -r ./src/.config/nvim ~/.config
	cp ./src/.zshrc ~/.zshrc
	cp ./src/.p10k.zsh ~/.p10k.zsh

.PHONY: fetch
fetch:
	cp ~/.config/tmux/tmux.conf ./src/.config/tmux/tmux.conf
	cp -r ~/.config/nvim ./src/.config/
	cp -r ~/.config/sway ./src/.config/
	cp -r ~/.config/wofi ./src/.config/
	cp -r ~/.config/kitty ./src/.config/
	cp -r ~/.config/waybar ./src/.config/
	cp -r ~/.config/eww ./src/.config/
	cp -r ~/.config/hypr ./src/.config/
	cp ~/.zshrc ./src/.zshrc
	cp ~/.p10k.zsh ./src/.p10k.zsh

.PHONY: build-image
build-image:
	podman build -t dotfiles .
