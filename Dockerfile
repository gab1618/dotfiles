FROM archlinux

ARG INSTALL_GUI=false

RUN pacman -Syu --noconfirm && \
  pacman -S zsh neovim tmux git --noconfirm

COPY ./assets/ /tmp/assets

RUN if [ "$INSTALL_GUI" = "true" ]; then \
    pacman -S sway swaybg waybar --noconfirm; \

    cp -r /tmp/assets/fonts/* /usr/share/fonts/ && \
    echo "Rebuilding font cache..." && \
    fc-cache -f && \
    rm -rf /tmp/assets/fonts && \
    echo "Font installation complete."; \

  else \
    echo "Skipping gui apps install"; \
  fi

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
