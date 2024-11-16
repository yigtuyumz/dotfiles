#!/usr/bin/bash

# device names are:
# HDA Intel PCH
# USBZH5XK
# can be gathered via aplay -l


if /usr/bin/pgrep -x "volumeicon" > /dev/null; then
  /usr/bin/pkill -x "volumeicon"
fi

if /usr/bin/pgrep -x "easyeffects" > /dev/null; then
  /usr/bin/pkill -x "easyeffects"
  /usr/bin/volumeicon --device 'HDA Intel PCH' &
else
  /usr/bin/easyeffects --gapplication-service &
  /usr/bin/volumeicon --device 'USBZH5XK' &
fi

