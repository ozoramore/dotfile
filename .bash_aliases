# q: Quit
alias q=exit

# ctrlc: Copy Shortcut
function ctrlc() {
	if test -e /bin/xsel; then
		xsel --clipboard --input
	elif test -e /bin/wl-copy; then
		wl-copy
	fi
}

# ctrlv: Paste Shortcut
function ctrlv() {
	if test -e /bin/xsel; then
		xsel --clipboard --output
	elif test -e /bin/wl-copy; then
		wl-paste
	fi
}

alias lesss='less -AFiKS~R --use-color -x4'
alias difff='diff --strip-trailing-cr -rptBbEwZ -u'
alias diffc='difff --color=always'
alias cutcomp='cut --complement'
alias info=pinfo
alias man='COLUMNS=$(( $COLUMNS-20 )) LC_ALL=C.UTF-8 /usr/bin/man'
alias jman='COLUMNS=$(( $COLUMNS-20 )) LC_ALL=ja_JP.UTF-8 /usr/bin/man'

function hctac() {
	tac "$@" | cut -f1 -d' ' | tr '\n' ' ' | sed 's/$/\n/'
}

function pacfzf() {
	pacman -Ssq "$@" | fzf --preview 'pacman -Si {}' --bind 'enter:execute(pacman -Si {} | less )'
}

function aurfzf() {
	aur search --json "$@" | jq -r .[].Name | fzf --preview 'aur search -i {}' --bind 'enter:execute( aur search -i {} | less )'
}
