#!/bin/sh
set -e

REPOSITORY="$(dirname $(realpath $0))"
DEVCONTAINER_PATH="${REPOSITORY}/.devcontainer"

mkdir -p "${REPOSITORY}/.devcontainer"
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/.devcontainer/devcontainer.json' \
    -o "${DEVCONTAINER_PATH}/devcontainer.json"
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/.devcontainer/entry.sh' \
    -o "${DEVCONTAINER_PATH}/entry.sh"
echo '*' >"${DEVCONTAINER_PATH}/.gitignore"
