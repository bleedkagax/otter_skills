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

# With color (amber/phosphor recommended — bold lines, high contrast)
FORCE_COLOR=1 uvx --from "termaid[rich]" termaid --gap 1 --padding-x 0 --theme amber <<'EOF'
...
EOF
```

## Color Output

Color requires the `rich` extra. Use `--from "termaid[rich]"` with uvx:

```bash
# Force color in non-TTY contexts (pipes, CI, agent tools)
FORCE_COLOR=1 uvx --from "termaid[rich]" termaid --theme amber <<'EOF'
graph LR; A --> B --> C
EOF
```

**`FORCE_COLOR=1`**: Rich suppresses color when stdout is not a TTY (pipes, CI, agent tools). Set this env var to force ANSI output.

**Theme selection**: `default` and `neon` use dim lines (`[2;` ANSI) — faint on many terminals. Prefer **`amber`** or **`phosphor`** which use bold + 24-bit RGB for higher contrast.

Available themes (via `uvx termaid`): `default`, `terra`, `neon`, `mono`, `amber`, `phosphor`.

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

**Mindmap label rules** (critical — long labels cause chaotic layout):
- **Max ~15 chars per label** — mindmap does NOT wrap text; long labels push branches off-screen
- Use short codes/abbreviations: `Evidence rules` not `必须引用具体原话 + anti-injection 防护`
- If content needs long descriptions, use flowchart TD with subgraphs instead of mindmap
- Keep depth ≤3 levels with ≤5 children per node for readable output

## Syntax Quick Reference

See [references/mermaid-syntax.md](references/mermaid-syntax.md) for full syntax of all 10 diagram types.

## CLI Options

| Flag | Effect |
|---|---|
| `--ascii` | ASCII-only output (+---+ boxes, > arrows). Works on all terminals |
| `--gap N` | Space between nodes (default 4). Only affects flowchart/sequence/class/ER/block |
| `--padding-x N` | Horizontal padding inside boxes (default 4). Same scope as `--gap` |
| `--width N` | Max width ceiling; auto-compacts if diagram exceeds N (not a forced width) |
| `--theme NAME` | Color theme (requires `--from "termaid[rich]"`). Use `--themes` to list |
| `--demo [TYPE]` | Render sample diagrams (`all`, `flowchart`, `sequence`, etc.) |
| `-o FILE` | Write output to file instead of stdout |

## Known Limitations

- **CJK characters misalign boxes**: termaid uses `len()` for width — CJK chars occupy 2 columns but counted as 1. **Workaround: use English labels** (PR submitted to fix upstream).
- **RL direction mirrors text**: `graph RL` renders node labels reversed (e.g. "Start" → "tratS"). **Avoid `graph RL`**; use `graph LR` instead.
- **`<br/>` not supported**: renders as literal text. Use `\n` in double-quoted labels: `A["line1\nline2"]`
- **HTML entities break rendering**: `&amp;`, `&quot;` etc. corrupt output. Use raw chars (`&`, `<`, `>`) directly.
- **Edge styles not differentiated**: bidirectional (`<-->`), dotted (`-.->`) and thick (`==>`) edges may look identical to normal arrows.
- **Dim lines on some themes**: `default`/`neon` use ANSI dim attribute. Use `amber`/`phosphor` for bold lines.
- **`--width N` is a ceiling, not a target**: diagrams render at natural size if narrower than N. Does not force compression.
- **`--padding-y 0` and `--sharp-edges` are no-ops**: no visible effect in terminal rendering.
- **Min vertical padding**: 1-line forced internal padding above/below text (not configurable).

## Tested Capacity

Verified via 100-test stress suite:
- Flowchart: up to 10 nodes TD, 8 nodes LR
- Sequence: up to 8 participants
- Mindmap: up to 20+ nodes across 4 levels
- All other types: standard complexity renders cleanly

## Tips

- **Always use `--gap 1 --padding-x 0`** — default padding wastes screen space
- **Use `\n` not `<br/>`** for multi-line labels: `A["line1\nline2"]`
- **Use raw chars** (`&`, `<`, `>`) in labels — never HTML entities
- **Avoid `graph RL`** — text mirrors bug; use `graph LR` instead
- Keep node labels concise (2-3 words for flowchart, **≤15 chars for mindmap**)
- Flowchart TD: ≤6 nodes to fit one screen; use LR for longer chains
- Mindmap: ≤3 levels deep, ≤5 children/node, short labels only — long text breaks layout
- `--gap`/`--padding-x` only affect flowchart/sequence/class/ER/block
- Prefer `amber`/`phosphor` theme over `neon`/`default` for line visibility
