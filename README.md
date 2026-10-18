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

### workspace on docker volume
Bind mount of workspace folder can be slow (e.g. Docker Desktop on macOS / Windows). [volume/devcontainer.json](./.devcontainer/volume/devcontainer.json) puts the workspace on a docker volume (`<folder name>-workspace`) instead.
- `initializeCommand` writes the `origin` remote url of the local folder into `.devcontainer/.remote-url`
- `postCreateCommand` runs [clone.sh](./.devcontainer/clone.sh), which clones the repository into the volume (only when not cloned yet)
- `.devcontainer/` and `.vscode/` are still bind mounted from the local folder, other files are not synced with the local folder

Copy it as `.devcontainer/devcontainer.json` with [clone.sh](./.devcontainer/clone.sh) and [entry.sh](./.devcontainer/entry.sh), or run next command.
```sh
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/init.sh' | WORKSPACE_MOUNT=volume bash
```
To recreate the workspace from scratch, remove the volume by `docker volume rm <folder name>-workspace`.
