#!/bin/bash

# TODO: make interactive (ask whether to delete and reinstall)
# TODO: add descriptive comments

# Hardlinking .gitconfig file
if [ ! -f "$HOME/.gitconfig" ]
then
  if [ grep -i wsl /proc/version ]
  then
    echo "Hardlinking .gitconfig.wsl"
    ln .gitconfig.wsl ~/.gitconfig
  else
    echo "Hardlinking .gitconfig"
    ln .gitconfig ~/.gitconfig
  fi
else
  echo "~/.gitconfig already exists, delete to reset"
fi

# Hardlinking .vimrc file
if [ ! -f "$HOME/.vimrc" ]
then
  echo "Hardlinking .vimrc"
  ln .vimrc ~/.vimrc
else
  echo "~/.vimrc already exists, delete to reset"
fi

# Hardlinking .zshrc file
if [ ! -f "$HOME/.zshrc" ]
then
  echo "Hardlinking .zshrc"
  ln .zshrc ~/.zshrc
else
  echo "~/.zshrc already exists, delete to reset"
fi

echo ""

# Clone plugins
if [ -z "$(ls -A "fzf")" ]
then
  echo "Cloning plugins"
  git submodule update --init --depth=1
else
  echo "Plugins are already cloned"
fi
echo ""

# Install fzf - https://github.com/junegunn/fzf
echo "Installing fzf: **CHOOSE Y Y N**"
./fzf/install
echo ""

# Install Oh My Posh (zsh theme) - https://ohmyposh.dev/docs/linux
if [ ! -f "/usr/local/bin/oh-my-posh" ]
then
  echo "Installing Oh My Posh"
  sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
  sudo chmod +x /usr/local/bin/oh-my-posh
else
  echo "Oh My Posh already installed, delete /usr/local/bin/oh-my-posh to reinstall"
fi

if [ ! -d "$HOME/.poshthemes" ]
then
  echo "Installing custom theme"
  mkdir ~/.poshthemes
  ln .poshthemes/* ~/.poshthemes
else
  echo "Custom theme already installed, delete ~/.poshthemes to reinstall"
fi

echo ""

# Install thefuck - https://github.com/nvbn/thefuck
echo "Installing thefuck"
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user
echo ""

# Install Oh My Zsh - https://github.com/ohmyzsh/ohmyzsh
if [ ! "/home/patrick/.oh-my-zsh" ]
then
  echo "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ln .zshrc ~/.zshrc -f
else
  echo "Oh My Zsh already installed, delete ~/.oh-my-zsh to reinstall"
  echo ""
fi

# Install ripgrep - https://github.com/BurntSushi/ripgrep
echo "Installing ripgrep"
sudo apt-get install ripgrep
echo ""

