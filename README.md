# devcontainer-features
[![Test dev container features](https://github.com/hayas1/devcontainer-features/actions/workflows/test.yaml/badge.svg)](https://github.com/hayas1/devcontainer-features/actions/workflows/test.yaml)
[![Release devcontainer features](https://github.com/hayas1/devcontainer-features/actions/workflows/release.yaml/badge.svg)](https://github.com/hayas1/devcontainer-features/actions/workflows/release.yaml)

This repository provide [Dev Container Features](https://code.visualstudio.com/docs/devcontainers/containers#_dev-container-features).
What features are provided, see [./src/](./src/) also. These `README.md` are auto-generated, and contain description, usage examples, and options.

## example usage
Copy 2 files [devcontainer.json](./.devcontainer/devcontainer.json) and [entry.sh](./.devcontainer/entry.sh) to `.devcontainer` directory. And prepare directories or files that source of mounts, such as `.git/config/`, `.zsh_history`, and so on.

Or run next command.
```sh
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/init.sh' | bash
```

## Nerd Font Setup (recommended)

Some features (e.g. `powerlevel10k`, `starship`) require a Nerd Font installed on the host to render glyphs correctly.

### 1. Install

```sh
brew install --cask font-hack-nerd-font
```

### 2. Configure VSCode

Add to `settings.json` (`Cmd+Shift+P` → `Open User Settings (JSON)`):

```json
{
  "editor.fontFamily": "'Hack Nerd Font', Menlo, Monaco, 'Courier New', monospace",
  "terminal.integrated.fontFamily": "'Hack Nerd Font'"
}
```

Just placing `'Hack Nerd Font'` at the front of `editor.fontFamily` is enough.