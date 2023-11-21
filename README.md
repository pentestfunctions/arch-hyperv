# arch-hyperv

- Still working on this, try follow it if you dare. All in order

  Boot into Arch Installation Media:

Start your VM with the Arch Linux installation ISO.
Launch gdisk for Disk Partitioning:

Open gdisk for partitioning the disk:
gdisk /dev/sda

Create New GPT Partition Table:
Inside gdisk, create a new GPT partition table:
o
y

Create EFI System Partition (ESP):
Create a new partition for the EFI system:
n
[Enter for default partition number, which should be 1]
[Enter for default first sector]
+500M
ef00

Create Root Partition:
Create another new partition for the root:
n
[Enter for default partition number, which should be 2]
[Enter for default first sector]
[Enter for default last sector to use remaining space]
[Enter for default hex code]

Write Changes and Exit gdisk:
Write the changes to the disk and exit gdisk:
w
Y

Format the EFI System Partition:
Format the EFI system partition with FAT32:
mkfs.fat -F32 /dev/sda1

Format the Root Partition:
Format the root partition with ext4:
mkfs.ext4 /dev/sda2

Mount the Root Partition:
Mount the root partition to /mnt:
mount /dev/sda2 /mnt

Mount the EFI System Partition:
Create a directory for mounting the EFI partition and mount it:
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

Install Arch Linux Base System:
Install the base system using pacstrap:
pacstrap /mnt base linux linux-firmware

Generate fstab File:
Generate an fstab file:
genfstab -U /mnt >> /mnt/etc/fstab

Change Root into Your New System:
Chroot into your new installation:
arch-chroot /mnt

Install GRUB Bootloader:
Install GRUB and related packages:
pacman -S grub efibootmgr

Install GRUB for UEFI:
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

Generate the GRUB configuration:
grub-mkconfig -o /boot/grub/grub.cfg

Set Root Password:
Set a password for the root user:
passwd

Install Additional Packages (Optional):
Install NetworkManager and nano (or any other text editor you prefer):
pacman -Syu
pacman -S networkmanager nano
pacman -S xfce4 xfce4-goodies
pacman -S lightdm lightdm-gtk-greeter

Enable NetworkManager & xfce to start on boot:
systemctl enable NetworkManager
systemctl enable lightdm.service --force

Exit Chroot and Reboot:
Exit from chroot:
exit

Unmount all mounted partitions:
umount -R /mnt

Reboot your system:
reboot
After rebooting, your Arch Linux system should start. Remember to remove the installation media so the system boots from the hard disk. If you encounter any issues, carefully check the messages displayed during boot for clues on what might be going wrong.

pacman -S sudo
sudo pacman -S --needed base-devel git
Find the line that says %wheel ALL=(ALL) ALL and uncomment it (remove the # at the beginning).

useradd -m lowlevel
passwd lowlevel
usermod -aG wheel lowlevel
su - lowlevel


git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -sri
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -sri

yaourt -S xts-windows10-theme --noconfirm
yaourt -S xfce4-theme-switcher --noconfirm

(Open xfce4 theme switch and select either Windows-10-db or Windows-10-lb)


###########################################################################################################################################################################################################################################################################################################################

pacman -S konsole shellcheck zenity
pacman -S vivaldi
pacman -S vivaldi-ffmpeg-codecs 
pacman -S wget
wget https://github.com/pentestfunctions/arch-hyperv/blob/main/wallpaper.jpg?raw=true -O ~/Downloads/wallpaper.jpg
(set as wallpaper)
cp ~/Downloads/wallpaper.jpg ~/.face

yaourt -S wafw00f --noconfirm
yaourt -S whatweb --noconfirm
yaourt -S burpsuite --noconfirm
yaourt -S dirsearch --noconfirm
sudo pacman -S netcat
sudo pacman -S nmap
###########################################################################################################################################################################################################################################################################################################################

wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xvf yay.tar.gz
cd yay
makepkg -si

pacman -S nautilus
sudo pacman -Syu dpkg

