#!/bin/bash

set -e

if [ "$(id -u)" = "0" ]; then
  echo "Root is not allowed to run it"
  exit 1
fi

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y git curl wget htop build-essential make cmake

# Config
cp ./ssh/config ~/.ssh/config
cp ./home/.gitconfig ~/.gitconfig
cp ./home/.zshrc ~/.zshrc
cp ./home/sublime-text.json ~/.config/sublime-text/Packages/User/Preferences.sublime-settings

# SSH and GPG
chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub
chmod 644 ~/.ssh/config

add_ssh_key ~/.ssh/id_ed25519
add_gpg_key ~/Desktop/gpg.key

# ZSH
sudo apt-get install -y zsh
chsh -s $(which zsh)

# OMZ
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# OMZ plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Node
sh -c "$(curl -fsSL https://raw.github.com/mafintosh/node-install/master/install)"
sudo node-install 20

# NPM
npm config set prefix "$HOME/.local"
npm config set loglevel http
npm config set progress false

# Programs (Node)
npm i -g node-gyp
npm i -g create-project
npm i -g clang-standard
npm i -g arduino-cli-runtime
npm i -g iot-dev iot-container

# Programs (Snap)
sudo snap install brave
sudo snap install sublime-text beekeeper-studio
sudo snap install obs-studio kdenlive vlc ffmpeg
sudo snap install lxd gnome-boxes

# Programs (APT)
sudo apt-get install -y golang clang-format
sudo apt-get install -y gufw flameshot guvcview
sudo apt-get install -y whois android-tools-adb
sudo apt-get install -y python3-pip

# Docker rootless
sudo curl -sS https://get.docker.com/ | sh
sudo apt-get install -y uidmap
dockerd-rootless-setuptool.sh install

# Encrypted git repos
sudo apt-get install -y git-remote-gcrypt
npm i -g lukks/gcrypt

# GNOME
gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-overview'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['F10']"
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute "['<Control>F10']"

# TODO: Not working for unknown reason
create_keyboard_shortcut 'Flameshot GUI' 'flameshot gui' 'Print'
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# Disable disk swap
sudo swapoff -a
sudo sed -i '/^\/swap\.img/s/^/# /' /etc/fstab

# Allow ttyUSB0 for logged-in user
sudo cp ./udev/60-extra-acl.rules /etc/udev/rules.d/60-extra-acl.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Firewall
sudo ufw enable

# Nautilus
touch ~/Templates/Empty\ File
touch ~/Templates/Plain\ Text.txt

# Trim SSD
sudo fstrim -av

create_keyboard_shortcut () {
  local media_keys_schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
  local custom_keybinding="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"

  gsettings set "$media_keys_schema":"$custom_keybinding" name "$1"
  gsettings set "$media_keys_schema":"$custom_keybinding" command "$2"
  gsettings set "$media_keys_schema":"$custom_keybinding" binding "$3"
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
