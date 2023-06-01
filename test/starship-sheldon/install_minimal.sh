#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib

command_not_exist() {
    if type "$1" >/dev/null; then
        return 1
    else
        return 0
    fi
}
file_not_exist() {
    if test -e "$1"; then
        return 1
    else
        return 0
    fi
}

# Definition specific tests
check "check for starship" starship --version
check "check for sheldon" sheldon --version
check "not install exa" command_not_exist exa
check "not install ripgrep" command_not_exist rg
check "not copy starship.toml" file_not_exist "${HOME}/.config/starship.toml"
check "not copy sheldon/plugins.toml" file_not_exist "${HOME}/.config/sheldon/plugins.toml"
check "write .zshrc" not diff "${HOME}/.zshrc" "${tmp}/zshrc" | cut -c 1 | grep '>'

# Report result
reportResults
