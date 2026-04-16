# Output Schemas

JSON schemas for flashcard and quiz output. These schemas enforce structure, field lengths, and exact card counts.

---

## Flashcard Schema

```json
{
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "subject": {
      "type": "string",
      "minLength": 1,
      "maxLength": 50,
      "description": "Title of the card set. Maximum 2 words."
    },
    "cards": {
      "type": "array",
      "minItems": "[CARD_COUNT]",
      "maxItems": "[CARD_COUNT]",
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "front": {
            "type": "string",
            "minLength": 1,
            "maxLength": 40,
            "description": "Front face content. Maximum 20 words."
          },
          "back": {
            "type": "string",
            "minLength": 1,
            "maxLength": 100,
            "description": "Back face explanation. Maximum 30 words."
          }
        },
        "required": ["front", "back"]
      }
    }
  },
  "required": ["subject", "cards"]
}
```

### Flashcard Output Example

```json
{
  "subject": "Physics",
  "cards": [
    {
      "front": "What is Ohm's Law?",
      "back": "A law stating that current is directly proportional to voltage and inversely proportional to resistance."
    },
    {
      "front": "Compare voltage and current.",
      "back": "Voltage ($V$) is the potential difference driving charge flow. Current ($I$) is the rate of charge flow itself."
    }
  ]
}
```

---

## Quiz Schema (Anti-Hallucination Field Ordering)

Quiz output uses alphabetically prefixed field names (`a_`, `b_`, `c_`, `d_`) to enforce a specific generation order. This is an anti-hallucination technique:

1. `a_question` -- Generated FIRST so the model understands the requirement
2. `b_options` -- Created SECOND with the correct answer included
3. `c_explanation` -- Written THIRD to analyze the correct choice
4. `d_answer_index` -- Set LAST based on the correct answer's position

By forcing this order, the model computes the answer and explanation BEFORE committing to the answer index, reducing the chance of hallucinated or inconsistent answers.

### Internal Schema (used during generation)

```json
{
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "quiz": {
      "type": "array",
      "minItems": "[CARD_COUNT]",
      "maxItems": "[CARD_COUNT]",
      "items": {
        "type": "object",
        "additionalProperties": false,
        "properties": {
          "a_question": {
            "type": "string",
            "minLength": 1,
            "maxLength": 40,
            "description": "Quiz question stem. Maximum 30 words."
          },
          "b_options": {
            "type": "array",
            "minItems": 4,
            "maxItems": 4,
            "items": {
              "type": "string",
              "minLength": 1,
              "maxLength": 100
            },
            "description": "Exactly 4 options, one correct."
          },
          "c_explanation": {
            "type": "string",
            "minLength": 1,
            "maxLength": 100,
            "description": "Why the answer is correct. Maximum 50 words."
          },
          "d_answer_index": {
            "type": "integer",
            "minimum": 0,
            "maximum": 3,
            "description": "Index of the correct option (0-3)."
          }
        },
        "required": ["a_question", "b_options", "c_explanation", "d_answer_index"]
      }
    }
  },
  "required": ["quiz"]
}
```

### Client-Facing Schema (after conversion)

The internal prefixed fields are stripped before returning to the client:

```json
{
  "quiz": [
    {
      "question": "Given $P(-2,1)$ and $Q(4,6)$, find vector $\\vec{PQ}$",
      "options": [
        "$(6, 5)$",
        "$(2, 7)$",
        "$(6, 7)$",
        "$(-6, -5)$"
      ],
      "answer_index": 0,
      "explanation": "$\\vec{PQ} = Q - P = (4-(-2), 6-1) = (6, 5)$"
    }
  ]
}
```

### Field Mapping

| Internal (generation) | Client (output) |
|----------------------|-----------------|
| `a_question`         | `question`      |
| `b_options`          | `options`       |
| `c_explanation`      | `explanation`   |
| `d_answer_index`     | `answer_index`  |

---

## Quiz Base Template

Transform flashcards into reliable, unambiguous multiple-choice questions. Guarantee exactly one correct option.

### Task
Generate exactly [CARD_COUNT] multiple-choice questions based on the flashcards provided.
Use only information derivable from each flashcard (for STEM you may vary numbers but must re-compute the result correctly).

### Core Rules (Strict)
1. **One-to-One Mapping**: Generate EXACTLY as many quiz questions as input flashcards
2. **Language Consistency**: Use exact same language as source flashcard
3. **Math Notation**: Use LaTeX -- inline `$...$`, block `$$...$$`
4. **Answer Position**: Randomize (0-3) to avoid patterns within the batch
5. **Single Correct Answer** (non-negotiable):
   - Exactly one option must be entirely correct
   - `d_answer_index` must point to that option
   - If multiple or zero options are correct, REVISE and recheck before output
6. **Complete Context**: Questions must be 100% self-contained
7. **Option Uniqueness**: Options must be mutually exclusive; no "All/None of the above"
8. **Computation Discipline (STEM)**: Compute the correct answer first, then design distractors from realistic mistakes

### Distractor Design
Make wrong answers educational:
1. **Common Misconceptions** - Typical student errors
2. **Near Misses** - Almost correct, missing key detail
3. **Domain Confusion** - Correct for different context
4. **Computational Errors** - Result of typical mistakes

### Self-Check Before Output
For every generated item, silently verify:
- Exactly 4 options; unique and not equivalent
- `d_answer_index` in {0,1,2,3} and the referenced option is fully correct
- Others are strictly incorrect
- Language matches the flashcard
- For STEM: recompute result; if a quick substitution/back-check exists, it succeeds
