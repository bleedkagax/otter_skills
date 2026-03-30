# Otter Skills

Reusable skills for AI coding agents. Compatible with [skills.sh](https://skills.sh) ecosystem.

## Install

```bash
npx skills add bleedkagax/otter_skills
```

Or install a specific skill:

```bash
npx skills add bleedkagax/otter_skills --skill diagram
```

Global install (available across all projects):

```bash
npx skills add bleedkagax/otter_skills --global
```

## Available Skills

### diagram

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

## Manual Install

If not using `npx skills`, copy directly:

```bash
# Skill (auto-triggers on diagram requests)
cp -r skills/diagram ~/.claude/skills/

# Slash command (/diagram)
cp skills/diagram/diagram-command.md ~/.claude/commands/diagram.md
```

## License

MIT
