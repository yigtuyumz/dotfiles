#!/usr/bin/bash


# current keyboard layout
current=$(setxkbmap -query | grep 'layout' | awk '{print $2}')

if [ "${current}" == 'us' ]; then
	setxkbmap -layout de
	notify-send -t 2000 'Keyboard Layout is set to de'
elif [ "${current}" == 'de' ]; then
	setxkbmap -layout tr
	notify-send -t 2000 'Keyboard Layout is set to tr'
elif [ "${current}" == 'tr' ]; then
	setxkbmap -layout us
	notify-send -t 2000 'Keyboard Layout is set to us'
else
	notify-send -t 2000 'Unknown Keyboard Layout'
fi
