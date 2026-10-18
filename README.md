# devcontainer-features
[![Test dev container features](https://github.com/hayas1/devcontainer-features/actions/workflows/test.yaml/badge.svg)](https://github.com/hayas1/devcontainer-features/actions/workflows/test.yaml)
[![Release devcontainer features](https://github.com/hayas1/devcontainer-features/actions/workflows/release.yaml/badge.svg)](https://github.com/hayas1/devcontainer-features/actions/workflows/release.yaml)

This repository provide [Dev Container Features](https://code.visualstudio.com/docs/devcontainers/containers#_dev-container-features).
What features are provided, see [./src/](./src/) also. These `README.md` are auto-generated, and contain description, usage examples, and options.

## example usage
Copy 3 files [devcontainer.json](./.devcontainer/devcontainer.json), [clone.sh](./.devcontainer/clone.sh) and [entry.sh](./.devcontainer/entry.sh) to `.devcontainer` directory. And prepare directories or files that source of mounts, such as `.config/git/`, `.zsh_history`, `.vscode/`, and so on.

Or run next command.
```sh
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/init.sh' | bash
```

### workspace is placed on docker volume
The workspace (source code) is not mounted from the host file system, but placed on a docker volume, because sharing files between the host and the container through mount is slow on some hosts (e.g. Docker Desktop on macOS / Windows).
- The volume is named `<local folder name>-workspace`, and mounted to `/workspaces/<local folder name>`.
- `initializeCommand` (run on the host) writes the url of the `origin` remote of the local folder into `.devcontainer/.remote-url`.
- `postCreateCommand` runs [clone.sh](./.devcontainer/clone.sh), which clones the repository into the volume from the url (only when it is not cloned yet).
- Only `.devcontainer/` and `.vscode/` are mounted from the local folder. Other files in the container are **not** synced with the local folder, so commit and push in the container.
- To recreate the workspace from scratch, remove the volume by `docker volume rm <local folder name>-workspace`.

### previous setting: mount the workspace from the host file system
Until [e04ba8e](https://github.com/hayas1/devcontainer-features/tree/e04ba8eac6f3d36111402a5ec32b7d7d0d3b916e/.devcontainer), the local folder on the host was mounted into the container as the workspace (default behavior of Dev Containers). Files edited in the container are directly reflected to the local folder, and no clone is needed, but file access may be slow.

To use that setting, copy files from the link above, or run next command.
```sh
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/init.sh' | DEVCONTAINER_REF=e04ba8eac6f3d36111402a5ec32b7d7d0d3b916e bash
```
