# Humanities Substages (5 Linguistic Layers)

Each substage targets a distinct part of speech or expression type. Cards from different substages MUST NOT overlap. This mutual exclusivity prevents duplication and ensures comprehensive vocabulary coverage.

**Weight Distribution**: [30%, 20%, 30%, 5%, 15%] across the 5 substages.

---

## Substage 1: Single-Chunk Nouns (30%)

Extract nouns that are exactly one language chunk. Focus on core concepts, academic vocabulary, and foundational terms. Do not extract multi-chunk nouns or any other part of speech.

### Core Question Types:
1. `[noun]\n/pronunciation/` - Core academic and literary concepts
2. `[specialized term]\n/pronunciation/` - Subject-specific terminology
3. `[cultural concept]\n/pronunciation/` - Cultural and historical terms

### Focus Areas
- **Academic Vocabulary**: Essential scholarly and intellectual terms
- **Literary Concepts**: Core literary terminology and character types
- **Historical Terms**: Important historical entities and concepts
- **Cultural Concepts**: Social, cultural, and philosophical terminology
- **Abstract Concepts**: Ideas, theories, and intellectual frameworks

### Extraction Guidelines
- Focus strictly on single-word nouns only
- **Priority Selection**:
  1. Academic and intellectual vocabulary (medium-advanced level)
  2. Subject-specific core terminology
  3. Cultural and literary concepts with educational value
  4. Abstract concepts that enhance understanding
- Avoid basic everyday nouns unless academically significant
- Include pronunciation guides for all terms
- **Quality Focus**: Select nouns with real educational and cultural value

### Content Structure
**Front**: `[noun]\n/pronunciation/`
**Back**:
- [Core definition] (precise, academic definition)
- [Usage context/field] (academic field or cultural context)
- [Example sentence] (demonstrating proper usage)

#### Example (Language)

**Input**: "The tragedy of Hamlet explores themes of revenge and mortality."

**Output**:
```json
{
  "subject": "Literature",
  "cards": [
    {
      "front": "tragedy\n/\u02c8tr\u00e6d\u0292\u0259di/",
      "back": "A serious drama involving the downfall of a heroic or noble character.\nShakespeare's Hamlet is considered one of the greatest tragedies in English literature."
    },
    {
      "front": "revenge\n/r\u026a\u02c8vend\u0292/",
      "back": "The act of retaliation against someone for a perceived wrong.\nThe prince's quest for revenge drives the entire plot of the play."
    }
  ]
}
```

Generate flashcards that build essential vocabulary and conceptual foundations for humanities learning.

---

## Substage 2: Single-Chunk Descriptors (20%)

Extract adjectives and adverbs that are exactly one language chunk. Focus on sophisticated descriptive vocabulary that enhances academic and literary expression.

### Core Question Types:
1. `[adjective]\n/pronunciation/` - Descriptive and evaluative adjectives
2. `[adverb]\n/pronunciation/` - Manner, degree, and evaluative adverbs
3. `[modifier]\n/pronunciation/` - Academic and literary modifiers

### Focus Areas
- **Academic Descriptors**: Scholarly and analytical adjectives/adverbs
- **Literary Language**: Sophisticated descriptive vocabulary
- **Evaluative Terms**: Words expressing judgment, quality, or degree
- **Emotional Vocabulary**: Terms describing feelings and psychological states
- **Stylistic Elements**: Language that enhances tone and register

### Extraction Guidelines
- Focus strictly on single-word adjectives and adverbs only
- **Priority Selection**:
  1. Academic and intellectual descriptors (formal register)
  2. Literary and sophisticated vocabulary
  3. Evaluative and analytical terms
  4. Emotional and psychological descriptors with depth
- Clearly distinguish adjectives from adverbs with part-of-speech labels
- Avoid basic descriptors unless academically significant
- **Quality Focus**: Select descriptors that enhance sophisticated expression

### Content Structure
**Front**: `[descriptor]\n/pronunciation/`
**Back**:
- [Definition with nuance] (precise meaning and connotations)
- [Register/usage context] (formal/informal, literary/academic)
- [Example sentence] (showing sophisticated usage)

#### Example (Language)

**Input**: "The melancholic protagonist moved hastily through the empty corridors, feeling profoundly isolated."

**Output**:
```json
{
  "subject": "Literature",
  "cards": [
    {
      "front": "melancholic\n/\u02ccmel\u0259n\u02c8k\u0252l\u026ak/",
      "back": "Feeling or expressing deep sadness or thoughtful sorrow.\nThe melancholic music perfectly captured the mood of the rainy afternoon."
    },
    {
      "front": "hastily\n/\u02c8he\u026ast\u026ali/",
      "back": "In a hurried manner; quickly and often carelessly.\nShe hastily packed her bags before catching the early flight."
    }
  ]
}
```

Generate flashcards that build descriptive vocabulary and enhance expressive language skills.

---

## Substage 3: Single-Chunk Actions (30%)

Extract verbs that are exactly one language chunk. Focus on sophisticated action vocabulary that enhances academic discourse and intellectual expression. Do not extract phrasal verbs or multi-word expressions.

### Core Question Types:
1. `[verb]\n/pronunciation/` - Academic and intellectual action verbs
2. `[action verb]\n/pronunciation/` - Cognitive and analytical verbs
3. `[expressive verb]\n/pronunciation/` - Literary and communicative verbs

### Focus Areas
- **Cognitive Verbs**: Mental processes and intellectual activities
- **Academic Actions**: Scholarly and research-related verbs
- **Analytical Verbs**: Critical thinking and evaluation actions
- **Expressive Actions**: Communication and artistic expression verbs
- **Abstract Actions**: Conceptual and theoretical processes

### Extraction Guidelines
- Focus strictly on single-word verbs only (infinitive form)
- **Priority Selection**:
  1. Academic and intellectual action verbs
  2. Cognitive and analytical process verbs
  3. Sophisticated communication and expression verbs
  4. Abstract conceptual action verbs
- Exclude phrasal verbs and multi-word expressions completely
- Avoid basic action verbs unless academically significant
- **Quality Focus**: Select verbs that enhance sophisticated discourse

### Content Structure
**Front**: `[verb]\n/pronunciation/`
**Back**:
- [Action definition] (precise meaning of the action)
- [Usage context/register] (academic, formal, literary context)
- [Example sentence] (demonstrating sophisticated usage)

#### Example (Language)

**Input**: "She tends to contemplate deeply before making decisions, and sometimes might feign interest in topics that bore her."

**Output**:
```json
{
  "subject": "Psychology",
  "cards": [
    {
      "front": "contemplate\n/\u02c8k\u0252nt\u0259mple\u026at/",
      "back": "To think about something deeply and at length; to consider thoughtfully.\nThe philosopher would contemplate the meaning of existence for hours."
    },
    {
      "front": "feign\n/fe\u026an/",
      "back": "To pretend to feel or be affected by something; to simulate.\nShe had to feign enthusiasm for the project despite her reservations."
    }
  ]
}
```

Generate flashcards that develop analytical and interpretive thinking skills.

---

## Substage 4: Single-Chunk Functions (5%)

Extract function words that are exactly one language chunk and are NOT nouns, adjectives, adverbs, or verbs. Focus on sophisticated grammatical elements that enhance formal discourse and literary expression.

### Core Question Types:
1. `[function word]\n/pronunciation/` - Formal conjunctions, prepositions
2. `[discourse marker]\n/pronunciation/` - Academic and literary connectors
3. `[grammatical element]\n/pronunciation/` - Specialized grammatical vocabulary

### Focus Areas
- **Advanced Conjunctions**: Sophisticated connective words (formal, literary)
- **Complex Prepositions**: Academic and literary prepositional vocabulary
- **Formal Pronouns**: Archaic, literary, and formal pronominal forms
- **Discourse Markers**: Academic and literary transitional elements
- **Specialized Particles**: Function words with literary or formal usage

### Extraction Guidelines
- Focus strictly on single-word function words only
- **CRITICAL FILTERS - Exclude Basic Function Words**:
  - **NO elementary conjunctions**: that, and, but, or, so, if, when, where, what, how
  - **NO basic prepositions**: in, on, at, to, from, with, by, for, of
  - **NO simple pronouns**: it, this, they, he, she, we, you, I, me
  - **NO common articles/determiners**: a, an, the, some, any, each, every
  - **NO basic auxiliary/modal verbs**: is, are, was, were, have, has, can, will, would, should
- **Priority Selection**:
  1. Formal and literary conjunctions (lest, albeit, whereas, henceforth, nevertheless)
  2. Sophisticated prepositions and particles (amid, amongst, beneath, upon, whereby)
  3. Archaic or literary pronouns and determiners (thee, thou, thy, whence, whither)
  4. Academic discourse markers and connectors (furthermore, nevertheless, consequently, moreover)
- **Quality Requirements**: Only select function words that enhance sophisticated expression and are NOT commonly known by elementary learners
- **Educational Value**: Function words must provide genuine learning benefit for intermediate+ students

### Content Structure
**Front**: `[function word]\n/pronunciation/`
**Back**:
- [Grammatical function] (role in sentence structure)
- [Usage context/register] (formal, literary, archaic, academic)
- [Example sentence] (demonstrating sophisticated usage)

#### Example (Language)

**Input**: "Lest we forget the lessons of history, we must remain vigilant, for thee and thy descendants shall inherit this world."

**Output**:
```json
{
  "subject": "Literature",
  "cards": [
    {
      "front": "lest\n/lest/",
      "back": "A conjunction meaning 'for fear that' or 'in case', used to express concern that something undesirable might happen.\nHe spoke quietly lest he wake the sleeping child."
    },
    {
      "front": "thee\n/\u00f0i\u02d0/",
      "back": "An archaic or poetic form of 'you' used as the object of a verb or preposition.\nI shall follow thee wherever thou goest."
    }
  ]
}
```

Generate flashcards that reveal important connections and relationships in humanities knowledge.

---

## Substage 5: Comprehensive Expressions (15%)

Extract meaningful expressions regardless of length - from two-chunk phrases to complex idioms and sayings. Focus on the most valuable linguistic expressions that enhance language learning.

### Core Expression Types:
1. `[two-word phrase]\n/pronunciation/` - High-frequency collocations
2. `[multi-word expression]\n/pronunciation/` - Idioms, proverbs, quotes
3. `[complete saying]\n/key pronunciation/` - Traditional wisdom and literary quotes

### Focus Areas
- **Valuable Collocations**: High-frequency two-word combinations
- **Idiomatic Expressions**: Fixed multi-word phrases with non-literal meanings
- **Cultural Sayings**: Proverbs, traditional wisdom, and cultural expressions
- **Literary Quotations**: Famous quotes and memorable literary phrases
- **Academic Expressions**: Scholarly terms and formal language patterns

### Extraction Guidelines
- **Smart Selection**: Choose the most educationally valuable expressions from the material
- **Length Flexibility**: Accept 2+ word expressions based on linguistic value, not arbitrary word count
- **Priority Order**:
  1. Famous quotes and literary expressions (3+ words)
  2. Cultural idioms and proverbs (2+ words)
  3. High-frequency academic collocations (2 words)
  4. Specialized terminology combinations (2+ words)
- **Quality over Quantity**: Select expressions with real learning value
- **Cultural Context**: Include cultural and historical significance when relevant

### Content Structure
**Front**: `[expression]\n/pronunciation/`
**Back**:
- [Definition/meaning] (clear explanation)
- [Usage context/register] (formal/informal, literary/academic)
- [Example sentence] (practical application)

#### Example (Language) - Comprehensive Expression Selection

**Input**: "When this mortal coil becomes too burdensome, critical thinking helps us navigate life's challenges with social justice in mind."

**Output**:
```json
{
  "subject": "Literature",
  "cards": [
    {
      "front": "mortal coil\n/\u02c8m\u0254\u02d0rt\u0259l k\u0254\u026al/",
      "back": "A poetic phrase meaning the troubles and tribulations of life on earth; human existence.\nPrimarily used in literary and philosophical contexts, from Shakespeare's Hamlet.\nThe poet reflected on shuffling off this mortal coil in times of despair."
    },
    {
      "front": "critical thinking\n/\u02c8kr\u026at\u026ak\u0259l \u02c8\u03b8\u026a\u014bk\u026a\u014b/",
      "back": "The objective analysis and evaluation of an issue to form a judgment.\nCommonly used in academic and professional contexts.\nStudents must develop critical thinking skills to succeed in university."
    },
    {
      "front": "social justice\n/\u02c8so\u028a\u0283\u0259l \u02c8d\u0292\u028cst\u026as/",
      "back": "The fair and just relation between individuals and society, including equal rights and opportunities.\nFrequently used in political, academic, and activist contexts.\nThe organization campaigns for social justice and human rights."
    }
  ]
}
```

Generate flashcards that capture the most valuable linguistic expressions for comprehensive language learning.
