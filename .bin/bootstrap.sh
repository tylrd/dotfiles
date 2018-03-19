#!/usr/bin/env bash

vim +'PlugInstall --sync' +qall &> /dev/null

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew ..."
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

if [[ -f "$HOME/.Brewfile" ]]; then
    echo "\nInstalling system dependencies from $HOME/.Brewfile"
    brew bundle --global
fi
