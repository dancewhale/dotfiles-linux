# vterm setting use to send information to vterm.
vterm_printf() {
		if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
				# Tell tmux to pass the escape sequences through
				printf "\ePtmux;\e\e]%s\007\e\\" "$1"
		elif [ "${TERM%%-*}" = "screen" ]; then
				# GNU screen (screen, screen-256color, screen-256color-bce)
				printf "\eP\e]%s\007\e\\" "$1"
		else
				printf "\e]%s\e\\" "$1"
		fi
}

# support C-c C-l  clear screen log
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
		function clear() {
				vterm_printf "51;Evterm-clear-scrollback";
				tput clear;
		}
fi

# support vterm-buffer-name-string
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }"'echo -ne "\033]0;${HOSTNAME}:${PWD}\007"'

# support vterm dire prompt tracking
vterm_prompt_end(){
		vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}
PS1=$PS1'\[$(vterm_prompt_end)\]'

# support message passing
vterm_cmd() {
		local vterm_elisp
		vterm_elisp=""
		while [ $# -gt 0 ]; do
				vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
				shift
		done
		vterm_printf "51;E$vterm_elisp"
}
