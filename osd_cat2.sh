#! /bin/bash

#temp=``
mem=`free -m | grep buffers/cache`
time=`date`
batt=`cat /sys/class/power_supply_BAT0/capacity`
#uptime=`uptime`
#mail=``

#OUTPUT=
$(echo -e $time $batt $mem | osd_cat -o 0 -d 15 -c black)
#`echo -e $time $mail $batt $uptime $mem | osd_cat -o 2 -d 15 -c black`
#-f -*-fixed-*-*-*-*-10-*-*-*-*-*-*-*`

#notify-send -u critical "$OUTPUT"

