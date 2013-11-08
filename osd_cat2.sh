#! /bin/bash

temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1/1000}') 
mem=$(free -m | grep buffers/cache | sed -e 's/[buffers/cache -+ :]//g' | sed 's/.\{4\}$//')
time=$(date | sed -e 's/EST 2013//g') 
batt=$(cat /sys/class/power_supply/BAT0/capacity)
mail=$($HOME/mail)

#OUTPUT=
$(echo -e $time '>>' m$mail b$batt r$mem t$temp | osd_cat -A center -o 2 -d 10 -c black)

#`echo -e $time $mail $batt $uptime $mem | osd_cat -o 2 -d 15 -c black -f -*-fixed-*-*-*-*-10-*-*-*-*-*-*-*`

