#!/bin/bash
# Watch Pi cam live on Mac
# Run livestream_start.sh on Pi first
# Usage: ./livestream_watch.sh

PI_IP=$(tailscale status | grep raspbirdypi | awk '{print $1}')
if [ -z "$PI_IP" ]; then
	echo "Error: Can't find Pi on Tailscale. Is it plugged in and online?"
	exit 1
fi
PORT=8888

echo "Connecting to Pi livestream at $PI_IP:$PORT..."
echo "Press Q to quit."

ffplay -f h264 -fflags nobuffer -flags low_delay tcp://$PI_IP:$PORT
