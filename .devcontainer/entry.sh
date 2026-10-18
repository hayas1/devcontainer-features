#! /bin/bash -e

# change home directory owner from root
echo "change home directory ${HOME} owner to ${USER}..."
sudo chown -R "${USER}:${USER}" "${HOME}"
echo "done"

# coding agents first, so that they are available as soon as possible
curl -fsSL https://claude.ai/install.sh | bash # https://code.claude.com/docs/ja/setup
if type npm >/dev/null 2>&1; then
    npm i -g @openai/codex # https://developers.openai.com/codex/cli
fi

# for develop with python
if [ -e "./requirements.txt" ]; then
    pip install -r "./requirements.txt"
fi

# for develop with go
if type go >/dev/null 2>&1; then
    go install -v golang.org/x/tools/gopls@latest
fi

# for develop with rust
if type cargo >/dev/null 2>&1; then
    cargo install miniserve
    cargo install cargo-readme
    cargo install cargo-tarpaulin
    cargo install tokei
fi

# project settings
# EXAMPLE:
# npm install -g @devcontainers/cli
# gh extension install https://github.com/nektos/gh-act
