#!/usr/bin/env bash

# Set git config

# user config
git config --global user.name "$1"
git config --global user.email "$2"

# aliases
git config --global --replace-all alias.co 'checkout'
git config --global --replace-all alias.cm 'commit -m'
git config --global --replace-all alias.st 'status'
git config --global --replace-all alias.br 'branch'
git config --global --replace-all alias.correct 'commit --amend --no-edit'
git config --global --replace-all alias.lg 'log --oneline --decorate --all --graph'
git config --global --replace-all alias.ri 'rebase -i'
git config --global --replace-all alias.rim 'rebase -i origin/main'
git config --global --replace-all alias.reset-main 'reset --hard origin/main'
git config --global --replace-all alias.pf 'push --force-with-lease'
git config --global --replace-all alias.pl 'pull --rebase'
git config --global --replace-all alias.pfu 'push --force'
git config --global --replace-all alias.wipe 'clean -df'
git config --global --replace-all alias.unstage 'restore --staged'
