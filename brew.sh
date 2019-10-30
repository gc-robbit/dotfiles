#!/usr/bin/env bash

# Install the most common packages with brew

# Upgrade any already-installed formulae.
brew update
brew upgrade

# Casks
brew tap homebrew/cask-versions

# Packages
# Install newer Bash
brew install bash

# Switch to brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells
then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi

# Install other useful binaries.
brew install ansible
brew install bash-completion
brew install docker
brew install git
brew install python
brew install ssh-copy-id
brew install the_silver_searcher
brew install tree
brew install wget

# k8s
brew install kubernetes-cli
brew install kubernetes-helm

# Cask packages
brew cask install sublime-text2
brew cask install intellij-idea
brew cask install iterm2
brew cask install slack
brew cask install flycut
# Seems broken on Catalina
# brew cask install spotify

# Remove outdated versions from the cellar.
brew cleanup
