#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version
check "install exa" exa --version
check "install ripgrep" rg --version
check "copy starship.toml" test -e "${HOME}/.config/starship.toml"
check "copy sheldon/plugins.toml" test -e "${HOME}/.config/sheldon/plugins.toml"

# Report result
reportResults
