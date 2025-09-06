.PHONY: help
help:
	@echo "Commands available"
	@echo "[install]: replace all your settings with this repo's"
	@echo "[fetch]: fetch your current config files to the repo"

.PHONY: install-full
install-full:
	@echo "Installing full distribution..."
	mkdir -p ~/.config

	cp ./files/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	cp -r ./files/.config/nvim ~/.config
	cp -r ./files/.config/sway ~/.config
	cp -r ./files/.config/wofi ~/.config
	cp -r ./files/.config/kitty ~/.config
	cp -r ./files/.config/waybar ~/.config
	cp -r ./files/.config/eww ~/.config
	cp -r ./files/.config/hypr ~/.config
	cp ./files/.zshrc ~/.zshrc


.PHONY: install-cli
install-cli:
	@echo "Installing command line distribution..."
	mkdir -p ~/.config

	cp ./files/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	cp -r ./files/.config/nvim ~/.config
	cp ./files/.zshrc ~/.zshrc

.PHONY: fetch
fetch:
	cp ~/.config/tmux/tmux.conf ./files/.config/tmux/tmux.conf
	cp -r ~/.config/nvim ./files/.config/
	cp -r ~/.config/sway ./files/.config/
	cp -r ~/.config/wofi ./files/.config/
	cp -r ~/.config/kitty ./files/.config/
	cp -r ~/.config/waybar ./files/.config/
	cp -r ~/.config/eww ./files/.config/
	cp -r ~/.config/hypr ./files/.config/
	cp ~/.zshrc ./files/.zshrc

FULL?=false
.PHONY: build-image
build-image:
	podman build --build-arg INSTALL_GUI=$(FULL) -t dotfiles .
