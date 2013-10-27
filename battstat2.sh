#! /bin/bash

# battery status script

BATTERY=/sys/class/power_supply/BAT0

CAPACITY=`cat $BATTERY/capacity`
STATE=`cat $BATTERY/status`

#CHARGE=`echo $(($CAPACITY))`

NON='\033[00m'
BLD='\033[01m'
RED='\033[01;31m'
GRN='\033[01;32m'
YEL='\033[01;33m'

COLOR="$RED"

case "${STATE}" in
   'Full')
   STATE="$BLD*$NON"
   #STATE="$BLD*$NON"
   ;;
   'Charging')
   STATE="$BLD+$NON"
   ;;
   'Discharging')
   STATE="$BLD-$NON"
   ;;
esac

# color code capacity 
if [ "$CAPACITY" -gt "99" ]
then
   CHARGE=100
fi

if [ "$CAPACITY" -gt "15" ]
then
   COLOR="$YEL"
fi
if [ "$CAPACITY" -gt "30" ]
then
   COLOR="$GRN"
fi

#echo -e "${COLOR}${CAPACITY}${NON}${STATE}"
#echo -e "${STATE}${NON}${COLOR}${CAPACITY}${NON}"
echo -e "${COLOR}${CAPACITY}${NON}"

# end
