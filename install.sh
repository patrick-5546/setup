#!/bin/bash

# TODO: make interactive (ask whether to delete, rename, or skip)
# TODO: add descriptive comments

# Install Oh My Posh (zsh theme) - https://ohmyposh.dev/docs/linux
if [ ! -f "/usr/local/bin/oh-my-posh" ]
then
  echo "Installing Oh My Posh"
  sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
  sudo chmod +x /usr/local/bin/oh-my-posh
else
  echo "Oh My Posh already installed, delete /usr/local/bin/oh-my-posh to reinstall"
fi

echo ""

# Install thefuck - https://github.com/nvbn/thefuck
echo "Installing thefuck"
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user
echo ""

# Install ripgrep - https://github.com/BurntSushi/ripgrep
echo "Installing ripgrep"
sudo apt-get install ripgrep
echo ""

source ./install_no_sudo.sh

# Restart into zsh
exec /bin/zsh
