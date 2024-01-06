#!/usr/bin/env bash

source ./etc/profile

sudo cp -r ./etc/* /etc/
sudo cp -r ./wallpapers/* /usr/share/wallpapers
cp -r ./.config/* ~/.config/
cp -r ./.local/* ~/.local
echo "dots copied"
sleep 3

if [[ "$(which "paru")" != "/usr/bin/paru" ]]; then
git clone https://aur.archlinux.org/paru.git ~/paru
cd ~/paru
makepkg -si
rm -rf ~/paru
fi

paru -S $(grep -v '^\s*#' packages.txt)  --needed


if [[ "$(echo "$SHELL")" != "/usr/bin/zsh" ]]; then
    chsh -s /usr/bin/zsh $USER
    sudo chsh -s /bin/zsh root
    echo rebooting to apply changes.
    sleep 5
    reboot
fi

./.secrets/install.sh 2> /dev/null
