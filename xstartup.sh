#!/bin/bash

CONFIG_PATH=/data/options.json
RESOLUTION=$(jq --raw-output '.display_resolution // empty' $CONFIG_PATH)

wine reg add "HKCU\\Software\\Wine\\X11 Driver" /v Managed /t REG_SZ /d "Y" /f
wine reg add "HKCU\\Control Panel\\Desktop" /v LogPixels /t REG_DWORD /d 96 /f

xfwm4 &

while true
do
    wine /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
    sleep 1
done
