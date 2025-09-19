#!/bin/bash

set -e

if [ "$(id -u)" = "0" ]; then
  echo "Root is not allowed to run it"
  exit 1
fi

main () {
  brew update
  brew upgrade

  brew install git curl wget htop coreutils
  brew install cmake ninja gpg clang-format

  # Config
  cp ./ssh/config ~/.ssh/config
  cp ./home/.gitconfig ~/.gitconfig
  cp ./home/.zshrc ~/.zshrc
  cp ./home/sublime-text.json ~/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings

  git config --global core.excludesFile ~/.gitignore

  # SSH and GPG
  chmod 600 ~/.ssh/*
  chmod 644 ~/.ssh/*.pub
  chmod 644 ~/.ssh/config

  add_ssh_key ~/.ssh/id_ed25519
  add_gpg_key ~/Desktop/gpg.key

  # ZSH
  brew install zsh
  chsh -s $(which zsh)

  # OMZ
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # OMZ plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  # Node
  sh -c "$(curl -fsSL https://raw.github.com/mafintosh/node-install/master/install)"
  sudo node-install 22

  # NPM
  npm config set prefix "$HOME/.local"
  npm config set loglevel http
  npm config set progress false

  # Programs (Node)
  npm i -g create-project

  # Mac
  defaults write com.apple.menuextra.clock ShowSeconds -bool true

  # Sublime
  sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
}

add_ssh_key () {
  local ssh_key="$1"

  if [ -f "$ssh_key" ]; then
    ssh-add "$ssh_key"
  fi
}

add_gpg_key () {
  local gpg_key="$1"

  if [ -f "$gpg_key" ]; then
    gpg --import "$gpg_key"
    rm "$gpg_key"
  fi
}

main
