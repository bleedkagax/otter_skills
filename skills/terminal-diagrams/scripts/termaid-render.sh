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

# Light mode colorizer: multi-color lines + black text (no termaid source changes)
# 5 colors by structural role, text stays terminal default (black)
colorize_lines() {
    python3 -c "
import sys
R = '\033[0m'
C = {
    'border':  '\033[38;2;30;100;180m',   # deep blue — box borders
    'arrow':   '\033[38;2;200;80;30m',    # warm orange — arrow heads
    'line':    '\033[38;2;100;130;160m',   # muted blue-gray — vertical lines
    'special': '\033[38;2;130;60;160m',   # purple — diamonds, circles
    'dash':    '\033[38;2;40;140;80m',    # forest green — dashed lines
}
MAP = {}
for ch in '┌┐└┘├┤┬┴─╭╮╰╯┼': MAP[ch] = C['border']
for ch in '▼►◄▲→←↑↓':       MAP[ch] = C['arrow']
for ch in '│┆┃':             MAP[ch] = C['line']
for ch in '◇◯◉●■✖':         MAP[ch] = C['special']
for ch in '┄':               MAP[ch] = C['dash']
for line in sys.stdin:
    sys.stdout.write(''.join(MAP[ch] + ch + R if ch in MAP else ch for ch in line))
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
