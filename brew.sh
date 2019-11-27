#!/usr/bin/env bash

function install_or_upgrade() {
    local package=$1

    echo "Installing/upgrading ${package}"

    if brew info "${package}" | grep -q "Not installed"
    then
        brew install "${package}"
    elif ! brew outdated "${package}"
    then
        # brew outdated exits with 0 if package is up to date!
        brew upgrade "${package}"
    fi
}

function cask_install_or_upgrade() {
    local package=$1

    echo "Installing/upgrading cask ${package}"

    if brew cask info "${package}" | grep -q "Not installed"
    then
        brew cask install --force "${package}"
    elif ! brew cask outdated "${package}"
    then
        # brew cask outdated exits with 0 if package is up to date!
        brew cask upgrade "${package}"
    fi
}

# Install the most common packages with brew

# Upgrade any already-installed formulae.
brew update
brew upgrade

# Casks
brew tap homebrew/cask-versions

# Packages
# Install newer Bash
install_or_upgrade bash

# Switch to brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells
then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi


# Install other useful binaries.
install_or_upgrade ansible
install_or_upgrade bash-completion
install_or_upgrade docker
install_or_upgrade git
install_or_upgrade python
install_or_upgrade ssh-copy-id
install_or_upgrade the_silver_searcher
install_or_upgrade tree
install_or_upgrade wget

# k8s
install_or_upgrade kubernetes-cli
install_or_upgrade helm
install_or_upgrade istioctl

# Cask packages
cask_install_or_upgrade sublime-text2
cask_install_or_upgrade intellij-idea
cask_install_or_upgrade iterm2
cask_install_or_upgrade slack
cask_install_or_upgrade flycut
cask_install_or_upgrade calibre
cask_install_or_upgrade spotify

# Remove outdated versions from the cellar.
brew cleanup
