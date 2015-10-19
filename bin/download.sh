#!/usr/bin/env bash

_require () {
  for i
  do
    if ! command -v "$i" > /dev/null
    then
      echo "Command not found $i" >&2
      exit 1
    fi
  done
}

_downloadKML() {
  open "https://www.google.com/maps/d/u/0/kml?mid=$GOOGLE_MAP_ID&forcekml=1"

  until test -f "$DOWNLOADFILE"
  do
    printf "."
    sleep 1
  done

  echo Done
  mv -v "$DOWNLOADFILE" .
}

_commit() {
  git add .
  git commit -m "Daily backup"
  git push
}

_require git

GOOGLE_MAP_ID=${GOOGLE_MAP_ID:-"zK3wb27P0oOw.kqYvfj1SZL2M"}
DOWNLOADFILE=~/Downloads/"SG Bicycle Parking Project.kml"

_downloadKML && _commit