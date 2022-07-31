# Install neovim on WSL 

## WSL install

Complete guide:  https://lecrabeinfo.net/installer-wsl-windows-subsystem-for-linux-sur-windows-10.html 

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
- `sudo apt install gcc g++ make zip unzip make build-essential libssl-dev zlib1g-dev software-properties-common`

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
go install github.com/jesseduffield/lazygit@latest


### Install pyenv
Complete guide to pyenv: https://github.com/pyenv/pyenv#getting-pyenv
- Summary:
  - `git clone https://github.com/pyenv/pyenv.git ~/.pyenv`
  - optional: `cd ~/.pyenv && src/configure && make -C src`
  - add this to .bashrc: 
  ```bash
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
  ```
  - run `pyenv install 3.9.12`
  - run `pyenv global 3.9.12`

### install ripgrep
`sudo apt install ripgrep`

## Install neovim:
- Complete guide: https://github.com/neovim/neovim/wiki/Installing-Neovim
- `sudo add-apt-repository ppa:neovim-ppa/unstable`
- `sudo apt update`
- `sudo apt install neovim`
- check /etc/apt/sources.list.d and /etc/apt/trusted.gpg.d/ : neovim files should be here

- clone this repo in .config/nvim: `git clone git@github.com:Gabriel2409/nvimconfig.git ~/.config/nvim`
- start neovim with `nvim`, go to config by pressing `c`, wait for install, go to `plugins.lua` and save to trigger all installs
- launch Mason in the command: `:Mason` to install language servers, formatters, etc

- add copy to system clipboard: you need to install win32yank and xclip
  - `sudo apt install xclip`

  - `curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip`
  - `unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe`
  - `chmod +x /tmp/win32yank.exe`
  - `sudo mv /tmp/win32yank.exe /usr/local/bin/`




