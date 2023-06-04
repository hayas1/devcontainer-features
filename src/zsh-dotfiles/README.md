
# zsh-dotfiles (zsh-dotfiles)

Setup zsh-dotfiles

## Example Usage

```json
"features": {
    "ghcr.io/hayas1/devcontainer-features/zsh-dotfiles:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| with-starship-config | if false, do not use starship, or use default config or mount `~/.config/starship.yaml` | boolean | true |
| with-sheldon-config | if false, do not use sheldon, or use default config or mount `~/.config/sheldon/plugins.yaml` | boolean | true |
| with-some-tools | if false, do not install zsh, git, sudo, exa, ripgrep and so on | boolean | true |
| overwrite-zshrc | if false, do not overwrite `~/.zshrc` (append only) | boolean | true |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/hayas1/devcontainer-features/blob/main/src/zsh-dotfiles/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
