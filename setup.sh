#!/usr/bin/env bash

help()
{
    # Display Help
    echo "Installer and uninstaller for dot files."
    echo ""
    echo "Syntax: sh $0 [-[h|1|2|3]]"
    echo "Options:"
    echo "\t-h\tBrings up the help menu."
    echo "\t-1\tInstall brew and it's associated packages"
    echo "\t-2\tSelects dbt it's configuration."
    echo "\t-3\tUninstalls all or the selected packages."
    exit  1
}

while getopts ":hu123" option; do
    case $option in 
        h)  # display help
            help;;
        u)  # uninstall script
            uninstall_opt=1;;
        1)  # pick brew
            select_brew_opt=1
            opt_select=1;;
        2)  # option oh-my-zsh and plugins
            opt_omz=1
            opt_select=1;;
        3)  # pick dbt
            opt_dbt=1
            opt_select=1;;
        \?) # Invalid option
            echo "Invalid option. Use $0 -h to bring up the list of commands."
            exit;;
    esac
done

# Get current directory
export DOTFILES_DIR EXTRA_DIR PYTHON_VERSION
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON_VERSION=$(cat .python-version)


# Setup brew
if [[ -z "$opt_select" || (-n "$opt_select" && -n "$opt_omz") ]]; then

    sh $DOTFILES_DIR/setup/brew.sh

fi


# # Setup git
# source $DOTFILES_DIR/setup/git.sh


# # Setup Virtual Environment

# pyenv install $PYTHON_VERSION
# pyenv virtualenv $PYTHON_VERSION .venv@$PYTHON_VERSION
# ln -s $(pyenv root)/versions/$PYTHON_VERSION/envs/.venv@$PYTHON_VERSION $DOTFILES_DIR

# # Install pip packages
# source .venv@$PYTHON_VERSION/bin/activate
# pip install -r install-requirements.txt

# # Install pre-commit
# pre-commit install


# Setup oh my zsh and plugins
if [[ -z "$opt_select" || (-n "$opt_select" && -n "$opt_omz") ]]; then

    echo "Setup for oh-my-zsh and plugins."
    sh $DOTFILES_DIR/setup/oh-my-zsh.sh $uninstall_opt

    # Setup and configure powerlevel10k
    echo "Setup for powerlevel10k."
    sh $DOTFILES_DIR/setup/powerlevel10k.sh $DOTFILES_DIR $uninstall_opt

fi

# dbt Setup
if [[ -z "$opt_select" || (-n "$opt_select" && -n "$opt_dbt") ]]; then
    echo "Setup for dbt."
    sh $DOTFILES_DIR/setup/dbt.sh $DOTFILES_DIR $uninstall_opt $github_email
fi