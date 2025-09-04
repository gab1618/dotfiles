FROM archlinux

RUN pacman -Syu --noconfirm && \
  pacman -S zsh neovim tmux git sway swaybg waybar --noconfirm

RUN chsh -s /bin/zsh

WORKDIR /root

COPY ./files .

# Install spaceship zsh theme
RUN rm -rf "/root/.oh-my-zsh/custom/themes/spaceship.zsh-theme" && \
  ln -s "/root/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "/root/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# Install Tmux tpm
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
  ~/.tmux/plugins/tpm/bin/install_plugins

ENTRYPOINT ["/bin/zsh"]
