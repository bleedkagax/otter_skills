# STEM Substages (5 Cognitive Layers)

Each substage targets a distinct cognitive level. Cards from different substages MUST NOT overlap in content or question type. This mutual exclusivity prevents duplication and ensures comprehensive coverage.

---

## Substage 1: What is it? - Core Definitions

Identify and define the most fundamental concepts. Focus ONLY on pure conceptual definitions.

### Mandatory Sentence Patterns (EXACTLY these 3, NO variations):
1. `What is [concept]?` / `什么是[概念]？`
2. `Could you explain [term]?` / `能解释一下[术语]吗？`
3. `What does [concept] mean?` / `[概念]是什么意思？`

### Execution Constraints
- **ABSOLUTELY FORBIDDEN**: Any formulas (=, $, LaTeX), calculations, comparisons (vs, different), steps, processes
- **MANDATORY**: Each answer must be exactly 1 sentence defining the concept
- **QUALITY CHECK**: Before generating, verify EVERY card uses one of the 3 patterns above
- **EDUCATIONAL ELEVATION**: If input material is simple, elevate to meaningful related concepts that enhance understanding
- **AVOID TRIVIAL**: Skip overly obvious definitions; focus on concepts that genuinely teach something valuable

### Content Selection Strategy
- GENERATE: Technical terms, scientific principles, mathematical concepts from or related to the input
- GENERATE: Educational extensions that build conceptual foundation (e.g., for geometry problems, ask about area formulas, scaling properties)
- GENERATE: Underlying principles that explain why methods work
- SKIP: Meaningless definitions of common words ("What is smaller?", "What is a garden?")
- SKIP: Concepts completely unrelated to the educational context

### Content Boundaries
- ALLOWED: Basic concept definitions, scientific terms, units
- FORBIDDEN: How-to instructions, comparisons, formulas, examples, calculations

**WARNING: If you generate content that belongs to other substages, it will cause duplication failures.**

### Examples
- Mathematical constants and definitions
- Physical quantities and their meanings
- Chemical elements and basic properties
- Biological structures and functions
- Programming fundamentals
- Engineering principles

#### Example (Educational Elevation) - Geometry Problem

**Input**: "A square garden has a side length of 48 meters. (1) What is its area? (2) If the side length is reduced to 1/2, what is the area?"

**Output**:
```json
{
  "subject": "Mathematics",
  "cards": [
    {
      "front": "What is area?",
      "back": "Area is the size of a plane covered by a two-dimensional figure, usually measured in square units."
    },
    {
      "front": "What is proportional scaling?",
      "back": "Proportional scaling is a geometric transformation that changes the side lengths of a figure by a fixed ratio while preserving its shape."
    },
    {
      "front": "Could you explain the square relationship?",
      "back": "The square relationship means that when a quantity becomes k times its original, its square becomes k squared times, which is important in area calculations."
    }
  ]
}
```

#### Example (STEM) - Ohm's Law Series

**Input**: "Calculate the resistance using Ohm's Law: $V = 12V, I = 2A$"

**Output**:
```json
{
  "subject": "Physics",
  "cards": [
    {
      "front": "What is Ohm's Law?",
      "back": "A law stating that the electric current flowing through a conductor is directly proportional to the voltage across it and inversely proportional to the resistance."
    },
    {
      "front": "Could you explain electrical resistance?",
      "back": "The opposition to the flow of electric current through a conductor, measured in ohms ($\\Omega$)."
    }
  ]
}
```

Generate flashcards that establish solid conceptual foundations for STEM learning using the specified question patterns.

---

## Substage 2: What is it like/unlike? - Comparison and Contrast

Compare core concepts with other related or easily confused concepts. Focus on systematic comparison analysis between 2 or more objects.

### Core Question Types (Use these sentence patterns ONLY):
1. `Compare [A] and [B].` / `比较[A]与[B]。`
2. `How is [A] different from [B]?` / `[A]与[B]有何不同？`
3. `What are the similarities between [A] and [B]?` / `[A]与[B]有哪些相似之处？`

### Focus Areas
- **Comparative Analysis**: Side-by-side comparisons of concepts
- **Key Differences**: What distinguishes similar concepts
- **Similarities**: Common features and shared properties
- **Conceptual Relationships**: How ideas relate and differ

### Hard Constraints
- **REQUIRED**: Must contain comparison vocabulary (vs, unlike, similar, different)
- **FORBIDDEN**: Single concept definitions
- **REQUIRED**: Must involve 2 or more objects for comparison
- **REQUIRED WORDS**: compare, different, similar, unlike, vs
- **FORBIDDEN WORDS**: define, what is, mean

### Extraction Guidelines
- Use ONLY the 3 core question patterns above
- Highlight key distinguishing features between concepts
- Show both similarities and differences systematically
- Focus on commonly confused or related concepts
- Always involve multiple entities in comparison

### Examples
- Comparing different mathematical methods
- Contrasting scientific theories or models
- Different engineering approaches
- Alternative computational algorithms
- Comparative biological structures or processes
- Contrasting physical phenomena

#### Example (STEM) - Circuit Comparison

**Input**: "Compare series and parallel circuits in terms of current flow and voltage distribution"

**Output**:
```json
{
  "subject": "Physics",
  "cards": [
    {
      "front": "How is voltage different from current?",
      "back": "Voltage ($V$) is the potential difference that drives the flow of charge (like water pressure). Current ($I$) is the rate of flow of charge itself (like water flow rate)."
    },
    {
      "front": "How does resistance compare to conductance?",
      "back": "Resistance ($R$) opposes current flow, measured in ohms ($\\Omega$). Conductance ($G$) facilitates current flow and is the reciprocal of resistance: $G = \\frac{1}{R}$."
    }
  ]
}
```

Generate flashcards that develop comparative thinking and analytical skills using the specified question patterns.

---

## Substage 3: Why does it work? - Mechanism Principles

Explore internal mechanisms and driving forces. Focus ONLY on causal explanations of how things function internally.

### Mandatory Sentence Patterns (EXACTLY these 3, NO variations):
1. `Why does [phenomenon] work the way it does?` / `为什么[现象]会以这种方式发生？`
2. `What makes [process] possible?` / `要让[过程]发生，需要什么条件？`
3. `What causes [effect] to happen?` / `为什么会出现[效应]？`

### Execution Constraints
- **ABSOLUTELY FORBIDDEN**: Steps, calculations, conditions, applications, numerical values
- **MANDATORY**: 1-2 sentences explaining internal mechanism/driving force
- **QUALITY CHECK**: Every answer must start with "Because..." or "Due to..." or equivalent causal language

### Content Boundaries
- ALLOWED: Internal mechanisms, driving forces, causal explanations
- FORBIDDEN: Conditions ("when", "if"), steps ("first", "then"), calculations, comparisons

**WARNING: This substage is ONLY about WHY things work internally, not HOW to use them or WHEN they apply.**

#### Example (STEM) - Ohm's Law Series

**Input**: "Apply ideal gas law: $PV = nRT$ to calculate pressure"

**Output**:
```json
{
  "subject": "Physics",
  "cards": [
    {
      "front": "Why does Ohm's Law work the way it does?",
      "back": "Because electron collision rates remain constant in ohmic materials, creating a linear voltage-current relationship."
    },
    {
      "front": "What makes electric current flow possible?",
      "back": "Voltage creates an electric field that provides the driving force, enabling charge carriers to move through conductors."
    }
  ]
}
```

Generate flashcards that develop deep understanding of scientific principles and their limitations using the specified question patterns.

---

## Substage 4: How does it work? - Relational Derivations

Describe how changing one variable in a formula affects others. Focus on cause-and-effect relationships and proportional changes using "ceteris paribus" reasoning.

### Core Question Types (Use these sentence patterns ONLY):
1. `If [variable A] increases, what happens to [variable B]?` / `若[变量A]增加，[变量B]会怎样？`
2. `How does changing [parameter] affect [outcome]?` / `改变[参数]如何影响[结果]？`
3. `What is the step-by-step process for [procedure]?` / `执行[流程]的逐步过程是什么？`

### Focus Areas
- **Variable Relationships**: How changes in one variable affect others
- **Proportional Changes**: Direct and inverse proportionality
- **Process Steps**: Sequential procedures and workflows
- **Mathematical Dependencies**: How variables interact in formulas

### Hard Constraints
- **REQUIRED**: Must describe variable relationships OR execution steps, using "ceteris paribus" phrasing
- **EITHER/OR OUTPUT**: (Variable relationship monotonicity/proportionality) OR (Clear Step 1/2/3 procedures)
- **REQUIRED WORDS**: if/when/while, increases/decreases, step
- **FORBIDDEN WORDS**: define, what is
- **NO CALCULATION**: Do not generate problems that require calculating a specific numerical answer. Focus on qualitative relationships (e.g., "increases," "decreases," "doubles") instead of specific values.

### Extraction Guidelines
- Use ONLY the 3 core question patterns above
- Focus on variable relationships and proportional changes
- Describe systematic step-by-step processes when applicable
- Use "if...then" reasoning structures with ceteris paribus conditions
- Emphasize mathematical dependencies and interactions
- Include quantitative relationships with mathematical notation

#### Example (STEM) - Ohm's Law Series

**Input**: "Calculate kinetic energy using $KE = \frac{1}{2}mv^2$"

**Output**:
```json
{
  "subject": "Physics",
  "cards": [
    {
      "front": "If voltage increases while resistance stays constant, what happens to current?",
      "back": "According to $V = IR$, if $R$ is constant, current $(I)$ is directly proportional to voltage $(V)$. Therefore, if voltage doubles, current also doubles."
    },
    {
      "front": "How does changing resistance affect current flow?",
      "back": "From $I = \\frac{V}{R}$, current is inversely proportional to resistance. If resistance doubles while voltage stays constant, current is halved."
    }
  ]
}
```

Generate flashcards that develop understanding of quantitative relationships and cause-effect reasoning using the specified question patterns.

---

## Substage 5: Applied Exercise (Dual Mode)

Coach learners with either a concise numeric drill or a grounded applied scenario. Keep outputs short, teachable, and aligned with base constraints (LaTeX math, JSON only, front/back length limits).

### 1) Inspect the Source
1. Skim for digits, formulas, units, operators, and explicit constraints.
2. Extract the core idea the learner should apply (one skill per card).
3. Decide which framing best reinforces that idea: numeric drill (A) or applied scenario (B).

### 2) Choose the Mode
- Use **Mode A (Numeric)** when the passage cues quantitative reasoning (numbers, formulas, rates, units).
- Use **Mode B (Applied)** when content is conceptual, procedural, policy, or system design.
- If cues are mixed/unclear, default to **Mode B** to avoid inventing data.

### 3) Mode A -- Numeric Calculation
- Prompt shape: `Calculate [target] given [conditions].` / `Determine [unknown] if [values].`
- Also allowed (variety, single-step):
  - `Compute [quantity] under [assumptions].`
  - `Find [value] from [equation/data].`
  - `Evaluate [expression] at [x=...].`
  - `Solve for [variable] in [equation].`
  - `Convert [value][unit] to [unit].`
  - `Estimate [target] to [n] sig figs given [data].`
  - `Express [result] in terms of [symbol].`
  - `Calculate the [ratio/rate] given [values].`
- Answer shape (exactly 3 short sentences):
  1) Name the formula in LaTeX. 2) Substitute the numbers. 3) Give the result with units.
- Hard constraints:
  - Create fresh numbers/units; never copy figures from the source.
  - Single-step skill only; one main formula; no multi-stage pipelines.
  - Use LaTeX for math (e.g., `$I=\tfrac{V}{R}$`). Include units on the final answer.
  - Keep `front <= 20 words`, `back <= 30 words` (3 short sentences). Aim for <= 100 characters to satisfy schema.
  - Rounding: use 2-3 significant figures unless exact; state "approx." if rounded.

### 4) Mode B -- Applied Scenario
- Prompt shape: `Outline how to apply [concept] to [goal].` / `Design a workflow to [outcome].`
- Also allowed (operational, concise):
  - `Propose a plan to [goal] using [tool/agent].`
  - `Design an experiment to test [hypothesis].`
  - `Map a system architecture for [use case].`
  - `Draft a checklist to deploy [component] with guardrails.`
  - `Recommend a monitoring strategy for [service].`
  - `Show how to integrate [X] with [Y] via handoff.`
  - `Create an incident playbook for [failure mode].`
- Answer shape (3 short sentences): Setup -> Steps -> Outcome.
- Hard constraints:
  - Mention at least one concrete operational element (agent/tool/handoff/guardrail/tracing/monitoring/logs).
  - Invent a new scenario; do not paraphrase the source sentences.
  - Lead with action verbs (design/outline/propose/build) and emphasize replicable steps.
  - Keep `front <= 20 words`, `back <= 30 words`. Avoid fluff, disclaimers, or citations.
  - Avoid definition, comparison, or pure mechanism prompts to prevent overlap with Substages 1-3.

### 5) Self-Check Before Emitting
- Mode alignment: Does A or B feel natural when read aloud?
- Mode A checklist: LaTeX formula -> substitution -> unit-bearing answer; new numbers; single step; concise.
- Mode B checklist: Clear Setup/Steps/Outcome; at least one control/guardrail element; actionable verbs; concise.

### 6) Reference Examples

**Mode A (Numeric)**:
```json
{
  "subject": "Physics",
  "cards": [
    {
      "front": "Determine current when $V=12\\,\\text{V}$ and $R=4\\,\\Omega$.",
      "back": "Formula: $I=\\tfrac{V}{R}$. Substitute: $I=12/4\\,\\text{A}$. Answer: $I=3\\,\\text{A}$."
    }
  ]
}
```

**Mode B (Applied)**:
```json
{
  "subject": "Software",
  "cards": [
    {
      "front": "Outline a guardrailed triage workflow for support tickets.",
      "back": "Setup: Intake agent sanitizes and labels tickets. Steps: Handoffs call tools with tracing and guardrails. Outcome: Faster, safer routing."
    }
  ]
}
```

Always keep each card strictly within the selected mode. Do not blend calculation steps with scenario prose.
