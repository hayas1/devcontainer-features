# devcontainer-features
[![Test dev container features](https://github.com/hayas1/devcontainer-features/actions/workflows/test.yaml/badge.svg)](https://github.com/hayas1/devcontainer-features/actions/workflows/test.yaml)
[![Release devcontainer features](https://github.com/hayas1/devcontainer-features/actions/workflows/release.yaml/badge.svg)](https://github.com/hayas1/devcontainer-features/actions/workflows/release.yaml)

This repository provide [Dev Container Features](https://code.visualstudio.com/docs/devcontainers/containers#_dev-container-features).
What features are provided, see [./src/](./src/) also. These `README.md` are auto-generated, and contain description, usage examples, and options.

## Nerd Font Setup (recommended)

Some features (e.g. `powerlevel10k`, `starship`) render special glyphs that require a Nerd Font on the **host** machine's terminal / VSCode.

### 1. Install Hack Nerd Font via Homebrew

```sh
brew install --cask font-hack-nerd-font
```

> **Note:** On Linux without Homebrew, download the font from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) and install it manually.

### 2. Configure VSCode

Open **Settings** (`Cmd+,` on macOS / `Ctrl+,` on Windows/Linux) and search for `Editor: Font Family`.

Add `'Hack Nerd Font'` at the **beginning** of the font list:

```
'Hack Nerd Font', Menlo, Monaco, 'Courier New', monospace
```

![VSCode font family setting](docs/images/vscode-font-family.png)

Alternatively, edit `settings.json` directly (`Cmd+Shift+P` → `Open User Settings (JSON)`):

```json
{
  "editor.fontFamily": "'Hack Nerd Font', Menlo, Monaco, 'Courier New', monospace",
  "terminal.integrated.fontFamily": "'Hack Nerd Font'"
}
```

> **Tip:** `terminal.integrated.fontFamily` is separate from `editor.fontFamily`.  
> Set both so glyphs render correctly in the VSCode integrated terminal as well.

### 3. Reload VSCode

Press `Cmd+Shift+P` (macOS) / `Ctrl+Shift+P` (Windows/Linux) and run **Developer: Reload Window** to apply the font change.

---

## example usage
Copy 2 files [devcontainer.json](./.devcontainer/devcontainer.json) and [entry.sh](./.devcontainer/entry.sh) to `.devcontainer` directory. And prepare directories or files that source of mounts, such as `.git/config/`, `.zsh_history`, and so on.

Or run next command.
```sh
curl -fsL 'https://github.com/hayas1/devcontainer-features/raw/main/init.sh' | bash
```