# Install Linux basics
sudo apt install vim
sudo apt install vim-gnome
sudo apt install git
sudo apt install git-cola
sudo apt install meld
sudo apt install keepassx
sudo apt install chromium-browser
sudo apt install htop
sudo apt remove firefox
sudo apt install texlive-full

# Install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
source "~/.bash_it/install.sh"

# Install Atom
wget -O "atom_installer.deb" "https://atom.io/download/deb"
sudo dpkg --install "atom_installer.deb"
rm "atom_installer.deb"

# Prepare fonts installation
mkdir "~/.fonts/"
