#!/usr/bin/env bash

# Get current directory
export DOTFILES_DIR EXTRA_DIR PYTHON_VERSION
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON_VERSION=$(cat .python-version)


# Setup brew
sh $DOTFILES_DIR/setup/brew.sh


# Setup git
source $DOTFILES_DIR/setup/git.sh


# Setup Virtual Environment

pyenv install $PYTHON_VERSION
pyenv virtualenv $PYTHON_VERSION .venv@$PYTHON_VERSION
ln -s $(pyenv root)/versions/$PYTHON_VERSION/envs/.venv@$PYTHON_VERSION $DOTFILES_DIR

# Install pip packages
source .venv@$PYTHON_VERSION/bin/activate
pip install -r install-requirements.txt

# Install pre-commit
pre-commit install


# Setup oh my zsh and plugins
sh $DOTFILES_DIR/setup/oh-my-zsh.sh


# Setup and configure powerlevel10k
sh $DOTFILES_DIR/setup/powerlevel10k.sh $DOTFILES_DIR


# dbt Setup
sh $DOTFILES_DIR/setup/dbt.sh $DOTFILES_DIR $github_email
