export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME_GIT_SHOW_UPSTREAM="true"
ZSH_THEME="spaceship"
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

bindkey "^n" autosuggest-accept

source $ZSH/oh-my-zsh.sh
source "$HOME/.asdf/asdf.sh"

fpath+=~/.zsh/completions

ZSH_AUTOSUGGEST_STRATEGY=(
  "completion"
  "history"
)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Config alias
alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="nvim ~/.config/nvim"
alias tlist="tmux list-sessions"
alias tconfig="nvim ~/.config/tmux/tmux.conf"
alias cl="clear"
alias pn="pnpm"

