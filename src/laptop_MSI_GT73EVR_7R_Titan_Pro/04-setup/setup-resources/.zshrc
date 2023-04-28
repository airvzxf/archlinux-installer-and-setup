# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Enable Powerlevel10k instant prompt. Should stay at the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Manual configuration
PATH=/root/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

# Manual aliases
alias l='lsd --group-dirs=first'
alias ll='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='bat'
alias sudo='sudo '
alias watching='watch -n 1 '
alias src='source ~/.zshrc'
alias diff='colordiff'
alias grepi='gp(){ sudo grep --color=always -nirs $1 $2./; unset -f gp; }; gp'
alias egrepi='egp(){ sudo egrep --color=always -nirs $1 $2./; unset -f egp; }; egp'
alias fgrepi='fgp(){ sudo fgrep --color=always -nirs $1 $2./; unset -f fgp; }; fgp'
alias pgrepi='pgp(){ sudo pgrep -il $1; unset -f pgp; }; pgp'
alias h='history'
alias hgrep='history | grep'
alias j='jobs -l'
alias dufast='du -had 1 | sort -rh'
alias dudirfast='du -hd 1 | sort -rh'
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias cpu='top -o %CPU'
alias mem='top -o %MEM'
alias cputemp='sensors | grep Core'
alias meminfo='free -mlt'
alias psmem='ps auxf | sort -nr -k 4 | head -5'
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
alias cpuinfo='lscpu'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias memoryclean='sudo sh -c "echo 3 >/proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf \"\n%s\n\" \"Ram-cache and Swap Cleared\""'
alias pingfast='while true; do echo -n $(date "+%a, %T%t")"> " && ping www.google.com; sleep 1; done'
alias ..='cd ../'
alias ....='cd ../../'
alias ......='cd ../../../'
alias ........='cd ../../../../'
alias ..........='cd ../../../../../'
alias chx='sudo chmod 755'
alias chxdirectories='sudo find ./ -type d -exec chmod 755 {} \;'
alias chr='sudo chmod 644'
alias chrfiles='sudo find ./ -type f -exec chmod 644 {} \;'
alias rmf='rm -rf'
alias tgzc='tar -zcvf'
alias tbzc='tar -jcvf'
alias txzc='tar -Jcvf'
alias tgzx='tar -zxvf'
alias tbzx='tar -jxvf'
alias txzx='tar -Jxvf'
alias tgzlist='tar -ztvf'
alias tbzlist='tar -jtvf'
alias txzlist='tar -Jtvf'
alias ct='column -t'
alias dffast='df -hPT | column -t'
alias mountinfo='mount | column -t'
alias mountfat32='fh(){ sudo mount -t vfat $1 $2 -o rw,uid=$(id -u),gid=$(id -g); unset -f fh; }; fh'
alias d='date'
alias now='date +"%T"'
alias nowdate='date +"%m-%d-%Y"'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "state|energy\:|time|percentage"'
alias batterydetails='upower -i /org/freedesktop/UPower/devices/battery_BAT1'
alias batterywatching='watch -n 1 upower -i /org/freedesktop/UPower/devices/battery_BAT1 "| grep -E \"state|energy\:|time|percentage\""'
alias findhere='fh(){ sudo find ./ -iname *"$@"* 2>/dev/null; unset -f fh; }; fh'
alias findherefile='fhf(){ sudo find ./ -type f -iname *"$@"* 2>/dev/null; unset -f fhf; }; fhf'
alias findheredir='fhd(){ sudo find ./ -type d -iname *"$@"* 2>/dev/null; unset -f fhd; }; fhd'
alias findall='fa(){ sudo find / -iname *"$@"* 2>/dev/null; unset -f fa; }; fa'
alias findallfile='faf(){ sudo find / -type f -iname *"$@"* 2>/dev/null; unset -f faf; }; faf'
alias findalldir='fad(){ sudo find / -type d -iname *"$@"* 2>/dev/null; unset -f fad; }; fad'
alias delete='dl(){ sudo find ./ -iname *"$@"* -exec rm -fR {} \; 2>/dev/null; unset -f dl; }; dl'
alias deleteall='dla(){ sudo find / -iname *"$@"* -exec rm -fR {} \; 2>/dev/null; unset -f dla; }; dla'
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
alias upgrade-reflector='sudo ~/.reflector_service.sh'
alias pacman-unlock='sudo rm /var/lib/pacman/db.lck'
pacmanbysize(){ pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -hr | head -25; }
alias pacman-by-size='pacmanbysize'
alias rs='upgrade && sudo reboot'
alias off='upgrade && sudo poweroff'
alias piplist='pip list --format columns'
alias pipoutdate='pip list --outdated --format freeze'
alias pipupgrade="pip list --outdated --format freeze | sed 's/=.*//g' | xargs -n1 sudo pip install -U"
alias pipsearch='pps(){ pip search $1 | sort; unset -f pps; }; pps'
alias pipinstall='ppi(){ sudo pip install $1; unset -f ppi; }; ppi'
alias attach-process='echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope'
alias m='spotify >/dev/null 2>&1 &'
alias myip='curl icanhazip.com'
alias boinc='cd ~/workspace/boinc/ && /usr/bin/boinc'
alias boincmgr='cd ~/workspace/boinc/ && boincmgr &'
alias screenshot='xfce4-screenshooter'
alias nv='nvidia-settings >/dev/null 2>&1 &'
alias ph='phoronix-test-suite'
alias v='alsamixer'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias workspace='cd ~/workspace'
alias p='cd ~/workspace/projects'
alias pc='cd ~/workspace/projects && ~/workspace/projects/check-git-projects.sh'
alias calculator='galculator &'
alias localnetstat='netstat -tulpn'
alias ij='~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox'
alias phone-screencast='scrcpy --bit-rate 8M --disable-screensaver --window-borderless --max-fps 260 --display 0 --push-target /sdcard/wolf/ --render-driver opengl --stay-awake --show-touches --verbosity debug'
alias phone-screencast-record='scrcpy --bit-rate 8M --disable-screensaver --window-borderless --max-fps 260 --display 0 --push-target /sdcard/wolf/ --render-driver opengl --stay-awake --show-touches --verbosity debug --no-display --record phone_record_$(date +"%Y%m%d").mp4'
alias network-monitor-ethernet='sudo bmon -b -p enp4s0'
alias network-monitor-wifi='sudo bmon -b -p wlp2s0'
alias dddfix="sed '/not set/d' -i $HOME/.ddd/init"
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
alias homewifi='connect_to_the_internet wlp2s0-Castillo_Grayskull_PA_5G'
alias homeethernet='connect_to_the_internet ethernet-dhcp'
alias usbethernet='connect_to_the_internet enp0s20u1u4-Home'
alias villas='connect_to_the_internet wlp2s0-INFINITUMh75z'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh-sudo/sudo.plugin.zsh

# Functions
function mkt(){
	mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf improvement
function fzf-lovely(){
	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
	                  cat {}) 2> /dev/null | head -500'

	else
	        fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
	                          cat {}) 2> /dev/null | head -500'
	fi
}

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "\E[1;5C" forward-word
bindkey "\E[1;5D" backward-word

# Autocomplete for AWS CLI
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws
