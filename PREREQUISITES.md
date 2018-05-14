## My toolset:

This page is a first step to automate the tools I'm using. Based on MacOS, I may
update it when I have a pretty new Linux Box as a development computer
:sunglasses:

Those apps are expected to be installed on OS:

### [brew](https://brew.sh/)
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### git, vim, tmux, ack, curl, htop, grip, ctags
```sh
brew install git vim tmux ack curl htop grip ctags
```

### Docker, docker-compose

https://www.docker.com/docker-mac

### minikube, kubectl

https://kubernetes.io/docs/tasks/tools/install-minikube/

```sh
brew install kubectl
```

### python and packages

[grip](https://github.com/joeyespo/grip) uses python@2 and when both python2 and python3 are installed with brew,
/usr/local/bin/python symlinks to python2, which I don't want. So manually I
need to change the python path, which is really ugly:
```sh
ln -sf /usr/local/bin/python3 /usr/local/bin/python
ln -sf /usr/local/bin/pip3 /usr/local/bin/pip
```
For homebrew Python details: https://docs.brew.sh/Homebrew-and-Python

```sh
brew install pipenv
```
### go

### [git-extras](https://github.com/tj/git-extras/blob/master/Installation.md)

```sh
brew install git-extras
```

### [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
```sh
cd ~/.oh-my-zsh/custom/plugins/;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```
