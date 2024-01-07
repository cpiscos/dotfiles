#!/bin/bash

DEFAULT_IDLE_TIME=300

swayidle_run() {
	idle_time="${1:-$DEFAULT_IDLE_TIME}"
	swayidle -w timeout "$idle_time" "hyprctl dispatch dpms off" \
		resume "hyprctl dispatch dpms on" \
  >> /tmp/sleep_idle.log 2>&1
		# timeout "$idle_time" "ags -q" \
		# resume "ags" \
}

if [[ "$1" == "--dry" ]]; then
	swayidle_run 5
else
	swayidle_run &
fi
