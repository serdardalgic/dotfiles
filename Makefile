all:
	[ -d ~/.vim/ ] || ln -s $(PWD)/vim/ ~/.vim
	[ -d ~/.autoenv/ ] || ln -s $(PWD)/.autoenv/ ~/.autoenv
	[ -f ~/.vimrc ] || ln -s $(PWD)/vim/vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.gitignore ] || ln -s $(PWD)/gitignore ~/.gitignore
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.ackrc ] || ln -s $(PWD)/ackrc ~/.ackrc
	[ -f ~/.ssh/config ] || ln -s $(PWD)/sshconfig ~/.ssh/config

clean:
	rm -f ~/.vimrc ~/.zshrc ~/.vim ~/.zsh ~/.gitconfig ~/.gitignore ~/.tmux.conf ~/.ackrc ~/.ssh/config

.PHONY: all
