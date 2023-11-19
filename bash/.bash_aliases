##############################
#  Editor control shortcuts  #
##############################

alias edit="$EDITOR"
alias se="sudoedit"
alias clearedit="rm $HOME/.local/state/nvim/swap/*"
alias sb="source $HOME/.bashrc && echo 'bash restarted!'"
alias i3c="$EDITOR $HOME/.config/i3/config"

#####################
#  Basic shortcuts  #
#####################

create_symlinks() {
	cd $HOME/.dotfiles && stow --adopt */ -t $HOME/
	cd $HOME/.dotfiles && git restore .
}

alias ls='ls --color=auto'
alias la="ls -alF"
alias r="ranger"
alias home="cd $HOME"
alias links="create_symlinks"

###################
#  Git shortcuts  #
###################

git_add_commit() {
	git add .
	git commit -m "$@"
}

alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias gp="git push"
alias gr="git restore ."
alias gu="git restore --staged ."
alias gac="git_add_commit"

##########################
#  Postgresql shortcuts  #
##########################

connectdb() {
	sudo -u postgres psql -d $@ -U $USER
}

alias cdb="connectdb"
alias createdb="createdb -O $USER"

######################
#  Django shortcuts  #
######################

alias rs="python manage.py runserver"
alias dsh="python manage.py shell"
alias mm="python manage.py makemigrations"
alias m="python manage.py migrate"
alias mmm="mm && m"
