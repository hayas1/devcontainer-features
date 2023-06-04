#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

tmp=/tmp/devcontainer-feature-zsh-dotfiles/test
not() {
    ! "$@"
}

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version
check "install exa" exa --version
check "install ripgrep" rg --version
check "copy starship.toml" diff "${HOME}/.config/starship.toml" "${tmp}/home/config/starship.toml"
check "copy sheldon/plugins.toml" diff "${HOME}/.config/sheldon/plugins.toml" "${tmp}/home/config/sheldon/plugins.toml"
check "overwrite .zshrc" diff "${HOME}/.zshrc" "${tmp}/zshrc"

# Report result
reportResults
