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

_init() {
  mkdir -p images tmp
  rm images.map
  rm images/*
}

_findImages() {
  xml2 < *.kml  | grep /kml/Document/Folder/Placemark/ExtendedData/Data/value | cut -d= -f2- | xargs -n1
}

_downloadImages() {
  local _dest1
  while read i
  do
    _dest1=tmp/"$(echo $i | md5)"
    curl "$i" --output "$_dest1" --silent --location
    _dest2=images/$(_generateFilename "$_dest1")
    mv -v "$_dest1" "$_dest2"
    if test "html" == "${_dest2##*.}"
    then
      echo An error downloading the image "$i" >&2
      continue
    fi
    echo "$_dest2" "$i" >> images.map
  done
}

_generateFilename () {
  _encodeFileName () {
    md5 < "$1"
  }
  _findFileExtention () {
    file --mime-type "$1" | cut -d/ -f3
  }
  echo $(_encodeFileName "$1").$(_findFileExtention "$1")
}

_replaceImages() {
  gsed -i s/amp\;//g *kml
  cat images.map | while read i j
  do
    gsed -i "s,$j,$i,g" *.kml
  done
}

_commit() {
  git add images.map images/*jpeg *.kml
  git add -u images
  git commit -m "Daily images backup"
}

_require xml2 md5 file cut curl mv grep xargs cat gsed

_init &&
_findImages | _downloadImages &&
_replaceImages && _commit
