#!/bin/bash

CONFIG_PATH=/data/options.json
RESOLUTION=$(jq --raw-output '.display_resolution // empty' $CONFIG_PATH)
DESKTOP_WIDTH=$(echo $RESOLUTION | cut -d'x' -f1)
DESKTOP_HEIGHT=$(echo $RESOLUTION | cut -d'x' -f2)

xfwm4 &

# Setze Emulated Desktop und Größe
wine reg add "HKCU\\Software\\Wine\\Explorer" /v Desktop /t REG_SZ /d "${DESKTOP_WIDTH}x${DESKTOP_HEIGHT}" /f

# Deaktiviere "Allow the window manager to control the windows"
wine reg add "HKCU\\Software\\Wine\\X11 Driver" /v Managed /t REG_SZ /d "N" /f

while true
do
    #wine /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
    wine explorer /desktop=BosMon,$RESOLUTION /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
    sleep 1
done
