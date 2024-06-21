# Personal dotfiles and scripts

These dotfiles are intended to be used when first setting up [Ubuntu](https://github.com/davenicoll/dotfiles/tree/ubuntu)/[MacOS](https://github.com/davenicoll/dotfiles/tree/macos). After a fresh install, I like to clone this repo into my home folder, and symlink the dotfiles to make it easier to push any changes back to this repo.

## Installation

**Warning:** Pilfer at your own peril :) If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. 

### MacOS
``` shell
cd ~
git clone -b macos https://github.com/davenicoll/dotfiles.git "$HOME/.dotfiles"
cd ~/.dotfiles
./install.sh
```

### Ubuntu
``` shell
cd ~
git clone -b ubuntu https://github.com/davenicoll/dotfiles.git "$HOME/.dotfiles"
cd ~/.dotfiles
./install.sh
```
