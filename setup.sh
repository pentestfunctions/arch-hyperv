#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Find user directories in /home, excluding 'root' and 'lost+found'
readarray -t users < <(find /home -maxdepth 1 -mindepth 1 -type d -not -name 'root' -not -name 'lost+found' -exec basename {} \;)

# Check if only one user is found
if [ "${#users[@]}" -eq 1 ]; then
    username="${users[0]}"
    echo "Running script for user: $username"
else
    echo "Multiple or no user directories found in /home. Please specify the username:"
    read -r username
fi

echo "Running script for user: $username"

# Install essential packages
pacman -Sy --noconfirm networkmanager nano xfce4 xfce4-goodies lightdm lightdm-gtk-greeter git konsole shellcheck zenity vivaldi vivaldi-ffmpeg-codecs wget nmap pavucontrol

# Enable and start essential services
systemctl enable NetworkManager
systemctl enable lightdm.service --force

# Install packages
pacman -Sy --noconfirm netcat code openvpn neofetch konsole bind

# Configure konsole for the user
su - "$username" -c 'curl https://raw.githubusercontent.com/pentestfunctions/konsole-quickcommands/main/konsolequickcommandsconfig > ~/.config/konsolequickcommandsconfig'

# Change ownership of a vscode directory
sudo chown -R "$username" /usr/lib/code/out/vs/workbench

# Install AUR packages with yay
sudo -u "$username" yay -S --noconfirm xts-windows10-theme xfce4-theme-switcher zsh wafw00f whatweb burpsuite dirsearch httpx enum4linux nmap rustscan

# Additional configuration
sudo cp /usr/bin/httpx-toolkit /usr/bin/httpx
mkdir -p "/home/$username/Downloads"
wget https://github.com/pentestfunctions/arch-hyperv/blob/main/wallpaper.jpg?raw=true -O "/home/$username/Downloads/wallpaper.jpg"
cp "/home/$username/Downloads/wallpaper.jpg" "/home/$username/.face"

# Create the startup script in the user's home directory
echo '#!/bin/bash' > "/home/$username/set_theme.sh"
echo "xfce4-theme-switcher -t Windows-10-db.tar.gz" >> "/home/$username/set_theme.sh"
chmod +x "/home/$username/set_theme.sh"

# Create the .desktop file for autostart
mkdir -p "/home/$username/.config/autostart"
cat << EOF > "/home/$username/.config/autostart/set_theme.desktop"
[Desktop Entry]
Type=Application
Exec=/home/$username/set_theme.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Set XFCE Theme
Name=Set XFCE Theme
Comment[en_US]=Automatically sets XFCE theme
Comment=
EOF

# Correct ownership of the script and .desktop file
chown "$username":"$username" "/home/$username/set_theme.sh"
chown -R "$username":"$username" "/home/$username/.config/autostart"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setup complete!"
