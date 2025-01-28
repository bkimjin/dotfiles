DOTFILES_DIR=$1

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "Downloading fonts.."
curl -fsSL "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" -o "MesloLGS NF Regular.ttf"
curl -fsSL "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf" -o "MesloLGS NF Bold.ttf"
curl -fsSL "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf" -o "MesloLGS NF Italic.ttf"
curl -fsSL "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf" -o "MesloLGS NF Bold Italic.ttf"

echo "Install fonts.."
mv "MesloLGS NF Regular.ttf" "$HOME/Library/Fonts"
mv "MesloLGS NF Bold.ttf" "$HOME/Library/Fonts"
mv "MesloLGS NF Italic.ttf" "$HOME/Library/Fonts"
mv "MesloLGS NF Bold Italic.ttf" "$HOME/Library/Fonts"
sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' $HOME/.zshrc

echo "Updating .zshrc.."
TEXT="# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r \"\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${USER}.zsh\" ]]; then
  source \"\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${USER}.zsh\"
fi
"
echo "$TEXT" | cat - "$HOME/.zshrc" > tmp_file && mv tmp_file "$HOME/.zshrc"
TEXT="

# To customize prompt, run \`p10k configure\` or edit ~/.p10k.zsh.\n\
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"
echo "$TEXT" >> "$HOME/.zshrc"

echo "Adding oh-my-zsh plugins.."
sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)/' $HOME/.zshrc

echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> "$HOME/.zshrc"

cp $DOTFILES_DIR/install/.p10k.zsh "$HOME/.p10k.zsh"

zsh -c 'source $HOME/.zshrc'
