## Personal dotfiles

These are my personal dotfiles that I'm using on Linux. Thanks to Fatih Arslan
for creating these configurations. I forked from his github repo, you can
checkout his repo https://github.com/farslan/dotfiles for details.

All vim plugins are added as a git submodule.

zshrc is changed for using oh-my-zsh configuration.

Install:

    git clone --recursive https://github.com/serdardalgic/dotfiles.git
    cd dotfiles
    make

Uninstall:

    cd dotfiles
    make clean

# Warning for Ubuntu 12.04 users:

There is no solarized theme in ubuntu 12.04, thus when you first open vim, it
will give errors. Just comment out the "colorscheme solarized" lines.

In case your submodules are not loaded, go to the root directory of this repo
and run this command:

    git submodule update --init
