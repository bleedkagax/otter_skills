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

2. Generate valid Mermaid syntax for the diagram

3. Render using heredoc pipe. **Always use `--gap 1 --padding-x 0`** for compact output:
   ```bash
   # Compact render (recommended default)
   uvx termaid --gap 1 --padding-x 0 <<'EOF'
   <mermaid syntax here>
   EOF

   # With color (amber/phosphor have bold lines; neon/default have dim/faint lines)
   FORCE_COLOR=1 uvx --from "termaid[rich]" termaid --gap 1 --padding-x 0 --theme amber <<'EOF'
   <mermaid syntax here>
   EOF
   ```

4. If output is still too large:
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

## Guidelines

- **Always `--gap 1 --padding-x 0`** — default padding wastes screen space
- **Use English labels** — CJK chars cause box misalignment (upstream bug, PR submitted)
- **Use `\n` not `<br/>`** for multi-line labels: `A["line1\nline2"]`
- **Use raw chars** (`&`, `<`, `>`) — never HTML entities (`&amp;` etc. break rendering)
- **Avoid `graph RL`** — text mirrors bug; use `graph LR` instead
- Prefer `graph LR` over `graph TD` for fewer lines; flowchart TD ≤6 nodes
- `mindmap` is the most compact for hierarchical info
- Keep node labels to 2-3 words
- `--gap`/`--padding-x` only affect flowchart/sequence/class/ER/block
- `--width N` is a ceiling, not forced — diagrams render at natural size if narrower
- Color: prefer `amber`/`phosphor` (bold lines); avoid `neon`/`default` (dim lines)
- If Python < 3.11 error, add `--python 3.11` after `uvx`
