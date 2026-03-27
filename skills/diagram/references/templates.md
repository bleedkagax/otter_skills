# Diagram Templates

Ready-to-use Mermaid templates rendered with `uvx termaid --gap 1 --padding-x 0`.

---

## 1. API Request Flow (sequenceDiagram)

```mermaid
sequenceDiagram
    participant C as Client
    participant G as Gateway
    participant S as Service
    participant D as Database
    C->>G: POST /api/data
    G->>S: Validate & Route
    S->>D: Query
    D-->>S: Result
    S-->>G: Response
    G-->>C: 200 OK
```

Rendered output:

```
 ┌──────────┐        ┌──────────┐          ┌──────────┐┌──────────┐
 │  Client  │        │ Gateway  │          │ Service  ││ Database │
 └──────────┘        └──────────┘          └──────────┘└──────────┘
       ┆ POST /api/data    ┆                     ┆           ┆
       ────────────────────►                     ┆           ┆
       ┆                   ┆ Validate & Route    ┆           ┆
       ┆                   ──────────────────────►           ┆
       ┆                   ┆                     ┆ Query     ┆
       ┆                   ┆                     ────────────►
       ┆                   ┆                     ┆ Result    ┆
       ┆                   ┆                     ◄┄┄┄┄┄┄┄┄┄┄┄┄
       ┆                   ┆ Response            ┆           ┆
       ┆                   ◄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄           ┆
       ┆ 200 OK            ┆                     ┆           ┆
       ◄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄                     ┆           ┆
       ┆                   ┆                     ┆           ┆
```

---

## 2. CRUD Pipeline (flowchart LR)

```mermaid
flowchart LR
    A[Request] --> B{Validate}
    B -->|Valid| C[Auth Check]
    B -->|Invalid| X[400 Error]
    C --> D[(Database)]
    D --> E[Transform]
    E --> F[Response]
```

Rendered output:

```
┌───────┐ ┌────◇───┐        ┌──────────┐ ╭────────╮ ┌─────────┐ ┌────────┐
│       │ │        │ Valid  │          │ ╰────────╯ │         │ │        │
│Request├►│Validate├────┬──►│Auth Check├►│Database├►│Transform├►│Response│
│       │ │        │    │   │          │ │        │ │         │ │        │
└───────┘ └────◇───┘    │   └──────────┘ ╰────────╯ └─────────┘ └────────┘
                        │Invalid
                        │   ┌──────────┐
                        │   │          │
                        ╰──►│400 Error │
                            │          │
                            └──────────┘
```

---

## 3. Microservice Architecture (flowchart TD with subgraphs)

```mermaid
flowchart TD
    LB[Load Balancer]
    subgraph Frontend
        UI[Web App]
        Mobile[Mobile App]
    end
    subgraph Backend
        API[API Gateway]
        Auth[Auth Service]
        Core[Core Service]
    end
    subgraph Data
        DB[(PostgreSQL)]
        Cache[(Redis)]
    end
    LB --> UI
    LB --> Mobile
    UI --> API
    Mobile --> API
    API --> Auth
    API --> Core
    Core --> DB
    Core --> Cache
```

Rendered output:

```
   ┌─────────────┐
   │             │
   │Load Balancer│
   │             │
   └──────┬──────┘
          │
 ┌────────┼────────────────────────┐
 │ Frontend───────────────╮        │
 │        │               │        │
 │        ▼               ▼        │
 │ ┌─────────────┐ ┌─────────────┐ │
 │ │             │ │             │ │
 │ │   Web App   │ │ Mobile App  │ │
 │ │             │ │             │ │
 │ └─────┬───────┘ └──────┬──────┘ │
 │       │                │        │
 └───────┼────────────────┼────────┘
         │                │
         │                │
         │                │
         │ ╭──────────────╯
 ┌───────┼─┼───────────────────────┐
 │ Backend │                       │
 │       │ │                       │
 │       ▼ ▼                       │
 │ ┌─────────────┐                 │
 │ │             │                 │
 │ │ API Gateway │                 │
 │ │             │                 │
 │ └──────┬──────┘                 │
 │        ▼───────────────▼        │
 │ ┌─────────────┐ ┌─────────────┐ │
 │ │             │ │             │ │
 │ │Auth Service │ │Core Service │ │
 │ │             │ │             │ │
 │ └─────────────┘ └──────┬──────┘ │
 │                        │        │
 └────────────────────────┼────────┘
                          │
                          │
                          │
          ╭───────────────┤
 ┌────────┼───────────────┼────────┐
 │ Data   │               │        │
 │        │               │        │
 │        ▼               ▼        │
 │ ╭─────────────╮ ╭─────────────╮ │
 │ ╰─────────────╯ ╰─────────────╯ │
 │ │ PostgreSQL  │ │    Redis    │ │
 │ │             │ │             │ │
 │ ╰─────────────╯ ╰─────────────╯ │
 │                                 │
 └─────────────────────────────────┘
```

---

## 4. Git Release Flow (gitGraph)

```mermaid
gitGraph
    commit id: "init"
    branch develop
    commit id: "feat-A"
    commit id: "feat-B"
    branch release/1.0
    commit id: "rc-1"
    checkout main
    merge release/1.0 id: "v1.0" tag: "v1.0"
    checkout develop
    commit id: "feat-C"
    branch release/1.1
    commit id: "rc-2"
    checkout main
    merge release/1.1 id: "v1.1" tag: "v1.1"
```

Rendered output:

```
                                           [v1.0]                [v1.1]
  main        ───●──────┼─────────────────────●─────────────────────●─
               init     │                   v1.0                  v1.1
                        │                     │                     │
  develop               ●───────●──────┼──────┼───────●──────┼      │
                     feat-A  feat-B    │      │    feat-C    │      │
                                       │      │              │      │
  release/1.0                          ●──────┼              │      │
                                     rc-1                    │      │
                                                             │      │
  release/1.1                                                ●──────┼
                                                           rc-2
```

---

## 5. Decision Matrix (flowchart TD with diamonds)

```mermaid
flowchart TD
    S[Start] --> Q1{Budget OK?}
    Q1 -->|Yes| Q2{Team Ready?}
    Q1 -->|No| R1[Cut Scope]
    R1 --> Q1
    Q2 -->|Yes| Q3{Timeline OK?}
    Q2 -->|No| R2[Hire/Train]
    R2 --> Q2
    Q3 -->|Yes| GO[Launch]
    Q3 -->|No| R3[Adjust Plan]
    R3 --> Q1
```

Rendered output:

```
┌────────────┐
│            │
│   Start    │
│            │
└──────┬─────┘
       ▼
┌──────◇─────┐  ╭────────────────╮
│            │  │                │
│ Budget OK? │◄─┴───────────────╮│
│            │                  ││
└──────◇─────┘                  ││
       │                        ││
       │                        ││
       ├─────────────────╮      ││
       │                 │No    ││
    Yes│                 │      ││
       │                 │      ││
       ▼                 ▼      ││
┌──────◇─────┐    ┌────────────┐││
│            │    │            │││
│Team Ready? │◄─╮ │ Cut Scope  ├╯│
│            │  │ │            │ │
└──────◇─────┘  │ └────────────┘ │
       │        │                │
       │        │                │
       ├────────┼────────╮       │
       │        │        │No     │
    Yes│        │        │       │
       │        ╰────────┼──────╮│
       ▼                 ▼      ││
┌──────◇─────┐    ┌────────────┐││
│            │    │            │││
│Timeline OK?│    │ Hire/Train ├╯│
│            │    │            │ │
└──────◇─────┘    └────────────┘ │
       │                         │
       │                         │
       ├─────────────────╮       │
    Yes│                 │       │
       │                 │No     │
       ▼                 ▼       │
┌────────────┐    ┌────────────┐ │
│            │    │            │ │
│   Launch   │    │Adjust Plan ├─╯
│            │    │            │
└────────────┘    └────────────┘
```

---

## 6. Project Structure (mindmap)

```mermaid
mindmap
    root((Project))
        Frontend
            React App
            Components
            State Mgmt
        Backend
            API Server
            Auth Module
            DB Layer
        DevOps
            CI/CD
            Docker
            Monitoring
        Docs
            API Docs
            User Guide
```

Rendered output:

```
                                ╭─ React App
                  ╭─ Frontend ──├─ Components
                  │             ╰─ State Mgmt
                  │            ╭─ API Server
                  ├─ Backend ──├─ Auth Module
root((Project)) ──┤            ╰─ DB Layer
                  │           ╭─ CI/CD
                  ├─ DevOps ──├─ Docker
                  │           ╰─ Monitoring
                  ╰─ Docs ──╭─ API Docs
                            ╰─ User Guide
```
