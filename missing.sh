#!/bin/bash

cp keyboard-scroll-lock $HOME
cp keyboard-mute-audio $HOME
cp keyboard-mute-mic $HOME
# + add keyboard shortcut: "bloq despl" with "keyboard-scroll-lock"
# + add keyboard shortcut: "pausa inter" with "keyboard-mute-audio"
# + add keyboard shortcut: "re pag" with "keyboard-mute-mic"
# ?

# RAM disk
sudo tee -a /etc/fstab > /dev/null <<EOF
tmpfs  /ram  tmpfs  defaults,noatime,mode=1777,size=100% 0 0
EOF
sudo mkdir -p /ram

# virt-manager
# protonvpn-cli
# libreoffice
# audacity
# atomic wallet
# ntp
# usb-creator-gtk
# seahorse
# alsamixer
# http toolkit

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
