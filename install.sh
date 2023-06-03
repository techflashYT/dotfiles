#!/bin/bash
mkdir -p backups
source /etc/os-release

red="\x1b[31m"
yellow="\x1b[1;33m"
reset="\x1b[0m"
installPkgs=true
if [[ "$NAME" != "*Arch Linux*" ]]; then
	echo -e "${red}This script has limited functionality outside of Arch Linux!$reset" >&2
	installPkgs=false
fi
# define wrapper function
install() {
	if [ -f ~/$1 ]; then
		echo -e "${yellow}Saving original file \"$1\" to \"$(pwd)/backups/$1\"$reset" >&2
		mv ~/$1 $(pwd)/backups/$1
	fi
	echo -n "Installing: \"$1\"... "
	ln -s $(pwd)/$1 ~/$1
	if [ $? != 0 ]; then
		echo "error"
		echo "Error installing dotfile \"$1\", continuing..." >&2
	else
		echo "done"
	fi
}
# symlink the configs into place
install .Xdefaults
install .xinitrc
install .zshrc
install .config/i3
install .config/i3status
install .config/spaceship.zsh
install .config/xorg
