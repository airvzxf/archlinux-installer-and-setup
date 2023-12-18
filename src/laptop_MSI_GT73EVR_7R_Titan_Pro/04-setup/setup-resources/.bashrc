# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /usr/bin/screenfetch ]; then screenfetch; fi

#~ PS1='[\u@\h \W]\$ '

# Terminal
# Decorations ~ \e[X;37m
# 0 - Regular text
# 1 - Bold text
# 4 - Underline text
# Colors ~ \e[1;XXm
# 30 - Black
# 31 - Red
# 32 - Green
# 33 - Yellow
# 34 - Blue
# 35 - Purple
# 36 - Cyan
# 37 - White
# Background ~ \e[XXm
# 40 - Black
# 41 - Red
# 42 - Green
# 43 - Yellow
# 44 - Blue
# 45 - Purple
# 46 - Cyan
# 47 - White
# Reset text color and decoration
text_color_reset='\e[0m'

color_my_prompt() {
  local _git
  _git=""

  local _white_color
  _white_color='\e[0;37m'

  local _red_color
  _red_color='\e[0;31m'

  local _green_color
  _green_color='\e[0;32m'

  local _yellow_color
  _yellow_color='\e[0;33m'

  local _cyan_color
  _cyan_color='\e[0;36m'

  local _red_color_bold
  _red_color_bold='\e[1;31m'

  local _green_color_bold
  _green_color_bold='\e[1;32m'

  local _yellow_color_bold
  _yellow_color_bold='\e[1;33m'

  local _white_color_bold
  _white_color_bold='\e[1;37m'

  # Check if the Git project is present in the folder.
  if [[ -d .git ]]; then
    _git+="\n${text_color_reset}Git:"

    local _text_color
    local _identifier
    _identifier="DELETE_THIS_LINE"

    # Get staged changes.
    local _staged_changes
    _staged_changes=$(\git status --short | \sed "s|^??.*|${_identifier}|" | \sed "s|^ [ACDMRT].*|${_identifier}|" | \sed --null-data "s|${_identifier}\n||g" | \wc --lines)
    _text_color="${text_color_reset}"
    if [[ ${_staged_changes} != "0" ]]; then
      _text_color="${_green_color}"
    fi
    _git+=" ${_text_color}${_staged_changes} staged ${text_color_reset}|"

    # Get not staged changes.
    local _not_staged_changes
    _not_staged_changes=$(\git status --short | \sed "s|^??.*|${_identifier}|" | \sed "s|^[ACDMRT].*|${_identifier}|" | \sed --null-data "s|${_identifier}\n||g" | \wc --lines)
    _text_color="${text_color_reset}"
    if [[ ${_not_staged_changes} != "0" ]]; then
      _text_color="${_yellow_color}"
    fi
    _git+=" ${_text_color}${_not_staged_changes} not staged ${text_color_reset}|"

    # Get untracked changes.
    local _untracked_changes
    _untracked_changes=$(\git status --short | \sed "s|^[^??].*|${_identifier}|" | \sed --null-data "s|${_identifier}\n||g" | \wc --lines)
    _text_color="${text_color_reset}"
    if [[ ${_untracked_changes} != "0" ]]; then
      _text_color="${_red_color}"
    fi
    _git+=" ${_text_color}${_untracked_changes} untracked ${text_color_reset}|"
  fi

  # User color.
  local _user_text_color
  _user_text_color="${_yellow_color_bold}"
  if [[ "$(whoami)" == "root" ]]; then
    _user_text_color="${_red_color_bold}"
  fi

  # User prompt tail.
  local _prompt_tail
  _prompt_tail="\n"
  if [[ "$(whoami)" == "root" ]]; then
    _prompt_tail+="${_red_color}#${text_color_reset}"
  else
    _prompt_tail+="${_yellow_color}\$${text_color_reset}"
  fi

  # Get max number of columns and create a division line.
  local _terminal_max_columns
  _terminal_max_columns="$(tput cols)"
  local _division_color
  _division_color="\e[35;45m"
  local _split_prompt
  _split_prompt="${text_color_reset}${_division_color}"
  local i
  for ((i = 0; i < _terminal_max_columns; i++)); do
    _split_prompt+="-"
  done
  _split_prompt+="${text_color_reset}\n\n"

  # Generate the user and path information.
  local _user_and_host="${_user_text_color}\u${_white_color_bold}@${_green_color_bold}\h ${_white_color}| ${_white_color_bold}\t (\d)\n"
  local _cur_location="${_cyan_color}\w"

  # Set the prompt.
  export PS1="${_split_prompt}${_user_and_host}${_cur_location}${_git}${_prompt_tail} "
}

error_handler() {
  local exit_code
  exit_code="${1}"

  local error_color
  error_color="\e[41;33m"

  echo -e "${text_color_reset}${error_color}ERROR | Exit code: ${1}${text_color_reset}"
  echo ""
}

pre_invoke_exec() {
  [ -n "$COMP_LINE" ] && return

  if [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ]; then
    local last_command_history
    last_command_history="$(history 1)"

    local last_word_command
    last_word_command=$(echo "$last_command_history" | awk '{print $NF}')

    if [[ ${last_word_command} =~ "clear" ]]; then
      return
    fi

    echo ""
    echo ""
  else
    local command_color
    command_color="\e[44;37m"

    echo -e "\n${text_color_reset}${command_color}BASH COMMAND | ${BASH_COMMAND}${text_color_reset}"
  fi
}

# Alias to make easier the life.
alias sudo='sudo '
alias ..........='cd ../../../../../'
alias ........='cd ../../../../'
alias ......='cd ../../../'
alias ....='cd ../../'
alias ..='cd ../'
alias battery-details='upower --show-info /org/freedesktop/UPower/devices/battery_BAT1'
alias battery-watching='watch --interval 1 upower --show-info /org/freedesktop/UPower/devices/battery_BAT1 "| grep --extended-regexp \"state:|energy:|time:|percentage:\""'
alias battery='upower --show-info /org/freedesktop/UPower/devices/battery_BAT1 | grep --extended-regexp "state:|energy:|time:|percentage:"'
alias c='galculator &'
alias chr-directories='sudo find ./ -type d -exec chmod 644 {} \;'
alias chr-files='sudo find ./ -type f -exec chmod 644 {} \;'
alias chr='sudo chmod 644'
alias chx-directories='sudo find ./ -type d -exec chmod 755 {} \;'
alias chx-files='sudo find ./ -type f -exec chmod 755 {} \;'
alias chx='sudo chmod 755'
alias clr='clear && printf "\E[3J"'
alias cls='printf "\E[\E[2J" && printf "\E[H"'
alias column-table='column --table'
alias cpu-info='lscpu'
alias cpu-temperature='sensors | grep --color=always Core'
alias d='date'
alias desktop='cd ~/Desktop'
alias df-table='df --human-readable --portability --print-type | column --table'
alias docker-clean-network='docker network rm "$(docker network ls --quiet --filter name=NAME_OF_THE_NETWORK)"'
alias docker-clean-service='docker service rm "$(docker service ls --quiet)"'
alias docker-clean='docker container stop "$(docker ps --all --quiet)" && docker container rm "$(docker ps -aq)"'
alias docker-ls='docker container ls --all; echo ""; docker image ls --all; echo ""; docker service ls; echo ""; docker network ls; echo ""; docker node ls'
alias downloads='cd ~/Downloads'
alias du-dir-sorted='du --human-readable --max-depth 1 | sort --human-numeric-sort'
alias du-sorted='du --all --human-readable --max-depth 1 | sort --human-numeric-sort'
alias enable-attach-process='echo "0" | sudo tee /proc/sys/kernel/yama/ptrace_scope'
alias gpu-memory-info='grep --color=always --ignore-case memory /var/log/Xorg.0.log'
alias grep-color='grep --color=always'
alias h-search='history | grep --color=always'
alias h='history'
alias ij='~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox'
alias j='jobs -l'
alias l='ls --color=always --human-readable --all '
alias ld.='ls --color=always --human-readable --all --directory .*'
alias ld='ls --color=always --human-readable --all --directory */'
alias ldi.='ls --color=always --human-readable --all --inode --directory .*'
alias ldi='ls --color=always --human-readable --all --inode --directory */'
alias li='ls --color=always --human-readable --all --inode'
alias ll='ls -l --color=always --human-readable --all'
alias lld.='ls -l --color=always --human-readable --all --directory .*'
alias lld='ls -l --color=always --human-readable --all --directory */'
alias lldi.='ls -l --color=always --human-readable --all --inode --directory .*'
alias lldi='ls -l --color=always --human-readable --all --inode --directory */'
alias lli='ls -l --color=always --human-readable --all --inode'
alias llp='stat --format "%a (%A) %n" *'
alias m='spotify >/dev/null 2>&1 &'
alias memory-clean='sudo bash -c "echo 3 >/proc/sys/vm/drop_caches; swapoff --all; swapon --all; echo \"RAM cache and SWAP were cleared.\""'
alias memory-info='free --human --mebi --lohi --total'
alias mount-table='mount | column --table'
alias my-public-ip='curl icanhazip.com'
alias netstat-local='netstat --tcp --udp --listening --program --numeric'
alias network-monitor-ethernet='sudo bmon --use-bit --policy enp4s0'
alias network-monitor-wifi='sudo bmon --use-bit --policy wlp2s0'
alias now-date='date +"%m-%d-%Y"'
alias now-time='date +"%T"'
alias nvs='nvidia-settings >/dev/null 2>&1 &'
alias oc="oc4"
alias off='sudo poweroff'
alias p='cd ~/workspace/projects'
alias pacman-unlock='sudo rm /var/lib/pacman/db.lck'
alias pc='cd ~/workspace/projects && ~/workspace/projects/check-git-projects.bash'
alias phone-screencast-record='scrcpy --video-bit-rate 32M --no-audio --disable-screensaver --max-fps 30 --display 0 --push-target /sdcard/wolf/ --render-driver opengl --stay-awake --show-touches --turn-screen-off --verbosity debug --record android-record-$(date +"%Y%m%d-%H%M%S-%N").mp4 --serial '
alias phone-screencast='scrcpy --video-bit-rate 32M --no-audio --disable-screensaver --max-fps 30 --display 0 --push-target /sdcard/wolf/ --render-driver opengl --stay-awake --show-touches --turn-screen-off --verbosity debug --serial '
alias phone-screenshot='adb exec-out screencap -p > "android-screenshot-$(date +"%Y%m%d-%H%M%S-%N").png"'
alias ping-fast='while true; do echo -n $(date "+%a, %T%t")"> " && ping www.google.com; sleep 1; done'
alias pip-list='pip list --format columns'
alias pip-outdate='pip list --outdated'
alias pip-upgrade="pip list --outdated 2> /dev/null | tail --lines +3 | cut --fields 1 --delimiter ' ' | xargs --max-args 1 pip install --upgrade"
alias ps-cpu='ps auxf | sort --numeric-sort --reverse --key 3 | head --lines 5'
alias ps-memory='ps auxf | sort --numeric-sort --reverse --key 4 | head --lines 5'
alias psg="ps aux | grep --invert-match grep | grep --color=always --ignore-case --line-number --regexp VSZ --regexp"
alias rmf='rm --force --recursive'
alias rm-special-characters='rm --force --recursive --'
alias rs='sudo reboot'
alias screenshot='xfce4-screenshooter'
alias src='source ~/.bash_profile'
alias systemctl-list-enabled='sudo systemctl list-unit-files --state enabled'
alias tar-bz-create='tar --bzip2 --create --verbose --file'
alias tar-bz-extract='tar --bzip2 --extract --verbose --file'
alias tar-bz-list='tar --bzip2 --list --verbose --file'
alias tar-gz-create='tar --gzip --create --verbose --file'
alias tar-gz-extract='tar --gzip --extract --verbose --file'
alias tar-gz-list='tar --gzip --list --verbose --file'
alias tar-xz-create='tar --xz --create --verbose --file'
alias tar-xz-extract='tar --xz --extract --verbose --file'
alias tar-xz-list='tar --xz --list --verbose --file'
alias top-cpu='top --sort-override %CPU'
alias top-memory='top --sort-override %MEM'
alias upgrade-logs='cat /var/log/pacman.log | grep --color=always --extended-regexp "\[ALPM\]\s+(upgraded|installed|removed|warning|downgraded)"'
alias upgrade-logs-short='cat /var/log/pacman.log | grep --color=always --extended-regexp "\[ALPM\]\s+(upgraded|installed|removed|warning|downgraded)" | tail --lines 200'
alias upgrade='sudo pacman --sync --refresh --refresh --sysupgrade --noconfirm && yay --sync --aur --sysupgrade --answerclean All --noconfirm && yay --sync --clean --noconfirm'
alias v='alsamixer'
alias watching='watch --interval 0.1 '
alias web='firefox-developer-edition >/dev/null 2>&1 &'
alias workspace='cd ~/workspace'
alias x='exit'
alias xterm-tmux='xterm -fullscreen tmux >/dev/null 2>&1 &'

# Functions that act as aliases.
delete-all-permanent() { sudo find / -iname "*${*}*" -exec rm --force --recursive {} \; 2> /dev/null; }
delete-here-permanent() { sudo find ./ -iname "*${*}*" -exec rm --force --recursive {} \; 2> /dev/null; }
find-all() { sudo find / -iname "*${*}*" 2> /dev/null; }
find-all-directory() { sudo find / -type d -iname "*${*}*" 2> /dev/null; }
find-all-file() { sudo find / -type f -iname "*${*}*" 2> /dev/null; }
find-here() { sudo find ./ -iname "*${*}*" 2> /dev/null; }
find-here-directory() { sudo find ./ -type d -iname "*${*}*" 2> /dev/null; }
find-here-file() { sudo find ./ -type f -iname "*${*}*" 2> /dev/null; }
packages-installed-by-size() { pacman --query --info | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort --human-numeric-sort; }
pid-by-name() { pgrep --full "${*}"; }
pid-search-files() { sudo lsof -p "$(pgrep --full --delimiter ',' "${*}")"; }
pid-search-files-filtered() { sudo lsof -p "$(pgrep --full --delimiter ',' "${1}")" | grep --color=always --ignore-case "${2}"; }
pip-install() { pip install "${*}"; }
pip-uninstall() { pip uninstall --yes "${*}"; }

connect_to_the_internet() {
  local configuration_name
  configuration_name=$1
  echo "configuration_name: ${configuration_name}"

  local max_retries
  max_retries=20
  echo "max_retries: ${max_retries}"

  local target_domain
  target_domain='www.google.com'
  echo "target_domain: ${target_domain}"

  local ping_command
  ping_command="ping -c 1 -q ${target_domain} >> /dev/null 2>&1"

  local counter
  counter=0
  echo "counter: ${counter}"

  local first_time
  first_time=true
  echo "first_time: ${first_time}"

  sudo netctl stop-all

  while true; do
    counter+=1
    echo "counter: ${counter}"

    if eval "${ping_command}"; then
      echo "Try to PING: $(date '+%a, %T%t')"

      if [[ ${counter} == "${max_retries}" || ${first_time} == "true" ]]; then
        counter=0
        first_time=false
        echo "counter: ${counter}"
        echo "first_time: ${first_time}"
        sudo netctl restart "${configuration_name}"
      fi
    else
      echo "SUCCESS: The ping works well."
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
#if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

export PS4='# -------------------------------------------------------------------------------
# Line #${LINENO}
# BASH_COMMAND: ${BASH_COMMAND}
# -------------------------------------------------------------------------------
'

PROMPT_COMMAND=color_my_prompt

#if [ "$(whoami)" != "root" ]; then
trap 'error_handler ${?}' ERR
trap 'pre_invoke_exec' DEBUG
#fi
