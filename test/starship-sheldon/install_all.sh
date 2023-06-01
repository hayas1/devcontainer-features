#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

tmp=/tmp/devcontainer-feature-starship-sheldon/test
not() {
    ! "$@"
}

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version
check "install exa" exa --version
check "install ripgrep" rg --version
check "copy starship.toml" diff "${HOME}/.config/starship.toml" "${tmp}/starship.toml"
check "copy sheldon/plugins.toml" diff "${HOME}/.config/sheldon/plugins.toml" "${tmp}/sheldon.toml"
check "write .zshrc" diff "${HOME}/.zshrc" "${tmp}/zshrc" | cut -c 1 | not grep '>'

# Report result
reportResults
