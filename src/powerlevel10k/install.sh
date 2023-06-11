#!/bin/sh -e
VERSION=${VERSION:-"master"}
PLUGIN_MANAGER=${PLUGIN_MANAGER:-"oh-my-zsh"}

# for test
tmp=/tmp/devcontainer-feature-powerlevel10k/test
mkdir -p "$tmp" && cp -r . "$tmp"

# dependencies
apt-get update -y && apt-get install -y git &&
    apt-get clean && rm -rf /var/lib/apt/lists

case "$PLUGIN_MANAGER" in
'default')
    git clone 'https://github.com/romkatv/powerlevel10k.git' --branch "${VERSION}" --depth 1 \
        "${_REMOTE_USER_HOME}/.powerlevel10k"
    echo >>"${_REMOTE_USER_HOME}/.zshrc"
    echo '# powerlevel10k installation' >>"${_REMOTE_USER_HOME}/.zshrc"
    echo 'source "${HOME}/.powerlevel10k/powerlevel10k.zsh-theme"' >>"${_REMOTE_USER_HOME}/.zshrc"
    ;;
'oh-my-zsh')
    # https://github.com/romkatv/powerlevel10k#oh-my-zsh
    git clone 'https://github.com/romkatv/powerlevel10k.git' --branch "${VERSION}" --depth 1 \
        "${ZSH_CUSTOM:-$_REMOTE_USER_HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed 's,^\s*ZSH_THEME=(.*)$,ZSH_THEME="powerlevel10k/powerlevel10k",g' -ri "${_REMOTE_USER_HOME}/.zshrc"
    echo >>"${_REMOTE_USER_HOME}/.zshrc"
    cat "./zshrc" >>"${_REMOTE_USER_HOME}/.zshrc"
    ;;
'sheldon')
    # https://sheldon.cli.rs/Examples.html#powerlevel10k
    sheldon add powerlevel10k --github romkatv/powerlevel10k
    ;;
*)
    echo "unrecognized plugin manager: ${PLUGIN_MANAGER}"
    exit 1
    ;;
esac
