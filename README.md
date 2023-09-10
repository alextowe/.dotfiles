# My personal dotfiles

These are my dotfiles for Manjaro Linux with i3wm. It uses a bare git repo with working directory set to the users home folder. 

## Using the installer
The command below will clone a gist containing a bash script that will start the installation process. If you want to take a closer look at that script, you can find it [here](https://gist.github.com/137148cda7ff2dee8464609ab3132124.git).

    git clone https://gist.github.com/137148cda7ff2dee8464609ab3132124.git $HOME/.dotfiles-installer && sh $HOME/.dotfiles-installer/dotfiles-installer


## Manual installation
Run the commands below to install this configuration manually on your machine. 

### 1. Configure git user 
To configure the git user on local machine, run the commands below. Replace *your-name* and *your email* with the name and email address you want to use.

Confgure git name.

    git config --global user.name "<your-name>"

Configure git email.

    git config --global user.email "<your-email>"

### 2. Set up an SSH connection with GitHub 

First, create the key on your local machine. Replace *your-email* with the email address used for you GitHub account. Optionally, you can specify a path to save this key with a custom name.

    ssh-keygen -t ed25519 -C "<your-email>" 

Or, specify a path to save this key with a custom name. 
	 
    ssh-keygen -t ed25519 -C "<your-email>" -f $HOME/.ssh/<key-name> 
	

After the key has been created, start the `ssh-agent` in the background.

	eval "$(ssh-agent -s)"

Now add the new key to the agent.

	ssh-add $HOME/.ssh/<key-name>

You will need to display the public key in the terminal, copy it, and add it to your GitHub account. 

	cat $HOME/.ssh/<key-name>.pub

If you used a custom key name, you'll need to add a host for github to the ssh configuration.  Create the file `$HOME/.ssh/config`, and add the following snippet to it. Replace *key-name* with your custom key name. 

	Host github.com
  		HostName github.com
  		User git
  		IdentityFile ~/.ssh/<key_name>
  		IdentitiesOnly yes

Test the connection. 

	ssh -T git@github.com 

### 3. Clone dotfiles repository

Now, clone this repostory into a folder in your home directory called `.dotfiles.git`. Use the `--bare` flag to clone as a bare repo.  

	git clone --bare git@github.com:alextowe/dotfiles.git $HOME/.dotfiles.git


Define a custom alias that points the git directory to the location of the git folder where this repo was cloned and set the working tree to the home folder.    
	
	alias dot=/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME


Tell git to hide untracked files. This way when running `dot status`, every untracked file in the home directory won't be displayed.

	dot config --local status.showUntrackedFiles no


Update all packages. 

	sudo pacman -Syu 

Install any software needed for the configuration.
	
	sudo pacman -S openshh neovim code brave-browser nvidia discord steam 

Uninstall any unneeded packages,

	sudo pacman -Rs vim palemoon 

Upgrade to PulseAudio

	install_pulse

Now pull the compressed files into the working directory.

	dot checkout

Some or all of the files listed below may conflict with the previous command. Make backups and delete originals. Then, run the `dot checkout` command again.

	.config/i3status/config
	.config/nvim/init.vim
	.i3/config
	.bashrc
	.gitignore
	README.md

