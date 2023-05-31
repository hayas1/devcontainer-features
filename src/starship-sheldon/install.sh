#!/bin/sh -e
WITH_STARSHIP_CONFIG=${WITH_STARSHIP_CONFIG:-"false"}
WITH_SHELDON_CONFIG=${WITH_SHELDON_CONFIG:-"false"}
WITH_SOME_TOOLS=${WITH_SOME_TOOLS:-"false"}

if [ "$WITH_SOME_TOOLS" = "true" ]; then
    apt-get update -y && apt-get upgrade -y &&
        apt-get install -y zsh curl wget git procps htop connect-proxy sudo \
            exa ripgrep fd-find bat hexyl &&
        apt-get clean && rm -rf /var/lib/apt/lists
fi

# https://starship.rs/#quick-install
curl -fsL https://starship.rs/install.sh | sh -s -- -y
if [ "$WITH_STARSHIP_CONFIG" = "true" ]; then
    cp ./starship.toml "${_REMOTE_USER_HOME}/.config/starship.toml"
fi

# https://sheldon.cli.rs/Installation.html#pre-built-binaries
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh |
    bash -s -- --repo rossmacarthur/sheldon --to /usr/local/bin
if [ "$WITH_STARSHIP_CONFIG" = "true" ]; then
    cp ./sheldon.toml "${_REMOTE_USER_HOME}/.config/sheldon/plugins.toml"
fi

# multi bytes
apt-get update -y && apt-get upgrade -y && apt-get install -y locales &&
    apt-get clean && rm -rf /var/lib/apt/lists
localedef -f UTF-8 -i en_US en_US.UTF-8

cat <<'EOF' >>"${HOME}/.zshrc"
### load sheldon
eval "$(sheldon source)"
### load starship
eval "$(starship init zsh)"

EOF
