## Personal dotfiles

These are my personal dotfiles that I'm using on Linux. Originated from the
first repository of Fatih Arslan's dotfiles: https://github.com/fatih/dotfiles
later on, I've added my stuff. (Later on, Fatih created a unique project called
Subvim: https://github.com/fatih/subvim) Thanks Fatih for his work ;)

My configuration changed a lot since I've forked the dotfiles from Fatih's, so
it is now a brand new project. 

My dotfiles include:

    * gitconfig
    * tmuxconf
    * zshrc
    * vimrc and vim configurations under vim folder
    * ackrc for Ack searching tool

All vim plugins are added as a git submodule.

zshrc is changed for using oh-my-zsh configuration. See
https://github.com/serdardalgic/oh-my-zsh for details. I'm holding my changes to
a different branch called `mymaster` in my oh-my-zsh fork. I keep my version of
oh-my-zsh installation frequently updated.

I've taken some noted to modules_explanations_vim.txt file, I'll turn them into
documentation a.s.a.p. 

P.S. If you're using vim, checkout the mac_settings branch instead of master.

Install:

    git clone --recursive https://github.com/serdardalgic/dotfiles.git
    cd dotfiles
    make

Uninstall:

    cd dotfiles
    make clean

In case your submodules are not loaded, go to the root directory of this repo
and run this command:

    git submodule update --init
