#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# test tools
tmp=/tmp/devcontainer-feature-zsh-dotfiles/test
not() {
    ! "$@"
}

# Definition specific tests
check "install exa" exa --version
check "install ripgrep" rg --version
check "copy p10k.zsh" diff "${HOME}/.p10k.zsh" "${tmp}/home/p10k.zsh"
check "not copy starship.toml" not test -e "${HOME}/.config/starship.toml"
check "not copy sheldon/plugins.toml" not test -e "${HOME}/.config/sheldon/plugins.toml"
check "history settings in ~/.zshrc" grep 'export SAVEHIST=100000' <"${HOME}/.zshrc"

# Report result
reportResults
