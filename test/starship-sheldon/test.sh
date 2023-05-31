#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-
sudo apt-get install -y zsh

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version

# Report result
reportResults
