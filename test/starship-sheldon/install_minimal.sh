#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version
check "not install exa" type exa >/dev/null || [ "$?" == "1" ]
check "not install ripgrep" type rg >/dev/null || [ "$?" == "1" ]
check "not copy starship.toml" test -e "${HOME}/.config/starship.toml" || [ "$?" == "1" ]
check "not copy sheldon/plugins.toml" test -e "${HOME}/.config/sheldon/plugins.toml" || [ "$?" == "1" ]

# Report result
reportResults
