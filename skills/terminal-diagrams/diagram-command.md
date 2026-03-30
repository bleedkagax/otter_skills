Render a Mermaid diagram in the terminal using termaid (zero-install via `uvx termaid`, requires Python >= 3.11).

User request: $ARGUMENTS

## Instructions

1. Determine the best diagram type for the request:
   - **flowchart** (`graph TD/LR`) - processes, decisions, workflows, architecture
   - **sequence** (`sequenceDiagram`) - interactions between actors/services over time
   - **class** (`classDiagram`) - classes, interfaces, relationships
   - **er** (`erDiagram`) - entities and relationships (database models)
   - **state** (`stateDiagram-v2`) - state machines, lifecycle
   - **block** (`block-beta`) - system components in grid layout
   - **git** (`gitGraph`) - branch/merge history
   - **pie** (`pie title ...`) - proportions/percentages
   - **treemap** (`treemap-beta`) - hierarchical data with sizes
   - **mindmap** (`mindmap`) - hierarchical brainstorming/structure

2. **Bilingual labels** — smart language strategy:
   Use the user's language directly in labels — CJK is fully supported (termaid >= 0.5.0). For bilingual contexts, optionally annotate: `A["Quality Gate\n(质量门控)"]`. Response text: user's language.

3. Generate valid Mermaid syntax. For complex multi-branch content, use vertical chain pattern:
   - Main flow down left column: `A --> B --> C`
   - Each step fans out one detail node right: `A -->|details| A1["Line1\nLine2"]`

4. Render using the auto-color script (handles --gap 1 --padding-x 0, Python version, dark/light theme automatically):
   ```bash
   # DEFAULT: auto-color render
   bash ~/.claude/skills/terminal-diagrams/scripts/termaid-render.sh <<'EOF'
   <mermaid syntax here>
   EOF

   # Fallback if script not available
   uvx termaid --gap 1 --padding-x 0 <<'EOF'
   <mermaid syntax here>
   EOF
   ```

5. If output is still too large:
   - Use `--width 80` for explicit width limit
   - Switch to `graph LR` (horizontal) — far fewer lines than `graph TD`
   - Use `mindmap` for hierarchical overviews — highest information density
   - Limit flowchart nodes to ≤6; merge minor steps

## Quick Syntax Reference

**Flowchart**: `A[Rect]`, `A(Rounded)`, `A{Diamond}`, `A([Stadium])`. Edges: `-->`, `-.->`, `==>`, `-->|label|`. Subgraphs: `subgraph Title ... end`.

**Sequence**: `participant A as Alice`, `A->>B: request` (solid), `B-->>A: response` (dashed).

**Class**: `class Name { +attr; +method() }`. Relations: `<|--` inherit, `*--` compose, `o--` aggregate, `..>` depend.

**ER**: `ENTITY1 ||--o{ ENTITY2 : "rel"`. Cardinality: `||` one, `o|` 0..1, `}|` 1+, `o{` 0+. Attributes: `{ type name PK }`.

**State**: `[*] --> State1`, `State1 --> State2 : event`, composite: `state Parent { ... }`.

**Block**: `columns N`, `A["Label"]`, spanning: `A["Wide"]:2`.

**Git**: `commit id: "x"`, `branch name`, `checkout main`, `merge name`.

**Pie**: `"Label" : value`.

**Treemap**: indent-based `"Group"\n  "Item": value`.

**Mindmap**: indent-based `Root\n  Branch\n    Leaf`.

## Complex Diagrams

When a diagram would exceed these thresholds, **auto-split** into index + sub-diagrams:

| Type | Split when |
|---|---|
| Flowchart TD | > 6 nodes |
| Flowchart LR | > 5 nodes (short labels) or > 4 (long labels) |
| Sequence | > 6 participants |
| Mindmap | > 15 labels |
| Class/ER | > 6 entities |
| State | > 8 states |

**Pattern:**
1. Render an **index diagram** (`graph LR`) with `[N/M]` labels showing parts:
   ```bash
   uvx termaid --gap 1 --padding-x 0 <<'EOF'
   graph LR; S1["[1/2] Extract\nMemories"] --> S2["[2/2] Update\nStore"]
   EOF
   ```
2. Print `**[N/M] Title**` header before each sub-diagram
3. Render each sub-diagram separately (self-contained, no Mermaid cross-refs)
4. Keep to 2-4 parts max; if 5+ needed, simplify content instead

**Terminal width rules** (~80 cols default):
- Linear chain <=5 short-label nodes: `graph LR`
- 6+ nodes, long labels, or branching: `graph TD`
- Index/overview: always `graph LR`
- Rule of thumb: each LR node costs ~(label_width + 6) chars; if total > 75, use TD

## Guidelines

- **Always `--gap 1 --padding-x 0`** — default padding wastes screen space
- **CJK fully supported** (termaid >= 0.5.0) — use any language directly in labels
- **Use `\n` not `<br/>`** for multi-line labels: `A["line1\nline2"]`
- **Use raw chars** (`&`, `<`, `>`) — never HTML entities (`&amp;` etc. break rendering)
- **Avoid `graph RL`** — text mirrors bug; use `graph LR` instead
- **Decision diamonds: max 2-3 branches** in TD — 4+ branches overflow width. Split into chained diamonds or use LR
- Prefer `graph LR` over `graph TD` for fewer lines; flowchart TD ≤6 nodes
- **Mindmap labels ≤15 chars** — no text wrapping; long labels break layout completely
- Mindmap: ≤3 levels, ≤5 children/node; for long descriptions use flowchart TD + subgraphs instead
- Keep node labels to 2-3 words (flowchart), ≤15 chars (mindmap)
- `--gap`/`--padding-x` only affect flowchart/sequence/class/ER/block
- `--width N` is a ceiling, not forced — diagrams render at natural size if narrower
- Color: dark terminal → `amber`; light terminal → no theme (plain black = max contrast)
- If Python < 3.11 error, add `--python 3.11` after `uvx`
