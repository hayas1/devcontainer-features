#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# test tools
tmp_dotfiles=/tmp/devcontainer-feature-zsh-dotfiles/test

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version
check "check for starship.toml" diff "${HOME}/.config/starship.toml" "${tmp_dotfiles}/home/config/starship.toml"

check "check for tfenv" tfenv --version
check "check for pyenv" pyenv --version

check "check for gcloud" gcloud --version

# Report result
reportResults
