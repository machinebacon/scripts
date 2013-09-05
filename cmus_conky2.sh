#!/bin/bash

# A script to scrape the output of "cmus-remote -Q"
# borrowed from a cb user

if pidof cmus > /dev/null; then
artist=`cmus-remote -Q | grep -m 1 'artist' | cut -d' ' -f3-`
  title=`cmus-remote -Q | grep -m 1 'title' | cut -d' ' -f3-`
  album=`cmus-remote -Q | grep -m 1 'album' | cut -d ' ' -f3-`

  if [ -n "$title" ]; then
echo \"$title\" by $artist from \"$album\"
  else
echo "end"
  fi
else
echo "off"
fi
