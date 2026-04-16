# Otter Skills

Reusable skills for AI coding agents. Compatible with [skills.sh](https://skills.sh) ecosystem.

## Install

```bash
npx skills add https://github.com/bleedkagax/otter_skills --skill terminal-diagrams
```

```bash
npx skills add https://github.com/bleedkagax/otter_skills --skill setup-fastfetch-theme
```

```bash
npx skills add https://github.com/bleedkagax/otter_skills --skill codex-subagent-nicknames
```

Global install (available across all projects):

```bash
npx skills add https://github.com/bleedkagax/otter_skills --skill terminal-diagrams --global
```

Install all skills in this repo:

```bash
npx skills add https://github.com/bleedkagax/otter_skills
```

## Available Skills

### terminal-diagrams

Render Mermaid diagrams as Unicode art in the terminal via [termaid](https://github.com/fasouto/termaid).

**10 diagram types**: flowchart, sequence, class, ER, state, block, git graph, pie chart, treemap, mindmap.

```bash
uvx termaid --gap 1 --padding-x 0 <<'EOF'
graph LR; A[Start] --> B{OK?} -->|Yes| C[Done]
EOF
```

**Features**:
- Zero-install rendering via `uvx termaid`
- Auto-detect dark/light terminal mode for optimal theme
- Multi-color light mode (colored lines + black text)
- CJK character support (termaid >= 0.5.0)
- Bilingual labels: `A["Quality Gate\n(质量门控)"]`
- Complex diagram auto-split with index + sub-diagrams
- 6 ready-to-use templates (API flow, CRUD, microservice, git, decision, project)
- 100-test stress suite verified

### setup-fastfetch-theme

Install Fastfetch on macOS and apply the `decksters-lab/fastfetch` theme with minimal compatibility patches.

**Features**:
- Preserves the original layout, colors, and image assets from the theme repo
- Fixes the macOS `OS Age` command without changing the visual design
- Uses `kitty-direct` plus explicit logo sizing for Ghostty image rendering
- Includes optional `~/.zshrc` auto-run guidance

### codex-subagent-nicknames

Configure Codex CLI subagent display names through `nickname_candidates` in `~/.codex/config.toml`.

**Features**:
- Confirms the local Codex build accepts the `nickname_candidates` key
- Adds or updates a top-level nickname list without disturbing other settings
- Explains restart expectations for newly spawned subagents
- Includes practical naming guidance for themed nickname sets

## Manual Install

If not using `npx skills`, copy directly:

```bash
# Skill (auto-triggers on diagram requests)
cp -r skills/terminal-diagrams ~/.claude/skills/

# Skill (install Fastfetch + decksters-lab config on macOS)
cp -r skills/setup-fastfetch-theme ~/.claude/skills/

# Skill (configure Codex subagent nicknames)
cp -r skills/codex-subagent-nicknames ~/.claude/skills/

# Slash command (/diagram)
cp skills/terminal-diagrams/diagram-command.md ~/.claude/commands/diagram.md
```

## License

MIT
