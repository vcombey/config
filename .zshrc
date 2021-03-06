# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export TURBOFISH_ROOT=/home/vcombey/KFS
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH=$PATH:~/Users/vcombey/mongo/bin
export PATH=$PATH:/Users/vcombey/.gem/ruby/2.4.0/bin
export PATH=~/.brew/bin:$PATH
export PATH=/Users/vcombey/.stack/programs/x86_64-osx/ghc-8.4.3/bin:$PATH
# export PATH="$HOME/opt/cross/bin/:$PATH"

export work=$HOME/git/Autopilot/
#export AUTOPILOT_PATH=$HOME/git/Autopilot/
export RUST_SRC_PATH=$HOME/.cargo/bin

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSHRC=~/.zshrc
source $HOME/.cargo/env

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit -m'
alias gd='git diff'
alias gco='git checkout '
alias v='/usr/bin/vim'
alias e='emacs --no-splash'
export EDITOR=vim
alias fix="git diff --name-only | uniq | xargs $EDITOR"
alias 42FileChecker=~/42FileChecker/42FileChecker.sh
plugins=zsh-syntax-highlighting
#source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias work="cd ~/42/mod1/srcs"
fpath+=~/.zfunc

# opam configuration
test -r /Users/vcombey/.opam/opam-init/init.zsh && . /Users/vcombey/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
alias serv="ssh vcombey@34.77.146.200"
alias serv-postgres="ssh vcombey@34.77.118.252"
export PATH=$HOME/.brew/bin:$PATH
