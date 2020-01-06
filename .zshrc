# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git
        poetry
)

source $ZSH/oh-my-zsh.sh

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#nvm use 18
source <(kubectl completion zsh)
export NODE_OPTIONS="--max-old-space-size=12048"
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:$PATH"
export ANDROID_HOME=~/Library/Android/sdk/

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


# bun completions
[ -s "/Users/vcombey/.bun/_bun" ] && source "/Users/vcombey/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bit
case ":$PATH:" in
  *":/Users/vcombey/bin:"*) ;;
  *) export PATH="$PATH:/Users/vcombey/bin" ;;
esac
# bit end

# pnpm
export PNPM_HOME="/Users/vcombey/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/opt/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/opt/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<


# place this after nvm initialization!
autoload -U add-zsh-hook

#load-nvmrc() {
#  local nvmrc_path
#  nvmrc_path="$(nvm_find_nvmrc)"
#
#  if [ -n "$nvmrc_path" ]; then
#    local nvmrc_node_version
#    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#
#    if [ "$nvmrc_node_version" = "N/A" ]; then
#      nvm install
#    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
#      nvm use
#    fi
#  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
#    echo "Reverting to nvm default version"
#    nvm use default
#  fi
#}

#add-zsh-hook chpwd load-nvmrc
#load-nvmrc
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"


export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH="$HOME/.local/bin:$PATH"
export MANPATH=$HOME/man:$MANPATH


export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/util-linux/bin:$PATH"

[ -f "/Users/vcombey/.ghcup/env" ] && . "/Users/vcombey/.ghcup/env" # ghcup-env
alias cursor="/Applications/Cursor.app/Contents/MacOS/Cursor"

# Temporarily disabled to debug ANSI escape sequences
 direnv hook zsh >/dev/null 2>&1

export EDITOR=vim
export TERM="xterm-256color"
 if [ -z "$TMUX" ]; then
     # Check if the 'main' session already exists
     if tmux has-session -t main 2>/dev/null; then
         # Session exists, attach to it
         tmux attach -t main
     else
         # Session doesn't exist, create and attach
         tmux new-session -s main
     fi
 fi

