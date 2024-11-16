#!/bin/bash

# Get current audio output device
CURRENT_DEVICE=$(SwitchAudioSource -c)

# Set different colors for different devices
case "$CURRENT_DEVICE" in
    "MacBook Pro Speakers")
        COLOR="0xffed8796"  # Red for internal speakers
        ;;
    "AirPods Pro")
        COLOR="0xff9ece6a"  # Green for AirPods
        ;;
    *)
        COLOR="0xff7aa2f7"  # Blue for other devices
        ;;
esac

sketchybar --set audio_output \
    label="$CURRENT_DEVICE" \
    label.color="$COLOR"
