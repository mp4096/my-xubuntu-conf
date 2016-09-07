# my-xubuntu-conf
* Most of the work is done by two shell scripts, `install.sh` and `configure.sh`.
  * Download them by pasting this command into the shell:
```sh
wget https://raw.githubusercontent.com/mp4096/my-xubuntu-conf/master/install.sh \
&& \
wget https://raw.githubusercontent.com/mp4096/my-xubuntu-conf/master/configure.sh
```
  * Run them by typing
```sh
source install.sh && source configure.sh
```
* Install fancy typefaces:
  * Download [Fantasque Sans](https://github.com/belluzj/fantasque-sans/releases/latest)
    and [Source Code Pro](https://github.com/adobe-fonts/source-code-pro/releases/latest).
  * Move them to `~/.fonts/`.
  * Install them by typing `sudo fc-cache -f`.
* Python3: Install Anaconda from [here](https://www.continuum.io/downloads#linux).
* Setup git:
```
git config --global user.name "ABC"
git config --global user.email "XYZ"
```
