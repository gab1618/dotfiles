FROM archlinux

RUN pacman -Syu --noconfirm && \
  pacman -S zsh neovim tmux git --noconfirm

WORKDIR /root

COPY ./files .

# Install spaceship zsh theme
RUN rm -rf "/root/.oh-my-zsh/custom/themes/spaceship.zsh-theme" && \
  ln -s "/root/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "/root/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

ENTRYPOINT ["/bin/zsh"]
