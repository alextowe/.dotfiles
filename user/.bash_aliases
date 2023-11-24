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

git_create_ssh_key() {
	read -p "Enter key name: " KEY_NAME
	GIT_EMAIL="$(git config --global user.email)"
	ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f $HOME/.ssh/$KEY_NAME
	eval "$(ssh-agent -s)"
	ssh-add $HOME/.ssh/$KEY_NAME

	echo -e "Copy the public key below and add it to your github account."
	cat $HOME/.ssh/$KEY_NAME.pub
	read -p "Hit ENTER to test connection." ENTER

	touch $HOME/.ssh/config
	echo "
      Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/$KEY_NAME
          IdentitiesOnly yes" >>$HOME/.ssh/config

	echo -e "Testing SSH key....."
	ssh -T git@github.com
}

alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias gp="git push"
alias gr="git restore ."
alias gu="git restore --staged ."
alias gac="git_add_commit"
alias gitkey="git_create_ssh_key"

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
