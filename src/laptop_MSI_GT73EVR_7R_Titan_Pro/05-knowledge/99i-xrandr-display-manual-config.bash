#!/bin/bash
#set -x

screenResolutionWidth=3286
screenResolutionHeight=1080
screenWidthMillimeters=462
screenHeightMillimeters=152
screenRate=60.00
echo -e ""

funcIsEmptyThenExit() {
	if ! [ "$1" ] ; then
		echo -e "Parameter missing, this script can't continue."
		echo -e "Error after line: ${BASH_LINENO[*]}"
		echo -e ""
		exit 1
	fi
}

# Step 1
# Connect you screen and logout from the windows manager (go to terminal mode withot GUI)

# Step 2
# Login again in your window manager 'nvidia-xrun'

# Step 3
# Looks for the screen at the end there are some mesures in millimeters

# Step 4
# Let's to do some operations
echo -e "screenWidthMillimeters: $screenWidthMillimeters"
echo -e "screenHeightMillimeters: $screenHeightMillimeters"
echo -e ""

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

screenDpis=$(awk "BEGIN { w=(($screenDpisWidth + $screenDpisHeight) / 2); printf(\"%d\", w)}")
funcIsEmptyThenExit screenDpis
echo -e "Medium Dpis: $screenDpis"
echo -e ""
