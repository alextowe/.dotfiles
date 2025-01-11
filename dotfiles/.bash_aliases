##############################
#  Editor control shortcuts  #
##############################

alias edit="$EDITOR"
alias se="sudoedit"
alias sb="source $HOME/.bashrc && echo 'bash restarted!'"

#####################
#  Basic shortcuts  #
#####################

create_symlinks() {
	cd $HOME/.dotfiles && stow --adopt user -t $HOME/
	cd $HOME/.dotfiles && git restore .
}

alias ls='ls --color=auto'
alias la="ls -alF"
alias r="ranger"
alias home="cd $HOME"
alias links="create_symlinks"

