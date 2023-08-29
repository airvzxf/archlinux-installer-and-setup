[[ -f ~/.Xresources ]] && xrdb -merge -I/home/wolf ~/.Xresources

xrandr --output DP-0 --off
#xrandr --output DP-0 --mode 1920x1080 --rate 120.00
xrandr --output DP-3 --mode 1920x1080 --rate 240.00
#xrandr --output HDMI-0 --mode 1920x1080 --rate 120.00

xbacklight -set 100

numlockx on

xbindkeys

battery-discharging &

openbox-session
