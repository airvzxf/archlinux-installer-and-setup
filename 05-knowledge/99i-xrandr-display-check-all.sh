#!/bin/bash

startAt=59
endAt=61
incrementBy=0.2
screenName="HDMI-1-1"
screenResolution="1680x1050"

count=$(echo "( $endAt - $startAt ) / $incrementBy" | bc)

for (( i=0; i <= $count; i++ ))
do
	value=$(echo "$startAt + ( $incrementBy * $i )" | bc)
	echo -e "xrandr --output $screenName --mode $screenResolution --rate $value\n"
	xrandr --output $screenName --mode $screenResolution --rate $value --dpi 120
	sleep 3
done
