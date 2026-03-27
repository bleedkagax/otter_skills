#!/bin/bash
# termaid-render.sh — auto-detect dark/light mode and render with best theme
# Usage: echo 'graph LR; A-->B' | ./termaid-render.sh
#        ./termaid-render.sh diagram.mmd
#
# Override: TERMAID_THEME=phosphor ./termaid-render.sh diagram.mmd

set -e

# Auto-detect theme based on macOS appearance (dark/light)
if [ -z "$TERMAID_THEME" ]; then
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark; then
        TERMAID_THEME="amber"      # gold on dark = high contrast
    else
        TERMAID_THEME="terra"      # earth tones on light = high contrast
    fi
fi

# Always specify Python for uvx (its default may differ from system python3)
PYTHON_FLAG="--python 3.11"
for v in 3.13 3.12 3.11; do
    if command -v "python$v" >/dev/null 2>&1; then
        PYTHON_FLAG="--python $v"
        break
    fi
done

exec env FORCE_COLOR=1 uvx $PYTHON_FLAG --from "termaid[rich]" termaid \
    --gap 1 --padding-x 0 --theme "$TERMAID_THEME" "$@"
