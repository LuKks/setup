#!/bin/bash

# + don't run this with sudo or as root

sudo apt-get update
sudo apt-get upgrade -y

# basics like htop, curl, etc
sudo apt-get install -y software-properties-common apt-transport-https ca-certificates
sudo apt-get install -y htop
sudo apt-get install -y curl wget net-tools nmap
sudo apt-get install -y sshfs
sudo apt-get install -y gparted gnome-disk-utility
sudo apt-get install -y knot-dnsutils
sudo apt-get install -y gcc make g++ build-essential
sudo apt-get install -y git
sudo apt-get install -y zip unzip rar unrar pigz
sudo apt-get install -y ncat socat
sudo apt-get install -y gnupg lsb-release
sudo apt-get install -y aptitude
# gnupg-agent

# ssh (manually download)
cp ./ssh/config ~/.ssh/config
# chmod
# ssh-add ~/.ssh/id_rsa

# gpg (manually download)
# gpg --import ~/Desktop/gpg.key
# rm ~/Desktop/gpg.key

# zsh
sudo apt-get install -y zsh
chsh -s $(which zsh)
# requires reboot

# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# change dns to cloudflare
# use the gui
# + there should be a command nm to change it
# * /etc/NetworkManager/system-connections/Wired\ connection\ 1.nmconnection

# dns over tls
# /etc/systemd/resolved.conf
# DNSOverTLS=no => DNSOverTLS=yes

# + change chrome dns settings to cloudflare

# [no need for this one]
# sudo nano /etc/systemd/resolved.conf
## [Resolve]
## #DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
## DNSSEC=yes
## DNSOverTLS=yes

# fix bluetooth
sudo cp ./bluetooth/rtl8761b_config.bin /usr/lib/firmware/rtl_bt/
sudo cp ./bluetooth/rtl8761b_fw.bin /usr/lib/firmware/rtl_bt/
# re-insert usb (usbreset?)

# disable swap
sudo swapoff -a
# sudo nano /etc/fstab
# and comment out the swap line:
# /swapfile                                 none            swap    sw              0       0

# fix keyboard (mayus)
cp ./keyboard/xkbmap $HOME/.xkbmap
echo "" >> ~/.profile
echo "# fix keyboard (mayus)" >> ~/.profile
echo "xkbcomp -w 0 \$HOME/.xkbmap \$DISPLAY" >> ~/.profile
source ~/.profile

# fix apple keyboard (button between F12 & F13)
echo "" >> ~/.xmodmap
echo "! fix apple keyboard (button between F12 & F13)" >> ~/.xmodmap
echo "keycode 169 = Print" >> ~/.xmodmap
xmodmap ~/.xmodmap

# change apple keyboard to fkeysfirst mode
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo "options hid_apple fnmode=2" | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all

# keyboard shortcuts
# Volume mute/unmute = F10
# Microphone mute/unmute = Ctrl+F10

# nautilus
touch ~/Templates/Empty\ File
touch ~/Templates/Plain\ Text.txt

# chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
echo "deb https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# telegram
wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
sudo cp ./telegram/telegram.png ~/.local/share/icons/
sudo cp ./telegram/telegramdesktop.desktop ~/.local/share/applications/

# install discord

# sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text
# sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/subl

# node
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# npm global path
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo "" >> ~/.profile
echo "# npm " >> ~/.profile
echo "export PATH=~/.npm-global/bin:\$PATH" >> ~/.profile
source ~/.profile

# yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y yarn

# process manager, etc
npm i -g pm2
npm i -g tldr
npm i -g why-is-node-running
npm i -g node-gyp

# encrypted git repositories
sudo apt-get install -y git-remote-gcrypt
npm i -g LuKks/gcrypt

# obs
sudo apt-get install -y ffmpeg
sudo apt-add-repository -y ppa:obsproject/obs-studio
sudo apt-get update
sudo apt-get install -y obs-studio

# kdenlive
sudo apt-add-repository -y ppa:kdenlive/kdenlive-stable
sudo apt-get update
sudo apt-get install -y kdenlive

# mysql client
sudo apt-get install -y mysql-client-core-8.0

# mysql workbench
sudo wget -P /tmp/ https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb 
sudo DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/mysql-apt-config_0.8.15-1_all.deb
sudo apt-get update
sudo apt-get install -y mysql-workbench-community

# flameshot
sudo apt install -y flameshot
# flameshot config # enable [startup, copy url after upload] and disable [tray icon]
# + change keyboard shurtcut: flameshot gui

# disable animations
gsettings set org.gnome.desktop.interface enable-animations false

# enable seconds on the clock
gsettings set org.gnome.desktop.interface clock-show-seconds true

# disable connectivity checking
busctl --system set-property org.freedesktop.NetworkManager /org/freedesktop/NetworkManager org.freedesktop.NetworkManager ConnectivityCheckEnabled "b" 0

# android studio
sudo apt-add-repository -y ppa:maarten-fonville/android-studio
sudo apt-get update
sudo apt-get install -y android-studio

# adb
sudo apt-get install -y android-tools-adb

# nginx
sudo apt-get install -y nginx
sudo systemctl stop nginx
sudo systemctl disable nginx

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.1.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# docker fix root
# sudo groupadd -f docker
## getent group docker || groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker << /dev/null

# github desktop
wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc > /dev/null
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftkey-desktop.list'
sudo apt-get update
sudo apt install github-desktop

# firewall
sudo apt-get install gufw
# + enable status

# settings
#sudo apt install -y gnome-tweak-tool
## sudo apt install -y chrome-gnome-shell
## sudo apt install -y gnome-shell-extension-dash-to-panel
## + https://extensions.gnome.org/extension/1160/dash-to-panel/
#sudo wget -O /tmp/dash-to-panel.zip https://extensions.gnome.org/extension-data/dash-to-paneljderose9.github.com.v40.shell-extension.zip
#GNOME_DASHTOPANEL_ID=`unzip -c /tmp/dash-to-panel.zip metadata.json | grep uuid | cut -d \" -f4`
#mkdir -p ~/.local/share/gnome-shell/extensions/$GNOME_DASHTOPANEL_ID
#unzip -q /tmp/dash-to-panel.zip -d ~/.local/share/gnome-shell/extensions/$GNOME_DASHTOPANEL_ID
#gnome-extensions enable $GNOME_DASHTOPANEL_ID
## + reload gnome shell
## + import ./dash-to-panel/config file

# disable terminal close confirmation
sudo apt-get install -y dconf-editor
# dconf-editor
# go to: org -> gnome -> terminal -> legacy

# https://extensions.gnome.org/extension/234/steal-my-focus/

# virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian focal contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update
sudo apt-get install -y virtualbox-6.1
# + download and install extension pack
