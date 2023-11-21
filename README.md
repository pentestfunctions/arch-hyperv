# Arch Linux Hyper-V Installation and Customization Guide

Welcome to the Arch Linux Hyper-V Installation and Customization Guide! This README provides step-by-step instructions for installing Arch Linux in a Hyper-V environment and customizing it. All commands are ready for copy-pasting to facilitate an easy setup. Let’s start! 🚀

## Prerequisites 📋
- Hyper-V enabled on your machine.
- Downloaded Arch Linux ISO.

## Installation Steps 💻

### Step 1: Create Network Adapter
  - Configure a virtual network adapter in Hyper-V Manager.

### Step 2: Add ISO to Hyper-V & Storage
  - Attach the Arch Linux ISO to your Hyper-V virtual machine.
  - Create vhdx storage to install Arch to
  
### Step 3: Begin Installation with `archinstall`
1. Navigate down to `Disk Configuration` and select "Use a best-effort default partition layout"
  - Select "Msft Virtual Disk"
  - Select "ext4"
  - Select "yes (default)" for a separate /home partition.

2. Navigate to "Root password"
  - Enter a password for the root account
  
3. Navigate to "User account"
  - Select "Add a user"
  - Select "yes (default)" for superuser (sudo)
  - Select "Confirm and exit"

4. Navigate to "Optional Repositories"
  - Select "multilib"

5. Navigate to "Additional packages"
  - Type in the following:
    ```bash
    networkmanager nano xfce4 xfce4-goodies lightdm lightdm-gtk-greeter git konsole shellcheck zenity vivaldi vivaldi-ffmpeg-codecs wget nmap pavucontrol
    ```

6. Select Install

7. After installing it will ask you if you wish to `chroot into the newly created installation`
   - Select "yes (default)"
     
###  Step 4: Finalize Installation
- After installation, choose "Yes" to reboot.

### Post-Installation Setup 🛠️
#### Enable Services
- Run:
  ```bash
  systemctl enable NetworkManager
  systemctl enable lightdm.service --force
  ```
#### Install Additional Packages
- Execute:
  ```bash
  pacman -S netcat vscode openvpn neofetch konsole bind
  ```

#### User Configuration
- Switch to your created user and run:
  ```bash
  su - [username]
  curl https://raw.githubusercontent.com/pentestfunctions/konsole-quickcommands/main/konsolequickcommandsconfig > ~/.config/konsolequickcommandsconfig
  sudo chown -R $(whoami) /usr/lib/code/out/vs/workbench
  ```

#### Install AUR Helpers
- Clone, build, and install `package-query` and `yaourt`:
  ```bash
  cd /tmp
  git clone https://aur.archlinux.org/package-query.git
  cd package-query
  makepkg -sri
  cd ..
  git clone https://aur.archlinux.org/yaourt.git
  cd yaourt
  makepkg -sri
  ```
#### Install Themes and Tools
- Use `yaourt` and move `httpx-toolkit` to `httpx`:
  ```bash
  yaourt -S xts-windows10-theme xfce4-theme-switcher wafw00f whatweb burpsuite dirsearch httpx enum4linux nmap rustscan --noconfirm
  sudo cp /usr/bin/httpx-toolkit /usr/bin/httpx
  ```

#### Oh My Zsh Installation
- Install Oh My Zsh:
  ```bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```

#### Wallpaper Setup (Profile picture)
- Download and set the wallpaper:
  ```bash
  mkdir /home/[username]/Downloads
  wget https://github.com/pentestfunctions/arch-hyperv/blob/main/wallpaper.jpg?raw=true -O ~/Downloads/wallpaper.jpg
  cp ~/Downloads/wallpaper.jpg ~/.face
  ```

#### Install and Configure Yay (New version of yaourt)
- Clone and install `yay`:
  ```bash
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -sri
  ```

#### Customize XFCE4
- Run `xfce4-theme-switcher` and choose "Windows-10-db".
Adjust fonts and appearance settings.

#### Install Additional Tools
- Execute:
  ```bash
  yay -S rustscan wfuzz httpx wpscan gobuster hydra enum4linux dig
  ```

#### Download Essential Wordlists
- Set up directories and download wordlists:
```bash
  mkdir /usr/share/hosting
  wget -P /usr/share/wordlists https://example.com/subdomains-top1million-110000.txt
  wget -P /usr/share/wordlists https://example.com/directory-list-2.3-medium.txt
  wget -P /usr/share/wordlists https://example.com/rockyou.txt
```

### Contributing 🤝
Feel free to contribute through the GitHub repository.

### License ⚖️
No license because screw that noise. Enjoy ❤️
