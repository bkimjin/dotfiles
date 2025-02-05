UNINSTALL_OPT=$1

if [[ -z "$UNINSTALL_OPT" ]]; then
    
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash || echo "Oh My Zsh installation skipped."

  # Install plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo "Installed oh-my-zsh and plugins."

else

  echo "Removing .oh-my-zsh. Press y to confirm."
  read input
  if  [[ "$input" == "y" ]]; then

    if [[ -d "$HOME/.oh-my-zsh" ]]; then

      rm -rf $HOME/.oh-my-zsh
      echo "Removed $HOME/.oh-my-zsh."

    else

      echo "$HOME/.oh-my-zsh does not exist."

    fi

  else

    echo "Did not remove $HOME/.oh-my-zsh."

  fi

fi