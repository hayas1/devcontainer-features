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
check "not copy starship.toml" not test -e "${HOME}/.config/starship.toml"
check "not copy sheldon/plugins.toml" not test -e "${HOME}/.config/sheldon/plugins.toml"
check "write .zshrc" diff "${HOME}/.zshrc" "${tmp}/home/zshrc" | cut -c 1 | not grep '>'

# Report result
reportResults