#!/bin/bash

# chrome gpu hardware decoding
# sudo apt install intel-media-va-driver-non-free libva-drm2 libva-x11-2
# google-chrome-stable --ignore-gpu-blacklist --enable-gpu-rasterization --enable-native-gpu-memory-buffers --enable-accelerated-video-decode --enable-zero-copy --enable-features=VaapiVideoDecoder
# https://www.linuxuprising.com/2021/01/how-to-enable-hardware-accelerated.html

cp keyboard-scroll-lock $HOME
cp keyboard-mute-audio $HOME
cp keyboard-mute-mic $HOME
# + add keyboard shortcut: "bloq despl" with "keyboard-scroll-lock"
# + add keyboard shortcut: "pausa inter" with "keyboard-mute-audio"
# + add keyboard shortcut: "re pag" with "keyboard-mute-mic"
# ?

# firefox developer
curl --location "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" \ | tar --extract --verbose --preserve-permissions --bzip2
mv firefox firefox-dev
sudo mv firefox-dev/ /opt
sudo ln -s /opt/firefox-dev/firefox /usr/bin/firefox-dev

# tor browser
sudo apt install -y torbrowser-launcher

# go
sudo apt-add-repository -y ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang
# .profile: export PATH=$PATH:/usr/local/go/bin
# .bashrc:
# export GOPATH=$HOME/go
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# change docker location
# systemctl stop docker
# sudo nano /lib/systemd/system/docker.service
# ExecStart=/usr/bin/dockerd --data-root /mnt/self/docker -H fd:// --containerd=/run/containerd/containerd.sock
# mv /var/lib/docker /mnt/self/docker
# systemctl daemon-reload
# systemctl start docker

# filezilla
sudo apt-get install -y filezilla

# syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing
sudo apt-get update
sudo apt-get install -y syncthing
# + config

# vlc
sudo apt install -y vlc

# robomongo
# https://download.studio3t.com/robomongo/linux/studio-3t-robo-3t-linux-double-pack.tar.gz

# zoom
sudo wget -P /tmp/ https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y /tmp/zoom_amd64.deb

# teamviewer
wget -q https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://linux.teamviewer.com/deb stable main" >> /etc/apt/sources.list.d/teamviewer.list'
sudo apt update
sudo apt install -y teamviewer
# dnssec=off
sudo systemctl disable teamviewerd

# arduino
sudo wget -P /tmp https://downloads.arduino.cc/arduino-1.8.13-linux64.tar.xz
tar -xvf /tmp/arduino-1.8.13-linux64.tar.xz -C /tmp
sudo mv /tmp/arduino-1.8.13 /opt/arduino-1.8.13
sh /opt/arduino-1.8.13/install.sh
sudo ln -s /opt/arduino-1.8.13/arduino /usr/local/bin/arduino
sudo usermod -a -G dialout $USER

# virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian focal contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt update
sudo apt install -y virtualbox-6.1
# extension pack:
# https://download.virtualbox.org/virtualbox/6.1.14/Oracle_VM_VirtualBox_Extension_Pack-6.1.14.vbox-extpack

# basic settings
sudo sh -c 'echo "" >> /etc/sysctl.conf'
sudo sh -c 'echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf'
sudo sh -c 'echo "vm.swappiness=0" >> /etc/sysctl.conf'
sudo sysctl -p

# disable automatic screen lock
gsettings set org.gnome.desktop.screensaver lock-enabled false

# disable blank screen delay
gsettings set org.gnome.desktop.session idle-delay 0

# disable lock screen on suspend
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false

# disable apport
sudo systemctl disable apport.service
sudo systemctl stop apport.service
sudo sed -ibak -e s/^enabled\=1$/enabled\=0/ /etc/default/apport

# disable popularity contest
sudo apt purge -y popularity-contest

# disable whoopsie (problem reporting)
sudo apt purge -y whoopsie

# disable ubuntu report
ubuntu-report -f send no
sudo apt purge -y ubuntu-report

# enabled dark mode
# gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'

# disable updates prompt
gconftool -s --type bool /apps/update-notifier/auto_launch false

# disable auto daily upgrade
sudo systemctl disable --now apt-daily-upgrade.timer

# ram disk
sudo sh -c 'echo "tmpfs            /ram            tmpfs   defaults,noatime,mode=1777,size=100% 0 0" >> /etc/fstab'
sudo mkdir -p /ram

# chrome ram cache
echo "" >> ~/.profile
echo "# chrome cache in ram" >> ~/.profile
echo "rm -r ~/.cache/google-chrome" >> ~/.profile
echo "mkdir -p /ram/google-chrome" >> ~/.profile
echo "ln -s /ram/google-chrome ~/.cache/google-chrome" >> ~/.profile

# folder encryption
sudo apt install cryfs
# cryfs /self/.encrypted /self/x
# cryfs-unmount /self/x

# unmount encrypted folder  
sudo chmod +x script-at-logout
cp script-at-logout $HOME
#sudo sh -c 'echo "[Seat:*]" >> /etc/lightdm/lightdm.conf'
#sudo sh -c 'echo "session-cleanup-script=/home/$USER/script-at-logout" >> /etc/lightdm/lightdm.conf'

# fix boot warn/err "Initramfs unpacking failed: Decoding failed"
# sudo sed -i 's/COMPRESS=lz4/COMPRESS=gzip/g' /etc/initramfs-tools/initramfs.conf
# sudo update-initramfs -u
# or maybe with lz4:
# sudo update-initramfs -c -k $(uname -r)

# trim ssd manually
sudo fstrim -av

# virt-manager
# protonvpn-cli
# whois
# proxychains
# libreoffice
# audacity
# atomic wallet
# ntp
# ulauncher
# usb-creator-gtk
# seahorse

#
# sudo apt-get remove kdeconnect

# sudo apt-add-repository -y ppa:agornostal/ulauncher
# sudo apt install ulauncher
# git clone https://github.com/dracula/ulauncher.git ~/.config/ulauncher/user-themes/dracula-ulauncher
# + find on session and startup: --no-window-shadow

# alsamixer

# http toolkit






wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium

