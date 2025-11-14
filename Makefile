.PHONY: help
help:
	@echo "Commands available"
	@echo "[install]: replace all your settings with this repo's"
	@echo "[fetch]: fetch your current config files to the repo"

.PHONY: install
install:
	@echo "Installing full distribution..."
	mkdir -p ~/.config

	mkdir -p ~/.config/tmux
	cp ./src/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	cp -r ./src/config/nvim ~/.config
	cp ./src/zshrc ~/.zshrc
	cp ./src/p10k.zsh ~/.p10k.zsh
	cp -r ./src/config/kitty ~/.config
	cp -r ./src/config/waybar ~/.config
	cp -r ./src/config/walker ~/.config
	cp -r ./src/config/elephant ~/.config
	cp -r ./src/config/eww ~/.config
	cp -r ./src/config/hypr ~/.config

.PHONY: fetch
fetch:
	make clean-repo
	mkdir -p ./src/config/tmux
	cp ~/.config/tmux/tmux.conf ./src/config/tmux/tmux.conf
	cp -r ~/.config/nvim ./src/config/
	cp -r ~/.config/kitty ./src/config/
	cp -r ~/.config/waybar ./src/config/
	cp -r ~/.config/eww ./src/config/
	cp -r ~/.config/hypr ./src/config/
	cp -r ~/.config/walker ./src/config/
	cp -r ~/.config/elephant ./src/config/
	cp ~/.zshrc ./src/zshrc
	cp ~/.p10k.zsh ./src/p10k.zsh

.PHONY: clean-local
clean-local:
	rm -rf ~/.config/tmux/tmux.conf
	rm -rf ~/.config/nvim
	rm ~/.zshrc
	rm ~/.p10k.zsh
	rm -rf ~/.config/kitty
	rm -rf ~/.config/waybar
	rm -rf ~/.config/eww
	rm -rf ~/.config/hypr
	rm -rf ~/.config/walker
	rm -rf ~/.config/elephant

.PHONY: clean-repo
clean-repo:
	rm -rf ./src/*

.PHONY: build-image
build-image:
	podman build -t dotfiles .
