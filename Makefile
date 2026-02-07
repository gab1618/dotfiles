.PHONY: help
help:
	@echo "Commands available"
	@echo "[install]: replace all your settings with this repo's"
	@echo "[fetch]: fetch your current config files to the repo"

.PHONY: install
install:
	mkdir -p ~/.config/tmux
	@echo "Installing..."
	make clean-local

	cp ./src/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	cp -r ./src/config/nvim ~/.config
	cp ./src/zshrc ~/.zshrc
	cp ./src/p10k.zsh ~/.p10k.zsh
	cp -r ./src/config/btop ~/.config

.PHONY: fetch
fetch:
	make clean-repo
	mkdir -p ./src/config/tmux
	cp ~/.config/tmux/tmux.conf ./src/config/tmux/tmux.conf
	cp -r ~/.config/nvim ./src/config/
	cp -r ~/.config/btop ./src/config/
	cp ~/.zshrc ./src/zshrc
	cp ~/.p10k.zsh ./src/p10k.zsh

.PHONY: clean-local
clean-local:
	rm -rf ~/.config/tmux/tmux.conf
	rm -rf ~/.config/nvim
	rm ~/.zshrc
	rm ~/.p10k.zsh
	rm -rf ~/.config/btop

.PHONY: clean-repo
clean-repo:
	rm -rf ./src/*

.PHONY: build-image
build-image:
	podman build -t dotfiles .
