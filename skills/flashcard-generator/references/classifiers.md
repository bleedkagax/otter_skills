# Content Classifiers

Three classification prompts used as pre-processing steps before flashcard generation.

---

## 1. Content Validity Check

Determine if the input content is suitable for generating learning flashcards.

### Evaluation Criteria

**Valid content (reply 1)**:
- Has educational value and can help with learning

**Invalid content (reply 0)**:
- Empty or blank input
- Pure decorative images or irrelevant information

### Output Requirements
Only reply with the number "1" or "0", no other content.

---

## 2. Language Detection

Detect the primary language of the text content.

### Detection Rules
Based on the textual characteristics, determine the main language used:

- Input English -> Output `english`
- Input Chinese -> Output `chinese`
- Mixed language input -> Output the dominant language
- If no clear text visible -> Output `english`

### Output Requirements
Only reply with one word, all lowercase, no other content.

---

## 3. Subject Classification (STEM vs Humanities)

Determine whether the content belongs to STEM or Humanities.

### Classification Standards

**STEM content (reply 1)**:
- Mathematics: algebra, geometry, calculus, statistics, formulas, equations, etc.
- Physics: mechanics, electricity, optics, thermodynamics, diagrams, etc.
- Chemistry: organic chemistry, inorganic chemistry, molecular structures, etc.
- Biology: cell biology, genetics, ecology, anatomical diagrams, etc.
- Engineering: mechanical, electronic, civil, software, technical drawings, etc.
- Computer Science: programming, algorithms, data structures, code, etc.
- Medicine: anatomy, physiology, pharmacology, medical diagrams, etc.

**Humanities content (reply 0)**:
- Language: grammar, vocabulary, linguistics, text analysis, etc.
- Literature: poetry, novels, essays, literary analysis, etc.
- History: historical events, historical figures, timelines, maps, etc.
- Philosophy: philosophical thoughts, logic, ethics, texts, etc.
- Arts: music, painting, sculpture, design, artistic works, etc.
- Social Sciences: economics, political science, sociology, charts, etc.
- Humanities: culture, religion, archaeology, cultural artifacts, etc.

### Output Requirements
Only reply with the number "1" (STEM) or "0" (Humanities), no other content.
