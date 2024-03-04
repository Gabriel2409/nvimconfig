# TODO

- jupynium fix
- autopair fix

# Install neovim on WSL

## WSL install

Complete guide: https://lecrabeinfo.net/installer-wsl-windows-subsystem-for-linux-sur-windows-10.html

Summary:

- in powershellm as admin:
  - `dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`
  - `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`
- restart
- download update package of linux kernel here from https://docs.microsoft.com/fr-fr/windows/wsl/install-manual
- in powershell as admin: `wsl --set-default-version 2`

- install ubuntu via windows store
- launch ubuntu from start folder to install it. This will open wsl and you can define default user and password

- download windows terminal from windows store
- Install a nerd font from https://www.nerdfonts.com/font-downloads (choose one, unzip and double click one one to install it)
- in windows terminal click on arrow next to tab, go to settings, and modify appearance of ubuntu to use this font

- Note: in case of Temporary failure in name resolution, you can modify /etc/resolv.conf

```
# example custom resolv.conf
search local.mydomain.com
nameserver 8.8.8.8
```

To make change permanent add the following to /etc/wsl.conf

```
[network]
generateResolvConf=false
```

Then run `sudo chattr +i /etc/resolv.conf` to prevent windows from deleting the file

Then exit wsl and run `wsl --shutdown` in powershell BEFORE reconnecting

- In case of SSL certs problems (for ex when dealing with zscaler):
  https://github.com/microsoft/WSL/issues/3161

```
Go to Manage User Certificates >  Trusted Root Certification Authorities > Certificates > Open the root CA you are interesed in
> Details > Copy To File > Base64 X.509

Copy that .cer file to /usr/local/share/ca-certificates in WSL2
Run
sudo openssl x509 -inform PEM -in xxx.cer -out xxx.crt
sudo update-ca-certificates

Verify:
ls /etc/ssl/certs | grep xxx
```

## qol bash

- create `.inputrc` in the $HOME directory and put

```
# Respect default shortcuts.
$include /etc/inputrc

## arrow up
"\e[A":history-search-backward
## arrow down
"\e[B":history-search-forward

# zsh like completion:
set show-all-if-ambiguous on
set completion-ignore-case on
"\t": menu-complete
"\e[Z": menu-complete-backward
set colored-completion-prefix on
```

## Install packages

- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install gcc g++ make zip unzip make build-essential libssl-dev zlib1g-dev software-properties-common libffi-dev python-dev libsqlite3-dev`

## Install ssh key for github

see https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54

- generate ssh key: `ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/github_ed25519 -C "youremail.com"`
- create `.ssh/config` file and paste

```
Host github.com
    User git
    Hostname github.com
    PreferredAuthentications publickey
    IdentityFile /home/user/.ssh/github_ed25519
```

- in github, add ssh key and paste the content of the public key.
- test connection with `ssh -T git@github.com`

## Install other dependencies

Note: go to your home directory first : `cd`

Note: after the installs, you may need to source .bashrc: `source .bashrc`.
Alternatively, you can close and reopen terminal

### npm and node

Complete guide to install nvm: https://github.com/nvm-sh/nvm

- summary:
  - run `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash` (this should update your .bashrc file)
  - run `nvm install 18`
  - check node version: `node -v`
  - check npm version: `npm -v`

### Install go

- go to https://go.dev/doc/install to see current version
- run `curl -OL https://golang.org/dl/go1.18.4.linux-amd64.tar.gz` (replace with your version)
- run `rm -rf ~/go && tar -C ~/ -xzf go1.18.4.linux-amd64.tar.gz` to install new version
- Add this to your .bashrc:

```bash
export GOBIN="$HOME/go/bin"
export PATH=$PATH:$GOBIN
```

### Install lazygit

`go install github.com/jesseduffield/lazygit@latest`

### Install pyenv

Complete guide to pyenv: https://github.com/pyenv/pyenv#getting-pyenv

- Summary:
  - `git clone https://github.com/pyenv/pyenv.git ~/.pyenv`
  - optional: `cd ~/.pyenv && src/configure && make -C src`
  - add this to .bashrc:
  ```bash
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  ```
  - run `pyenv install 3.9.12`
  - run `pyenv global 3.9.12`

Note: if you are running behind zscaler, you must create a .pip/pip.conf file:

```
[global]
cert=/etc/ssl/certs/zscaler-root-ca.pem
```

### Install pipx

https://github.com/pypa/pipx

- very clean way to have global python packages available in the shell

```bash
sudo apt update
sudo apt install pipx
pipx ensurepath
```

- I added in `.bashrc`: `export PIPX_DEFAULT_PYTHON=python` to make sure that it uses
  the python version exposed by pyenv

A utility I like to have installed globally is cookiecutter: see https://github.com/cookiecutter/cookiecutter

Either install it with pipx: `pipx install cookiecutter` and use it with `cookiecutter ...` or use `pipx run cookiecutter ...` to run it even if it is not installed

### install ripgrep

`sudo apt install ripgrep`

### optional: installs for plots (matplotlib, R and nvim-R plugin...)

- wsl now supports GUI: see `https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps`
- NO need to install VcXsrv and modify DISPLAY anymore in `.bashrc`

### Install cargo

- Install rustup: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
  NOTE: if rust is already installed: `sudo apt autoremove rustc`
- run `rustup install stable` and `rustup default stable`

This should also install cargo

then in ~./bashrc: `export PATH="$HOME/.cargo/bin:$PATH"`

## System clipboard for wsl

- add copy to system clipboard: you need to install win32yank and xclip: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl

  - `sudo apt install xclip`

  - `curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip`
  - `unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe`
  - `chmod +x /tmp/win32yank.exe`
  - `sudo mv /tmp/win32yank.exe /usr/local/bin/`

## System clipboard for ubuntu

- You only need xclip: `sudo apt install xclip`

## Install neovim:

### Hard way

- Complete guide: https://github.com/neovim/neovim/wiki/Installing-Neovim
- `sudo add-apt-repository ppa:neovim-ppa/unstable`
- `sudo apt update`
- `sudo apt install neovim`
- check /etc/apt/sources.list.d and /etc/apt/trusted.gpg.d/ : neovim files should be here

### Better way

- Use Bob: https://github.com/MordechaiHadad/bob: `cargo install bob-nvim`
- then run `bob install stable` and `bob use stable` (or `nightly`)

then in ~/.bashrc:

```bash
export BOB_PATH="$HOME/.local/share/bob/nvim-bin"
export PATH="$BOB_PATH:$PATH"
```

### Finally clone the repo

- clone this repo in .config/nvim: `git clone git@github.com:Gabriel2409/nvimconfig.git ~/.config/nvim`

I maintain several configs in different subfolders: see `https://michaeluloth.com/neovim-switch-configs/`

- Default config is an empty init.lua
- LazyVim config is in nvim-lazyvim folder (`https://www.lazyvim.org/`)
- Completely personal config is in nvim-kickstart folder (`https://github.com/nvim-lua/kickstart.nvim`)

- add these in your .bashrc:

```bash
alias vi="NVIM_APPNAME=nvim/nvim-lazyvim nvim"
alias vk="NVIM_APPNAME=nvim/nvim-kickstart nvim"
```

`vi` will launch lazyvim config, `vk` will launch kickstart config and `nvim` will launch native nvim

- Note: launch Mason in the command: `:Mason` to install language servers, formatters, etc

## Extra install

### Alacritty

- Install alacritty: `https://github.com/alacritty/alacritty` then in `.bashrc`: `source "$HOME/extra/completions/alacritty.bash"`

### Jupyter notebooks

- For the jupyter notebook plugin to work, you need to install the gecko driver for
  firefox (so that selenium can interact with it), see `https://github.com/mozilla/geckodriver/releases`
  and move it to /usr/local/bin/:

```bash
curl -LO https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz
tar -xvzf geckodriver-v0.33.0-linux64.tar.gz
sudo mv geckodriver /usr/local/bin/
```

You may still have errors: see workaround here: `https://github.com/mozilla/geckodriver/releases/tag/v0.31.0`
create a /tmp dir: `mkdir $HOME/tmp`
then in .bashrc:
`export TMPDIR=$HOME/tmp geckodriver`

- Note: i did not install the package globally, you need to run `pip install ~/.local/share/nvim/lazy/jupynium.nvim/`
  in each virtual env before using it (shortcut space jI)

- If there are errors, test that selenium correctly works:

```python
from selenium import webdriver
webdriver.Firefox()
```

### Good rust plugins for better terminal experience

- see https://www.youtube.com/watch?v=dFkGNe4oaKk

- `cargo install bat`: drop-in replacement for `cat`: `https://github.com/sharkdp/bat`
- `cargo install du-dust`: better `du`: `https://github.com/bootandy/dust`
- `cargo install starship`: better prompt: `https://starship.rs/`
- `cargo install eza`: better ls: `https://github.com/eza-community/eza`
- `cargo install irust`: rust REPL: `https://github.com/sigmaSd/IRust`

## NOTE FOR R projects with renv with nvim-r plugin

libraries installed by Mason and nvimcom must be available.

https://stackoverflow.com/questions/15170399/change-r-default-library-path-using-libpaths-in-rprofile-site-fails-to-work
For ex, adding the line `.libPaths(c(.libPaths(), "~/R/x86_64-pc-linux-gnu-library/4.2"))` to .Rprofile can work

## Helper cmd lines:

- kill connection: `sudo lsof -t -i tcp:<port> | xargs kill -9`
