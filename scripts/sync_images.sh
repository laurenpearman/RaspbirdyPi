#!/bin/bash
# sync bird images from Pi to Mac
# usage: ./sync_images.sh

PI_IP=$(tailscale status | grep raspbirdypi | awk '{print $1}')
if [ -z "PI_IP" ]; then
	echo "Error: Can't find Pi on Tailscale. Is it plugged in and online?"
	exit 1
fi
PI_USER="lauren"
REMOTE_PATH="~/RaspbirdyPi/data/images/"
LOCAL_PATH="$HOME/RaspbirdyPi/data/images/"

echo "Syncing images from Pi ($PI_IP)..."
rsync -avz --progress "$PI_USER@$PI_IP:$REMOTE_PATH" "$LOCAL_PATH"

if [ $? -eq 0 ]; then
	COUNT=$(ls -1 "$LOCAL_PATH" 2>/dev/null | grep -v '.gitkeep' | wc
	echo "Sync complete. $COUNT images in ~/data/images/."
else
	echo "Sync failed. Check the Pi?"
fi
