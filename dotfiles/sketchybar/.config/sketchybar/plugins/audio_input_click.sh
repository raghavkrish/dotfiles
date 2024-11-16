#!/bin/bash

# Get list of input devices
DEVICES=$(SwitchAudioSource -a -t input)
CURRENT_DEVICE=$(SwitchAudioSource -c -t input)

# Get next device in the list
NEXT_DEVICE=$(echo "$DEVICES" | grep -A1 "^$CURRENT_DEVICE$" | tail -n1)
if [ -z "$NEXT_DEVICE" ]; then
    NEXT_DEVICE=$(echo "$DEVICES" | head -n1)
fi

# Switch to next device
SwitchAudioSource -s "$NEXT_DEVICE" -t input

# Update sketchybar
$HOME/.config/sketchybar/plugins/audio_input.sh
