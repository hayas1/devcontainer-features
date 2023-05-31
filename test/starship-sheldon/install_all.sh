#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version
check "not install exa" exa --version
check "not install ripgrep" rg --version
check "not copy starship.toml" test -e "${HOME}/.config/starship.toml"
check "not copy sheldon/plugins.toml" test -e "${HOME}/.config/sheldon/plugins.toml"

# Report result
reportResults
