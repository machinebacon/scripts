#! /bin/bash

if egrep -iq 'touchpad' /proc/bus/input/devices; then
	synclient VertEdgeScroll=1 &
	synclient TapButton1=1 &
fi

