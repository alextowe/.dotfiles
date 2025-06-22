#
# ~/.zshrc
# 

autoload -Uz compinit vcs_info terminfo
compinit

zstyle ':completion:*' menu select

# Sets the prompt. vcs_info will display green if branch is up to date. It will change to yellow if changes are detected. 
precmd() {
	vcs_info
	setopt prompt_subst
	zstyle ':vcs_info:git:*' formats '%s:%r(%b) ' '%S ' '%r ' 
	
	PS1='%F{white}[${(r:COLUMNS-2::-:)}]%f'
	RPS1=''

	if [[ -n ${vcs_info_msg_0_} ]] ; then
		if [[ -n "$(git status --porcelain)" ]] ; then
			RPS1+='%F{yellow}${vcs_info_msg_0_}%f'
		else
			RPS1+='%F{green}${vcs_info_msg_0_}%f'
		fi
	fi


	PS1+='%F{cyan}%~%f '
	PS1+='>> '
	RPS1+='%F{grey}%n@%m%f %*'
}

# Aliases
alias ls='ls -F --color=auto'
alias la='ls -alF --color=auto'
alias hm='cd $HOME'
alias r='/usr/bin/ranger'
alias ss='source ~/.zshrc && echo ".zshrc reloaded!"'

#
# Keybinds
#

# Set typeset
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Set keybinds
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Set terminal to application mode. 
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Enable history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
