#!/usr/bin/env sh
set -e

mkdir -p /app/tmp

Error() {
  echo "$1 EXITED"
  exit 1
}

(
  Xvfb :0 -screen 0 1600x900x8 -fbdir /app/tmp; Error "Xvfb"
) &

(
  while true; do
    ls -l /app/tmp
    set +e
      cp /app/tmp/Xvfb_screen0 /app/tmp/snapshot.xwd
      convert /app/tmp/snapshot.xwd /app/www/snapshot_new.png
      cp /app/www/snapshot_new.png /app/www/snapshot.png
    set -e
    echo "sleeping.."
    sleep 1
  done
) &

(
  xclock -update 1; Error "xclock" &
) &

(
  busybox httpd -p 0.0.0.0:$PORT -f -v -h /app/www
) &

tail -f /dev/null
