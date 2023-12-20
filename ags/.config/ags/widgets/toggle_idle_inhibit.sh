#!/bin/bash

LOCKFILE="/tmp/idle_inhibitor.lock"
PIPE="/tmp/idle_inhibitor.pipe"

enable_idle_inhibit() {
    systemd-inhibit --what=idle --who="IdleInhibitToggle" --why="Manual toggle" --mode=block sleep infinity &
    echo $! > $LOCKFILE
}

disable_idle_inhibit() {
    if [[ -f $LOCKFILE ]]; then
      kill $(cat $LOCKFILE)
      rm $LOCKFILE
    fi
}

enabled=0
if [[ -f $LOCKFILE ]] && ps -p $(cat $LOCKFILE) > /dev/null; then
  disable_idle_inhibit
  echo "Idle inhibit disabled"
else
  [[ -f $LOCKFILE ]] && rm $LOCKFILE
  enable_idle_inhibit & disown
  enabled=1
  echo "Idle inhibit enabled"
fi

[[ -p $PIPE ]] && echo $enabled > $PIPE

exit
