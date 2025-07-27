#!/bin/bash

CONFIG_PATH=/data/options.json
RESOLUTION=$(jq --raw-output '.display_resolution // empty' $CONFIG_PATH)

# Setze Wine-Konfiguration automatisch (wie vorher besprochen)
wine reg add "HKCU\\Software\\Wine\\Explorer" /v Desktop /t REG_SZ /d "${RESOLUTION}" /f
wine reg add "HKCU\\Software\\Wine\\X11 Driver" /v Managed /t REG_SZ /d "N" /f

# Starte NUR Wine mit Emulated Desktop, OHNE Window-Manager
while true
do
    wine explorer /desktop=BosMon,$RESOLUTION /root/.wine/drive_c/Program\ Files/BosMon/BosMon.exe
    sleep 1
done
