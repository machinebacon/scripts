#! /bin/bash

#temp=``
mem=`free -m | grep buffers/cache`
time=`date`
batt=`cat /sys/module/battery/initstate`
uptime=`uptime`
#mail=``

#OUTPUT=
$(echo -e $time $mail $batt $mem | osd_cat -o 0 -d 15 -c gray)
#`echo -e $time $mail $batt $uptime $mem | osd_cat -o 2 -d 15 -c black`
#-f -*-fixed-*-*-*-*-10-*-*-*-*-*-*-*`

#notify-send -u critical "$OUTPUT"
