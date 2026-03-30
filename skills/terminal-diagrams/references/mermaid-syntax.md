# Mermaid Syntax Reference for termaid

## Flowcharts

```
graph TD          (top-down, also TB)
graph LR          (left-right)
graph RL          (right-left)
graph BT          (bottom-top)
```

Node shapes:
```
A[Rectangle]    A(Rounded)    A{Diamond}    A([Stadium])
A[[Subroutine]] A((Circle))   A>Asymmetric]  A{{Hexagon}}
A[(Cylinder)]   A(((Double circle)))
A["Multi-line\nlabel"]    (use \n, NOT <br/> — termaid renders <br/> as literal text)
```

Edge styles:
```
A --> B           solid arrow
A -.-> B          dotted arrow
A ==> B           thick arrow
A <--> B          bidirectional
A --o B           circle endpoint
A --x B           cross endpoint
A -->|label| B    labeled edge
A ---> B          longer edge
```

Subgraphs:
```
subgraph Title
    direction LR
    A --> B
end
```

## Sequence Diagrams

```
sequenceDiagram
    participant A as Alice
    participant B as Bob
    A->>B: Solid arrow (request)
    B-->>A: Dashed arrow (response)
    A->B: Solid line
    B-->A: Dashed line
```

Note: termaid renders participants and message arrows. Advanced Mermaid features (activate/deactivate, alt/loop blocks, notes) may not be supported.

## Class Diagrams

```
classDiagram
    class ClassName {
        +String publicAttr
        -int privateAttr
        #protectedMethod()
        +publicMethod() ReturnType
    }
    ClassA <|-- ClassB      inheritance
    ClassA *-- ClassB       composition
    ClassA o-- ClassB       aggregation
    ClassA --> ClassB       association
    ClassA ..> ClassB       dependency
    ClassA ..|> ClassB      realization
```

## ER Diagrams

```
erDiagram
    ENTITY1 ||--o{ ENTITY2 : "relationship"
    ENTITY2 ||--|{ ENTITY3 : "relationship"

    ENTITY1 {
        string id PK
        string name
        int foreign_id FK
    }
```

Cardinality: `||` exactly one, `o|` zero or one, `}|` one+, `o{` zero+
Line style: `--` solid, `..` dashed

## State Diagrams

```
stateDiagram-v2
    [*] --> State1
    State1 --> State2 : event
    State2 --> [*]

    state State1 {
        [*] --> SubState1
        SubState1 --> SubState2
    }
```

## Block Diagrams

```
block-beta
    columns 3
    A["Label A"] B["Label B"] C["Label C"]
    D["Wide Block"]:2 E["Normal"]
```

Features: `columns N`, column spanning (`:N`), links between blocks, nested blocks.

## Git Graphs

```
gitGraph
    commit id: "init"
    branch develop
    commit id: "feat-1"
    checkout main
    commit id: "fix"
    merge develop id: "merge"
```

Commit types: `type: NORMAL` (default), `type: REVERSE`, `type: HIGHLIGHT`

## Pie Charts

```
pie title Chart Title
    "Slice A" : 45
    "Slice B" : 30
    "Slice C" : 25
```

Rendered as horizontal bar chart in terminal.

## Treemaps

```
treemap-beta
    "Group A"
        "Item 1": 40
        "Item 2": 15
    "Group B"
        "Item 3": 35
```

Indentation-based nesting, `"label": value` syntax.

## Mindmaps

```
mindmap
    Root
        Branch A
            Leaf 1
            Leaf 2
        Branch B
            Leaf 3
```

Indentation-based nesting. Mermaid shape markers (`(round)`, `[square]`, `{{hexagon}}`) are stripped by termaid — all nodes render as plain text labels.
