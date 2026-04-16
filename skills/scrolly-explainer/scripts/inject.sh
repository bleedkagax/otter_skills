#!/bin/bash
# inject.sh — Inject ScrollyEngine framework into AI-generated HTML
# Usage: bash inject.sh <input.html> [output.html]
#   If output.html is omitted, modifies input.html in-place
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT="$1"
OUTPUT="${2:-$1}"

# Validate input
if [ -z "$INPUT" ] || [ ! -f "$INPUT" ]; then
    echo "Usage: bash inject.sh <input.html> [output.html]" >&2
    exit 1
fi

# Check if HTML uses ScrollyEngine
if ! grep -q "new ScrollyEngine" "$INPUT"; then
    echo "[inject] No ScrollyEngine usage detected, skipping" >&2
    [ "$INPUT" != "$OUTPUT" ] && cp "$INPUT" "$OUTPUT"
    exit 0
fi

python3 - "$INPUT" "$OUTPUT" "$SCRIPT_DIR" << 'PYEOF'
import sys, os

input_path, output_path, script_dir = sys.argv[1], sys.argv[2], sys.argv[3]

with open(input_path, 'r') as f:
    html = f.read()

# Load framework files
with open(os.path.join(script_dir, 'scrollama.min.js'), 'r') as f:
    scrollama_js = f.read()
with open(os.path.join(script_dir, 'scrolly_engine.js'), 'r') as f:
    engine_js = f.read()

# Step 1: Rename AI-generated ScrollyEngine class to prevent conflicts
if 'class ScrollyEngine' in html:
    html = html.replace('class ScrollyEngine', 'class ScrollyEngine_AI_Generated_Ignored')
    print('[inject] Renamed AI-generated ScrollyEngine class', file=sys.stderr)

# Step 2: Find inline <script> containing "new ScrollyEngine" and inject after <script>
new_engine_idx = html.index('new ScrollyEngine')
search_area = html[:new_engine_idx]

# Search backwards for the last inline <script> tag (without src=)
insertion_point = -1
pos = len(search_area)
while pos > 0:
    script_start = search_area.rfind('<script', 0, pos)
    if script_start < 0:
        break

    # Find the closing '>' of this tag
    tag_end = html.find('>', script_start)
    if tag_end < 0:
        pos = script_start
        continue

    # Extract the complete script tag
    script_tag = html[script_start:tag_end + 1]

    # Skip external scripts (with src attribute)
    if ' src=' in script_tag or ' src ' in script_tag:
        pos = script_start
        continue

    # Found an inline script — inject after the '>'
    insertion_point = tag_end + 1
    break

# Build injection payload
inject_code = (
    "\n        // ===== Scrollama.js (v3.2.0) - Auto-injected =====\n        "
    + scrollama_js
    + "\n\n        // ===== ScrollyEngine Framework - Auto-injected =====\n        "
    + engine_js
    + "\n\n        "
)

if insertion_point > 0 and insertion_point <= len(html):
    result = html[:insertion_point] + inject_code + html[insertion_point:]
    print(f'[inject] Injected at position {insertion_point}', file=sys.stderr)
else:
    # Fallback: inject before </body>
    body_end = html.rfind('</body>')
    if body_end < 0:
        body_end = len(html)
    inject_script = (
        "\n<script>\n"
        + "// ===== Scrollama.js (v3.2.0) - Auto-injected =====\n"
        + scrollama_js
        + "\n\n// ===== ScrollyEngine Framework - Auto-injected =====\n"
        + engine_js
        + "\n</script>\n"
    )
    result = html[:body_end] + inject_script + html[body_end:]
    print('[inject] Fallback: injected before </body>', file=sys.stderr)

with open(output_path, 'w') as f:
    f.write(result)
print(f'[inject] Output written to {output_path}', file=sys.stderr)
PYEOF
