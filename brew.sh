#!/usr/bin/env bash

# Install the most common packages with brew

# Upgrade any already-installed formulae.
brew update
brew upgrade

# Install casks I use
brew tap homebrew/cask-versions

# Install GNU `sed`, overwriting the built-in `sed`.
# brew install gnu-sed --with-default-names

# Install new Bash
brew install bash

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells
then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi

# Install other useful binaries.
brew install wget
brew install the_silver_searcher
brew install docker
brew install git
brew install ssh-copy-id
brew install tree

# k8s
brew install kubernetes-cli
brew install kubernetes-helm

brew cask install sublime-text2
brew cask install intellij-idea
brew cask install iterm2
brew cask install slack
brew cask install flycut
# Seems broken on Catalina
# brew cask install spotify

# Remove outdated versions from the cellar.
brew cleanup
