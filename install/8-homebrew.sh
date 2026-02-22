#!/usr/bin/env bash

#This script is used to install Homebrew on Fedora.

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install jesseduffield/lazydocker/lazydocker
brew install anomalyco/tap/opencode 
