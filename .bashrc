#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# path for binaries
export PATH="${PATH}:${HOME}/bin"

# editor control shortcuts
export EDITOR=nvim # editor
export SUDO_EDITOR=nvim # sudo editor
alias e="$EDITOR"
alias se="sudoedit"
alias clearedit="rm $HOME/.local/state/nvim/swap/*" # clear buffers left open after close



# configuration shortcuts
alias eb="$EDITOR $HOME/.bashrc" # edit .bashrc
alias sb="source $HOME/.bashrc && echo 'Bash restarted!'" # restart .bashrc
alias i3c="nvim $HOME/.config/i3/config" # open i3 config file



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
alias ga="git push"
alias ga="git add ."
alias gd="git diff"
alias gu="git restore --staged ."
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias ds="dot status"
alias dl="dot log"
alias dd="dot diff"
gc () { git commit -m "$@" ; }
gac () {
	ga ;
	gc "$@";
}
dc () { dot commit -m "$@" ; }

# code shorcuts
alias code="cd $HOME/code"
dev () { cd "$HOME/code/$@" ; }
delp () {	
	rm -rf "$HOME/code/$@" ;
	echo "Project $@ has been deleted." ;
}



# python/pip/django shortcuts
alias venv="cd $HOME/venv"
alias sv="source bin/activate" 
alias dv="deactivate"
alias dvh="dv && home"
alias di="python -m pip install django" 
alias pf="pip freeze"
alias pfr="pip freeze > requirements.txt"
alias pir="pip install -r requirements.txt" 
cvc () { python -m venv "$@" ; }
cv () { python -m venv "/home/$USER/venv/$@" ; }
sve () { source "/home/$USER/venv/$@/bin/activate" ; }
new-python () { 
	cv "$@" ;
	sve "$@" ;	
	code ;
	nd $@;
	git init ;
}
workon () { 
	sve $@ ;
	dev $@ ; 
	gs ;
}
delv () {
	rm -rf "$HOME/venv/$@" ;
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
	code ;
	sd "$@" ;	
	cd "$@" ;
	git init ;
}






