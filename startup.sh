#!/bin/bash

x-window-manager &

# Install BosMon
if [ ! -f "/root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe" ]; then
    ./install_bosmon.sh &
    wine bosmon_setup.exe /silent /COMPONENTS=bosmon
fi

wine /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
