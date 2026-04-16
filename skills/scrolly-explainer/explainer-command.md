Generate an interactive scrollytelling HTML explanation for the given topic.

$ARGUMENTS

## Instructions

1. Read `references/prompt-template.md` for generation rules and the output template
2. Read `references/scrollyengine-api.md` for the ScrollyEngine API
3. Optionally read `references/design-guide.md` for creativity tips and examples
4. Generate a complete HTML file following the scrollytelling template:
   - Define a `steps` array with educational content and visualization params
   - Write `drawScene(ctx, state, width, height, progress)` for Canvas visualization
   - Call `new ScrollyEngine({ steps, drawFn: drawScene, onInteractive })`
   - Make the last step interactive with sliders/controls embedded in its `content`
   - NEVER write `class ScrollyEngine` — the framework is auto-injected
5. Write the HTML to a file (e.g., `explanation.html`)
6. Inject the framework:
   ```bash
   bash {baseDir}/scripts/inject.sh explanation.html
   ```
7. Open in browser:
   ```bash
   open explanation.html
   ```

## Output

A self-contained HTML file with scroll-driven animated explanations.
