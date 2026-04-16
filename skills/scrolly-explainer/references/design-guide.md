# Scrollytelling Design Guide

## Creativity Tips

1. **Visual Metaphors**: Don't just draw shapes — tell a story (e.g., "water flowing" instead of "rectangle filling")
2. **Parameter Choreography**: Use smooth transitions like `{ opacity: 0 }` -> `{ opacity: 1 }`
3. **Interactive Control Layout**:
   - **Position**: EMBED CONTROLS DIRECTLY INSIDE THE LAST STEP'S `content` HTML.
   - **No Overlays**: DO NOT create a separate `<div id="controls" class="absolute ...">`. This blocks the view.
   - **Integration**: The slider/buttons should be part of the narrative text in the scrollable sidebar.
   - **Styling**: Use standard Tailwind classes (e.g., `w-full h-2 bg-slate-200 rounded-lg`).
4. **Canvas Safety**:
   - **Padding**: Keep all visual elements at least **40px** away from canvas edges.
   - **Dynamic Scale**: Calculate `scale` based on `width` and `height` (e.g., `Math.min(width, height) / 20`) instead of hardcoding pixels.
   - **Origin**: Center your coordinate system (`width/2`, `height/2`) properly.

---

## Topic Types and Presentation Modes

| Topic Type | Presentation Mode | Key Approach |
|---|---|---|
| Calculation / arithmetic | Step-by-step walkthrough | Animate operands, operators, show result |
| Concept explanation | Progressive reveal | Build up diagram/scene across steps |
| Proof / derivation | Formal step animation | Each step adds a line of reasoning |
| Process / algorithm | Flowchart animation | Highlight current stage, show data flow |
| Comparison | Side-by-side reveal | Parallel canvas regions, sync transitions |
| Timeline / history | Chronological scroll | Left-to-right or top-to-bottom progression |

---

## Few-Shot Example: "2+3=?"

Below is a **complete, minimal example**. Notice:
- Total ~180 lines
- NO `class ScrollyEngine` definition
- Jumps directly to `new ScrollyEngine({...})`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2+3=?</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        window.MathJax = {
            tex: { inlineMath: [['$', '$'], ['\\(', '\\)']] },
            svg: { fontCache: 'global' }
        };
    </script>
    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
</head>
<body class="h-screen overflow-hidden bg-gradient-to-br from-blue-50 to-indigo-100">
    <div class="flex h-full">
        <div id="step-container" class="h-full overflow-y-auto p-6 bg-white shadow-2xl"
             style="width: 33.33%; flex-shrink: 0; padding-top: 40vh; padding-bottom: 40vh;"></div>
        <div class="h-full relative flex items-center justify-center" style="width: 66.67%;">
            <canvas id="vis-canvas"></canvas>
            <button id="autoplay-btn" class="absolute bottom-8 left-8 px-6 py-3 bg-indigo-600 text-white font-bold rounded-full shadow-xl">Pause Auto-play</button>
        </div>
    </div>
    <script>
        const steps = [
            {
                id: 0,
                title: "Problem",
                content: `<p>Calculate <strong class="text-indigo-600">2 + 3</strong> = ?</p>`,
                params: { leftCount: 2, rightCount: 0, showResult: false }
            },
            {
                id: 1,
                title: "First Number",
                content: `<p>First, we have <mark class="bg-yellow-200">2</mark> apples.</p>`,
                params: { leftCount: 2, rightCount: 0, showResult: false }
            },
            {
                id: 2,
                title: "Second Number",
                content: `<p>Then, we add <mark class="bg-green-200">3</mark> more apples.</p>`,
                params: { leftCount: 2, rightCount: 3, showResult: false }
            },
            {
                id: 3,
                title: "Result",
                content: `<p>Count them all: <strong class="text-2xl text-indigo-600">5</strong> apples!</p><p>Formula: $ 2 + 3 = 5 $ or $ \\frac{10}{2} = 5 $</p>`,
                params: { leftCount: 2, rightCount: 3, showResult: true }
            },
            {
                id: 4,
                title: "Interactive Playground",
                content: `
                    <p>Try it yourself! Drag the slider:</p>
                    <div class="my-4 bg-slate-100 p-4 rounded-lg border border-slate-300">
                        <label class="block text-sm font-bold mb-2">Red Apples: <span id="val-disp">2</span></label>
                        <input type="range" id="my-slider" min="1" max="5" value="2" class="w-full accent-red-500">
                    </div>
                `,
                params: { leftCount: 2, rightCount: 3, showResult: true },
                isInteractive: true
            }
        ];

        function drawScene(ctx, state, width, height) {
            ctx.clearRect(0, 0, width, height);
            const cx = width / 2, cy = height / 2;
            const r = 30, gap = 80;

            // Draw left apples (red)
            const left = Math.round(state.leftCount);
            for (let i = 0; i < left; i++) {
                ctx.beginPath();
                ctx.arc(cx - 100 + i * gap, cy - 50, r, 0, Math.PI * 2);
                ctx.fillStyle = '#ef4444';
                ctx.fill();
            }

            // Draw right apples (green)
            const right = Math.round(state.rightCount);
            for (let i = 0; i < right; i++) {
                ctx.beginPath();
                ctx.arc(cx - 100 + i * gap, cy + 50, r, 0, Math.PI * 2);
                ctx.fillStyle = '#22c55e';
                ctx.fill();
            }

            // Show result
            if (state.showResult) {
                ctx.font = 'bold 48px sans-serif';
                ctx.fillStyle = '#4f46e5';
                ctx.textAlign = 'center';
                ctx.fillText(`= ${left + right}`, cx, cy + 140);
            }
        }

        function onInteractive(engine) {
            const slider = document.getElementById('my-slider');
            const disp = document.getElementById('val-disp');
            if (slider) {
                slider.oninput = (e) => {
                    const val = parseInt(e.target.value);
                    engine.targetState.leftCount = val;
                    if (disp) disp.innerText = val;
                };
            }
        }

        const engine = new ScrollyEngine({
            steps,
            drawFn: drawScene,
            onInteractive: onInteractive
        });
    </script>
</body>
</html>
```
