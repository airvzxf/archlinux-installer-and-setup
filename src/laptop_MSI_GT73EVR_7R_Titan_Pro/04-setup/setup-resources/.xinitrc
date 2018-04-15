[[ -f ~/.Xresources ]] && xrdb -merge -I/home/wolf ~/.Xresources

xrandr --newmode "1920x1080_120.00"  368.76  1920 2072 2288 2656  1080 1081 1084 1157  -HSync +Vsync
xrandr --addmode DP-0 "1920x1080_120.00"
xrandr --output DP-0 --primary --mode "1920x1080_120.00" --dpi 130

xbacklight -set 100

# msiklm <color_left>,<color_middle>,<color_right>,<color_logo>,<color_front_left>,<color_front_right>,<color_mouse>
sudo msiklm green,blue,red,white,yellow,green,sky

numlockx &

openbox-session
