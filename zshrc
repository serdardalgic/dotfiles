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
# CHECKOUT history-substring-search, virtualenvwrapper, fasd, systemadmin plugins
# No-need-to-use:
#
# django : Instead, install django-extensions.
#
plugins=(git git-extras gitfast colored-man colorize extract autojump command-not-found debian encode64 history lol pip vagrant themes urltools zsh-syntax-highlighting autoenv python nyan redis-cli web-search celery rand-quote jira gitignore tmux git-prompt pep8 pylint iwhois fabric)

# Needed for virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/serdar/.rvm/bin:/home/serdar/Development/LIBS/sbt/bin

# Uncomment these, 'cause we are doing source activate.sh in lib/directories.sh
# source activate.sh for autoenv
# source ~/.autoenv/activate.sh

# UA_PARSER_YAML environment variable is used by ua_parser.
export UA_PARSER_YAML=$HOME/ua_parser_regexes.yaml

# ORDERBIRD SETTINGS
# in order to reach Postgres.app binaries
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin:~/.bin:

# Should I export this? Or keep on using /usr/local/bin/python?
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export MY_OB_DEV_SETTINGS='myorderbird.conf.development'
export MY_OB_PROJECT_ROOT='/Users/serdardalgic/Development/orderbird/my.orderbird/django_project'
export MY_OB_VENV_NAME='orderbird'
