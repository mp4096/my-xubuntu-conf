# Create directories
mkdir ~/.fonts/   # prepare fonts installation
mkdir ~/repos/    # folder for repos
mkdir ~/.scripts/ # folder for scripts
export PATH="$PATH:$HOME/.scripts/"

# ==============================================================================

# Add latest git PPA
sudo add-apt-repository ppa:git-core/ppa
# Add PPA with VeraCrypt
sudo add-apt-repository ppa:unit193/encryption

# Update apt repos
sudo apt update

# Install Linux basics
sudo apt install -y vim
sudo apt install -y git
sudo apt install -y htop
sudo apt install -y tmux
sudo apt install -y curl
sudo apt install -y gcc  # just in case
sudo apt install -y make # just in case
# Install nice apps
sudo apt install -y git-cola
sudo apt install -y meld
sudo apt install -y vim-gnome
sudo apt install -y keepassx
sudo apt remove -y firefox # we'll install Pale Moon instead
sudo apt install -y chromium-browser
sudo apt install -y texlive-full
sudo apt install -y texstudio
sudo apt install -y vlc
sudo apt install -y veracrypt
sudo apt install -y p7zip-full
sudo apt install -y p7zip-rar
sudo apt install -y colordiff
sudo apt install -y trash-cli
sudo apt install -y graphviz
sudo apt install -y doxygen
sudo apt install -y hunspell
# Install dependencies for ksuperkey
sudo apt install -y libx11-dev
sudo apt install -y libxtst-dev
sudo apt install -y pkg-config

# Install Bluetooth audio support (optional)
sudo apt install -y pulseaudio-module-bluetooth

# Install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
source ~/.bash_it/install.sh

# Install Atom
wget -O "atom_installer.deb" "https://atom.io/download/deb"
sudo dpkg --install "atom_installer.deb"
rm "atom_installer.deb"

# Install Atom packages
cat > ~/atom-pkgs.txt <<EOF
atom-clock
autocomplete-go
autocomplete-haskell
build
editor-stats
go-config
go-get
haskell-ghc-mod
highlight-selected
ide-haskell
ide-haskell-cabal
ide-haskell-repl
jumpy
language-batch
language-cython
language-fortran
language-haskell
language-julia
language-latex
language-markdown
language-matlab-octave
language-powershell
language-rust
language-x86-64-assembly
linter
linter-alex
linter-clang
linter-pycodestyle
linter-pydocstyle
linter-golinter
markdown-folder
markdown-table-formatter
minimap
minimap-cursorline
minimap-find-and-replace
minimap-git-diff
minimap-highlight-selected
minimap-selection
minimap-titles
pigments
scroll-sync
sort-lines
Zen
EOF
apm install --packages-file ~/atom-pkgs.txt
rm ~/atom-pkgs.txt

# Install Pale Moon
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/palemoon.list"
wget "http://download.opensuse.org/repositories/home:stevenpusser/xUbuntu_16.04/Release.key"
sudo apt-key add - < Release.key
sudo apt update
sudo apt install -y palemoon
rm Release.key
sudo update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser /usr/bin/palemoon 100

# Install ksuperkey
git clone https://github.com/hanschen/ksuperkey.git ~/repos/ksuperkey
cd ~/repos/ksuperkey
make
mkdir -p ~/.config/autostart/
# Add it to autostart
cat > ~/.config/autostart/ksuperkey.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=ksuperkey
Comment=Map Windows button to Alt+F1
Exec=$PWD/ksuperkey
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
EOF
cd ~

# ==============================================================================

# Configure the login screen
# Hide users, no guest account, manual login
cat > 10-xubuntu.conf <<EOF
[Seat:*]
allow-guest=false
greeter-show-manual-login=true
greeter-hide-users=true
EOF
sudo mv '10-xubuntu.conf' '/etc/lightdm/lightdm.conf.d/10-xubuntu.conf'

# ==============================================================================

# Configure git to use gnome-keyring
sudo apt install -y libgnome-keyring-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
# Configure git to use vim
git config --global core.editor vim
# Configure git to use Meld as a diff and merge tool
git config --global diff.tool meld
git config --global merge.tool meld
# Configure git to do simple push
git config --global push.default simple
# Add a nice log output
git config --global alias.nicelog "log --graph --full-history --all --color --date=short --pretty=format:'%x1b[0m%h%x09%x1b[33m%d%x1b[32m%x20[%ad] %x1b[0m%s %x1b[36m(%an)'"
# Add git aliases for the typing-lazy people
git config --global alias.cam "commit -a -m"
git config --global alias.ca "commit -a"
git config --global alias.cm "commit -m"
git config --global alias.newbranch = "checkout -b"
git config --global alias.publish = "!git push -u origin $(git rev-parse --abbrev-ref HEAD)"

# ==============================================================================

# Create a Python startup script

cat >> ~/.pythonstartup.py <<EOF
import pprint
import sys

import numpy as np
import scipy as sp

sys.ps1 = "\033[32m>>> \033[0m"
sys.ps2 = "\033[32m... \033[0m"
sys.displayhook = pprint.pprint
EOF

# ==============================================================================

# Install Rust
curl https://sh.rustup.rs -sSf | sh
# WARNING: Might not be able to resolve `rustup`, check later
rustup install nightly
rustup default nightly

# Install exa, ripgrep, fd and rff
cargo install exa
cargo install ripgrep
cargo install fd-find
cargo install rff

# ==============================================================================

# Configure .bashrc
cat >> ~/.bashrc <<EOF

# Add Golang env variables
export GOPATH="$HOME/repos/go"
export GOROOT="/usr/local/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# Add cargo to the path
export PATH="$PATH:$HOME/.cargo/bin"

# Specify Python startup file
export PYTHONSTARTUP="$HOME/.pythonstartup.py"

# Change the colour of the virtualenv tag in Powerline
VIRTUALENV_THEME_PROMPT_COLOR=56

# Modify Bash It's aliases
unalias ll
alias ll='ls -oXh --group-directories-first --time-style=long-iso'
unalias l
alias l='ls -X --group-directories-first'
unalias h
alias h='cd ~'

# Add exa aliases
alias lk='exa -lhG --sort type'

# Alias for the repos folder
alias r='cd ~/repos'

# Safety first! Use \rm to access original rm
alias rm=trash

# Confirmation on overwrite
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Fuzzy search in history
alias zz='cat $HISTFILE | sort -u | rff'

# Parenting changing perms on root
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Nice diffs
alias diff='colordiff'

# Nice mount output
alias mount='mount | column -t'

# Some convenience stuff
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

# Disable accessibility features to avoid random warnings
export NO_AT_BRIDGE=1

# Start tmux on shell startup
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && tmux -2
EOF

# Configure .inputrc
cat >> ~/.inputrc <<EOF
# Ctrl + Arrow key to jump to word boundaries
"\e[1;5C": forward-word
"\e[1;5D": backward-word
"\e[5C": forward-word
"\e[5D": backward-word
"\e\e[C": forward-word
"\e\e[D": backward-word

# Incremental history search
"\e[A":history-search-backward  # Arrow up
"\e[B":history-search-forward  # Arrow down

set show-all-if-ambiguous on
EOF

# Configure tmux
cat >> ~/.tmux.conf <<EOF
set-option -g xterm-keys on
set-option -g default-terminal "screen-256color"
set -g mouse on
set -g history-limit 30000
bind -T root WheelUpPane   if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
bind -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"

set -g base-index 1
set-window-option -g pane-base-index 1
EOF

# Configure vimrc
cat >> ~/.vimrc <<EOF
set number
highlight LineNr term=NONE cterm=NONE ctermfg=DarkBlue

set rtp+=~/anaconda3/lib/python3.5/site-packages/powerline/bindings/vim/
set laststatus=2

set mouse=a

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes work
    " properly when Vim is used inside tmux and GNU screen.
    " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

if &term =~ '^screen'
    " Page up/down keys
    " http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
    execute "set t_kP=\e[5;*~"
    execute "set t_kN=\e[6;*~"

    " Home/end keys
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>

    " Arrow keys
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
EOF
