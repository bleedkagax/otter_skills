# Quiz Generation Stages (3 Difficulty Tiers)

Quiz questions are generated from flashcard content using three difficulty tiers, distributed as:
- **Stage 1 (Easy)**: 50% -- Terms and Methods
- **Stage 2 (Medium)**: 30% -- Reasons and Logic
- **Stage 3 (Hard)**: 20% -- Solvable Applications

---

## Stage 1: Terms and Methods (Easy - 50%)

### Task
Generate multiple-choice quiz questions focusing on foundational knowledge capture: precise terms, definitions, symbols, and concise procedures/methods. Avoid extended causal reasoning or full application problems.

### Requirements
- Produce EXACTLY [CARD_COUNT] questions.
- **Prioritize source material language**
- Backup system language: [LANGUAGE].
- Each question must be fully self-contained; include all symbols/constraints.
- Prefer symbolic variables over arbitrary constants unless the source fixes values.
- DO NOT leak instructions; output JSON only per schema.

### Output JSON Schema
```json
{
  "quiz": [
    { "question": "...", "options": ["...","...","...","..."], "answer_index": 0, "explanation": "..." }
  ]
}
```

### Content Focus -- Terms and Methods
- Ask for precise meanings, laws, symbols, or named principles ("What").
- Ask for summarized steps/algorithms or standard procedures ("How").
- Explanations end with a short micro-example that demonstrates the concept or steps.
- Do NOT include long causal chains or multi-step numeric applications.

### Quality and Constraints
1. No duplicates across questions; each targets a distinct atom of content.
2. Options: exactly 4, balanced length, one correct answer only, keep only the content, no option number required.
3. Math uses LaTeX ($...$); variables/units explicit.
4. Explanation <= 50 words, explains WHY the answer is correct.
5. Do not include images, links, or URLs; text-only content that renders in plain text.

Only return valid JSON as per schema, nothing else.

---

## Stage 2: Reasons and Logic (Medium - 30%)

### Task
Generate multiple-choice quiz questions emphasizing causal explanations and logical chains that justify principles or procedures from the source material.

### Requirements
- Produce EXACTLY [CARD_COUNT] questions.
- **Prioritize source material language**
- Backup system language: [LANGUAGE].
- Each question must explicitly ask for reasons/causes or justification; state assumptions/conditions.
- Include a brief scenario or numeric micro-example that demonstrates the reasoning step.
- DO NOT leak instructions; output JSON only per schema.

### Output JSON Schema
```json
{
  "quiz": [
    { "question": "...", "options": ["...","...","...","..."], "answer_index": 0, "explanation": "..." }
  ]
}
```

### Guidance -- Focus on Reasons/Logic
- Ask why the concept/theorem/method works under the stated conditions.
- Answers must follow a short, clear logical chain.
- End with: Example: ... giving a concise scenario or small numbers grounding the reason.

### Quality and Constraints
1. No duplicates; target distinct rationales.
2. Options: exactly 4, balanced length, one correct answer only, keep only the content, no option number required.
3. Explanation <= 50 words, focuses on cause-effect logic.
4. Math uses LaTeX if applicable; assumptions explicit.
5. Do not include images, links, or URLs; ensure text-only content displayable in plain text.

Only return valid JSON as per schema, nothing else.

---

## Stage 3: Solvable Applications (Hard - 20%)

### Task
Generate multiple-choice quiz questions emphasizing realistic, fully specified application problems whose conclusions are derivable from the given information.

### Requirements
- Produce EXACTLY [CARD_COUNT] questions.
- **Prioritize source material language**
- Backup system language: [LANGUAGE].
- Each item must be a complete application problem with all givens, units, and boundary conditions; the final conclusion must be solvable.
- Avoid restating pure definitions or reasons; focus on carrying out calculations/steps to a result.
- DO NOT leak instructions; output JSON only per schema.

### Output JSON Schema
```json
{
  "quiz": [
    { "question": "...", "options": ["...","...","...","..."], "answer_index": 0, "explanation": "..." }
  ]
}
```

### Guidance -- Focus on Solvable Applications
- Present realistic or textbook-style tasks drawn from the source content.
- Include every given value, unit, and boundary condition.
- The explanation briefly outlines the solution path and states the result basis.

### Quality and Constraints
1. No duplicates; each problem scenario must be unique.
2. Options: exactly 4, balanced length, one correct answer only, keep only the content, no option number required.
3. Explanation <= 50 words, concise solution rationale.
4. Use LaTeX for math; ensure units and variable names are explicit.
5. Do not include images, links, or URLs; text-only content suitable for plain text rendering.

Only return valid JSON as per schema, nothing else.
