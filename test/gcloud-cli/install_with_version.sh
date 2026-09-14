#!/bin/bash
set -e

# Optional: Import test library
source dev-container-features-test-lib
tmp=/tmp/devcontainer-feature-gcloud-cli/test
not() {
    ! "$@"
}

# Definition specific tests
check "check for gcloud 584.0.0" gcloud --version | grep 'Google Cloud SDK 584.0.0'
check "check for kubectl 1:584.0.0-0" dpkg-query --show --showformat='${Version}\n' kubectl | grep '^1:584.0.0-0$'
check "check for helm v3" helm version --client | grep 'Version:"v3.'
check "check for gcloud completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/gcloud.zshrc" | cut -c 1 | not grep '>'
check "check for kubectl completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/kubectl.zshrc" | cut -c 1 | not grep '>'
check "check for helm completion" diff "${HOME}/.zshrc" "${tmp}/zshrc/helm.zshrc" | cut -c 1 | not grep '>'

# Report result
reportResults
