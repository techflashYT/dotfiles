#!/bin/sh
~/.screenlayout/main.sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi


feh /usr/share/backgrounds/nixlabs.png --bg-scale --no-fehbg &
/usr/lib/notification-daemon-1.0/notification-daemon &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom --no-fading-openclose -i 0.75 --vsync --fade-out-step 1 --fade-in-step 1 &

gnome-terminal --name="music_terminal" -- music
exec i3
