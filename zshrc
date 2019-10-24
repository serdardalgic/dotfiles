# zmodload zsh/zprof and the zprof at the end of the zshrc file
# are used to debug and profile zsh load times.
# zmodload zsh/zprof
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
plugins=(alias-finder
        autojump
	bgnotify
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
	jira
        kube-ps1
	kubectl
	man
	pep8
	pip
	pylint
	python
	redis-cli
	rsync
	sudo
	systemadmin
	terraform
	themes
	tmux
	transfer
	urltools
	vagrant
	vault
	web-search
	zsh-syntax-highlighting # cd ~/.oh-my-zsh/custom/plugins/; git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	zsh_reload)


# See https://github.com/robbyrussell/oh-my-zsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/serdar/.rvm/bin:/home/serdar/Development/LIBS/sbt/bin

update_git_repo() {
    local repo=$1
    echo
    echo "UPDATING $repo"
    echo
    pushd $repo > /dev/null
    git fetch --prune
    local stash_output=`git stash`
    git co master
    git pull origin master
    if [[ `git branch --list develop ` ]]; then
        git co develop
        git pull origin develop
        git co @{-2}
    else
        git co @{-1}
    fi
    if [ "${stash_output}" != "No local changes to save" ]; then
	git stash pop
    fi
    popd > /dev/null
}

update_all_git_repos() {
    # If no args are given, update the storm reply repositories
    local dir=${1:-~/Development/STORM_REPLY}
    cd ${dir}
    if [[ -a ".update" ]]; then
        for repo in `cat .update`; do
            update_git_repo $repo
        done
    else
	echo "No .update file is found, creating one..."
	for dir in `find . -maxdepth 2 -name .git`;
	do
	    echo `dirname $dir` >> .update;
        done
	echo "Please check the autocreated .update file and run $funcstack[1] command again."
    fi
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

add_ssh_keys_in_the_folder() {
    DIR=$1
    if [ "$(ls -A $DIR)" ]; then
	# Do not add public keys, ending with .pub
	for privat_key in `find $DIR -type f ! -name "*.*"`; do
            ssh-add $privat_key
        done
	# Add *.pem files too.
	for pem_file in ${DIR}/*.pem; do
	    ssh-add $pem_file
        done
    fi
}

add_serdars_ssh_keys() {
    add_ssh_keys_in_the_folder ~/.ssh/privat
}

add_serdars_ssh_keys

# Used for creating an ~/.ssh/config file.
#
# Either you call it without any arguments and it adds all the .sshconfig files
# under ~/.ssh/sshconfigd/{public/private} directories
# or
# You would specify which configurations you want to add to your ~/.ssh/config
# file
create_ssh_config() {
    if ! ln ~/.ssh/config ~/.ssh/config.lock 2>/dev/null; then
	    return 1
    fi
    mv ~/.ssh/config ~/.ssh/old_config
    if (( $# > 0 )); then
        for arg;
	do cat $arg >> ~/.ssh/config; echo >> ~/.ssh/config
	done;
    else
        # (n) is a zsh function for numerical sort
	echo "################################################################" >> ~/.ssh/config
	echo "# Private ssh configs from ~/.ssh/sshconfigd/private directory #" >> ~/.ssh/config
	echo "################################################################" >> ~/.ssh/config
        for priv in ~/.ssh/sshconfigd/private/*.sshconfig(n);
	do
            cat $priv >> ~/.ssh/config
	    echo >> ~/.ssh/config
        done
	echo "##############################################################" >> ~/.ssh/config
	echo "# Public ssh configs from ~/.ssh/sshconfigd/public directory #" >> ~/.ssh/config
	echo "##############################################################" >> ~/.ssh/config
        for pub in ~/.ssh/sshconfigd/public/*.sshconfig(n);
        do
            cat $pub >> ~/.ssh/config
            echo >> ~/.ssh/config
        done
    fi
    echo "~/.ssh/config is regenerated."
    rm -f ~/.ssh/config.lock
}

#create_ssh_config public/01-bitbucket.sshconfig public/99-default.sshconfig
# The following is the same with running create_ssh_config without any arguments
# create_ssh_config ~/.ssh/sshconfigd/private/*(n) ~/.ssh/sshconfigd/public/*(n)
create_ssh_config

gitlocalconfigreply() {
    git config --local user.name "Serdar Dalgic"
    git config --local user.email "s.dalgic@reply.de"
}

nsalistens() {
    # shows which ports are being listened on local machine
    sudo lsof -nP +c 15 |grep LISTEN
}

no_newline_at_the_end() {
    printf %s "$(cat $1)" > $1
}

extract_all_gz() {
    if (($# == 0 ))
    then searchdir="."
    else searchdir=$1; fi
    # Extract comes from zsh extract plugin
    find $searchdir -name "*.gz" | while read filename; do extract $filename; done
}

compress_all_to_gz() {
    if (($# == 0 ))
    then searchdir="."
    else searchdir=$1; fi
    find $searchdir -type file -name "*" | while read filename; do gzip $filename; done
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

# Following line depends on kube-ps1 plugin
PROMPT='$(kube_ps1) '$PROMPT

# Added by fzf installation through vim-plug
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# LANG and LC_ALL should be exported manually for pipenv to work.
# See the following tickets for details:
# https://github.com/pypa/pipenv/issues/187
# https://bugs.python.org/issue18378
# https://github.com/pypa/pipenv/issues/538
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$PATH:${HOME}/.pyenv/bin
# Lazy load pyenv
if command -v pyenv 1> /dev/null 2>&1; then
  local PYENV_SHIMS="${PYENV_ROOT:-${HOME}/.pyenv}/shims"
  export PATH="${PYENV_SHIMS}:${PATH}"
  function pyenv() {
    unset pyenv
    eval "$(command pyenv init -)"
    eval "$(command pyenv virtualenv-init -)"
    # oh-my-zsh aws plugin doesn't work well with pyenv, that's why I source it in that way
    if pyenv which aws_zsh_completer.sh 1>/dev/null 2>&1; then
      source "$(pyenv which aws_zsh_completer.sh)"
    fi
    pyenv $@
  }
fi

# Lazy load Kompose
if command -v kompose 1>/dev/null 2>&1; then
  function kompose() {
    unset kompose
    eval "$(command kompose completion zsh)"
    kompose $@
  }
fi

# ack aliases
alias terrack="ack --ignore-dir=.terraform --terraform --json"

# gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then source ~/google-cloud-sdk/path.zsh.inc; fi
# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then source ~/google-cloud-sdk/completion.zsh.inc; fi

# zprof

#AWSume alias to source the AWSume script. It's installed on venv2.7
alias awsume=". \$(pyenv which awsume)"
# TODO:
# I'm not so sure about the following addition to the fpath. Investigate!
fpath=(/usr/local/share/zsh/site-functions $fpath)

# mysql-client is keg-only, not symlinked into /usr/local , to avoid conflicts with mysql package
# That's why I import the PATH to have mysql-client first in my PATH
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
