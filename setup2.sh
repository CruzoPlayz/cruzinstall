#!/bin/bash

clear

systemctl enable NetworkManager

clear
echo "Setting Timezone..."
sleep 1
ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime

hwclock --systohc

clear

        rm /etc/locale.gen
        cp files/locale.gen /etc/
        cp files/locale.conf /etc/


clear

echo CRUZOPLAYZ >> /etc/hostname 


clear
echo "Running mkinitcpio..."
sleep 3
mkinitcpio -P

clear

            echo "Creating Root Account..."
            sleep 1
            passwd
            echo "Account Created!"


clear

pacman -Syu nvidia nvidia-settings nvidia-utils nvidia-prime --noconfirm 
cp files/mkinitcpio-nvidia.conf /etc/mkinitcpio.conf
             
clear
echo "Installing GRUB..."
sleep 2

        pacman -Syu grub efibootmgr intel-ucode  --noconfirm
        grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB 
        grub-mkconfig -o /boot/grub/grub.cfg


        clear
        echo "Installing KDE..."
        pacman -Syu plasma plasma-wayland-session sddm --noconfirm
        clear
        echo "Installing KDE Applications..."
        pacman -Syu kde-applications --noconfirm
        pacman -R konqueror kmix --noconfirm # i hate these :3
        echo "Enabling SDDM..."
        sleep 2
        systemctl enable sddm

                    echo "password for you???"
                        useradd -m -G wheel Cruz
                        echo "Passsword for Superuser Account:"
                        passwd Cruz

                    echo "my password is bazinga type that"
                        useradd -m -G wheel logzinga
                        echo "Passsword for Superuser Account:"
                        passwd logzinga

clear
echo "Installing Sudo..."
sleep 5
cp files/sudoers /etc/sudoers
pacman -Syu sudo --noconfirm

clear
echo "Installing pipewire..."
sleep 5
pacman -Syu pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber --noconfirm # pipewire doesn't work FIXME

clear

            pacman -Syu firefox --noconfirm


            pacman -Syu chromium --noconfirm


clear
echo "Configuring Pacman..."
sleep 3
rm /etc/pacman.conf
cp files/pacman.conf /etc/pacman.conf

                        pacman -Syu lib32-nvidia-utils openssh --noconfirm 
                        systemctl enable sshd

clear                
mkinitcpio -P
clear

clear
echo "You have finished your install of Arch Linux!"
sleep 1
echo "When you are ready you can restart your computer."
sleep 1
echo "If you want to leave the install, do 'exit' then 'reboot'."
sleep 1
echo "Cleaning up..."
sleep 1
cd ..
rm -R arch-install-scripts
