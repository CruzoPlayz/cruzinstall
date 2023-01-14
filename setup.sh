#!/bin/bash

clear

timedatectl set-ntp true
ntpd -qg
hwclock -w

clear

echo "Partitioning..."

sleep 1

parted /dev/$DRIVETYPE mklabel gpt
parted /dev/$DRIVETYPE mkpart "EFI" fat32 1MiB 512MiB
parted /dev/$DRIVETYPE set 1 esp on

clear

parted /dev/$DRIVETYPE mkpart "swap" linux-swap 512MiB 16GiB

parted /dev/$DRIVETYPE mkpart "root" ext4 16GiB 100%

clear
echo "Formatting Partitions..." 
sleep 2

		mkfs.ext4 /dev/nvme0n1p3
        mkswap /dev/nvme0n1p2
        mkfs.fat -F 32 /dev/nvme0n1p1

        mount /dev/nvme0n1p3 /mnt 
        mount --mkdir /dev/nvme0n1p1 /mnt/boot
        swapon /dev/nvme0n1p2


		mkfs.ext4 /dev/nvme0n1p2
        mkswap /dev/nvme0n1p1
        parted /dev/nvme0n1 set 2 boot on
        

        mount /dev/nvme0n1p2 /mnt 
        
        swapon /dev/nvme0n1p1

clear
echo "Installing Arch Packages..."
pacman -Sy archlinux-keyring --noconfirm
sleep 1
pacstrap /mnt base linux linux-firmware nano dkms

clear
echo "Generating fstab..."
sleep 1
genfstab -U /mnt >> /mnt/etc/fstab

clear
echo "Installing Git..."
sleep 1
pacstrap /mnt git

clear
echo "Installing NetworkManager..."
sleep 1
pacstrap /mnt networkmanager

cp setup2.sh /mnt/usr/bin/setup
chmod +777 /mnt/usr/bin/setup

clear
echo "You are now booting into the Chroot environment."
sleep 3
echo "When ready, type 'setup' "
echo "Make sure to redo any changes inside the chroot environment"
arch-chroot /mnt
