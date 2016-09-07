# Create directories
mkdir ~/.fonts/ # prepare fonts installation
mkdir ~/repos/  # folder for repos

# Install Linux basics
sudo apt install vim
sudo apt install git
sudo apt install htop
sudo apt install gcc  # just in case
sudo apt install make # just in case
# Install nice apps
sudo apt install git-cola
sudo apt install meld
sudo apt install vim-gnome
sudo apt install keepassx
sudo apt remove firefox # we'll install Pale Moon instead
sudo apt install chromium-browser
sudo apt install texlive-full
# Install dependencies for ksuperkey
sudo apt install libx11-dev
sudo apt install libxtst-dev
sudo apt install pkg-config

# Install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
source "~/.bash_it/install.sh"

# Install Atom
wget -O "atom_installer.deb" "https://atom.io/download/deb"
sudo dpkg --install "atom_installer.deb"
rm "atom_installer.deb"

# Install ksuperkey
git clone https://github.com/hanschen/ksuperkey.git ~/repos/ksuperkey
cd ~/repos/ksuperkey
make
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
