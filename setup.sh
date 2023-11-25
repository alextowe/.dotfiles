#!/bin/bash

# Configure git user
read -p "Enter your name for git: " GIT_NAME
read -p "Enter email for git: " GIT_EMAIL
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Skip password prompt for sudo commands
sudo su - <<END
printf "%%wheel ALL=(ALL) NOPASSWD: ALL\n" > /etc/sudoers.d/10-wheel
END

# Enable color and parallel downloads in pacman
sudo sed -i "s/#Color/Color/" /etc/pacman.conf
sudo sed -i "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf

# Install yay
git clone https://aur.archlinux.org/yay.git $HOME/yay
cd $HOME/yay
makepkg -si
rm -rf $HOME/yay

# Install packages
yay -Syu --noconfirm
yay -S --noconfirm \
	bash-completion \
	ranger \
	reflector \
	less \
	which \
	stow \
	man-db \
	man-pages \
	emacs \
	numlockx \
	os-prober \
	ntfs-3g \
	nodejs \
	postgresql \
	nftables \
	ufw \
	openssh \
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
	dunst \
	xdg-user-dirs \
	xautolock \
	feh \
	arandr \
	alacritty \
	dmenu \
	clipmenu \
	firefox \
	discord \
	scrot \
	arc-gtk-theme \
	arc-icon-theme \
	xcursor-breeze \
	noto-fonts \
	ttf-ubuntu-font-family \
	ttf-dejavu \
	ttf-freefont \
	ttf-liberation \
	ttf-droid \
	ttf-roboto \
	terminus-font

# Enable autologin
sudo sed -i "s/#autologin-user=/autologin-user=$USER/" /etc/lightdm/lightdm.conf
sudo sed -i "s/#autologin-session=/autologin-session=i3/" /etc/lightdm/lightdm.conf
sudo groupadd -r autologin
sudo gpasswd -a $USER autologin

# Enable lightdm
sudo systemctl enable lightdm.service

# Enable ufw
sudo systemctl enable ufw.service
sudo systemctl start ufw.service
sudo ufw allow SSH
sudo ufw enable

# Enable reflector updates
sudo sed -i "s/# --country France,Germany/--country US/" /etc/xdg/reflector/reflector.conf
sudo systemctl enable reflector.service
sudo systemctl start reflector.service
sudo systemctl enable reflector.timer
sudo systemctl start reflector.timer

# Enable psql
sudo -iu postgres bash <<END
initdb -D /var/lib/postgres/data
END
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service

# Add windows to boot menu

# Create user directories
cd $HOME && mkdir \
	desktop/ \
	downloads/ \
	templates/ \
	public/ \
	documents/ \
	music/ \
	pictures/ \
	videos/ \
	dev/

# Use stow to create symlinks
cd $HOME/.dotfiles/ && stow --adopt */ -t $HOME
cd $HOME/.dotfiles/ && git restore .

rm -rf $HOME/.emacs.d
git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom install

printf "\nAll finsihed. Reboot for configuration to take effect.\n\n"
