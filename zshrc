# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#
# Check https://github.com/robbyrussell/oh-my-zsh/wiki/themes for details
#
#ZSH_THEME="robbyrussell"
ZSH_THEME="re5et"
#ZSH_THEME="random"
#ZSH_THEME="aussiegeek"
#ZSH_THEME="smt"
#ZSH_THEME="bira" # good for using rvm

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"
## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# In order to get solarized vim theme work with tmux configurations
# add this tmux alias:
alias tmux="TERM=screen-256color-bce tmux"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#
#
#
plugins=(autojump
	bgnotify
	brew
	celery
	colored-man-pages
	colorize
	command-not-found
	copybuffer
	cp
	debian # Some nice aliases here, check it: https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#debian
	docker
	docker-compose
	dotenv
	emoji
	encode64
	extract
	fabric
	git
	git-extras # You need to install git-extras first https://github.com/tj/git-extras
	gitignore
	golang
	history
	history-substring-search
	iterm2
	iwhois # I'm not so sure to keep this plugin :S
	jira
        #kube-ps1 #kube-ps1.zsh file should be renamed, comment in when it's fixed
	kubectl
	man
	minikube # custom plugin ???
	nyan
	pep8
	pip
	pylint
	python
	rand-quote
	redis-cli
	rsync
	sudo
	systemadmin
	terraform
	themes
	tmux
	urltools
	vagrant
	vault
	web-search
	zsh-syntax-highlighting # cd ~/.oh-my-zsh/custom/plugins/; git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	zsh_reload)


source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/serdar/.rvm/bin:/home/serdar/Development/LIBS/sbt/bin

# TODO: Check the following line, if we don't need it, remove it.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

update_git_repo() {
    local repo=$1
    echo
    echo "UPDATING $repo"
    echo
    cd $repo
    git fetch --prune
    git stash
    git co master
    git pull origin master
    if [[ `git branch --list develop ` ]]; then
        git co develop
        git pull origin develop
        git co @{-2}
    else
        git co @{-1}
    fi
    git stash pop
    cd ..
}

# TODO: Make the ob functions more generic.
# FUNCTION TO UPDATE OB REPOS
update_ob() {
    cd ~/Development/ORDERBIRD
    for repo in `cat .update`; do
        update_git_repo $repo
    done
}

# FUNCTION THAT SHOWS THE RELATION BETWEEN MASTER AND DEVELOP IN OB REPOS
relation_ob() {
    cd ~/Development/ORDERBIRD
    for repo in `cat .update`; do
        cd $repo
        if [[ `git branch --list develop ` ]]; then
            echo
            echo "RELATION FOR $repo"
            echo
            git relation master develop
        fi
        cd ..
    done
}

add_serdars_ssh_keys() {
    DIR=~/.ssh/privat
    if [ "$(ls -A $DIR)" ]; then
        for privat_key in $DIR/*; do
            ssh-add $privat_key
        done
    fi
}

add_serdars_ssh_keys

nsalistens() {
    # shows which ports are being listened on local machine
    sudo lsof -nP +c 15 |grep LISTEN
}

#
# THRIFT ALIASES AND FUNCTIONS
#
# Using https://hub.docker.com/_/thrift/ for thrift
# docker pull thrift // Call this command first
alias thrift='docker run -v "$PWD:/data" -u $(id -u) thrift thrift -r -o /data'
pythrift(){
    thrift --gen py /data/$1
}
gothrift(){
    thrift --gen go /data/$1
}

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export DOCKER_ID_USER="serdard"
# Prints a random quote every time (It takes a long time to open a new terminal, so, abort!
# quote

# Remove the source here, once the kube-ps1 plugin is fixed.
source /Users/serdar/.oh-my-zsh/plugins/kube-ps1/kube-ps1.zsh
PROMPT='$(kube_ps1) '$PROMPT
