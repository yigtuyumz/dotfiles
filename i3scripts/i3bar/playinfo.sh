#!/usr/bin/env bash

song_title="$(playerctl metadata xesam:title)"
artist="$(playerctl metadata xesam:artist)"
album="$(playerctl metadata xesam:album)"

echo "${artist} | ${song_title} - ${album}"


