#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
linux) [ "$FBTERM" ] && export TERM=fbterm && color_prompt=yes ;;
fbterm) color_prompt=yes ;;
xterm-color | *-256color) color_prompt=yes ;;
esac

# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
if test -x /usr/bin/tput && tput setaf 1 >&/dev/null; then
	color_prompt=yes
else
	color_prompt=
fi

if test -f /.dockerenv; then
	color_prompt=
fi

ps1_user='\u@\h'
randomface="\`randomface\`"

if test "$color_prompt" = yes; then
	COLORTERM=truecolor
	PS1="\[\e[01;32m\]$randomface\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ "
else
	PS1="$ps1_user:\W\$ "
fi

unset color_prompt
unset randomface
unset ps1_user

# enable color support of ls and also add handy aliases
if test -x /usr/bin/dircolors; then
	if test -r ~/.dircolors; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b)"
	fi
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
if test -f ~/.bash_aliases; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if test -f /usr/share/bash-completion/bash_completion; then
		. /usr/share/bash-completion/bash_completion
	elif test -f /etc/bash_completion; then
		. /etc/bash_completion
	fi
fi

export EDITOR=vi
export VISUAL=vi
export BROWSER=w3m

GPG_TTY="$(tty)"
export GPG_TTY

export AUR_PAGER='lf'

export PAGER=less

if test -f /etc/wsl.conf; then
	export XAUTHORITY=~/.Xauthority
	export XDG_CONFIG_HOME="$HOME/.config"
	export XDG_CACHE_HOME="$HOME/.cache"
	export XDG_DATA_HOME="$HOME/.local/share"
	export XDG_STATE_HOME="$HOME/.local/state"
	export XDG_RUNTIME_DIR="/mnt/wslg/runtime-dir"
	if test ! -f /.dockerenv; then
		sudo wslg-enable.sh
		if test -x /usr/bin/gpg-agent; then
			gpg-connect-agent /bye
		fi
	fi
fi

if test -x /usr/bin/gem; then
	PATH="$PATH:$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
	export PATH
fi
