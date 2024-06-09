export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting command-not-found)

source $ZSH/oh-my-zsh.sh

setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS

export HISTSIZE=50000
export HISTFILESIZE=1000000

alias ll='ls -lh --group-directories-first'
alias publish='git push --follow-tags && npm publish'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Android
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/platform-tools

# Go
# export PATH="$HOME/go/bin:$PATH"

# Docker rootless
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# Local bins
export PATH="$HOME/.local/bin:$PATH"
