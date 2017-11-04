#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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


if [ ! -f ~/.bash_git ]; then
	curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
fi

source ~/.bash_git

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

	# collect the number of commits ahead or behind origin 
	sym="$(echo \"${git_status}\" | sed -r 's/.*by[[:blank:]]([0-9]*)[[:blank:]]commit.*/\1/' | grep '[0-9]' 2> /dev/null)"
	
	# add marker for origin status with number of commits ahead (+) or behind (-)
	if [[ ${git_status} =~ "branch is ahead of" ]]; then
		sym="[+"${sym}"]"
	elif [[ ${git_status} =~ "branch is behind" ]]; then
		sym="[-"${sym}"]"
	else
		sym=""
	fi

	export PS1="$__user_and_host$__cur_location${state}$__git_branch${sym}$__last_color$__prompt_tail "
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

trap 'pre_invoke_exec' DEBUG

function make_completion_wrapper () {
	local function_name="$2"
	local arg_count=$(($#-3))
	local comp_function_name="$1"
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


alias src='source ~/.bash_profile'

alias ls='ls --color=auto'
alias l='ls --color=auto -lh'
alias l.='ls --color=auto -lhad .*'
alias ll='ls --color=auto -lha'

alias diff='colordiff'

alias grep='gp(){ grep --color=auto -nir $1 $2;  unset -f gp; }; gp'
alias egrep='egp(){ egrep --color=auto -nir $1 $2;  unset -f egp; }; egp'
alias fgrep='fgp(){ fgrep --color=auto -nir $1 $2;  unset -f fgp; }; fgp'
alias pgrep='pgp(){ pgrep -il $1;  unset -f pgp; }; pgp'

alias h='history'
alias hg='history | grep'
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

alias pingfast='while true; do echo -n $(date "+%a, %T%t")"> " && ping www.google.com; sleep 1; done'

alias ..='cd ../'
alias ....='cd ../../'
alias ......='cd ../../../'
alias ........='cd ../../../../'
alias ..........='cd ../../../../../'

alias chx='chmod 755'
alias chr='chmod 644'
alias rmf='rm -rf'

alias tgz='tar -zcvf'
alias tbz='tar -jcvf'
alias untgz='tar -zxvf'
alias untbz='tar -jxvf'
alias tgzlist='tar -ztvf'
alias tbzlist='tar -jtvf'

alias ct='column -t'
alias dffast='df -hPT | column -t'
alias mount='mount | column -t'

alias d='date'
alias now='date +"%T"'
alias nowdate='date +"%m-%d-%Y"'

alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|energy\:|time|percentage"'

alias findhere='fh(){ sudo find ./ -iname *"$@"* 2>/dev/null;  unset -f fh; }; fh'
alias findherefile='fhf(){ sudo find ./ -type f -iname *"$@"* 2>/dev/null;  unset -f fhf; }; fhf'
alias findheredir='fhd(){ sudo find ./ -type d -iname *"$@"* 2>/dev/null;  unset -f fhd; }; fhd'

alias findall='fa(){ sudo find / -iname *"$@"* 2>/dev/null;  unset -f fa; }; fa'
alias findallfile='faf(){ sudo find / -type f -iname *"$@"* 2>/dev/null;  unset -f faf; }; faf'
alias findalldir='fad(){ sudo find / -type d -iname *"$@"* 2>/dev/null;  unset -f fad; }; fad'

alias delete='dl(){ find ./ -iname *"$@"* -exec rm -fR {} \; 2>/dev/null;  unset -f dl; }; dl'
alias deleteall='dla(){ sudo find / -iname *"$@"* -exec rm -fR {} \; 2>/dev/null;  unset -f dla; }; dla'

alias x='exit'
alias cls='printf "\E[\E[2J" && printf "\E[H"'
alias clr='clear && printf "\E[3J"'

alias piplist='pip list --format=columns'
alias pipoutdate='pip list --outdated --format=legacy'
alias pipupgrade="pip list --outdated --format legacy | sed 's/(.*//g' | xargs -n1 sudo pip install -U"
alias pipsearch='pps(){ pip search $1 | sort;  unset -f pps; }; pps'
alias pipinstall='ppi(){ sudo pip install $1;  unset -f ppi; }; ppi'

alias o='chromium >/dev/null 2>&1 & firefox >/dev/null 2>&1 & geany >/dev/null 2>&1 &'
alias m='spotify >/dev/null 2>&1 &'
alias web='chromium >/dev/null 2>&1 &'
alias upgrade='sudo pacman -Syyu --noconfirm'
alias myip='curl icanhazip.com'
alias boinc='cd ~/workspace/boinc/ && /usr/bin/boinc'
alias boincmgr='cd ~/workspace/boinc/ && boincmgr &'
alias boincmgrnvidia='cd ~/workspace/boinc/ && boincmgr >/dev/null 2>&1 & nvidia-settings >/dev/null 2>&1 &'
alias screenshot='xfce4-screenshooter'
alias v='alsamixer'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias workspace='cd ~/workspace'
alias p='cd ~/workspace/projects'
alias pc='cd ~/workspace/projects && ~/workspace/projects/check-git-projects.sh'
alias pyc='pycharm.sh >/dev/null 2>&1 &'
alias pycformatter='pyf(){ pycharm-formatter -r $(pwd)/$1;  unset -f pyf; }; pyf'
alias pycinspector='rmf ~/Downloads/pyInspectorOutpu && pycharm-inspector $(pwd)/ $(pwd)/.idea/inspectionProfiles/python_inspector.xml ~/Downloads/pyInspectorOutpu -v2 && geany ~/Downloads/pyInspectorOutpu/*'

alias wifi='sudo netctl stop-all && sudo netctl start'
_completion_loader netctl
make_completion_wrapper _netctl _netctl_start netctl start
complete -F _netctl_start wifi


function try_to_connect_to_my_internet() {
	wifi_name=$1
	max_retrys=20

	ping='ping -c 1 -q www.google.com'
	counter=0
	first_time=true

	while true
	do
		let "counter++"
		ping_result=$($ping 2>&1)

		if [[ "$ping_result" == "ping: www.google.com: Name or service not known" ]]
		then
			echo -n $(date "+%a, %T%t")"> " && $ping

			if [[ $counter == $max_retrys || $first_time == true ]]
			then
				counter=0
				first_time=false

				sudo netctl stop-all
				sudo netctl start $wifi_name
			fi
		else
			break
		fi

		sleep 1
	done
}
alias uvwifi='try_to_connect_to_my_internet wlp3s0-Brutus24GHz'
alias homewifi='try_to_connect_to_my_internet wlp3s0-MySpectrumWiFi20-2G'
