# Configure the login screen
# Hide users, no guest account, manual login
echo '[Seat:*]' > '10-xubuntu.conf'
echo 'allow-guest=false' >> '10-xubuntu.conf'
echo 'greeter-show-manual-login=true' >> '10-xubuntu.conf'
echo 'greeter-hide-users=true' >> '10-xubuntu.conf'
sudo mv '10-xubuntu.conf' '/etc/lightdm/lightdm.conf.d/10-xubuntu.conf'

# Configure git to use gnome-keyring
sudo apt install libgnome-keyring-dev
sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
# Configure git to use vim
git config --global core.editor vim
# Configure git to use Meld as a diff tool
git config --global diff.tool meld
