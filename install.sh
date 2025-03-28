#!/bin/bash
mkdir -p backups/.config

trap exit INT
red="\x1b[31m"
green="\x1b[1;32m"
yellow="\x1b[1;33m"
reset="\x1b[0m"
installPkgs=true

asRoot() {
	if command -v sudo &> /dev/null; then
		sudo $@
	else
		su -c "$@"
	fi
}

if ! grep "Arch Linux" /etc/os-release &> /dev/null; then
	echo -e "${red}This script has limited functionality outside of Arch Linux!$reset" >&2
	installPkgs=false
fi
# define wrapper function
install() {
	if ls ~/"$1" &> /dev/null; then
		echo -e "${yellow}Saving original file \"$1\" to \"$(pwd)/backups/$1\"$reset" >&2
		rm -f backups/"$1"
		mv ~/"$1" backups/"$1"
	fi
	echo -n "Installing: \"$1\"... "

	if ln -s "$PWD/$1" "$HOME/$1"; then
		echo -e "${green}done$reset"
	else
		echo -e "${red}error$reset"
		echo "Error installing dotfile \"$1\", continuing..." >&2
	fi
}

# symlink the configs into place
echo "Installing dotfiles..."
install .Xdefaults
install .xinitrc
install .zshrc
install .gitconfig
if ! [ -d ~/.config ]; then
	echo -e "${yellow}WARNING: Creating \`.config' directory since it doesn't exist.${reset}"
	mkdir ~/.config
fi
install .config/i3
install .config/i3status
install .config/spaceship.zsh
install .config/xorg
install .config/rofi
install .config/zsh
install .config/gtk-2.0
install .config/gtk-3.0
install .config/gtk-4.0

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

install .config/nvim
nvim +PlugUpdate '+qa!'

echo -n "Installing: \"firefoxUser.js\"... "
dir=$PWD
cd ~/.mozilla/firefox/*default-release/
ls user.js &> /dev/null
if [ $? = 0 ]; then
	echo -e "${yellow}Saving original file \"user.js\" to \"$dir/backups/user.js\"$reset" >&2
	rm -f "$dir/backups/user.js"
	mv user.js "$dir/backups/user.js"
fi
if ! ln -s "$dir/firefoxUser.js" user.js; then
	echo -e "${red}error$reset"
	echo "Error installing \"user.js\", continuing..." >&2
else
	echo -e "${green}done$reset"
fi


installYay() {
	if ! command -v yay &> /dev/null; then
		echo -e "${red}yay not installed!$reset  Installing now."

		asRoot "pacman -S --needed git make gcc binutils fakeroot"
		git clone https://aur.archlinux.org/yay
		if ! cd yay; then
			echo -e "${red}Failed to cd into the yay directory... did git fail?$reset"
			return 1
		fi
		makepkg -sir --noconfirm --needed
		echo -e "${green}yay installed!$reset"
	fi
}

installPkgs() {
	echo -n "Installing packages... "
	if ! $installPkgs; then
		echo -e "${red}not supported!$reset"
		return
	fi
	echo -e "${green}supported!$reset"

	installYay

	echo "Updating repos first..."

	yay -Sy
	echo "Done, installing packages"
	yay -S --needed i3-wm rofi \
		ttf-dejavu-nerd ttf-dejavu ttf-firacode-nerd \
		zsh spaceship-prompt zsh-syntax-highlighting zsh-autosuggestions \
		xorg-server xorg-xinit libxcomposite \
		notification-daemon polkit-gnome picom feh less \
		arc-gtk-theme gnome-themes-extra arc-icon-theme breeze-icons papirus-icon-theme \
		confuse dash \
		zoxide github-cli

	cd ~/src
	git clone https://github.com/techflashYT/i3status-mod
	cd i3status-mod
	meson setup build --prefix=/usr
	cd build
	ninja -j$(nproc)
	asRoot ninja install
}

installPkgs

echo "Disabling services..."
systemctl --user disable --now at-spi-dbus-bus
systemctl --user mask at-spi-dbus-bus
asRoot systemctl disable --now systemd-userdbd.socket
asRoot systemctl mask systemd-userdbd systemd-userdbd.socket

# replace /bin/sh with dash
ln -sf dash /bin/sh

echo "setting up /etc/environment"

cat << EOF | asRoot tee -a /etc/environment
GTK_THEME=Adwaita-dark:dark
GTK_ICON_THEME=Papirus-Dark
MOZ_USE_XINPUT2=1
GTK_ALLY=none
EOF

echo "Done!  Enjoy!"
