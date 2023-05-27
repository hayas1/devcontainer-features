#! /bin/bash -e

VERSION=${VERSION:-"master"}
WITH=${WITH:-"none"}

### https://github.com/pyenv/pyenv#basic-github-checkout
apt-get update -y && apt-get install -y git &&
    apt-get clean && rm -rf /var/lib/apt/lists
git clone https://github.com/pyenv/pyenv.git "${_REMOTE_USER_HOME}/.pyenv" --branch "${VERSION}" --depth 1
pushd "${_REMOTE_USER_HOME}/.pyenv" && src/configure && make -C src && popd

if [ "$WITH" != "none" ]; then
    if [ "$WITH" = "latest" ]; then
        WITH="3:latest"
        GLOBAL=3
    else
        GLOBAL=$WITH
    fi
    "${PYENV_ROOT:-$_REMOTE_USER_HOME/.pyenv}/bin/pyenv" install "$WITH"
    "${PYENV_ROOT:-$_REMOTE_USER_HOME/.pyenv}/bin/pyenv" global "$GLOBAL"
fi

cat <<'EOF' >>"${_REMOTE_USER_HOME}/.zshrc"
### pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

EOF

