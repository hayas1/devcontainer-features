#!/bin/sh -e
WITH_STARSHIP_CONFIG=${WITH_STARSHIP_CONFIG:-"true"}
WITH_SHELDON_CONFIG=${WITH_SHELDON_CONFIG:-"true"}
WITH_SOME_TOOLS=${WITH_SOME_TOOLS:-"true"}
OVERWRITE_ZSHRC=${OVERWRITE_ZSHRC:-"true"}

# for test
tmp=/tmp/devcontainer-feature-zsh-dotfiles/test
mkdir -p "$tmp" && cp -r . "$tmp"

# tools
if [ "$WITH_SOME_TOOLS" = "true" ]; then
    apt-get update -y && apt-get upgrade -y &&
        apt-get install -y zsh wget git procps htop connect-proxy sudo \
            exa ripgrep fd-find bat hexyl &&
        apt-get clean && rm -rf /var/lib/apt/lists
fi

# starship
if [ "$WITH_STARSHIP_CONFIG" = "true" ]; then
    mkdir -p "${_REMOTE_USER_HOME}/.config/"
    cp ./home/config/starship.toml "${_REMOTE_USER_HOME}/.config/starship.toml"
fi

# sheldon
if [ "$WITH_SHELDON_CONFIG" = "true" ]; then
    mkdir -p "${_REMOTE_USER_HOME}/.config/sheldon/"
    cp ./home/config/sheldon/plugins.toml "${_REMOTE_USER_HOME}/.config/sheldon/plugins.toml"
fi

# overwrite zshrc
if [ "$OVERWRITE_ZSHRC" = "true" ]; then
    cat ./home/zshrc >"${_REMOTE_USER_HOME}/.zshrc"
fi
