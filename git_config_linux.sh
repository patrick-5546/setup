#!/bin/bash

echo "Configuring git settings"

# configure git settings common to Windows and Linux
BASEDIR=$(dirname "$0")
$BASEDIR/git_config_common.sh

# use vim as editor
git config --global core.editor "vim"

# diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"
# diff-so-fancy suggested highlighted colors
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

if grep -iq wsl /proc/version
then
    echo "WSL detected, authenticate using Git Credential Manager"
    git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"
fi

echo ""
