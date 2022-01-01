#!/bin/bash

# TODO: make interactive (ask whether to delete, rename, or skip)
# TODO: add descriptive comments
# NOTE: does not refresh shell (do so manually with `zsh`)

# Clone plugins
if [ -z "$(ls -A "$HOME/.setup/fzf")" ]
then
  echo "Cloning plugins"
  cd .setup
  git submodule update --init --depth=1
  cd ..
else
  echo "Plugins are already cloned"
fi
echo ""

# Install Oh My Zsh - https://github.com/ohmyzsh/ohmyzsh
if [ ! -d "$HOME/.oh-my-zsh" ]
then
  echo "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ln $HOME/.setup/.zshrc ~/.zshrc -f
else
  echo "Oh My Zsh already installed, delete ~/.oh-my-zsh to reinstall"
fi

echo ""

# Configuring git settings
$HOME/.setup/git_config.sh

# Symlinking .vimrc file
if [ ! -f "$HOME/.vimrc" ]
then
  echo "Symlinking .vimrc"
  ln -s $HOME/.setup/.vimrc ~/.vimrc
else
  echo "~/.vimrc already exists, delete to reset"
fi

# Symlinking .zshrc file
if [ ! -f "$HOME/.zshrc" ]
then
  echo "Symlinking .zshrc"
  ln -s $HOME/.setup/.zshrc ~/.zshrc
else
  echo "~/.zshrc already exists, delete to reset"
fi

# Creating machine-specific Zsh setup file
if [ ! -f "$HOME/.zshrc.local" ]
then
  echo "Creating .zshrc.local"
  touch $HOME/.zshrc.local
else
  echo "~/.zshrc.local already exists, delete to reset"
fi

echo ""

# Restart into zsh
exec /bin/zsh

