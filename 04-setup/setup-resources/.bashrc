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
	local __user_and_host="$bldylw\u$bldwht@$bldgrn\h"
	local __cur_location="$bldblu\W"
	local __git_branch_color="$bldred"
	local __git_branch='$(__git_ps1 "(%s)")'
	local __prompt_tail="$txtwht$(date)\n$bldpur$"
	local __last_color="$txtrst"
	export PS1="\n\n$__user_and_host\n$__cur_location $__git_branch_color$__git_branch\n$__prompt_tail$__last_color "
}
color_my_prompt


alias src='source ~/.bash_profile'

alias ls='ls --color=auto'
alias l='ls --color=auto -lh'
alias l.='ls --color=auto -lhad .*'
alias ll='ls --color=auto -lha'

alias diff='colordiff'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

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

alias pingfast='ping www.google.com'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

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

alias d='date +%F'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%m-%d-%Y"'

alias web='chromium'
alias myip='curl icanhazip.com'
alias boinc='cd ~/workspace/boinc/ && /usr/bin/boinc'
alias boincmgr='cd ~/workspace/boinc/ && boincmgr'
