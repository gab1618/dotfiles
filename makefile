.PHONY: help
help:
	@echo "Commands available"
	@echo "[install]: replace all your settings with this repo's"

.PHONY: install
install:
	@echo "Installing..."
	mkdir -p ~/.config
	cp -r ./files/.config/* ~/.config
	cp ./files/.zshrc ~/.zshrc
	cp ./files/.zshenv ~/.zshenv

.PHONY: fetch
fetch:
	mkdir -p ~/.config/tmux/
	cp ~/.config/tmux/tmux.conf ./files/.config/tmux/tmux.conf
	cp -r ~/.config/nvim ./files/.config/
	cp -r ~/.config/sway ./files/.config/
	cp -r ~/.config/wofi ./files/.config/
	cp -r ~/.config/kitty ./files/.config/
	cp -r ~/.config/waybar ./files/.config/
	cp -r ~/.config/eww ./files/.config/
	cp ~/.zshrc ./files/.zshrc
	cp ~/.zshenv ./files/.zshenv
