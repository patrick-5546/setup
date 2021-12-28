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

# Install fzf - https://github.com/junegunn/fzf
echo "Installing fzf: **CHOOSE Y Y N**"
$HOME/.setup/fzf/install
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

# Copying .gitconfig file
if [ ! -f "$HOME/.gitconfig" ]
then
  if grep -iq wsl /proc/version
  then
    echo "Copying .gitconfig.wsl"
    cp -u $HOME/.setup/.gitconfig.wsl ~/.gitconfig
  else
    echo "Copying .gitconfig"
    cp -u $HOME/.setup/.gitconfig ~/.gitconfig
  fi
else
  echo "~/.gitconfig already exists, delete to reset"
fi

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

echo ""

# Restart into zsh
exec /bin/zsh

