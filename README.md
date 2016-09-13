# my-xubuntu-conf
* Most of the work is done by the shell script `init.sh`.
  * Download it by pasting this command into the terminal:
  ```sh
  wget https://raw.githubusercontent.com/mp4096/my-xubuntu-conf/master/init.sh
  ```
  * Open it (`nano init.sh`) and make sure you're ok with its contents.
    Remember that piping downloaded files directly into shell is
    [considered](https://www.seancassidy.me/dont-pipe-to-your-shell.html)
    [harmful](https://jordaneldredge.com/blog/one-way-curl-pipe-sh-install-scripts-can-be-dangerous/).
  * Run it by typing (requires su permissions):
  ```sh
  source init.sh
  ```
* Install fancy typefaces:
  * Download [Fantasque Sans](https://github.com/belluzj/fantasque-sans/releases/latest)
    and [Source Code Pro](https://github.com/adobe-fonts/source-code-pro/releases/latest).
  * Untar them by calling `tar -zxvf $filename`.
  * Move all `*.otf` files to `~/.fonts/`.
  * Install them by typing `sudo fc-cache -fv`.
* Python3: Install Anaconda from [here](https://www.continuum.io/downloads#linux).
* Setup git:
```
git config --global user.name "ABC"
git config --global user.email "XYZ"
```
