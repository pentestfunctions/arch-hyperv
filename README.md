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
     
### Post-Installation Setup 🛠️
```bash
su - robot
cd /tmp
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
curl https://raw.githubusercontent.com/pentestfunctions/arch-hyperv/main/setup.sh >> setup.sh
chmod +x setup.sh
sudo ./setup.sh
```

### Contributing 🤝
Feel free to contribute through the GitHub repository.

### License ⚖️
No license because screw that noise. Enjoy ❤️
