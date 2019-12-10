#!/usr/bin/env bash
set -euo pipefail

_term() {
  >&2 echo "TERM"
  exit 0
}
trap "_term" TERM

_err() {
  >&2 echo "err: $*"
  exit 1
}

(
  exec xclock -update 1
) &

(
  while true; do
    sec=$(date '+%S')
    echo "value $sec" > /tmp/metrics
    sleep 1
  done
) &

echo "started"
tail -f /dev/null &
wait $!
