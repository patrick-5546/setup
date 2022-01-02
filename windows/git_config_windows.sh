#!/bin/bash

# To run in windows, use the Git bash shell

echo "Configuring git settings"

# configure git settings common to Windows and Linux
BASEDIR=$(dirname "$0")
$BASEDIR/../git_config_common.sh

# use neovim as editor
git config --global core.editor "nvim"

echo ""
