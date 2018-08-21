SHELL := /bin/bash # Use bash syntax

SSHCONFIG_PRIVATE_BACKUP_DIR = ~/.ssh/sshconfigd.backup
# If mkdir is an alias, use it
# If it's not an alias, find it with command
MKDIR:=$(shell ([[ `type -t mkdir` == "alias" ]] && echo "mkdir") || ([[ `type -t mkdir` == "file" ]] && command -v mkdir))

all: autoenv vim zsh git tmux ack ssh

autoenv:
	[ -d ~/.autoenv/ ] || ln -s $(PWD)/.autoenv/ ~/.autoenv

vim:
	[ -f ~/.vimrc ] || ln -s $(PWD)/vim/vimrc ~/.vimrc

zsh:
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

git:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.gitignore ] || ln -s $(PWD)/gitignore ~/.gitignore

tmux:
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf

ack:
	[ -f ~/.ackrc ] || ln -s $(PWD)/ackrc ~/.ackrc

ssh:
	[ -d ~/.ssh/sshconfigd ] || ${MKDIR} -p ~/.ssh/sshconfigd/private
	if [ -d ${SSHCONFIG_PRIVATE_BACKUP_DIR}]; then \
	    cp -a ${SSHCONFIG_PRIVATE_BACKUP_DIR}/private/* ~/.ssh/sshconfigd/private
	    # FIXME:Do I really need to remove this backup dir?
	    rm -r $(SSHCONFIG_PRIVATE_BACKUP_DIR)
	fi
	[ -d ~/.ssh/sshconfigd/public ] || ln -s $(PWD)/sshconfigd/public ~/.ssh/sshconfigd/public

clean:
	@echo "Backing up the sshconfigd/private configs to ${SSHCONFIG_PRIVATE_BACKUP_DIR}"
	[ -d ${SSHCONFIG_PRIVATE_BACKUP_DIR} ] || ${MKDIR} -p ${SSHCONFIG_PRIVATE_BACKUP_DIR}/private
	mv ~/.ssh/sshconfigd/private/* ${SSHCONFIG_PRIVATE_BACKUP_DIR}/private
	rm -r ~/.ssh/sshconfigd
	rm -f ~/.vimrc ~/.zshrc ~/.vim ~/.zsh ~/.gitconfig ~/.gitignore ~/.tmux.conf ~/.ackrc ~/.ssh/config

.PHONY: all
