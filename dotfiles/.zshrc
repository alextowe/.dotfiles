#
# ~/.zshrc
# 

autoload -Uz compinit vcs_info
compinit

zstyle ':completion:*' menu select

# Sets the prompt. vcs_info will display green if branch is up to date. It will change to yellow if changes are detected. 
precmd() {
	vcs_info
	setopt prompt_subst
	zstyle ':vcs_info:git:*' formats '%s:%r(%b) ' '%S ' '%r ' 
	
	PS1=$'\n'
	PS1+='%F{white}[${(r:COLUMNS-2::-:)}]%f'
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

