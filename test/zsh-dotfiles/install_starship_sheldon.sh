#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

# test tools
tmp=/tmp/devcontainer-feature-zsh-dotfiles/test

# Definition specific tests
check "copy p10k.zsh" diff "${HOME}/.p10k.zsh" "${tmp}/.p10k.zsh"
check "install exa" exa --version
check "install ripgrep" rg --version
check "copy starship.toml" diff "${HOME}/.config/starship.toml" "${tmp}/home/config/starship.toml"
check "copy sheldon/plugins.toml" diff "${HOME}/.config/sheldon/plugins.toml" "${tmp}/home/config/sheldon/plugins.toml"
check "overwrite .zshrc" diff "${HOME}/.zshrc" "${tmp}/home/zshrc"

# Report result
reportResults
