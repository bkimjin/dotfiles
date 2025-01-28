# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade

# Install packages
apps=(
    awscli
    git
    pyenv
    pyenv-virtualenv
    terraform
)

casks=(
    iterm2
    visual-studio-code
)

brew install "${apps[@]}"
brew install --cask "${casks[@]}"
