LOCKFILE="/tmp/idle_inhibitor.lock"
PIPE="/tmp/idle_inhibitor.pipe"

if [[ -f $LOCKFILE ]]; then
  echo 1
fi

if [[ -p $PIPE ]]; then
  rm -f $PIPE
fi

mkfifo $PIPE

while true; do
  read -r line < $PIPE
  echo $line
done
