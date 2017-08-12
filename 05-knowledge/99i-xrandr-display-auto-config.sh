#!/bin/bash
#set -x

screenName="LVDS-1-1"
screenName="HDMI-1-1"
screenStatus="connected"
echo -e ""

funcIsEmptyThenExit() {
	if ! [ "$1" ] ; then
		echo -e "Parameter missing, this script can't continue."
		echo -e "Error after line: ${BASH_LINENO[*]}"
		echo -e ""
		exit -1
	fi
}

# Step 1
# Connect you screen and logout from the windows manager (go to terminal mode withot GUI)

# Step 2
# Login again in your window manager 'nvidia-xrun'

# Step 3
# Show the screens connected in your computer
xrandr=$(xrandr | grep -w "$screenName.* $screenStatus")
funcIsEmptyThenExit $xrandr
echo -e "Looking for screen: $screenName"
echo -e "$xrandr"
echo -e "\n"
# Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 16384 x 16384
# LVDS-1-1 connected 1366x768+0+0 (normal left inverted right x axis y axis) 309mm x 173mm
# HDMI-1-1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 853mm x 480mm

# Step 4
# Looks for the screen at the end there are some mesures in millimeters

# Step 5
# Let's to do some operations
screenXrandrMillimeters=$(xrandr | grep -w "$screenName.* $screenStatus" | grep -Eoi "[0-9]+mm" | grep -Eoi "[0-9]+")
funcIsEmptyThenExit $screenXrandrMillimeters
screenWidthMillimeters=$(echo $screenXrandrMillimeters | cut -d' ' -f1)
funcIsEmptyThenExit $screenWidthMillimeters
screenHeightMillimeters=$(echo $screenXrandrMillimeters | cut -d' ' -f2)
funcIsEmptyThenExit $screenHeightMillimeters

echo -e "screenWidthMillimeters: $screenWidthMillimeters"
echo -e "screenHeightMillimeters: $screenHeightMillimeters"
echo -e ""

screenXrandrResolution=$(xrandr | grep -w "$screenName.* $screenStatus" | grep -Eoi "[0-9]+x[0-9]+" | grep -Eoi "[0-9]+")
funcIsEmptyThenExit screenXrandrResolution
screenResolutionWidth=$(echo $screenXrandrResolution | cut -d' ' -f1)
funcIsEmptyThenExit screenResolutionWidth
screenResolutionHeight=$(echo $screenXrandrResolution | cut -d' ' -f2)
funcIsEmptyThenExit screenResolutionHeight

echo -e "screenResolutionWidth: $screenResolutionWidth"
echo -e "screenResolutionHeight: $screenResolutionHeight"
echo -e ""

screenWidthCentimeters=$(awk "BEGIN {print $screenWidthMillimeters * 0.1}")
funcIsEmptyThenExit screenWidthCentimeters
screenHeightCentimeters=$(awk "BEGIN {print $screenHeightMillimeters * 0.1}")
funcIsEmptyThenExit screenHeightCentimeters
echo -e "screenWidthCentimeters: $screenWidthCentimeters"
echo -e "screenHeightCentimeters: $screenHeightCentimeters"
echo -e ""

screenWidthInches=$(awk "BEGIN { w=($screenWidthCentimeters / 2.54); printf(\"%.2f\", w)}")
funcIsEmptyThenExit screenWidthInches
screenHeightInches=$(awk "BEGIN { h=($screenHeightCentimeters / 2.54); printf(\"%.2f\", h)}")
funcIsEmptyThenExit screenHeightInches
echo -e "screenWidthInches: $screenWidthInches"
echo -e "screenHeightInches: $screenHeightInches"
echo -e ""

screenDpisWidth=$(awk "BEGIN { w=($screenResolutionWidth / $screenWidthInches); printf(\"%.2f\", w)}")
funcIsEmptyThenExit screenDpisWidth
screenDpisHeight=$(awk "BEGIN { w=($screenResolutionHeight / $screenHeightInches); printf(\"%.2f\", w)}")
funcIsEmptyThenExit screenDpisHeight
echo -e "screenDpisWidth: $screenDpisWidth"
echo -e "screenDpisHeight: $screenDpisHeight"
echo -e ""

screenDpis=$(awk "BEGIN { printf(\"%d\", $screenDpisWidth)}")
funcIsEmptyThenExit screenDpis
echo -e "screenDpis: $screenDpis"
echo -e ""

# Step 6
# Put this into your .nvidia-xinitrc
echo -e "Run this command'nano ~/.nvidia-xinitrc' and copy the line below."
echo -e "xrandr --output $screenName --mode ${screenResolutionWidth}x${screenResolutionHeight} --rate 60 --dpi ${screenDpis}"
xrandr --output $screenName --mode ${screenResolutionWidth}x${screenResolutionHeight} --rate 60 --dpi ${screenDpis}
echo -e "\n"

#~ 1366x768

#~ HDMI-1-1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 853mm x 480mm
   #~ 1920x1080     60.00*+  59.94    30.00    24.00    29.97    23.98  
   #~ 1920x1080i    60.00    59.94  
   #~ 1680x1050     59.88  
   #~ 1280x1024     60.02  
   #~ 1440x900      59.90  
   #~ 1280x960      60.00  
   #~ 1280x800      74.93    59.91  
   #~ 1280x768      59.99  
   #~ 1280x720      60.00    59.94  
   #~ 1024x768      60.00  
   #~ 1440x480i     59.94  
   #~ 800x600       60.32    56.25  
   #~ 720x480       60.00    59.94  
   #~ 720x480i      60.00    59.94  
   #~ 640x480       60.00    59.94  
   #~ 720x400       70.08  

#~ https://www.insigniaproducts.com/pdp/NS-40D510NA15/2992002
#~ E39G4QNKDWBYNNX
#~ Serial No.: KQPG7YA009654
#~ 16G28X
#~ Rev. B
#~ MFG Date: July, 2016
