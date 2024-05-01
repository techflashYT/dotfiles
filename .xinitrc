#!/bin/sh
~/.screenlayout/main.sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

alive=false
if alive 0.35 precision; then
	alive=true
fi
if [ "$alive" = "true" ]; then
	data=$(timeout 1 ls /mnt/net)

	# it's mounted but not responding
	if [ "$?" = "124" ]; then
		sudo umount -l /mnt/net
	fi

	# it's not mounted
	if [ "${#data}" -lt "50" ]; then
		sudo mount -t nfs4 truenas:/mnt/hdd /mnt/net
	fi

	# it's now mounted and should be reponding.  Start music player.
	#PLAY_MUSIC=1 gnome-terminal --role="music_terminal" &
fi
feh /usr/share/backgrounds/nixlabs.png --bg-scale --no-fehbg &
/usr/lib/notification-daemon-1.0/notification-daemon &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
picom --no-fading-openclose -i 1 --vsync --fade-out-step 1 --fade-in-step 1 &

discord &
firefox &
exec i3
