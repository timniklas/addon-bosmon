#!/bin/bash

echo 'Updating /etc/hosts file...'
HOSTNAME=$(hostname)
echo "127.0.1.1\t$HOSTNAME" >> /etc/hosts

echo "Starting VNC server at $RESOLUTION..."
vncserver -geometry $RESOLUTION -SecurityTypes None &

echo "VNC server started at $RESOLUTION! ^-^"

echo "Starting novnc..."
websockify --web=/usr/share/novnc/ 8099 localhost:5901
