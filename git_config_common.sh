#!/bin/bash

# git pull -> git pull --rebase
git config --global pull.rebase true

# automatically prune on pull/fetch
git config --global fetch.prune true
