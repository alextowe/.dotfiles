# variables
export DEV_DIR="$HOME/dev/"

# editor control shortcuts
export TERMINAL="/usr/bin/alacritty"
export EDITOR=nvim # editor
export SUDO_EDITOR=nvim # sudo editor
alias e="$EDITOR"
alias se="sudoedit"
alias clearedit="rm $HOME/.local/state/nvim/swap/*" # clear buffers left open after close


# configuration shortcuts
alias eb="$EDITOR $HOME/.zshrc" # edit .bashrc
alias sz="source $HOME/.zshrc && echo 'zsh restarted!'" # restart .bashrc
alias i3c="nvim $HOME/.i3/config" # open i3 config file


# package manager commands 
alias pacup="sudo pacman -Syu"
alias yayup="yay -Syu"
pacsearch () { sudo pacman -Ss $@ ; }
pacin () { sudo pacman -S $@; }
yayin () { yay -S $@ ; }
pacout () { sudo pacman -Rs $@ ; }
yayout () { yay -R $@ ; }


# basic shortcuts
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias la="ls -alF" # list all
alias r="ranger"
alias home="cd $HOME"
nd () { 
	mkdir $@ ; 
	cd $@ ;
}

# git shortcuts
alias gs="git status"
alias gl="git log"
alias gb="git branch -a"
alias ga="git add ."
alias gd="git diff"
alias gp="git push"
alias gu="git restore --staged ."
gc () { git commit -m "$@" ; }
gac () {
	ga ;
	gc "$@";
}

# dev shorcuts
dev () { 
	if [[ $@ != "" ]];
	then
		cd "$DEV_DIR/$@" ;
	else
		cd "$DEV_DIR"
	fi
}
delp () {	
	rm -rf "$DEV_DIR/$@" ;
	echo "Project $@ has been deleted." ;
}

# psql shortcuts
pdb () {
	sudo -u postgres psql -d $@ -U $USER ;
}

# python/pip/django shortcuts
alias venv="cd $DEV_DIR/venv"
alias sv="source bin/activate" 
alias dv="deactivate"
alias dvh="dv && home"
alias di="python -m pip install django" 
alias pf="pip freeze"
alias pfr="pip freeze > requirements.txt"
alias pir="pip install -r requirements.txt" 
cvc () { python -m venv "$@" ; }
cv () { python -m venv "$DEV_DIR/venv/$@" ; }
sve () { source "/$DEV_DIR/venv/$@/bin/activate" ; }
new-python () { 
	cv "$@" ;
	sve "$@" ;	
	dev ;
	nd $@;
	git init ;
}
workon () { 
	sve $@ ;
	dev $@ ; 
	gs ;
}
delv () {
	rm -rf "$DEV_DIR/venv/$@" ;
	echo "Python venv $@ has been deleted."
} 
delb () {
	delp "$@" ;
	delv "$@" ;
}

## django
alias rs="python manage.py runserver"
alias mm="python manage.py makemigrations"
alias m="python manage.py migrate"
sd () { django-admin startproject "$@" ; }
mmm () { mm ; m  ; }
new-django () { 
	cv "$@" ;
	sve "$@" ;
	di ;
	dev ;
	sd "$@" ;	
	cd "$@" ;
	git init ;
}
