#!/bin/bash

screenName="HDMI-1-1"
screenResolution="1920x1080i"

var1StartAt=-2
var1EndAt=2
var1IncrementBy=0.5

var2StartAt=-2
var2EndAt=2
var2IncrementBy=0.5

var3StartAt=-50
var3EndAt=50
var3IncrementBy=1

var4StartAt=-2
var4EndAt=2
var4IncrementBy=0.5

var5StartAt=-2
var5EndAt=2
var5IncrementBy=0.5

var6StartAt=-50
var6EndAt=50
var6IncrementBy=1

var7StartAt=-2
var7EndAt=2
var7IncrementBy=0.5

var8StartAt=-2
var8EndAt=2
var8IncrementBy=0.5

var9StartAt=-2
var9EndAt=2
var9IncrementBy=0.5

count1=$(echo "( $var1EndAt - $var1StartAt ) / $var1IncrementBy" | bc)
count2=$(echo "( $var2EndAt - $var2StartAt ) / $var2IncrementBy" | bc)
count3=$(echo "( $var3EndAt - $var3StartAt ) / $var3IncrementBy" | bc)
count4=$(echo "( $var4EndAt - $var4StartAt ) / $var4IncrementBy" | bc)
count5=$(echo "( $var5EndAt - $var5StartAt ) / $var5IncrementBy" | bc)
count6=$(echo "( $var6EndAt - $var6StartAt ) / $var6IncrementBy" | bc)
count7=$(echo "( $var7EndAt - $var7StartAt ) / $var7IncrementBy" | bc)
count8=$(echo "( $var8EndAt - $var8StartAt ) / $var8IncrementBy" | bc)
count9=$(echo "( $var9EndAt - $var9StartAt ) / $var9IncrementBy" | bc)

total=$(echo "$count1 * $count2 * $count3 * $count4 * $count5 * $count6 * $count7 * $count8 * $count9" | bc)
echo -e "${total} = ${count1} * ${count2} * ${count3} * ${count4} * ${count5} * ${count6} * ${count7} * ${count8} * ${count9}"
echo -e "\n"

timeDate=$(date +"%Y-%m-%d__%H-%M-%S__%N")
fileName=~/Downloads/xrandr_testing__${timeDate}.txt
touch ${fileName}

for (( i=0; i <= $count1; i++ ))
do
	for (( j=0; j <= $count2; j++ ))
	do
		for (( k=0; k <= $count3; k++ ))
		do
			for (( k=0; k <= $count4; k++ ))
			do
				for (( k=0; k <= $count5; k++ ))
				do
					for (( k=0; k <= $count6; k++ ))
					do
						for (( k=0; k <= $count7; k++ ))
						do
							for (( k=0; k <= $count8; k++ ))
							do
								for (( k=0; k <= $count9; k++ ))
								do
									var1=$(echo "$var1StartAt + ( $var1IncrementBy * $i )" | bc)
									var2=$(echo "$var2StartAt + ( $var2IncrementBy * $j )" | bc)
									var3=$(echo "$var3StartAt + ( $var3IncrementBy * $k )" | bc)
									var4=$(echo "$var4StartAt + ( $var4IncrementBy * $k )" | bc)
									var5=$(echo "$var5StartAt + ( $var5IncrementBy * $k )" | bc)
									var6=$(echo "$var6StartAt + ( $var6IncrementBy * $k )" | bc)
									var7=$(echo "$var7StartAt + ( $var7IncrementBy * $k )" | bc)
									var8=$(echo "$var8StartAt + ( $var8IncrementBy * $k )" | bc)
									var9=$(echo "$var9StartAt + ( $var9IncrementBy * $k )" | bc)

									commandString="xrandr --output ${screenName} --off"
									echo -e ${commandString}
									$($commandString 2>/dev/null)
									sleep 3

									commandString="xrandr --noprimary --output ${screenName} --mode ${screenResolution} --rate 60.00 --dpi 140"
									echo -e ${commandString}
									$($commandString 2>/dev/null)
									sleep 3

									commandString="xrandr --output ${screenName} --mode ${screenResolution} --output LVDS-1-1 --mode 1366x768 --left-of ${screenName}"
									echo -e ${commandString}
									$($commandString 2>/dev/null)
									sleep 3

									commandString="xrandr --output ${screenName} --transform ${var1},${var2},${var3},${var4},${var5},${var6},${var7},${var8},${var9}"

									$($commandString 2>/dev/null)
									if [ $? -eq 0 ]; then
										echo -e ${commandString} >> ${fileName}
										echo -e "${commandString} | #${total} | OK"
									else
										echo -e "${commandString} | #${total} | FAIL"
									fi
									echo -e ""

									sleep 6
									total=$(echo "$total - 1" | bc)
								done
							done
						done
					done
				done
			done
		done
	done
done
