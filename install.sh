#!/bin/bash

# Make zsh the default shell
if [ $SHELL != "/usr/bin/zsh" ]
then
  echo "Changing default shell to zsh"
  chsh -s $(which zsh)
  echo ""
fi

# Hardlinking .zshrc file
if [ ! "$HOME/.zshrc" ]
then
  echo "Hardlinking .zshrc"
  ln .zshrc ~/.zshrc
else
  echo "~/.zshrc already exists, delete to reset"
fi

# Install Oh My Posh (zsh theme) - https://ohmyposh.dev/docs/linux
if [ ! "/usr/local/bin/oh-my-posh" ]
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

# Install Oh My Zsh - https://github.com/ohmyzsh/ohmyzsh
if [ ! "/home/patrick/.oh-my-zsh" ]
then
  echo "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed, delete ~/.oh-my-zsh to reinstall"
  echo ""
fi

# Run zsh
exec /bin/zsh

