#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

alias src='source ~/.bash_profile'

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
alias dufast='du -hd 1 | sort -rh'
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias cpu='top -o cpu'
alias mem='top -o rsize'
alias cputemp='sensors | grep Core'
alias fastping='pingf -c 5'

alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'
alias ......='cd ../../../../../../'

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
alias dfc='df -hPT | column -t'
alias mount='mount | column -t'

alias d='date +%F'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%m-%d-%Y"'

alias meminfo='free -mlt'
alias psmem='ps auxf | sort -nr -k 4 | head -5'
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
alias cpuinfo='lscpu'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

alias web='chromium'
alias myip='curl icanhazip.com'
alias boinc='cd ~/workspace/boinc/ && /usr/bin/boinc'
alias boincmgr='cd ~/workspace/boinc/ && boincmgr'
