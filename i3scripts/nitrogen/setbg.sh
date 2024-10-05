#!/usr/bin/env bash

# what if value of --head changes?? (1 becomes 0 or viceversa)

bgfile="${HOME}/.local/share/black.png"


if ! [ -f "${bgfile}" ]; then
  ffmpeg -f lavfi -i color=c=black:s=2x2:d=1 -frames:v 1 "${bgfile}" \
    2>/dev/null
fi

monitor_count=$(xrandr | grep '\bconnected\b' | cut -d' ' -f1 | wc -w)

# set bg for main display, always
nitrogen --head=1 --set-zoom-fill "${bgfile}" 2>/dev/null

# set bg for auxilary display, if connected
if [[ "${monitor_count}" -ge 2 ]]; then
	nitrogen --head=0 --set-zoom-fill "${bgfile}" 2>/dev/null
fi
