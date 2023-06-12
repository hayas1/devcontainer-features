#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# test tools
tmp_dotfiles=/tmp/devcontainer-feature-zsh-dotfiles/test

# Definition specific tests
check "check for .p10k.zsh" diff "${HOME}/.p10k.zsh" "${tmp_dotfiles}/home/p10k.zsh" --version

check "check for tfenv" tfenv --version
check "check for pyenv" pyenv --version

check "check for gcloud" gcloud --version

# Report result
reportResults
