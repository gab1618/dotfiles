. "$HOME/.cargo/env"

export SPRING_HOME="$HOME/.spring"
export PATH="$PATH:$SPRING_HOME/bin"
export GCM_CREDENTIAL_STORE="cache"
export GOPATH="$HOME/gopath"
export PATH="$PATH:$GOPATH/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# set JAVA_HOME in asdf integration
#. ~/.asdf/plugins/java/set-java-home.zsh

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export ANDROID_TOOLS_PATH="$ANDROID_HOME/build-tools/35.0.0/"
export PATH="$PATH:$ANDROID_TOOLS_PATH"

export GTK_THEME=catppuccin-mocha-flamingo-standard+default

#autoload -U +X bashcompinit && bashcompinit
#complete -o nospace -C /usr/bin/terraform terraform
