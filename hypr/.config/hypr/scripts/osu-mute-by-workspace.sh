#!/bin/bash
status_file="/tmp/osu-mute-by-workspace"
if [ ! -f "$status_file" ]; then
    playerctl -p spotify status > $status_file
fi

osu_workspace=$(hyprctl clients | grep -A 12 "osu!" | grep "workspace:" | awk '{print $2}' | tr -d '()')
active_workspace=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')
previous_spotify_status=$(cat $status_file)

osu_sink_input=$(pactl list sink-inputs | grep -B 20 'application.name = "osu!"' | grep "Sink Input" | awk '{print $3}' | tr -d '#')
spotify_sink_input=$(pactl list sink-inputs | grep -B 20 'application.name = "spotify"' | grep "Sink Input" | awk '{print $3}' | tr -d '#')

if [ "$osu_workspace" == "$active_workspace" ]; then
    pactl set-sink-input-mute $osu_sink_input 0
    playerctl -p spotify status > $status_file
    playerctl -p spotify pause
else
    pactl set-sink-input-mute $osu_sink_input 1
    if [ "$previous_spotify_status" == "Playing" ]; then
        # playerctl -p spotify play
        echo "Playing"
    fi
fi

exit 0
