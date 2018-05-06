#!/usr/bin/env bash

separator() {
  echo ""
  echo ""
}

echo "Install vim plugins..."
vim +'PlugInstall --sync' +qall &> /dev/null
echo "Done!"

separator

if [[ "$(uname)" == "Darwin" ]]; then
  if ! command -v brew >/dev/null; then
    echo "Installing Homebrew ..."
    curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    separator
  fi

  if [[ -f "$HOME/.Brewfile" ]]; then
    echo "Installing system dependencies from $HOME/.Brewfile"
    brew bundle --global
    echo "Done!"
  fi
fi
