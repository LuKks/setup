#!/bin/bash

# Fix Apple keyboard
# 1. Capital letters on key down
# 2. Button between F12 & F13 should act as Print
# 3. Adjust FN mode to fkeysfirst
# 4. Fixes keypad Enter in ZSH

# 1 & 2
sudo cat <<EOF > /usr/share/X11/xkb/symbols/cmswin
partial modifier_keys
xkb_symbols "cms_modkeys" {
  key <CAPS> {
    type="ALPHABETIC",
    repeat=No,
    symbols[Group1]= [ Caps_Lock, Caps_Lock ],
    actions[Group1]= [ LockMods(modifiers=Lock),
                       LockMods(modifiers=Shift+Lock,affect=unlock) ]
  };
  key <I169> {
    type="ALPHABETIC",
    repeat=No,
    symbols[Group1]= [ Print ]
  };
};
EOF

sudo sed -i '/! option                        = symbols/a\  cmswin:cms_modkeys            = +cmswin(cms_modkeys)' /usr/share/X11/xkb/rules/evdev
sudo sed -i '/! option/a\cmswin\ncmswin:cms_modkeys   Fix Apple keys' /usr/share/X11/xkb/rules/evdev.lst
sudo dconf write /org/gnome/desktop/input-sources/xkb-options "['cmswin:cms_modkeys']"

# 3
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo "options hid_apple fnmode=2" | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all

# 4
sudo cat <<EOF > $ZSH/custom/fix-keypad-enter.zsh
bindkey -s "^[OM" "^M"
EOF
