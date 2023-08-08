#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /usr/bin/screenfetch ]; then screenfetch; fi

#~ PS1='[\u@\h \W]\$ '

txtblk='\e[0;30m\]' # Black - Regular
txtred='\e[0;31m\]' # Red
txtgrn='\e[0;32m\]' # Green
txtylw='\e[0;33m\]' # Yellow
txtblu='\e[0;34m\]' # Blue
txtpur='\e[0;35m\]' # Purple
txtcyn='\e[0;36m\]' # Cyan
txtwht='\e[0;37m\]' # White
bldblk='\e[1;30m\]' # Black - Bold
bldred='\e[1;31m\]' # Red
bldgrn='\e[1;32m\]' # Green
bldylw='\e[1;33m\]' # Yellow
bldblu='\e[1;34m\]' # Blue
bldpur='\e[1;35m\]' # Purple
bldcyn='\e[1;36m\]' # Cyan
bldwht='\e[1;37m\]' # White
unkblk='\e[4;30m\]' # Black - Underline
undred='\e[4;31m\]' # Red
undgrn='\e[4;32m\]' # Green
undylw='\e[4;33m\]' # Yellow
undblu='\e[4;34m\]' # Blue
undpur='\e[4;35m\]' # Purple
undcyn='\e[4;36m\]' # Cyan
undwht='\e[4;37m\]' # White
bakblk='\e[40m\]' # Black - Background
bakred='\e[41m\]' # Red
bakgrn='\e[42m\]' # Green
bakylw='\e[43m\]' # Yellow
bakblu='\e[44m\]' # Blue
bakpur='\e[45m\]' # Purple
bakcyn='\e[46m\]' # Cyan
bakwht='\e[47m\]' # White
txtrst='\e[0m\]' # Text Reset

if [ ! -f ~/.git-prompt.sh ]; then
  curl --location https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
fi

source ~/.git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1

function color_my_prompt {
  local __user_and_host="${bldylw}\u${bldwht}@${bldgrn}\h ${txtwht}| ${bldwht}\t (\d)\n"
  local __cur_location="${txtcyn}\w"
  local __git_branch='$(__git_ps1 "\n(%s)")'
  local __prompt_tail="\n$"
  local __last_color="${txtrst}"

  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "othing to commit" ]]; then
    state="${bldgrn}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${bldylw}"
  else
    state="${bldred}"
  fi

  # Collect the number of commits ahead or behind origin.
  sym="$(echo \"${git_status}\" | sed -r 's/.*by[[:blank:]]([0-9]*)[[:blank:]]commit.*/\1/' | grep '[0-9]' 2> /dev/null)"

  # Add marker for origin status with number of commits ahead (+) or behind (-)
  if [[ ${git_status} =~ "branch is ahead of" ]]; then
    sym="[+"${sym}"]"
  elif [[ ${git_status} =~ "branch is behind" ]]; then
    sym="[-"${sym}"]"
  else
    sym=""
  fi

  export PS1="${__user_and_host}${__cur_location}${state}${__git_branch}${sym}${__last_color}${__prompt_tail} "
}

PROMPT_COMMAND=color_my_prompt

is_prompted=false

pre_invoke_exec () {
  [ -n "$COMP_LINE" ] && return

  if [ "$BASH_COMMAND" == "clear" ] || [[ "$BASH_COMMAND" == 'printf "'* ]]
  then
    is_prompted=false
    return
  fi

  if [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ]
  then
    if $is_prompted
    then
      echo -e "\n\n"
    fi

    is_prompted=true
  fi
}

if [ $(whoami) != "root" ]; then
  trap 'pre_invoke_exec' DEBUG
fi

function make_completion_wrapper () {
  local function_name="${2}"
  local arg_count=$(($#-3))
  local comp_function_name="${1}"
  shift 2
  local function="
function $function_name {
  ((COMP_CWORD+=$arg_count))
  COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
  "$comp_function_name"
  return 0
}"
  eval "$function"
}

alias sudo='sudo '
alias watching='watch -n 0.1 '

alias src='source ~/.bash_profile'

alias xterm-tmux='xterm -fullscreen tmux >/dev/null 2>&1 &'

alias ls='ls --color=always'
alias l='ls --color=always -lh'
alias li='ls --color=always -lhi'
alias l.='ls --color=always -lhadi .*'
alias li.='ls --color=always -lhadi .*'
alias ll='ls --color=always -lha'
alias lli='ls --color=always -lhai'
alias llp='stat -c "%a (%A) %n" *'

# alias diff='colordiff'

alias grep='grep --color=always'
# alias grepi='gp(){ sudo grep --color=always -nirs $1 $2./; unset -f gp; }; gp'
# alias egrepi='egp(){ sudo egrep --color=always -nirs $1 $2./; unset -f egp; }; egp'
# alias fgrepi='fgp(){ sudo fgrep --color=always -nirs $1 $2./; unset -f fgp; }; fgp'
# alias pgrepi='pgp(){ sudo pgrep -il $1; unset -f pgp; }; pgp'

alias h='history'
alias h-grep='history | grep'
alias j='jobs -l'
alias du-fast='du -had 1 | sort -rh'
alias du-dir-fast='du -hd 1 | sort -rh'
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias cpu='top -o %CPU'
alias mem='top -o %MEM'
alias cpu-temp='sensors | grep Core'
alias memory-info='free -mlt'
alias ps-mem='ps auxf | sort -nr -k 4 | head -5'
alias ps-cpu='ps auxf | sort -nr -k 3 | head -5'
alias cpu-info='lscpu'
alias gpu-memory-info='grep -i --color memory /var/log/Xorg.0.log'

alias memory-clean='sudo sh -c "echo 3 >/proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf \"\n%s\n\" \"Ram-cache and Swap Cleared\""'

function set_brightness_at() {
  is_number=^[0-9]+$
  default_brightness=90
  max_brightness=$(cat /sys/class/backlight/nvidia_0/max_brightness)
  brightness=${default_brightness}

  if [[ ${1} =~ ${is_number} ]]
  then
    if [ ${1} -gt "-1" ] && [ ${1} -lt $((${max_brightness} + 1)) ]
    then
      brightness=${1}
    fi
  fi

  sudo echo ${brightness} > /sys/class/backlight/nvidia_0/brightness

  echo -e "Max brightness: ${max_brightness}"
  echo -e "Set the brightness at ${brightness}"
}

DECL=`declare -f set_brightness_at`
alias brightness-at='sbrgss(){ sudo bash -c "$DECL; set_brightness_at ${1}"; unset -f sbrgss; }; sbrgss'
alias brightness-is='cat /sys/class/backlight/nvidia_0/brightness'

alias ping-fast='while true; do echo -n $(date "+%a, %T%t")"> " && ping www.google.com; sleep 1; done'

alias ..='cd ../'
alias ....='cd ../../'
alias ......='cd ../../../'
alias ........='cd ../../../../'
alias ..........='cd ../../../../../'

alias chx='sudo chmod 755'
alias chx-directories='sudo find ./ -type d -exec chmod 755 {} \;'
alias chr='sudo chmod 644'
alias chr-files='sudo find ./ -type f -exec chmod 644 {} \;'

alias rmf='rm --force --recursive'

alias tar-gzc='tar -zcvf'
alias tar-bzc='tar -jcvf'
alias tar-xzc='tar -Jcvf'
alias tar-gzx='tar -zxvf'
alias tar-bzx='tar -jxvf'
alias tar-xzx='tar -Jxvf'
alias tar-gz-list='tar -ztvf'
alias tar-bz-list='tar -jtvf'
alias tar-xz-list='tar -Jtvf'

alias ct='column -t'
alias df-fast='df -hPT | column -t'
alias mount-info='mount | column -t'
alias mount-fat32='fh(){ sudo mount -t vfat $1 $2 -o rw,uid=$(id -u),gid=$(id -g); unset -f fh; }; fh'

alias d='date'
alias now='date +"%T"'
alias now-date='date +"%m-%d-%Y"'

alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep --extended-regexp "state|energy\:|time|percentage"'
alias battery-details='upower -i /org/freedesktop/UPower/devices/battery_BAT1'
alias battery-watching='watch -n 1 upower -i /org/freedesktop/UPower/devices/battery_BAT1 "| grep --extended-regexp \"state|energy\:|time|percentage\""'

alias find-here='fh(){ sudo find ./ -iname *"$@"* 2>/dev/null; unset -f fh; }; fh'
alias find-here-file='fhf(){ sudo find ./ -type f -iname *"$@"* 2>/dev/null; unset -f fhf; }; fhf'
alias find-here-dir='fhd(){ sudo find ./ -type d -iname *"$@"* 2>/dev/null; unset -f fhd; }; fhd'

alias find-all='fa(){ sudo find / -iname *"$@"* 2>/dev/null; unset -f fa; }; fa'
alias find-all-file='faf(){ sudo find / -type f -iname *"$@"* 2>/dev/null; unset -f faf; }; faf'
alias find-all-dir='fad(){ sudo find / -type d -iname *"$@"* 2>/dev/null; unset -f fad; }; fad'

alias delete='dl(){ sudo find ./ -iname *"$@"* -exec rm --force --recursive {} \; 2>/dev/null; unset -f dl; }; dl'
alias delete-all='dla(){ sudo find / -iname *"$@"* -exec rm --force --recursive {} \; 2>/dev/null; unset -f dla; }; dla'

alias x='exit'
alias cls='printf "\E[\E[2J" && printf "\E[H"'
alias clr='clear && printf "\E[3J"'

alias systemctl-enabled='systemctl list-unit-files --state enabled'
pidbyname(){ ps -a | grep -i ${1} | cut -d' ' -f2; }
alias pid-by-name='pidbyname'
pidsf(){ sudo lsof -p `pid-by-name ${1}` | grep -i ${2}; }
alias process-search-files='pidsf'

alias upgrade='sudo powerpill -Syyu --noconfirm && yay -Sau --noconfirm && yay -Yc --noconfirm'
alias upgrade-logs='cat /var/log/pacman.log | fgrep "[ALPM] upgraded" | tail -100'
alias pacman-unlock='sudo rm /var/lib/pacman/db.lck'
pacmanbysize(){ pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -hr | head -25; }
alias pacman-by-size='pacmanbysize'

alias rs='upgrade && sudo reboot'
alias off='upgrade && sudo poweroff'

alias pip-list='pip list --format columns'
alias pip-outdate='pip list --outdated --format freeze'
alias pip-upgrade="pip list --outdated --format freeze | sed 's/=.*//g' | xargs -n1 sudo pip install -U"
alias pip-search='pps(){ pip search $1 | sort; unset -f pps; }; pps'
alias pip-install='ppi(){ sudo pip install $1; unset -f ppi; }; ppi'

alias attach-process='echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope'

alias m='spotify >/dev/null 2>&1 &'
alias web='firefox >/dev/null 2>&1 &'
alias myip='curl icanhazip.com'
alias boinc='cd ~/workspace/boinc/ && /usr/bin/boinc'
alias boinc-mgr='cd ~/workspace/boinc/ && boincmgr &'
alias screenshot='xfce4-screenshooter'
alias nv='nvidia-settings >/dev/null 2>&1 &'
alias ph='phoronix-test-suite'
alias v='alsamixer'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias workspace='cd ~/workspace'
alias p='cd ~/workspace/projects'
alias pc='cd ~/workspace/projects && ~/workspace/projects/check-git-projects.bash'
alias calculator='galculator &'
alias local-netstat='netstat -tulpn'
alias ij='~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox'
alias phone-screenshot='adb exec-out screencap -p > "cellphone-screenshot-$(date +"%Y%m%d-%H%M%S-%N").png"'
alias phone-screencast='scrcpy --video-bit-rate 32M --no-audio --disable-screensaver --max-fps 30 --display 0 --push-target /sdcard/wolf/ --render-driver opengl --stay-awake --show-touches --turn-screen-off --verbosity debug --serial '
alias phone-screencast-record='scrcpy --video-bit-rate 32M --no-audio --disable-screensaver --max-fps 30 --display 0 --push-target /sdcard/wolf/ --render-driver opengl --stay-awake --show-touches --turn-screen-off --verbosity debug --record cellphone_record_$(date +"%Y%m%d").mp4 --serial '
alias network-monitor-ethernet='sudo bmon -b -p enp4s0'
alias network-monitor-wifi='sudo bmon -b -p wlp2s0'

alias ddd-fix="sed '/not set/d' -i $HOME/.ddd/init"

#alias docker-clean-service="docker service rm $(docker service ls -q)"
#alias docker-clean-network="docker network rm $(docker network ls -q -f name=python_ecommerce_app_dev_service_webnet)"
#alias docker-clean="docker container stop $(docker ps -aq) && docker container rm $(docker ps -aq)"
#alias docker-ls="docker container ls --all && echo '' && docker image ls --all && echo ''  && docker service ls && echo ''  && docker network ls && echo '' && docker node ls"
alias oc="oc4"

function connect_to_the_internet() {
  configuration_name=$1
  max_retrys=20
  target_domain='www.google.com'

  ping='ping -c 1 -q $target_domain >> /dev/null 2>&1'
  counter=0
  first_time=true

  sudo netctl stop-all

  while true
  do
    let "counter++"

    eval $ping
    if [ $? -ne 0 ]
    then
      echo "Try to PING: "$(date "+%a, %T%t")

      if [[ $counter == $max_retrys || $first_time == true ]]
      then
        counter=0
        first_time=false

        sudo netctl restart $configuration_name
      fi
    else
      break
    fi

    sleep 1
  done
}

alias home-wifi='connect_to_the_internet wlp2s0-Castillo_Grayskull_PA_5G'
alias home-ethernet='connect_to_the_internet ethernet-dhcp'
alias usb-ethernet='connect_to_the_internet enp0s20u1u4-Home'
alias villas='connect_to_the_internet wlp2s0-INFINITUMh75z'

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
