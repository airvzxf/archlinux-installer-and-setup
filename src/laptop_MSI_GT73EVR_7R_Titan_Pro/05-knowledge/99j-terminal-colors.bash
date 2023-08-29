#!/usr/bin/env bash

# Change the font styles and the background color:
declare -a FIRST_POSITION=(0 1 2 4 5 6 8 9)
declare -a SECOND_POSITION=(30 31 32 33 34 35 36 37
  40 41 42 43 44 45 46 47
  90 91 92 93 94 95 96 97
  100 101 102 103 104 105 106 107)

# To change the colors of the foreground and background, uncomment the variables:
#declare -a FIRST_POSITION=(30 31 32 33 34 35 36 37
#  40 41 42 43 44 45 46 47
#  90 91 92 93 94 95 96 97
#  100 101 102 103 104 105 106 107)
#declare -a SECOND_POSITION=(40 41 42 43 44 45 46 47
#  100 101 102 103 104 105 106 107)

# To create a sequences of numbers, you can execute the command 'seq'.
#for i in $(seq 0 256); do

for i in "${FIRST_POSITION[@]}"; do
  for j in "${SECOND_POSITION[@]}"; do
    echo -e "\e[0me[${i};${j}m: \e[${i};${j}mHello World\e[0m"
  done
done
