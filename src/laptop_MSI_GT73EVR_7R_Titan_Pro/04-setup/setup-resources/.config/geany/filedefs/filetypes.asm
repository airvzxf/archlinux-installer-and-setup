# For complete documentation of this file, please see Geany's main documentation
[styling]
# Edit these in the colorscheme .conf file instead
default=default
comment=comment_line
commentblock=comment
commentdirective=comment
number=number_1
string=string_1
operator=operator
identifier=identifier_1
cpuinstruction=keyword_1
mathinstruction=keyword_2
register=type
directive=preprocessor
directiveoperand=keyword_3
character=character
stringeol=string_eol
extinstruction=keyword_4

[keywords]
# all items must be in one line
# this is Intel x86 instruction set
instructions=aaa aad aam aas adc add addst and bt call clc cld cli cmp dec dek div divst fld fst fadd faddp fsub fsubp fmul fmulp fdiv fdivp fsqrt fcos fsin hlt imul inc ink int iret ja jae jb jbe jc jcxz je jecxz jg jge jgz jl jle jlz jmp jna jnae jnb jnbe jnc jne jng jnge jnl jnle jno jnp jns jnz jo jp jpe jpo js jsr jz lad ldi lds ldx lea lia loop loope loopne loopnz loopz lsa mov movs movsb movsd movsw movsx mul mulst neg nop not or pop popa popac popad popfd push pusha pushac pushad pushf pushfd rep ret ret rol ror sbb shl shr spi stc std stos stosb stosd stosw sub subst swap test xchg xlat xor
registers=eax ax al ah ebx bx bl bh ecx cx cl ch edx dx dl dh di edi si esi bp ebp esp sp
directives=org list nolist page equivalent text .data .text .bss _start main equ times section segment global extern %macro %endmacro db dw dd dq dt resb resw resd resq rest byte word dword qword tword %1 %2 %3 %4 %5 %6 %7 %8 %9 %10

[settings]
# default extension used when saving files
extension=asm

# the following characters are these which a "word" can contains, see documentation
#wordchars=_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789

# single comments, like # in this file
comment_single=;
# multiline comments
#comment_open=
#comment_close=

# set to false if a comment character/string should start at column 0 of a line, true uses any
# indentation of the line, e.g. setting to true causes the following on pressing CTRL+d
#	#command_example();
# setting to false would generate this
##	command_example();
# This setting works only for single line comments
comment_use_indent=true

# context action command (please see Geany's main documentation for details)
context_action_cmd=

[indentation]
width=4
# 0 is spaces, 1 is tabs, 2 is tab & spaces
type=0

[build_settings]
# %f will be replaced by the complete filename
# %e will be replaced by the filename without extension
# (use only one of it at one time)
compiler=nasm "%f"
