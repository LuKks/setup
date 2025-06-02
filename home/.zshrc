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

if [[ "$OSTYPE" == darwin* ]]; then
  alias ls='gls'

  export GPG_TTY=$(tty)
fi

alias ll='ls -lh --group-directories-first'
alias publish='git push --follow-tags && npm publish'

export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"

export PATH="$HOME/.local/bin:$PATH"
