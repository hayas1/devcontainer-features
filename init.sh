#!/bin/bash -e

REPOSITORY="$(dirname "$(realpath "$0")")"
DEVCONTAINER_DIR=${DEVCONTAINER_DIR:-"${REPOSITORY}/.devcontainer"}

# prepare .devconotainer directory in workspace directory
if [[ ! -e "${DEVCONTAINER_DIR}" ]]; then
    mkdir -p "${DEVCONTAINER_DIR}"
    curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/.devcontainer/devcontainer.json' \
        -o "${DEVCONTAINER_DIR}/devcontainer.json"
    curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/.devcontainer/entry.sh' \
        -o "${DEVCONTAINER_DIR}/entry.sh"
    echo '*' >"${DEVCONTAINER_DIR}/.gitignore"
fi

# prepare mount source in home directory (# TODO parse json-with-comment)
sources="$(
    grep -E '^\s*"source=(.*)"' <"${DEVCONTAINER_DIR}/devcontainer.json" |
        sed -r 's/^\s*"source=(.*),target=(.*)"\s*,?.*$/\1/' |
        sed -r 's/localEnv://g'
)"
for s in $sources; do
    source="$(eval echo "$s")"
    if [[ "$source" =~ ^(.*)/$ ]]; then
        mkdir -p "$source"
    else
        mkdir -p "$(dirname "$source")" && touch "$source"
    fi
done
