#!/bin/bash

# Get list of output devices
DEVICES=$(SwitchAudioSource -a -t output)
CURRENT_DEVICE=$(SwitchAudioSource -c)

# Get next device in the list
NEXT_DEVICE=$(echo "$DEVICES" | grep -A1 "^$CURRENT_DEVICE$" | tail -n1)
if [ -z "$NEXT_DEVICE" ]; then
    NEXT_DEVICE=$(echo "$DEVICES" | head -n1)
fi

# Switch to next device
SwitchAudioSource -s "$NEXT_DEVICE"

# Update sketchybar
$HOME/.config/sketchybar/plugins/audio_output.sh
