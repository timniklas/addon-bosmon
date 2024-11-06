#!/bin/bash

x-window-manager &

# Link persistent storage
mkdir -p /data/program
mkdir -p /root/.wine/drive_c/users/root/AppData/Roaming/BosMon
mkdir -p /data/appdata
mkdir -p /root/.wine/drive_c/Program Files/BosMon
ln -s /root/.wine/drive_c/users/root/AppData/Roaming/BosMon /data/program
ln -s /root/.wine/drive_c/Program Files/BosMon /data/appdata

# Install BosMon
if [ ! -f "/root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe" ]; then
    ./install_bosmon.sh &
    wine bosmon_setup.exe /silent /COMPONENTS=bosmon
fi

# Keep BosMon running
while true
do
    wine /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
    sleep 1
done
