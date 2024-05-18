#!/usr/bin/bash

if /usr/bin/pgrep -x "easyeffects" > /dev/null; then
  /usr/bin/pkill -x "easyeffects"
else
  /usr/bin/easyeffects --gapplication-service &
fi

