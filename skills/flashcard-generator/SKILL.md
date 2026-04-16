---
name: flashcard-generator
description: Generate educational flashcards using cognitive-layer decomposition. Use when the user asks to "generate flashcards", "make study cards", "create quiz cards", "flashcard from image", "study material", or any request to create flashcards from text, images, or topics. Produces structured JSON flashcards with 5 cognitive layers (STEM) or 5 linguistic layers (Humanities), plus optional quiz generation.
---

# Flashcard Generator

Generate structured educational flashcards using a 5-substage cognitive decomposition strategy. Each substage targets a distinct cognitive or linguistic level, producing mutually exclusive cards that together cover the topic comprehensively.

## Overview

This skill decomposes flashcard generation into 5 specialized substages rather than generating all cards in a single pass. This approach:

- Ensures coverage across multiple cognitive levels (definition, comparison, mechanism, relationship, application)
- Prevents duplicate or overlapping content through strict substage boundaries
- Produces higher-quality cards by constraining each generation to a focused question type
- Adapts to STEM vs Humanities content with different substage strategies

```
Input Text/Topic
       |
       v
+------------------+
| 1. Classify      |  STEM (1) or Humanities (0)
| 2. Detect lang   |  english, chinese, etc.
+------------------+
       |
       v
+------------------+
| 3. Split counts  |  Distribute cards across 5 substages
+------------------+
       |
       v
+------+------+------+------+------+
| SS1  | SS2  | SS3  | SS4  | SS5  |   Generate per-substage
+------+------+------+------+------+
       |
       v
+------------------+
| 4. Merge & dedup |  Combine all cards
+------------------+
       |
       v
  JSON output
```

## Workflow

### Step 1: Classify Input

Determine whether the content is STEM or Humanities using the classification criteria in `references/classifiers.md`.

- STEM (1): math, physics, chemistry, biology, engineering, CS, medicine
- Humanities (0): language, literature, history, philosophy, arts, social sciences

If unclear, default to STEM for technical/quantitative content and Humanities for language/vocabulary content.

### Step 2: Detect Language

Detect the primary language of the input:
- English input -> `english`
- Chinese input -> `chinese`
- Mixed -> use the dominant language
- Default: `english`

### Step 3: Determine Card Count and Distribution

Default total: 10 cards. Then distribute across 5 substages:

**STEM distribution** (equal):
Each substage gets `total / 5` cards, with remainder distributed round-robin starting from substage 1.

Example for 10 cards: [2, 2, 2, 2, 2]

**Humanities distribution** (weighted [30%, 20%, 30%, 5%, 15%]):

| Substage | Name                | Weight |
|----------|---------------------|--------|
| 1        | Single-Chunk Nouns  | 30%    |
| 2        | Single-Chunk Descriptors | 20% |
| 3        | Single-Chunk Actions | 30%   |
| 4        | Single-Chunk Functions | 5%   |
| 5        | Comprehensive Expressions | 15% |

Example for 10 cards: [3, 2, 3, 1, 1] (minimum 1 per substage)

### Step 4: Generate Cards Per Substage

For each substage with count > 0:

1. Read `references/base-template.md` for the generation wrapper
2. Choose the correct base template (STEM or Humanities)
3. Fill in placeholders:
   - `[CARD_COUNT]` -> number of cards for this substage
   - `[LANGUAGE]` -> detected language
   - `[SUBSTAGE_PROMPT]` -> full prompt from `references/stem-substages.md` or `references/humanities-substages.md` for the corresponding substage number
4. Generate cards using the assembled prompt

**STEM Substages** (see `references/stem-substages.md`):
1. **What is it?** -- Core definitions, single-sentence answers
2. **What is it like/unlike?** -- Comparison and contrast between concepts
3. **Why does it work?** -- Internal mechanisms and causal explanations
4. **How does it work?** -- Variable relationships and step-by-step processes
5. **Applied Exercise** -- Numeric calculations or applied scenarios

**Humanities Substages** (see `references/humanities-substages.md`):
1. **Single-Chunk Nouns** -- Academic and literary noun vocabulary
2. **Single-Chunk Descriptors** -- Adjectives and adverbs
3. **Single-Chunk Actions** -- Verbs for academic discourse
4. **Single-Chunk Functions** -- Sophisticated grammatical elements (NOT basic function words)
5. **Comprehensive Expressions** -- Multi-word phrases, idioms, collocations

### Step 5: Merge and Deduplicate

Combine all substage results into a single card array. Remove near-duplicates. Truncate to the target count if the total exceeds the request.

### Step 6: Output

**Default: HTML page** — Generate a self-contained HTML file using the template in `references/page-template.md`:
1. Read the HTML skeleton from `references/page-template.md`
2. Fill `const cards = [...]` with the generated flashcard data (include `substage` and `label` fields)
3. Fill `const quizItems = [...]` with quiz data (if generated)
4. Replace `[TOPIC]` in `<title>` and `<h1>` with the actual topic
5. For Humanities, update `ssColors` labels (Nouns, Descriptors, Actions, Functions, Expressions)
6. Write to a `.html` file and open in browser: `open flashcards.html`

The page includes:
- **Card mode**: Flip animation (click/Space), arrow key navigation, progress bar
- **Quiz mode**: Multiple choice with instant feedback and explanations
- **Grid mode**: All cards at a glance, click to reveal answer
- **Substage filters**: Color-coded tabs to view cards by cognitive level
- MathJax for LaTeX rendering, Tailwind CSS for styling

**Alternative: JSON output** — If the user explicitly requests JSON, return:

```json
{
  "subject": "Physics",
  "cards": [
    {
      "front": "What is Ohm's Law?",
      "back": "V = IR; voltage equals current times resistance.",
      "substage": 1,
      "label": "Definition"
    }
  ]
}
```

## Quiz Generation (Optional)

If the user also wants quiz questions, generate them from the flashcards using `references/quiz-stages.md` and the quiz base template in `references/output-schema.md`.

### Quiz Workflow

1. Take the generated flashcards as input
2. Detect card type: if >= 50% of the first 5 cards match a vocabulary pattern (word + /pronunciation/), use Humanities quiz mode; otherwise use STEM quiz mode
3. Distribute quiz questions across 3 difficulty tiers:
   - **Stage 1 (Easy, 50%)**: Terms and Methods -- precise definitions, symbols, procedures
   - **Stage 2 (Medium, 30%)**: Reasons and Logic -- causal explanations, logical chains
   - **Stage 3 (Hard, 20%)**: Solvable Applications -- realistic problems with full givens
4. Generate quiz questions per stage using the prompts in `references/quiz-stages.md`
5. Use anti-hallucination field ordering: `a_question`, `b_options`, `c_explanation`, `d_answer_index`

### Anti-Hallucination Field Ordering

Quiz fields use alphabetical prefixes to force a specific generation order:

```
a_question       -->  Generated FIRST (understand requirements)
b_options         -->  Created SECOND (with correct answer)
c_explanation     -->  Written THIRD (analyze correctness)
d_answer_index    -->  Set LAST (based on correct answer position)
```

This ensures the model computes the answer and justification BEFORE committing to the index, reducing hallucinated answers. The prefixes are stripped in the final output.

### Quiz Output Format

```json
{
  "quiz": [
    {
      "question": "Given $P(-2,1)$ and $Q(4,6)$, find vector $\\vec{PQ}$",
      "options": ["$(6, 5)$", "$(2, 7)$", "$(6, 7)$", "$(-6, -5)$"],
      "answer_index": 0,
      "explanation": "$\\vec{PQ} = Q - P = (4-(-2), 6-1) = (6, 5)$"
    }
  ]
}
```

## Key Techniques

### Cognitive Decomposition
Rather than asking "generate 10 flashcards", the system generates 2 cards at each of 5 cognitive levels. This mirrors Bloom's taxonomy progression from recall to application.

### Mutual Exclusivity
Each substage has strict content boundaries and forbidden words/patterns that prevent overlap with other substages. For example, Substage 1 (definitions) forbids comparison words like "vs" and "different", which are required by Substage 2 (comparisons).

### Weighted Distribution (Humanities)
Vocabulary learning research shows nouns and verbs are most impactful, so they receive 30% each. Function words are rare in typical study material, receiving only 5%.

### Anti-Hallucination Field Ordering (Quiz)
By naming quiz fields with alphabetical prefixes (`a_`, `b_`, `c_`, `d_`), JSON serialization order forces the model to generate the question and options before deciding on the answer index.

## Known Limitations

- **No image input in skill context**: The original system supports image-to-flashcard; in the Claude Code skill context, only text input is available
- **No parallel generation**: The original backend runs all 5 substages concurrently via goroutines; in skill context, substages are generated sequentially
- **No model routing**: The original system routes between Gemini, Doubao, and other models based on region; in skill context, the active Claude model handles all generation

## References

- `references/stem-substages.md` -- All 5 STEM cognitive substage prompts
- `references/humanities-substages.md` -- All 5 Humanities linguistic substage prompts
- `references/quiz-stages.md` -- 3 quiz difficulty tier prompts
- `references/classifiers.md` -- Content validity, language detection, subject classification
- `references/base-template.md` -- Generation wrapper templates for STEM and Humanities
- `references/output-schema.md` -- JSON schemas for flashcard and quiz output
- `references/page-template.md` -- HTML page template with flip cards, quiz mode, and grid view
