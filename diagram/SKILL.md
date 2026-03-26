---
name: diagram
description: Render Mermaid diagrams as Unicode art in the terminal using termaid. Use when the user asks to visualize architecture, workflows, data models, class hierarchies, state machines, sequences, git history, proportions, hierarchies, or any diagram. Triggers include "draw a diagram", "visualize this", "show the flow", "render a flowchart", "sequence diagram", "class diagram", "ER diagram", "state diagram", "mindmap", "treemap", "pie chart", "git graph", or any request to diagram code structure, system design, or data relationships.
---

# Diagram

Render Mermaid diagrams in the terminal via `uvx termaid` (zero-install, pure Python, requires Python >= 3.11).

If the default Python is < 3.11, use `uvx --python 3.11 termaid` (or 3.12/3.13).

## Workflow

1. Determine the best diagram type from user request or code context
2. Generate valid Mermaid syntax
3. Render via pipe to termaid
4. If output is too wide, re-render with compact options

## Rendering

Always use `--gap 1 --padding-x 0` for compact output. termaid's defaults (gap=4, padding-x=4) are too spacious for terminal viewing.

```bash
# Standard compact render (recommended default)
uvx termaid --gap 1 --padding-x 0 <<'EOF'
graph LR; A[Start] --> B{OK?} --> C[Done]
EOF

# File input
uvx termaid --gap 1 --padding-x 0 diagram.mmd

# With color
FORCE_COLOR=1 uvx --from "termaid[rich]" termaid --gap 1 --padding-x 0 --theme neon <<'EOF'
...
EOF
```

## Color Output

Color requires the `rich` extra. Use `--from "termaid[rich]"` with uvx:

```bash
# Basic color (in real terminal, colors render automatically)
uvx --from "termaid[rich]" termaid --theme neon <<'EOF'
graph TD; A --> B --> C
EOF

# Force color in non-TTY contexts (pipes, subprocesses, CI, Claude Code Bash tool)
FORCE_COLOR=1 uvx --from "termaid[rich]" termaid --theme neon <<'EOF'
graph TD; A --> B --> C
EOF
```

**When to use `FORCE_COLOR=1`**: Rich auto-detects TTY and suppresses color when stdout is captured (pipes, CI logs, Claude Code Bash tool). Set `FORCE_COLOR=1` to force ANSI output regardless. The raw escape codes (`[1;35m` etc.) will appear in non-terminal contexts but render as actual colors in a real terminal.

Available themes: `default`, `terra`, `neon`, `mono`, `amber`, `phosphor`, `gruvbox`, `monokai`, `dracula`, `nord`, `solarized`.

## Diagram Type Selection

| User Intent | Type | Header |
|---|---|---|
| Process, decision, workflow, architecture | Flowchart | `graph TD` / `graph LR` |
| Service/actor interactions over time | Sequence | `sequenceDiagram` |
| Classes, interfaces, inheritance | Class | `classDiagram` |
| Database entities, relationships | ER | `erDiagram` |
| States, transitions, lifecycle | State | `stateDiagram-v2` |
| System components in grid | Block | `block-beta` |
| Branch/merge history | Git | `gitGraph` |
| Proportions, percentages | Pie | `pie title ...` |
| Hierarchical data with sizes | Treemap | `treemap-beta` |
| Brainstorm, tree structure | Mindmap | `mindmap` |

**Density strategy**: Flowchart TD costs ~5 lines per node (box borders + forced 1-line internal padding). For one-screen diagrams:
- Prefer `graph LR` over `graph TD` — horizontal layout uses far fewer lines
- Use `mindmap` for hierarchical overviews — highest information density
- Limit flowcharts to ≤6 nodes; merge minor steps into single nodes

## Syntax Quick Reference

See [references/mermaid-syntax.md](references/mermaid-syntax.md) for full syntax of all 10 diagram types.

## CLI Options

| Flag | Effect |
|---|---|
| `--ascii` | ASCII-only output (no Unicode box-drawing) |
| `--gap N` | Space between nodes (default 4). Only affects flowchart/sequence/class/ER/block |
| `--padding-x N` | Horizontal padding inside boxes (default 4). Same scope as `--gap` |
| `--padding-y N` | Vertical padding inside boxes (default 2) |
| `--width N` | Max output width; auto-compacts with smaller gap/padding if exceeded |
| `--no-auto-fit` | Disable automatic compaction when diagram exceeds terminal width |
| `--sharp-edges` | Sharp corners on edge routing turns instead of rounded |
| `--theme NAME` | Color theme (requires `pip install termaid[rich]`). Use `--themes` to list all |
| `--tui` | Interactive TUI viewer (requires `pip install termaid[tui]`) |
| `-o FILE` | Write output to file instead of stdout |
| `--demo [TYPE]` | Render sample diagrams (`all`, `flowchart`, `sequence`, etc.) |
| `--show-ids` | Show node IDs alongside labels for debugging |

## Tips

- **Always use `--gap 1 --padding-x 0`** — default padding wastes screen space
- Keep node labels concise (2-3 words)
- Flowchart TD: ≤6 nodes to fit one screen; use LR for longer chains
- `mindmap` is the most compact for hierarchical structures
- `--gap`/`--padding-x` only affect flowchart/sequence/class/ER/block
- termaid auto-fits to terminal width; use `--no-auto-fit` to disable
