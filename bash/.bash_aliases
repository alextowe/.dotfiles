# Editor control shortcuts
alias e="$EDITOR"
alias se="sudoedit"
alias clearedit="rm $HOME/.local/state/nvim/swap/*"
alias sz="source $HOME/.zshrc && echo 'zsh restarted!'"
alias i3c="nvim $HOME/.config/i3/config" #

# Basic shortcuts
alias ls='ls --color=auto'
alias la="ls -alF"
alias r="ranger"
alias home="cd $HOME"

# Git shortcuts
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


# Postgresql shortcuts
pdb () {
	sudo -u postgres psql -d $@ -U $USER ;
}

# Python/pip/django shortcuts
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

## Django
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
