#!/bin/bash
set -e

cat $1 | while read url 
do
  echo "URL: $url"
  clean=$(echo $url | sed -e 's/\//_/g')
  echo "Path: $clean"
  curl -s $url > "./output/$clean.html"
done