
# starship-sheldon (starship-sheldon)

Install starship and sheldon

## Example Usage

```json
"features": {
    "ghcr.io/hayas1/devcontainer-features/starship-sheldon:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| with-starship-config | if false, use default config or mount ~/.config/starship.yaml | boolean | false |
| with-sheldon-config | if false, use default config or mount ~/.config/sheldon/plugins.yaml | boolean | false |
| with-some-tools | if false, do not install zsh, git, sudo, exa, ripgrep and so on | boolean | false |
| write-zshrc | if false, do not write ~/.zshrc | boolean | false |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/hayas1/devcontainer-features/blob/main/src/starship-sheldon/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
