# TODO: For configuring uninstall, reference the below.
# rm -rf $HOME/.oh-my-zsh
# rm -rf ~/.zshrc
# rm -rf ~/.p10k.zsh

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash || echo "Oh My Zsh installation skipped."

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
