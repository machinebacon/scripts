#!/bin/bash
#
# screenlock: lock screen on hibernate or suspend
# place in /etc/pm/sleep.d
# chmod 755
# chown root:root

username=dkeg # add username here; i.e.: username=foobar
userhome=/home/$username
export XAUTHORITY="$userhome/.Xauthority"
export DISPLAY=":0"
case "$1" in 
	hibernate|suspend)
	   su $username -c "/usr/bin/i3lock -i /home/dkeg/images/i3lock_back2.png"
	   ;;
	thaw|resume)
           ;;
	*) exit $NA
	   ;; 
esac
