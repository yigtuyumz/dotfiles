#!/usr/bin/env bash

# this program needs yt-dlp packet.
# pacman -S yt-dlp

if [ -z "${1}" ]; then
  echo "  argv[1] is search value."
  exit 1
fi

play_audio() {
  yt-dlp -f bestaudio ytsearch:"${1}" -o - 2>/dev/null \
    | ffplay -nodisp -autoexit -i - &>/dev/null
}

play_audio "${1}"

