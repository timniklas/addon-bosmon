#!/bin/bash

echo 'Updating /etc/hosts file...'
HOSTNAME=$(hostname)
echo "127.0.1.1\t$HOSTNAME" >> /etc/hosts

echo "Starting VNC server at $RESOLUTION..."
vncserver -geometry $RESOLUTION -SecurityTypes None &

echo "VNC server started at $RESOLUTION! ^-^"

echo "Linking persistent storage..."
mkdir -p "/root/.wine/drive_c/users/root/AppData/Roaming"
ln -sT /data/appdata "/root/.wine/drive_c/users/root/AppData/Roaming/BosMon"
mkdir -p "/root/.wine/drive_c/Program Files"
ln -sT /data/program "/root/.wine/drive_c/Program Files/BosMon"

echo "Starting novnc..."
websockify --web=/usr/share/novnc/ 8099 localhost:5901
