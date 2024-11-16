#!/usr/bin/env bash

bgfile="${HOME}/.local/share/bliss.jpg"
monitor_count=$(xrandr | grep '\bconnected\b' | cut -d' ' -f1 | wc -w)

if ! [ -f "${bgfile}" ]; then
  ffmpeg -f lavfi -i color=c=cblack:s=2x2:d=1 -frames:v 1 \
    "${HOME}/.local/share/black.png" 2>/dev/null
  bgfile="${HOME}/.local/share/black.png"
fi

for ((i = 1; i <= "${monitor_count}"; i++)) ; do
  nitrogen --head="${i}" --set-zoom-fill "${bgfile}" 2>/dev/null
done
