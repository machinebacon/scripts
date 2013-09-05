## EXPERIMENTAL, SOME FUCKIN AROUND ##


#! /bin/bash

#TEMP=``
MEM=`free -h`
TIME=`date`
BATT=`cat /sys/module/battery/initstate`
UPTIME=`uptime`

OUTPUT=`echo -e $TIME $BATT $UPTIME $MEM`

notify-send -u critical "$OUTPUT"

