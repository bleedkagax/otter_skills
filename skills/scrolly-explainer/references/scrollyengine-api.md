# ScrollyEngine API Reference

The `ScrollyEngine` class is auto-injected. You ONLY call `new ScrollyEngine({...})`.
Here are the **REAL APIs** you can use:

## Constructor

```javascript
const engine = new ScrollyEngine({
    steps: steps,           // Required: your steps array
    drawFn: drawScene,      // Required: your draw function
    onInteractive: fn       // Optional: called when reaching isInteractive step
});
```

## Available Properties (Read/Write in onInteractive)

```javascript
engine.targetState      // Object: Modify this to update animation params in real-time
engine.currentState     // Object: Current interpolated state (read-only recommended)
engine.currentIndex     // Number: Current step index (read-only)
engine.isAutoPlaying    // Boolean: Whether auto-play is active (read-only)
```

## Available Methods

```javascript
engine.stopAutoPlay()   // Stop auto-play
engine.startAutoPlay()  // Restart auto-play
engine.scrollToIndex(i) // Jump to step i
```

## NON-EXISTENT APIs (DO NOT USE!)

```javascript
engine.onStepChange()   // DOES NOT EXIST - will cause error!
engine.setParam()       // DOES NOT EXIST
engine.goToStep()       // Use scrollToIndex() instead
```

## Step Object Structure

```javascript
{
    id: Number,
    title: String,
    content: String,       // HTML, can include MathJax: \\( formula \\)
    params: Object,        // Numeric values are auto-interpolated (lerped)
    isInteractive: Boolean // Optional: marks interactive step (usually last)
}
```

## drawScene Signature

```javascript
function drawScene(ctx, state, width, height, progress) {
    // ctx: CanvasRenderingContext2D
    // state: Current interpolated params (numbers are smoothly lerped)
    // width, height: Canvas dimensions
    // progress: 0.0-1.0 scroll progress within current step
}
```

## onInteractive Example (CORRECT USAGE)

```javascript
// This function is called ONCE when user reaches the interactive step.
// NO need to check which step - it only triggers on isInteractive: true steps.
function onInteractive(engine) {
    // 1. Show controls (if hidden by default)
    const controls = document.getElementById('my-controls');
    if (controls) controls.classList.remove('hidden');

    // 2. Bind slider/input events
    const slider = document.getElementById('my-slider');
    if (slider) {
        slider.oninput = (e) => {
            // Directly modify targetState to update animation
            engine.targetState.myParam = parseFloat(e.target.value);
        };
    }
}
```
