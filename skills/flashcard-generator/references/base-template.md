# Base Generation Template

This template is the outer wrapper for each substage generation call. Replace the placeholders before use:
- `[CARD_COUNT]` -- number of cards to generate for this substage
- `[LANGUAGE]` -- target language (e.g., "english", "chinese")
- `[SUBSTAGE_PROMPT]` -- the substage-specific prompt from stem-substages.md or humanities-substages.md

---

## STEM Base Template

```
# Flashcard Generator

Generate exactly [CARD_COUNT] flashcards from the provided material.

## Core Rules

1. **Language**:
Use [LANGUAGE].

2. **Output Format**:
{
  "subject": "...",
  "cards": [
    {
      "front": "...",
      "back": "..."
    }
  ]
}

3. **Field Length Requirements**:
- `subject`: Maximum 2 words (e.g., "Vector Algebra", "Physics")
- `front`: Maximum 20 words per card
- `back`: Maximum 30 words per card

4. **Anti-Duplication Quality Control**:
**CRITICAL**: Every card must cover a distinct knowledge point; remove near-duplicates before returning the result.

5. **Mathematical Formatting**: Format math in LaTeX.
   Use `$...$` for inline math; use `$$...$$` for block (display) math.
   Examples: $E=mc^2$, $$\int f(x)dx$$, $f(x)=\ln x-ax$

[SUBSTAGE_PROMPT]
```

---

## Humanities Base Template

```
# Flashcard Generator

Generate exactly [CARD_COUNT] flashcards from the provided material.

## Core Rules

1. **Language**:
Use [LANGUAGE].
2. **Output Format**:
{
  "subject": "...",
  "cards": [
    {
      "front": "...",
      "back": "..."
    }
  ]
}

**Field Length Requirements**:
- `subject`: Maximum 2 words (e.g., "Economics")
- `front`: Maximum 20 words per card
- `back`: Maximum 30 words per card
4. **No Duplicates**: Every card must cover distinct content; remove near-duplicates before returning the result.

[SUBSTAGE_PROMPT]
Please Use [LANGUAGE].
```

---

## Usage

To generate cards for a specific substage:

1. Choose the appropriate base template (STEM or Humanities)
2. Replace `[CARD_COUNT]` with the number of cards allocated to this substage
3. Replace `[LANGUAGE]` with the detected language
4. Replace `[SUBSTAGE_PROMPT]` with the full substage prompt text
5. Send the assembled prompt as the system message, with user content as the user message
