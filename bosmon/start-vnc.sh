#!/bin/bash

CONFIG_PATH=/data/options.json
KEY_NAME=$(jq --raw-output '.key_name // empty' $CONFIG_PATH)
KEY_SERIAL=$(jq --raw-output '.key_serial // empty' $CONFIG_PATH)

echo 'Updating /etc/hosts file...'
HOSTNAME=$(hostname)
echo "127.0.1.1\t$HOSTNAME" >> /etc/hosts

echo "Linking persistent storage..."
mkdir -p /data/appdata
ln -sT /data/appdata "/root/.wine/drive_c/users/root/AppData/Roaming/BosMon"

echo "Activating License..."
wine reg add "HKEY_LOCAL_MACHINE\SOFTWARE\BosMon" /v key /t REG_SZ /d "$KEY_SERIAL"
wine reg add "HKEY_LOCAL_MACHINE\SOFTWARE\BosMon" /v username /t REG_SZ /d "$KEY_NAME"

echo "Starting VNC server at $RESOLUTION..."
vncserver -geometry $RESOLUTION -SecurityTypes None &

echo "Starting novnc..."
websockify --web=/usr/share/novnc/ 8099 localhost:5901
