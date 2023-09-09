# My personal dotfiles

These are my personal dotfiles for Manjaro Linux with i3wm. It uses a bare git repo with working directory set to the $HOME folder. 

## Using the installer
The command below will clone a gist containing a bash script that will automate the installation process. If you want to take a closer look at that script, you can find it [here](https://gist.github.com/137148cda7ff2dee8464609ab3132124.git).

        git clone https://gist.github.com/137148cda7ff2dee8464609ab3132124.git $HOME/dotfiles-installer && cd $HOME/dotfiles-installer && sh dotfiles-installer


## Manual installation
Run the commands below to install this configuration manually on your machine. 

1. The first step is to clone this repository into a folder in your home directory called `.dotfiles.git`. Use the `--bare` flag to clone as a bare repo.  

        git clone --bare git@github.com:alextowe/dotfiles.git $HOME/.dotfiles.git


2. Next, define the custom alias that lets you run the next two commands. The command below sets the alias `dot` to a git command that directs the git directory (`--git-dir`) to the place where you cloned into (`$HOME/.dotfiles.git`). It also sets the working tree to the home folder (`--work-tree=$HOME`).    
        
        alias dot=/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME


3. Now you need to tell git to hide untracked files. This way when running `dot status`, every untracked file in the home directory won't be displayed.

        dot config --local status.showUntrackedFiles no


4. Finally, run this command to pull the compressed files into the working tree. If there are any conflicting files, back them up and delete the originals, and run the command again.

        dot checkout

