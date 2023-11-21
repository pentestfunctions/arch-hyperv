#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Ask for the non-root username
read -p "Enter the non-root username: " username

# Enable and start essential services
systemctl enable NetworkManager
systemctl enable lightdm.service --force

# Install packages
pacman -Sy --noconfirm netcat vscode openvpn neofetch konsole bind

# Configure konsole for the user
su - "$username" -c 'curl https://raw.githubusercontent.com/pentestfunctions/konsole-quickcommands/main/konsolequickcommandsconfig > ~/.config/konsolequickcommandsconfig'

# Change ownership of a vscode directory
sudo chown -R "$username" /usr/lib/code/out/vs/workbench

# Install AUR helpers and packages
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -sri
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -sri
yaourt -S --noconfirm xts-windows10-theme xfce4-theme-switcher wafw00f whatweb burpsuite dirsearch httpx enum4linux nmap rustscan

# Additional configuration
sudo cp /usr/bin/httpx-toolkit /usr/bin/httpx
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p "/home/$username/Downloads"
wget https://github.com/pentestfunctions/arch-hyperv/blob/main/wallpaper.jpg?raw=true -O "/home/$username/Downloads/wallpaper.jpg"
cp "/home/$username/Downloads/wallpaper.jpg" "/home/$username/.face"

echo "Setup complete!"
