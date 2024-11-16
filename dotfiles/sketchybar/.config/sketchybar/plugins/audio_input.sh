#!/bin/bash

# Get current audio input device
CURRENT_DEVICE=$(SwitchAudioSource -c -t input)

# Set different colors for different devices
case "$CURRENT_DEVICE" in
    "MacBook Pro Microphone")
        COLOR="0xffed8796"  # Red for internal mic
        ;;
    "AirPods Pro")
        COLOR="0xff9ece6a"  # Green for AirPods
        ;;
    *)
        COLOR="0xff7aa2f7"  # Blue for other devices
        ;;
esac

sketchybar --set audio_input \
    label="$CURRENT_DEVICE" \
    label.color="$COLOR"
