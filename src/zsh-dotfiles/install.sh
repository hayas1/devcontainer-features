#!/bin/sh -e
PLUGIN_MANAGER=${PLUGIN_MANAGER:-"without"}
THEME=${THEME:-"without"}
WITH_PLUGINS=${WITH_PLUGINS:-"false"}
WITH_TOOLS=${WITH_TOOLS:-"false"}
WITH_ALIASES=${WITH_ALIASES:-"false"}

# for test
tmp=/tmp/devcontainer-feature-zsh-dotfiles/test
mkdir -p "$tmp" && cp -r . "$tmp"

if [ "$PLUGIN_MANAGER" = "sheldon" ]; then
    # overwrite .zshrc
    cat ./home/zshrc >"${_REMOTE_USER_HOME}/.zshrc"
fi

if [ "$WITH_PLUGINS" = "true" ]; then
    case "$PLUGIN_MANAGER" in
    'without')
        echo 'for install plugins, some kind of plugin manager must be available'
        exit 1
        ;;
    'oh-my-zsh')
        # dependencies
        apt-get update -y && apt-get install -y git &&
            apt-get clean && rm -rf /var/lib/apt/lists
        ./plugins-omz.sh
        ;;
    'sheldon')
        mkdir -p "${_REMOTE_USER_HOME}/.config/sheldon/"
        cp ./home/config/sheldon/plugins.toml "${_REMOTE_USER_HOME}/.config/sheldon/plugins.toml"
        ;;
    *)
        echo "unrecognized plugin manager: ${PLUGIN_MANAGER}"
        exit 1
        ;;
    esac
fi

case "$THEME" in
'without') ;;
'powerlevel10k')
    cp ./home/p10k.zsh "${_REMOTE_USER_HOME}/.p10k.zsh"
    ;;
'starship')
    mkdir -p "${_REMOTE_USER_HOME}/.config/"
    cp ./home/config/starship.toml "${_REMOTE_USER_HOME}/.config/starship.toml"
    ;;
*)
    echo "unrecognized theme: ${THEME}"
    exit 1
    ;;
esac

if [ "$WITH_TOOLS" = "true" ]; then
    apt-get update -y && apt-get upgrade -y &&
        apt-get install -y zsh wget git procps htop connect-proxy sudo \
            exa ripgrep fd-find bat hexyl &&
        apt-get clean && rm -rf /var/lib/apt/lists
fi

if [ "$WITH_ALIASES" = "true" ]; then
    echo >>"$_REMOTE_USER_HOME/.zshrc"
    cp ./home/aliases "${_REMOTE_USER_HOME}/.aliases"
    cat ./aliases.zshrc >>"$_REMOTE_USER_HOME/.zshrc"
fi
