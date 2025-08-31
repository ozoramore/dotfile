#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If posix mode, dont do anything too.
shopt -oq posix && return

# history
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
PROMPT_COMMAND='history -a'

# automatic update LINES and COLUMNS
shopt -s checkwinsize

# colorize prompt
if test -x /usr/bin/tput &&
	tput setaf 1 >&/dev/null; then
	export COLORTERM=truecolor
	PS1="\[\e[01;32m\]\u\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ "
else
	PS1="\u@\h:\W\$ "
fi

if test -f /.dockerenv; then PS1="docker: \W\$ "; fi

# Colorize commands output.
if test -x /usr/bin/dircolors; then
	if test -r ~/.dircolors; then eval "$(dircolors -b ~/.dircolors)"; else eval "$(dircolors -b)"; fi
fi
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# shellcheck disable=SC1090
if test -f ~/.bash_aliases; then . ~/.bash_aliases; fi

# Enable Completion.
# shellcheck disable=SC1091
if test -f /usr/share/bash-completion/bash_completion; then . /usr/share/bash-completion/bash_completion; fi
# shellcheck disable=SC1091
if test -f /etc/bash_completion; then . /etc/bash_completion; fi

# set default commands
export EDITOR=vi
export VISUAL=vi
export PAGER=less
export BROWSER=w3m
export AUR_PAGER='lf'

GPG_TTY="$(tty)"
export GPG_TTY

if test -f /etc/wsl.conf; then
	export XAUTHORITY=~/.Xauthority
	export XDG_CONFIG_HOME="$HOME/.config"
	export XDG_CACHE_HOME="$HOME/.cache"
	export XDG_DATA_HOME="$HOME/.local/share"
	export XDG_STATE_HOME="$HOME/.local/state"
	export XDG_RUNTIME_DIR="/mnt/wslg/runtime-dir"
fi

if test ! -f /.dockerenv && test -x /usr/bin/gpg-agent; then
	gpg-connect-agent /bye
fi

if test -x /usr/bin/gem; then
	PATH="$PATH:$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
	export PATH
fi
