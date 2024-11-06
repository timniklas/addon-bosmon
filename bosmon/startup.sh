#!/bin/bash

x-window-manager &

# Install BosMon
./activate_bosmon.sh &
wine bosmon_setup.exe /silent /COMPONENTS=bosmon

while true
do
    wine /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
    sleep 1
done
