## PROPERTY OF LINUXBBQ ##

#!/bin/bash
# script to copy an iso to usb stick at /dev/sdb

DEVICE='/dev/sdb' # assume /dev/sdb

function usage() {
    echo 'ddiso: copies an iso file to usb drive at '$DEVICE
    echo 'usage: ddiso isofile <sdX>'
    echo 'assumes /dev/sdb if device is not specified'
    exit 1
}

if [ -z $1 ]; then # no iso file specified
    usage
fi

if [ ! -e $1 ]; then # iso file not found
    echo 'file "'$1'" does not exist'
    usage
fi

if [ ! -z $2 ]; then # alternate device specified
    if [ $2 = 'sda' ]; then
        echo "I can't let you do that"
        exit 1
    fi
   DEVICE='/dev/'$2
fi

echo 'copy '$1' to usb stick at '$DEVICE
read -n1 -p 'are you sure? (y/n)'
echo
if [ $REPLY = 'y' ]; then
    cmd='dd bs=4M if='$1' of='$DEVICE
    echo $cmd
    $cmd
    echo 'done'
    sync
    echo 'now safe to remove '$DEVICE
fi
