Generate educational flashcards for the given topic and render as an interactive HTML page.

$ARGUMENTS

## Instructions

1. Classify the topic: STEM or Humanities
   - Read `references/classifiers.md` for classification criteria
   - STEM: math, physics, chemistry, biology, engineering, CS, medicine
   - Humanities: language, literature, history, philosophy, arts, social sciences
2. Detect the language from the input (default: English)
3. Determine card count (default: 10) and split across 5 substages
   - STEM: equal distribution
   - Humanities: weighted [30%, 20%, 30%, 5%, 15%]
4. Read `references/base-template.md` for the generation template
5. Read the appropriate substage reference (stem or humanities)
6. For each substage, fill in `[CARD_COUNT]`, `[LANGUAGE]`, `[SUBSTAGE_PROMPT]` and generate cards
7. Merge results, remove duplicates, truncate to target count
8. Generate quiz questions using `references/quiz-stages.md` (3 tiers: Easy 50%, Medium 30%, Hard 20%)
9. Read `references/page-template.md` for the HTML skeleton
10. Generate a complete HTML file:
    - Fill `const cards = [...]` with card data (include `front`, `back`, `substage`, `label`)
    - Fill `const quizItems = [...]` with quiz data
    - Replace `[TOPIC]` with the actual topic
    - For Humanities, update `ssColors` labels
11. Write to `flashcards.html` and open in browser: `open flashcards.html`

## Features

The generated page includes:
- **Card mode**: Flip animation (click/Space), arrow keys, progress bar
- **Quiz mode**: Multiple choice with instant feedback
- **Grid mode**: All cards at a glance, click to reveal
- **Substage filters**: Color-coded cognitive level tabs
- MathJax for math, Tailwind CSS for styling

## JSON Alternative

If the user says "output as JSON" or "just the data", skip the HTML and output:
```json
{
  "subject": "...",
  "cards": [{ "front": "...", "back": "...", "substage": 1, "label": "Definition" }],
  "quiz": [{ "question": "...", "options": [...], "answer_index": 0, "explanation": "..." }]
}
```
