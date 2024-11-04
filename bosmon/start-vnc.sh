#!/bin/bash

echo 'Updating /etc/hosts file...'
HOSTNAME=$(hostname)
echo "127.0.1.1\t$HOSTNAME" >> /etc/hosts

echo "Starting VNC server at $RESOLUTION..."
vncserver -geometry $RESOLUTION -SecurityTypes None &

echo "VNC server started at $RESOLUTION! ^-^"

echo "Starting novnc..."
websockify -D --web=/usr/share/novnc/ 7281 localhost:5901

echo "Waiting for BosMon to start..."
# Wait for the notification daemon to finish launching
while ! pgrep -f "xstartup" > /dev/null; do

    # Set optional delay
    sleep .1
done

echo "Startup complete"
while pgrep -f "xstartup" > /dev/null; do

    # Set optional delay
    sleep .1
done
