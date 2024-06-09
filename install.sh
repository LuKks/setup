#!/bin/bash

set -e

if [ "$(id -u)" = "0" ]; then
  echo "Root is not allowed to run it"
  exit 1
fi

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y git curl wget htop build-essential make cmake gcc-multilib

# Config
cp ./ssh/config ~/.ssh/config
cp ./home/.gitconfig ~/.gitconfig
cp ./home/.zshrc ~/.zshrc
cp ./home/sublime-text.json ~/.config/sublime-text/Packages/User/Preferences.sublime-settings

# SSH
chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub
chmod 644 ~/.ssh/config

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
npm i -g create-project
npm i -g arduino-cli-runtime
npm i -g clang-standard
npm i -g esp-container
npm i -g iot-dev

# Programs (Snap)
sudo snap install brave
sudo snap install sublime-text
sudo snap install telegram-desktop discord
sudo snap install obs-studio kdenlive vlc ffmpeg
sudo snap install lxd gnome-boxes
# sudo snap install libreoffice audacity

# Programs (APT)
sudo apt-get install -y golang clang-format
sudo apt-get install -y gufw flameshot guvcview
sudo apt-get install -y whois android-tools-adb
sudo apt-get install -y pipx

# Programs (Python)
python3 -m pipx install esptool

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

# GNOME
gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-overview'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['F10']"
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute "['<Control>F10']"

# ~/.config/flameshot/flameshot.ini
# show-screenshot-ui, screenshot, screenshot-window, show-screen-recording-ui
create_keyboard_shortcut 'Flameshot GUI' 'flameshot gui' 'Print'
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# keyboard shortcuts
# Volume mute/unmute = F10
# Microphone mute/unmute = Ctrl+F10

# Disable disk swap
sudo swapoff -a
sudo sed -i '/^\/swap\.img/s/^/# /' /etc/fstab

# Allow ttyUSB0 for logged-in user
sudo cp ./udev/60-extra-acl.rules /etc/udev/rules.d/60-extra-acl.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

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
