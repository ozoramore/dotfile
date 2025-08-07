# q: Quit
alias q=exit

# ctrlc: Copy Shortcut
alias ctrlc='wl-copy'
# ctrlv: Paste Shortcut
alias ctrlv='wl-paste'

alias lesss='less -AFiKS~R --use-color -x4'
alias cutcomp='cut --complement'
alias info=pinfo
alias man='LC_ALL=C.UTF-8 /usr/bin/man'
alias jman='LC_ALL=ja_JP.UTF-8 /usr/bin/man'

function hctac() {
	tac "$@" | cut -f1 -d' ' | tr '\n' ' ' | sed 's/$/\n/'
}

function pacfzf() {
	pacman -Ssq "$@" | fzf --preview 'pacman -Si {}' --bind 'enter:execute(pacman -Si {} | less )'
}

function aurfzf() {
	aur search --json "$@" |
		jq -r ".[].Name" |
		fzf --preview 'aur search -i {}' --bind 'enter:execute( aur search -i {} | less )'
}
