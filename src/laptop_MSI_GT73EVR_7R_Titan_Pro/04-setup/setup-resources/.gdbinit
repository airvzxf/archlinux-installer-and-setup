#source /usr/share/gef/gef.py
#source /usr/share/peda/peda.py
source /usr/share/pwndbg/gdbinit.py
#source /usr/share/gdb-dashboard/.gdbinit

set detach-on-fork off
set disassembly-flavor att

set exception-verbose on
set exception-debugger on

show follow-fork-mode
show detach-on-fork
show disassembly-flavor
