#!/bin/bash

echo 'Write license data to /tmp'
echo $(bashio::config 'key_name') > /tmp/key_name
echo $(bashio::config 'key_serial') > /tmp/key_serial

echo 'Updating /etc/hosts file...'
HOSTNAME=$(hostname)
echo "127.0.1.1\t$HOSTNAME" >> /etc/hosts

echo "Starting VNC server at $RESOLUTION..."
vncserver -geometry $RESOLUTION -SecurityTypes None &

echo "VNC server started at $RESOLUTION! ^-^"

echo "Starting novnc..."
websockify --web=/usr/share/novnc/ 8099 localhost:5901
