#!/bin/bash

CONFIG_PATH=/data/options.json

KEY_NAME=$(jq --raw-output '.key_name // empty' $CONFIG_PATH)
KEY_SERIAL=$(jq --raw-output '.key_serial // empty' $CONFIG_PATH)

# Wait for the notification daemon to finish launching
while ! pgrep -f "Activate.exe" > /dev/null; do

    # Set optional delay
    sleep .1
done

setxkbmap de

sleep 1
xte "str $KEY_NAME"
xte 'key Tab'
sleep 0.5
xte "str $KEY_SERIAL"
xte 'key Return'
sleep 0.5
xte 'key Return'
