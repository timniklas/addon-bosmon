#!/bin/bash

wine bosmon_setup.exe /silent /COMPONENTS=bosmon &

# Wait for the setup to finish
while ! pgrep -f "Activate.exe" > /dev/null; do

    # Set optional delay
    sleep .1
done

pkill -f "Activate.exe"