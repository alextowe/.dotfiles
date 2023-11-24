#!/bin/bash

# Get keyboard layout
read -p "Enter keyboard layout: " keymap

# Get timezone
read -p "Enter timezone (County/Region): " timezone

# Get disk
printf "\nSelect disk for installation.\n"
lsblk
printf "\nWarning! The disk you select will be wiped and re-formatted.\n"
read -p "Enter the disk name: " disk

# Get use/machine information
read -p "Enter name for this machine: " hostname
read -s -p "Enter password for the root user: " rootpass
echo
read -p "Enter username for your user: " username
read -s -p "Enter password for your user: " userpass

# Set keyboard layout
printf "\nSetting keyboard layout..."
loadkeys $keymap

# Enable network time protocol
printf "\nEnable network time protocol..."
timedatectl set-ntp true

# Update mirror list
printf "\nUpdating mirror list...\n"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --download-timeout 15 --latest 7 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist

# Create, format and mount partitions

# Install packages
pacstrap -i /mnt \
	base \
	base-devel \
	linux \
	linux-firmware \
	bash-completion \
	ranger \
	reflector \
	emacs \
	git \
	less \
	which \
	stow \
	man-db \
	man-pages \
	numlockx \
	os-prober \
	ntfs-3g \
	nodejs \
	postgresql \
	nftables \
	ufw \
	intel-ucode \
	xorg-server \
	xorg-apps \
	xorg-xinit \
	nvidia \
	lightdm \
	dex \
	i3-wm \
	i3status \
	i3lock \
	i3exit \
	perl-anyevent-i3 \
	picom \
	pavucontrol \
	pasystray \
	network-manager-applet \
	dunst \
	xdg-user-dirs \
	xautolock \
	feh \
	arandr \
	alacritty \
	firefox \
	discord \
	scrot \
	xcursor-breeze \
	noto-fonts \
	ttf-ubuntu-font-family \
	ttf-dejavu \
	ttf-freefont \
	ttf-liberation \
	ttf-droid \
	ttf-roboto \
	terminus-font

# Generate fstab
genfstab -U /mnt >>/mnt/etc/fstab

# Configure time
arch-chroot /mnt timedatectl set-ntp true
arch-chroot /mnt ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
arch-chroot /mnt hwclock --systohc

# Configure locales
printf "en_US.UTF-8 UTF-8\n" >>/mnt/etc/locale.gen
arch-chroot /mnt locale-gen
printf "LANG=en_US.UTF-8\n" >/mnt/etc/locale.conf
printf "\nKEYMAP=$keymap\n" >>/mnt/etc/vconsole.conf

# Enable color in pacman
sed -i "s/#Color/Color/" /mnt/etc/pacman.conf

# Enable lightdm
arch-chroot /mnt systemctl enable lightdm.service

# Enable autologin
arch-chroot /mnt sudo -u $username bash -c "groupadd -r autologin"
arch-chroot /mnt sudo -u $username bash -c "gpasswd -a $USER autologin"
sed -i "s/#autologin-user=/autologin-user=$USER/" /mnt/etc/lightdm/lightdm.conf

# Enable ufw
arch-chroot /mnt systemctl enable ufw.service
arch-chroot /mnt systemctl start ufw.service
arch-chroot /mnt ufw allow SSH
arch-chroot /mnt ufw enable

# Enable network manager
arch-chroot /mnt systemctl enable NetworkManager.service

# Enable reflector updates
sed -i "s/# --country France,Germany/--country US/" /mnt/etc/xdg/reflector/reflector.conf
arch-chroot /mnt systemctl enable reflector.service
arch-chroot /mnt systemctl start reflector.service
arch-chroot /mnt systemctl enable reflector.timer
arch-chroot /mnt systemctl start reflector.timer

# Enable psql
arch-chroot /mnt sudo -u postgres bash -c initdb -D /var/lib/postgres/data
arch-chroot /mnt systemctl enable postgresql.service
arch-chroot /mnt systemctl start postgresql.service

# Configure bootloader

# Add windows to boot menu

# Configure host machine
printf "$hostname\n" >>/mnt/etc/hostname
cat >>/mnt/etc/hosts <<END
127.0.0.1   localhost.localdomain   localhost
::1         localhost.localdomain   localhost
127.0.1.1   $hostname.localdomain   $hostname
END

# Skip password prompt for members of wheel
printf "%%wheel ALL=(ALL) NOPASSWD: ALL\n" >>/mnt/etc/sudoers.d/10-wheel

# Set root user password
echo "root:$rootpass" | arch-chroot /mnt chpasswd

# Create new user
arch-chroot /mnt useradd -m -g users -G wheel,storage,power,audio $username
echo "$username:$userpass" | arch-chroot /mnt chpasswd

# Create user directories
arch-chroot /mnt sudo -u $username bash -c "cd $HOME && mkdir \
	desktop/ \
	downloads/ \
	templates/ \
	public/ \
	documents/ \
	music/ \
	pictures/ \
	videos/ \
	dev/"

# Use stow to create symlinks
arch-chroot /mnt sudo -u $username bash -c "git clone https://github.com/alextowe/.dotfiles.git $HOME/.dotfiles.git"
arch-chroot /mnt sudo -u $username bash -c "cd $HOME/.dotfiles/ && stow --adopt user -t $HOME"
arch-chroot /mnt sudo -u $username bash -c "cd $HOME/.dotfiles/ && git restore ."

umount -R /mnt
printf "\nAll finsihed. Reboot for configuration to take effect.\n\n"
