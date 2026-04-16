---
name: setup-fastfetch-theme
description: Install Fastfetch and apply the decksters-lab/fastfetch configuration on macOS, especially for Ghostty. Use when the user asks to install, configure, restore, or troubleshoot Fastfetch, wants the decksters-lab theme kept visually intact, or needs the macOS OS Age fix and Ghostty image-logo compatibility patch.
---

# Fastfetch Setup

Install Fastfetch and apply `https://github.com/decksters-lab/fastfetch` while preserving the repository's original layout, colors, and image assets. Favor minimal compatibility edits over style changes.

Upstream references:
- Fastfetch: `https://github.com/fastfetch-cli/fastfetch`
- Theme config: `https://github.com/decksters-lab/fastfetch`

## Use This Skill When

- The user asks to install or set up Fastfetch on macOS.
- The user wants the `decksters-lab/fastfetch` config applied without redesigning it.
- The user wants Ghostty to render the theme's PNG image logo correctly.
- The user sees a broken `OS Age` command on macOS.
- The user wants `fastfetch` added to `~/.zshrc` after installation.

## Workflow

1. Inspect the machine and existing config:

```bash
uname -s
which brew || true
which fastfetch || true
ls -la ~/.config/fastfetch 2>/dev/null || true
sed -n '1,120p' ~/.config/ghostty/config 2>/dev/null || true
```

2. Install Fastfetch on macOS with Homebrew:

```bash
brew install fastfetch
```

3. Fetch the theme repository to a temporary location:

```bash
tmpdir=$(mktemp -d)
git clone --depth=1 https://github.com/decksters-lab/fastfetch "$tmpdir/repo"
```

4. Copy the repository assets and original config into `~/.config/fastfetch`:

```bash
mkdir -p ~/.config/fastfetch
cp -R "$tmpdir/repo/fastfetch/pngs" ~/.config/fastfetch/
cp "$tmpdir/repo/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc
```

5. Start from the repository's original `config.jsonc`, then patch only the compatibility issues below.

6. Add fastfetch to the user's shell startup file (see **Shell Auto-Run** below). This is a recommended step — without it the user must type `fastfetch` manually each time they open a terminal.

## Compatibility Rules

Keep the theme visually intact. Do not redesign spacing, colors, modules, or artwork unless the user explicitly asks.

### macOS `OS Age` fix

The upstream config uses GNU `stat`:

```bash
echo $(($(($(date +%s) - $(stat -c %W /))) / 86400)) days
```

Replace only that command with a Darwin-safe version:

```bash
boot=$(if [ "$(uname)" = Darwin ]; then stat -f %B /; else stat -c %W /; fi); echo $((($(date +%s) - boot) / 86400)) days
```

### Ghostty image-logo fix

For Ghostty, use `kitty-direct` with explicit width and height. `kitty` alone may still fail to render the PNG logo.

Use this exact `logo` block:

```jsonc
"logo": {
    "type": "kitty-direct",
    "source": "${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/*.png",
    "width": 36,
    "height": 18,
    "padding": { "top": 2, "right": 8 }
}
```

Keep the existing `source`, `height`, and `padding` from the repo. Add `width: 36` and change the protocol only if needed for Ghostty image rendering.

### Shell Auto-Run (Recommended)

Append the following guarded snippet to the user's shell rc file (`~/.zshrc` for zsh, `~/.bashrc` for bash). **Do not** add it to `~/.zshenv` or `~/.bash_profile` — those run for non-interactive shells too and will break pipes and scripts.

```zsh
# Fastfetch — show system info on new interactive shell
if [[ -o interactive ]] && command -v fastfetch &>/dev/null; then
    fastfetch
fi
```

The two guards are important:
- `[[ -o interactive ]]` — only runs in interactive shells (not scripts, pipes, or agent subprocesses like Claude Code)
- `command -v fastfetch` — gracefully skips if fastfetch is uninstalled later

Check if the snippet already exists before appending (`grep -q fastfetch ~/.zshrc`). Place it at the **end** of the rc file so all PATH and environment setup has completed before fastfetch tries to locate its config and image assets.

## Validation

- Run `fastfetch` after applying the config.
- Open a new Ghostty window after changing the logo protocol.
- If the image still does not appear, run `fastfetch --show-errors`.
- Check `~/.config/ghostty/config` for `image-storage-limit = 0`; that disables terminal image rendering.
- Confirm the only intentional theme edits are the macOS `OS Age` fix and the Ghostty logo protocol/size patch.

## Notes

- The theme uses `*.png`, so Fastfetch may pick different images from the `pngs/` folder.
- In sandboxed agent environments, writing to `~/.config/fastfetch` or `~/.zshrc` may require escalation.
- If the user says the theme looks worse after changes, prefer restoring the repository's original config and re-applying only the minimum compatibility patches.
