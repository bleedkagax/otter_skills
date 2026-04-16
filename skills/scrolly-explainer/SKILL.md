---
name: scrolly-explainer
description: Generate interactive scrollytelling HTML explanations using Canvas animations. Use when the user asks to "explain this visually", "interactive explanation", "scrollytelling", "visualize this concept", "animated walkthrough", "teach this interactively", or any request to create an interactive visual explanation of a concept, algorithm, math problem, or process. Produces a self-contained HTML file with scroll-driven navigation, Canvas visualizations, and optional interactive controls.
---

# Scrolly Explainer

Generate interactive HTML pages that explain concepts through scrollytelling — scroll-driven narrative paired with Canvas animations. Uses the ScrollyEngine micro-framework (powered by Scrollama for scroll detection).

The user scrolls (or auto-play advances) through step cards on the left panel. Each step drives parameter changes that the Canvas visualization on the right panel animates smoothly via lerp interpolation.

## Workflow

1. User provides a topic or concept to explain (text description, math problem, algorithm, process)
2. Determine output language from user request; if not specified, auto-detect from the topic; default to English
3. Read `references/prompt-template.md` for the generation rules and output template
4. Read `references/scrollyengine-api.md` for the ScrollyEngine API reference
5. Optionally read `references/design-guide.md` for creativity tips and examples
6. Generate the complete HTML following the strict template pattern:
   - Define a `steps` array with educational content and params
   - Write a `drawScene(ctx, state, width, height, progress)` function for Canvas visualization
   - Call `new ScrollyEngine({ steps, drawFn: drawScene, onInteractive })`
   - NEVER write `class ScrollyEngine` — it is auto-injected
   - Make the last step interactive (`isInteractive: true`) with embedded controls
   - Target ~200-350 lines total
7. Write the HTML to a `.html` file (e.g., `explanation.html`)
8. Run injection to embed the framework:
   ```bash
   bash {baseDir}/scripts/inject.sh explanation.html
   ```
9. Open in browser:
   ```bash
   open explanation.html
   ```

## Critical Rules

- Output ONLY raw HTML starting with `<!DOCTYPE html>` — no explanatory text before it
- NEVER write `class ScrollyEngine`, `requestAnimationFrame`, animation loops, or DOM creation for steps — the framework handles all of these
- Include MathJax config in `<head>` for any math content (use `$` delimiters with DOUBLE backslashes)
- Use Tailwind CSS via CDN (`<script src="https://cdn.tailwindcss.com"></script>`) for styling
- Embed interactive controls (sliders, buttons) directly inside the last step's `content` HTML — NO separate overlay divs
- Canvas safety: 40px padding from edges, dynamic scale via `Math.min(width, height)`, centered origin at `width/2, height/2`
- If the topic has multiple sub-questions, create steps for EVERY sub-question

## Architecture

| AI Writes | Framework Handles (Auto-Injected) |
|-----------|-----------------------------------|
| `steps` array | Animation loop (`requestAnimationFrame`) |
| `drawScene()` function | State interpolation (lerp between params) |
| HTML structure (head, body, panels) | DOM generation for step cards |
| `new ScrollyEngine({...})` call | Auto-play timers and scheduling |
| Interactive hooks (`onInteractive`) | Scroll detection (via Scrollama) |
| | Step highlight management |
| | Canvas resize handling |
| | MathJax re-typesetting |

## Rendering

After generating the HTML file, inject the framework:

```bash
bash {baseDir}/scripts/inject.sh <file.html>
```

This script:
- Detects `new ScrollyEngine` usage in the HTML
- Renames any AI-generated `class ScrollyEngine` to prevent conflicts
- Injects Scrollama.js and ScrollyEngine framework into the inline `<script>` tag
- Falls back to injecting before `</body>` if no suitable insertion point is found

## Known Limitations

- Requires internet connection (Tailwind CDN, MathJax CDN)
- Canvas-only visualization (no SVG or D3 — all drawing through CanvasRenderingContext2D)
- Best suited for conceptual explanations, step-by-step processes, math topics, and algorithm walkthroughs
- Auto-play timing is heuristic-based on content length (3-5 seconds per step)

## References

- `references/prompt-template.md` — Generation rules and output template
- `references/scrollyengine-api.md` — Complete ScrollyEngine API reference
- `references/design-guide.md` — Design tips, topic-type mapping, and few-shot example
