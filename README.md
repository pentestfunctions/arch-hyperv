# arch-hyperv

- Still working on this, try follow it if you dare. All in order

Create network adapter
Add ISO to hyper-V

archinstall
Disk option (Use a best-effort default partition layout - choose Msft Virtual Disk / ext - Add sepearate partition for /home)
(Set root password)
(Add user account & enable sudo)
networkmanager nano xfce4 xfce4-goodies lightdm lightdm-gtk-greeter git konsole shellcheck zenity vivaldi vivaldi-ffmpeg-codecs  wget nmap pavucontrol zsh

Choose "Yes" after it is installed

# Install
pacman -S netcat
pacman -S vscode

systemctl enable NetworkManager
systemctl enable lightdm.service --force

su - robot
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -sri
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -sri


yaourt -S xts-windows10-theme xfce4-theme-switcher wafw00f whatweb burpsuite dirsearch --noconfirm
sudo chown -R $(whoami) /usr/lib/code/out/vs/workbench
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir /home/robot/Downloads
wget https://github.com/pentestfunctions/arch-hyperv/blob/main/wallpaper.jpg?raw=true -O ~/Downloads/wallpaper.jpg
(set as wallpaper)
cp ~/Downloads/wallpaper.jpg ~/.face
