# zmodload zsh/zprof and the zprof at the end of the zshrc file
# are used to debug and profile zsh load times.
# zmodload zsh/zprof
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

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


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"
## case-insensitive (all),partial-word and then substring completion
#
# TODO: The following if checks for CASE_SENSITIVE may not be needed.
# as of 12.Oct.2021, It doesn't exist in the zshrc template
# https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template
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
# TODO: Check if that's still the case
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
	direnv # install direnv program manually
	docker
	docker-compose
	dotenv
	emoji
	encode64
	extract
	fabric
	gcloud
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
	)


# TODO: It looks like there is no need for ZSH_DISABLE_COMPFIX=true any more
# let's keep it for a while, and in case it's not needed, let's remove it
# See https://github.com/robbyrussell/oh-my-zsh/issues/6835#issuecomment-390216875
# ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# Source specialized helper functions
[ -f ~/.serdars_helper_functions ] && source ~/.serdars_helper_functions

# Keep this here for debugging purposes
# echo $PATH

export DOCKER_ID_USER="serdard"

# Following line depends on kube-ps1 plugin
PROMPT='$(kube_ps1) '$PROMPT

# Added by fzf installation through vim-plug
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
