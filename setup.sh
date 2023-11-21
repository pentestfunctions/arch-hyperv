#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Automatically determine the username of the user who initiated the sudo command
username=$(logname)

echo "Running script for user: $username"

# Enable and start essential services
systemctl enable NetworkManager
systemctl enable lightdm.service --force

# Install packages
pacman -Sy --noconfirm netcat code openvpn neofetch konsole bind

# Configure konsole for the user
su - "$username" -c 'curl https://raw.githubusercontent.com/pentestfunctions/konsole-quickcommands/main/konsolequickcommandsconfig > ~/.config/konsolequickcommandsconfig'

# Change ownership of a vscode directory
sudo chown -R "$username" /usr/lib/code/out/vs/workbench

# Install yay (AUR helper)
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

# Install AUR packages with yay
sudo -u "$username" yay -S --noconfirm xts-windows10-theme xfce4-theme-switcher wafw00f whatweb burpsuite dirsearch httpx enum4linux nmap rustscan

# Additional configuration
sudo cp /usr/bin/httpx-toolkit /usr/bin/httpx
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p "/home/$username/Downloads"
wget https://github.com/pentestfunctions/arch-hyperv/blob/main/wallpaper.jpg?raw=true -O "/home/$username/Downloads/wallpaper.jpg"
cp "/home/$username/Downloads/wallpaper.jpg" "/home/$username/.face"

xfce4-theme-switcher -t Windows-10-db.tar.gz

echo "Setup complete!"
