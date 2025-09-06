FROM archlinux

RUN pacman -Syu --noconfirm && \
  pacman -S zsh neovim tmux git base-devel eza --noconfirm

# For GUI packages: pacman -S sway swaybg waybar kitty grim slurp hyprland hyprpaper

# Configuring git
RUN git config --global user.name "Gabriel C. Brandão" && \
  git config --global user.email "biel.brandao2004@gmail.com" && \
  git config --global core.editor nvim && \
  git config --global rerere.enabled true && \
  git config --global column.ui auto && \
  git config --global init.defaultbranch main;

RUN chsh -s /bin/zsh
ENV ZSH=/root/.oh-my-zsh

WORKDIR /root

COPY ./files .

# Install oh-my-zsh
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH

# Install zsh autosuggestions and syntax highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

# Install spaceship zsh theme
RUN git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt" --depth=1 && \
  ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"

# Install Tmux tpm
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
  ~/.tmux/plugins/tpm/bin/install_plugins

ENTRYPOINT ["/bin/zsh"]
