#!/bin/bash
mkdir -p backups/.config

trap exit INT
red="\x1b[31m"
green="\x1b[1;32m"
yellow="\x1b[1;33m"
reset="\x1b[0m"
installPkgs=true
grep "Arch Linux" /etc/os-release &> /dev/null
if [ $? != 0 ]; then
	echo -e "${red}This script has limited functionality outside of Arch Linux!$reset" >&2
	installPkgs=false
fi
# define wrapper function
install() {
	ls ~/$1 &> /dev/null
	if [ $? = 0 ]; then
		echo -e "${yellow}Saving original file \"$1\" to \"$(pwd)/backups/$1\"$reset" >&2
		rm -f backups/$1
		mv ~/$1 backups/$1
	fi
	echo -n "Installing: \"$1\"... "
	ln -s $(pwd)/$1 ~/$1
	if [ $? != 0 ]; then
		echo -e "${red}error$reset"
		echo "Error installing dotfile \"$1\", continuing..." >&2
	else
		echo -e "${green}done$reset"
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

echo -n "Installing: \"firefoxUser.js\"... "
dir=$(pwd)
cd ~/.mozilla/firefox/*default-release/
ls user.js &> /dev/null
if [ $? = 0 ]; then
	echo -e "${yellow}Saving original file \"user.js\" to \"$dir/backups/user.js\"$reset" >&2
	rm -f $dir/backups/user.js
	mv user.js $dir/backups/user.js
fi
ln -s $dir/firefoxUser.js user.js
if [ $? != 0 ]; then
	echo -e "${red}error$reset"
	echo "Error installing \"user.js\", continuing..." >&2
else
	echo -e "${green}done$reset"
fi
cmd=none
installPkgs() {
	echo -n "Installing packages... "
	if ! $installPkgs; then
		echo -e "${red}not supported!$reset"
		return
	fi
	echo -e "${green}supported!$reset"

	command -v yay &> /dev/null
	if [ $? != 0 ]; then
		echo -e "${red}yay not installed!$reset  Press enter to install it, or CTRL-C to abort"
		read -n 1 k
		su -c "pacman -S --needed git make gcc binutils fakeroot"
		git clone https://aur.archlinux.org/yay
		cd yay
		makepkg -si
		echo -e "${green}yay installed!$reset"
	fi
	echo "Updating repos first..."

	yay -Sy
	echo "Done, installing packages"
	yay -S --needed i3-wm i3status rofi \
		rxvt-unicode ttf-dejavu ttf-fira-code \
		zsh spaceship-prompt zsh-syntax-highlighting zsh-autosuggestions \
		xorg-server xorg-xinit libxcomposite \
		libconfig \
		dunst compton-old-git feh

}

#installPkgs
echo "Done!  Enjoy!"

