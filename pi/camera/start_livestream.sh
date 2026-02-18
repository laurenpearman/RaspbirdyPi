#!/bin/bash
# Start camera livestream on the Pi
# Run on the Pi, then run livestream_watch.sh on Mac
# Usage: ./livestream_start.sh

PORT=8888

echo "Starting livestream on port $PORT..."
echo "Run livestream_watch.sh on your Mac to view."
echo "Press Ctrl+C to stop."

rpicam-vid \
    -t 0 \
    --nopreview \
    --codec h264 \
    --profile baseline \
    --inline \
    --listen \
    --width 1280 \
    --height 720 \
    -o tcp://0:$PORT