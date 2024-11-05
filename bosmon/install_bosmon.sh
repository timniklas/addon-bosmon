#!/usr/bin/env bashio

KEY_NAME=$(bashio::config 'key_name')
KEY_SERIAL=$(bashio::config 'key_serial')

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
