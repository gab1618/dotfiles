.PHONY: help
help:
	@echo "Commands available"
	@echo "[install]: replace all your settings with this repo's"
	@echo "[fetch]: fetch your current config files to the repo"

.PHONY: install-full
install-full:
	@echo "Installing full distribution..."
	mkdir -p ~/.config

	make install-cli
	cp -r ./src/config/sway ~/.config
	cp -r ./src/config/wofi ~/.config
	cp -r ./src/config/kitty ~/.config
	cp -r ./src/config/waybar ~/.config
	cp -r ./src/config/eww ~/.config
	cp -r ./src/config/hypr ~/.config

.PHONY: install-cli
install-cli:
	@echo "Installing command line distribution..."
	mkdir -p ~/.config/tmux
	make clean-cli

	cp ./src/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	cp -r ./src/config/nvim ~/.config/nvim
	cp ./src/zshrc ~/.zshrc
	cp ./src/p10k.zsh ~/.p10k.zsh

.PHONY: fetch
fetch:
	make clean-repo
	mkdir -p ./src/config/tmux
	cp ~/.config/tmux/tmux.conf ./src/config/tmux/tmux.conf
	cp -r ~/.config/nvim ./src/config/
	cp -r ~/.config/sway ./src/config/
	cp -r ~/.config/wofi ./src/config/
	cp -r ~/.config/kitty ./src/config/
	cp -r ~/.config/waybar ./src/config/
	cp -r ~/.config/eww ./src/config/
	cp -r ~/.config/hypr ./src/config/
	cp ~/.zshrc ./src/zshrc
	cp ~/.p10k.zsh ./src/p10k.zsh

.PHONY: clean-local
clean-local:
	make clean-cli
	rm -rf ~/.config/sway
	rm -rf ~/.config/wofi
	rm -rf ~/.config/kitty
	rm -rf ~/.config/waybar
	rm -rf ~/.config/eww
	rm -rf ~/.config/hypr

.PHONY: clean-cli
clean-cli:
	rm -rf ~/.config/tmux/tmux.conf
	rm -rf ~/.config/nvim
	rm ~/.zshrc
	rm ~/.p10k.zsh

.PHONY: clean-repo
clean-repo:
	rm -rf ./src/*

.PHONY: build-image
build-image:
	podman build -t dotfiles .
