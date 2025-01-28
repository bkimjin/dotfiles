#!/usr/bin/env bash

# Get current directory
export DOTFILES_DIR EXTRA_DIR PYTHON_VERSION
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON_VERSION=$(cat .python-version)


# Install brew
sh $DOTFILES_DIR/install/brew.sh


# Setup git
source $DOTFILES_DIR/install/git.sh


# Setup Virtual Environment

pyenv install $PYTHON_VERSION
pyenv virtualenv $PYTHON_VERSION .venv@$PYTHON_VERSION
ln -s $(pyenv root)/versions/$PYTHON_VERSION/envs/.venv@$PYTHON_VERSION $DOTFILES_DIR

# Install pip packages
source .venv@$PYTHON_VERSION/bin/activate
pip install -r install-requirements.txt

# Install pre-commit
pre-commit install


# Install oh my zsh and plugins
sh $DOTFILES_DIR/install/oh-my-zsh.sh


# Install and configure powerlevel10k
sh $DOTFILES_DIR/install/powerlevel10k.sh $DOTFILES_DIR


# dbt Setup
sh $DOTFILES_DIR/install/dbt.sh $DOTFILES_DIR $github_email
