---
name: codex-subagent-nicknames
description: Configure Codex subagent display names via `agents.<name>.nickname_candidates` in `~/.codex/config.toml` or `.codex/agents/*.toml`. Use when the user asks to name subagents, customize Codex agent nicknames, set food-style codenames, or update the local Codex TOML so spawned agents stop using generic labels.
---

# Codex Subagent Nicknames

Use this skill when the user wants Codex subagents to appear with custom nicknames instead of generic labels.

This skill is specifically for the documented Codex config shape:

```toml
[agents.default]
nickname_candidates = ["PekingDuck", "MapoTofu", "DongpoRou"]
```

## Workflow

1. Inspect the local Codex setup before editing:

```bash
codex --version
sed -n '1,160p' ~/.codex/config.toml
```

2. Confirm the config shape is accepted by the installed build. A safe parse check is:

```bash
codex -c '[agents.default]\nnickname_candidates=["PekingDuck","MapoTofu"]' features list
```

If this command parses normally, the config shape is recognized by the local build.

3. Edit `~/.codex/config.toml` and add or update `nickname_candidates` under the target agent.

Use `[agents.default]` when you want a nickname pool for the default spawned agent type. For custom agents defined in `.codex/agents/*.toml`, put `nickname_candidates` directly in that agent file next to `name`, `model`, and related keys.

Example:

```toml
model = "gpt-5.4"
model_reasoning_effort = "high"

[agents.default]
nickname_candidates = [
  "PekingDuck",
  "MapoTofu",
  "DongpoRou",
  "FotiaoQiang",
  "LionHead",
  "BeggarChicken",
  "SquirrelFish",
  "WestLakeFish",
  "WhiteCutChicken",
  "KungPaoChicken",
  "TwiceCookedPork",
  "MeiCaiKouRou",
]
```

4. Re-run a lightweight Codex command after the edit to ensure the TOML still parses:

```bash
codex features list
```

5. Tell the user to start a new Codex session or restart the current UI if the old thread still shows previous names.

## Editing Rules

- In shared config, `nickname_candidates` belongs under `agents.<name>`, not at the top level.
- In a custom agent file under `.codex/agents/*.toml`, `nickname_candidates` can live directly beside `name`.
- Preserve existing user settings; only add or update the relevant nickname array.
- Prefer short, visually distinct nicknames.
- Use ASCII unless the user explicitly wants Unicode names.
- If the config file is outside the writable sandbox, request approval before writing.

## Good Candidate Lists

Good nickname sets usually have:

- consistent theme
- easy spelling
- low collision risk
- short visual width in the TUI

Useful themes:

- Chinese classic dishes (recommended): `PekingDuck`, `MapoTofu`, `DongpoRou`
- foods: `PekingDuck`, `MapoTofu`, `LionHead`
- trees: `Juniper`, `Maple`, `Cedar`
- weather: `Nimbus`, `Cirrus`, `Monsoon`
- colors/minerals: `Amber`, `Onyx`, `Coral`

Avoid:

- names that differ by one character only
- very long phrases
- punctuation-heavy strings
- duplicates

## Notes

- In current Codex builds, nickname changes may only become visible for newly spawned subagents.
- The `name` field still controls which agent is spawned; `nickname_candidates` only affects display labels.
- If the user also wants the setting captured as reusable team convention, add the chosen nickname set to dotfiles or a bootstrap script separately.
