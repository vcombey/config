# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git
        poetry
)
source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)
export PNPM_HOME="/Users/vcombey/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/util-linux/bin:$PATH"
alias cursor="/Applications/Cursor.app/Contents/MacOS/Cursor"
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm use 22
autoload -U add-zsh-hook