#!/bin/bash

set -e

if [ "$(id -u)" = "0" ]; then
  echo "Root is not allowed to run it"
  exit 1
fi

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y git curl wget htop build-essential make

# Personal folder
# TODO: /self

# SSH
cp ./ssh/config ~/.ssh/config

sudo chown "$(whoami)":"$(whoami)" -R ~/.ssh

chmod 700 ~/.ssh

chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub

chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
chmod 644 ~/.ssh/config

eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519

# GPG
gpg --import ~/Desktop/gpg.key
rm ~/Desktop/gpg.key

# ZSH
sudo apt-get install -y zsh
chsh -s $(which zsh)

# OMZ
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# OMZ plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Disable disk swap
sudo swapoff -a
sudo sed -i '/^\/swap\.img/s/^/# /' /etc/fstab

# keyboard shortcuts
# Volume mute/unmute = F10
# Microphone mute/unmute = Ctrl+F10

# Nautilus
touch ~/Templates/Empty\ File
touch ~/Templates/Plain\ Text.txt

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts
nvm use --lts

# NPM
npm config set loglevel http
npm config set progress false
npm config set ignore-scripts true

# Programs (Node)
npm i -g node-gyp

# Programs (Snap)
sudo snap install brave
sudo snap install sublime-text arduino
sudo snap install telegram-desktop discord
sudo snap install obs-studio kdenlive vlc ffmpeg
sudo snap install lxd gnome-boxes

# Programs (APT)
sudo apt-get install -y gufw flameshot guvcview
sudo apt-get install -y whois android-tools-adb

# Docker rootless
sudo curl -sS https://get.docker.com/ | sh
sudo apt-get install -y uidmap
dockerd-rootless-setuptool.sh install

# gufw: Enable status
# flameshot: flameshot config # Enable [startup, copy url after upload] and disable [tray icon]
# flameshot: Change keyboard shurtcut Print = flameshot gui

# Encrypted git repos
sudo apt-get install -y git-remote-gcrypt
npm i -g lukks/gcrypt

# Disable terminal close confirmation
gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false

# Toggle minimize/maximize app on click
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-overview'

# Enable seconds on the clock
gsettings set org.gnome.desktop.interface clock-show-seconds true

# Trim SSD
sudo fstrim -av
