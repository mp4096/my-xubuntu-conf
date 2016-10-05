# Create directories
mkdir ~/.fonts/   # prepare fonts installation
mkdir ~/repos/    # folder for repos
mkdir ~/.scripts/ # folder for scripts
export PATH=$PATH:~/.scripts/

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
atom-beautify
atom-cli-diff
atom-clock
autocomplete-emojis
autocomplete-go
autocomplete-haskell
editor-stats
environment
go-config
go-get
haskell-ghc-mod
highlight-selected
ide-haskell
ide-haskell-cabal
ide-haskell-repl
ink
julia-client
jumpy
keyboard-localization
language-fortran
language-haskell
language-julia
language-latex
language-markdown
language-matlab-octave
language-powershell
language-rust
latex-completions
latexer
linter
linter-alex
linter-golinter
markdown-folder
markdown-table-formatter
minimap
minimap-cursorline
minimap-git-diff
minimap-highlight-selected
minimap-selection
platformio-ide-terminal
process-palette
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
git config --global alias.ca "commit -m"

# ==============================================================================

# Configure .bashrc
cat >> ~/.bashrc <<EOF

# Change the colour of the virtualenv tag in Powerline
VIRTUALENV_THEME_PROMPT_COLOR=56

# Modify Bash It's aliases
unalias ll
alias ll='ls -oXh --group-directories-first --time-style=long-iso'
unalias l
alias l='ls -X --group-directories-first'
unalias h
alias h='cd ~'

# Alias for the repos folder
alias r='cd ~/repos'

# Safety first! Use \rm to access original rm
alias rm=trash

# Confirmation on overwrite
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

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
