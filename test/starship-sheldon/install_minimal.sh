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
check "not install exa" not type exa >/dev/null
check "not install ripgrep" not type rg >/dev/null
check "not copy starship.toml" not test -e "${HOME}/.config/starship.toml"
check "not copy sheldon/plugins.toml" not test -e "${HOME}/.config/sheldon/plugins.toml"
check "write .zshrc" not diff "${HOME}/.zshrc" "${tmp}/zshrc" | cut -c 1 | grep '>'

# Report result
reportResults
