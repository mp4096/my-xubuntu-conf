# Create directories
mkdir ~/.fonts/ # prepare fonts installation
mkdir ~/repos/  # folder for repos

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
sudo apt install -y vlc
sudo apt install -y veracrypt
# Install dependencies for ksuperkey
sudo apt install -y libx11-dev
sudo apt install -y libxtst-dev
sudo apt install -y pkg-config

# Install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
source ~/.bash_it/install.sh

# Install Atom
wget -O "atom_installer.deb" "https://atom.io/download/deb"
sudo dpkg --install "atom_installer.deb"
rm "atom_installer.deb"

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

# Disable Bluetooth on startup
sudo systemctl stop bluetooth.service
sudo systemctl disable bluetooth.service
sudo systemctl mask dbus-org.bluez.service

# ==============================================================================

# Configure git to use gnome-keyring
sudo apt install -y libgnome-keyring-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
# Configure git to use vim
git config --global core.editor vim
# Configure git to use Meld as a diff tool
git config --global diff.tool meld
# Configure git to do simple push
git config --global push.default simple
# Add a nice log output
git config --global alias.nicelog "log --graph --full-history --all --color --date=short --pretty=format:'%x1b[0m%h%x09%x1b[33m%d%x1b[32m%x20[%ad] %x1b[0m%s %x1b[36m(%an)'"
