#!/bin/bash
# termaid-render.sh — auto-detect dark/light mode and render with best theme
# Usage: echo 'graph LR; A-->B' | ./termaid-render.sh
#        ./termaid-render.sh diagram.mmd
#
# Override: TERMAID_THEME=amber ./termaid-render.sh
#           TERMAID_THEME=none  ./termaid-render.sh  (force plain, no color)

set -e

# Auto-detect theme based on macOS appearance
# Dark  → amber theme (gold lines + gold text, full color)
# Light → "light" mode (colored lines only, black text — best contrast on white bg)
MODE="light"
if [ -n "$TERMAID_THEME" ]; then
    if [ "$TERMAID_THEME" = "none" ]; then
        MODE="plain"
    else
        MODE="theme"
    fi
elif defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark; then
    TERMAID_THEME="amber"
    MODE="theme"
fi

# Always specify Python for uvx (its default may differ from system python3)
PYTHON_FLAG="--python 3.11"
for v in 3.13 3.12 3.11; do
    if command -v "python$v" >/dev/null 2>&1; then
        PYTHON_FLAG="--python $v"
        break
    fi
done

# Light mode colorizer: colored lines + black text (no termaid source changes)
colorize_lines() {
    python3 -c "
import sys
COLOR = '\033[38;2;30;120;200m'   # steel blue for lines
RESET = '\033[0m'
BOX = set('┌┐└┘├┤┬┴─│◇◯▼►◄▲╭╮╰╯┆┼◉●━┃┄')
for line in sys.stdin:
    out = []
    for ch in line:
        if ch in BOX:
            out.append(COLOR + ch + RESET)
        else:
            out.append(ch)
    sys.stdout.write(''.join(out))
"
}

case "$MODE" in
    theme)
        exec env FORCE_COLOR=1 uvx $PYTHON_FLAG --from "termaid[rich]" termaid \
            --gap 1 --padding-x 0 --theme "$TERMAID_THEME" "$@"
        ;;
    light)
        uvx $PYTHON_FLAG termaid --gap 1 --padding-x 0 "$@" | colorize_lines
        ;;
    plain)
        exec uvx $PYTHON_FLAG termaid --gap 1 --padding-x 0 "$@"
        ;;
esac
