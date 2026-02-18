#!/bin/bash
# Check and adjust Pi Cam autofocus
# Run on the Pi, sync images to Mac to view
# Usage: ./check_focus.sh [mode]
#   Modes: auto (default), manual, continuous

MODE=${1:-auto}
SAVE_DIR="$HOME/RaspbirdyPi/data/images/focus_test"
mkdir -p "$SAVE_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Camera info:"
rpicam-hello --list-cameras 2>&1 | head -20

case $MODE in
    auto)
        echo "Taking photo with autofocus (single shot)..."
        rpicam-still \
            --autofocus-mode auto \
            --width 4608 --height 2592 \
            -o "$SAVE_DIR/focus_auto_$TIMESTAMP.jpg"
        ;;
    continuous)
        echo "Taking photo with continuous autofocus..."
        rpicam-still \
            --autofocus-mode continuous \
            --width 4608 --height 2592 \
            -o "$SAVE_DIR/focus_continuous_$TIMESTAMP.jpg"
        ;;
    manual)
        echo "Taking photos at multiple manual focus distances..."
        for LENS in 0.0 2.0 5.0 10.0; do
            echo "  Lens position: $LENS"
            rpicam-still \
                --autofocus-mode manual \
                --lens-position "$LENS" \
                --width 4608 --height 2592 \
                -o "$SAVE_DIR/focus_manual_${LENS}_$TIMESTAMP.jpg"
        done
        ;;
    *)
        echo "Unknown mode: $MODE. Use auto, manual, or continuous."
        exit 1
        ;;
esac

echo "Focus test images saved to $SAVE_DIR"