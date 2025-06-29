#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
latest() {
    repository="$1"
    curl -fsL -o /dev/null -w "%{url_effective}" "${repository}/releases/latest" |
        sed -r "s,^${repository}/releases/tag/v(.*)$,\1,g"
}

# Definition specific tests
check "tfenv version" tfenv --version | grep "$(latest 'https://github.com/tfutils/tfenv')"
check "terraform version" terraform --version

# Report result
reportResults
