#!/bin/bash

CONFIG_PATH=/data/options.json
RESOLUTION=$(jq --raw-output '.display_resolution // empty' $CONFIG_PATH)

xfwm4 &

while true
do
    wine explorer /desktop=BosMon,$RESOLUTION "C:\\Program Files\\BosMon\\BosMon.exe"
    sleep 1
done
