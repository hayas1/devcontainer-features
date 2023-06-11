#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for sheldon" sheldon --version
check "check sheldon toml" grep "\[plugins.powerlevel10k\]" "${HOME}/.config/sheldon/plugins.toml"
check "check sheldon toml" grep "github = 'romkatv/powerlevel10k'" "${HOME}/.config/sheldon/plugins.toml"

# Report result
reportResults
