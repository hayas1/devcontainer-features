#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
tmp=/tmp/devcontainer-feature-pyenv/test
export PYENV_ROOT="$HOME/.pyenv" && eval "$(pyenv init -)"
not() {
    ! "$@"
}
latest() {
    repository="$1"
    curl -fsL -o /dev/null -w %{url_effective} "${repository}/releases/latest" |
        sed -r "s,^${repository}/releases/tag/v(.*)$,\1,g"
}

# Definition specific tests
check "pyenv latest version" pyenv --version | grep $(latest 'https://github.com/pyenv/pyenv')
check "python version" python --version
check "pip version" pip --version
check "check for zshrc" diff "${HOME}/.zshrc" "${tmp}/rc" | cut -c 1 | not grep '>'

# Report result
reportResults
