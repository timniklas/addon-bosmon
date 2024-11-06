#!/bin/bash

x-window-manager &

# Install BosMon
./activate_bosmon.sh &
if [ ! -f /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe ]; then
    wine bosmon_setup.exe /silent /COMPONENTS=bosmon
else
    wine /root/.wine/drive_c/Program\ Files/BosMon/Activate.exe
fi

while true
do
    wine /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
    sleep 1
done
