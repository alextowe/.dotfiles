# My personal dotfiles

This are my personal dotfiles for Manjaro Linux with i3wm. Uses a bare git repo with working directory set to the $HOME folder. Run the commands below to setup on a new system. Make sure you have git installed.

1. The first step is to clone this repository as into a folder in your home director called `dotfiles.git`. Use the `--bare` flag to clone a bare repo.  

        git clone --bare <remote-repo-url> $HOME/.dotfiles.git


2. Next, define the custom alias that lets you run the next two commands. The command below sets the alias `dot` to a git command that directs the git directory (`--git-dir`) to the place where you cloned into (`$HOME/.dotfiles.git`). It also sets the working tree to the home folder (`--work-tree=$HOME`).    
        
        alias dot=/user/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME


3. Now you need to tell git to hide untracked files. This way when running `dot status`, every untracked file in the home directory won't be displayed.

        `dot config --local status.showUntrackedFiles no`


4. Finally, run this command to pull the compressed files into the working tree. If there are any conflicting files, back them up and delete the originals, and run the command again.

        `dot checkout`

