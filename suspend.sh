#!/bin/bash

username=dkeg    # insert username
userhome=/home/$username
export XAUTHORITY="$userhome/.Xauthority"
export DISPLAY=":0"
case "$1" in
hibernate|suspend)
su $username -c "/usr/bin/i3lock -i /home/dkeg/images/i3lock_back.png"  
;;
thaw|resume)
           ;;
*) exit $NA
;;
esac
