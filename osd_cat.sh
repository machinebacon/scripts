#! /bin/bash

#temp=``
mem=$( inxi -Q 2>/dev/null | grep Mem cut -f 3- )
#time=
#batt=
#uptime=
#mail=``

#OUTPUT=
$(echo -e $mem | osd_cat -o 0 -d 15 -c gray)
#`echo -e $time $mail $batt $uptime $mem | osd_cat -o 2 -d 15 -c black`
#-f -*-fixed-*-*-*-*-10-*-*-*-*-*-*-*`

#notify-send -u critical "$OUTPUT"

