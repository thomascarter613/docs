+-------------------------------------------------------------+
|                         MonadOS                             |
|            AI‑Native Monorepo Operating System              |
+-------------------------------------------------------------+

                 ┌───────────────────────────┐
                 │        Developer          │
                 │      (Human-in-loop)      │
                 └────────────┬──────────────┘
                              │
                              │ CLI Commands (monad ...)
                              ▼
+-------------------------------------------------------------+
|                         CLI Layer                           |
+-------------------------------------------------------------+
|  (monad CLI commands)                                       |
|  - Command parsing (commander)                               |
|  - Subcommands:                                              |
|      init, add-domain, apply-governance,                    |
|      check-topology, check-policies, report                 |
|  - Thin façade: delegates to engines                        |
+-------------------------------------------------------------+
                              │
                              │ uses
                              ▼
+-------------------------------------------------------------+
|                    Governance & Config Layer                 |
+-------------------------------------------------------------+
|  Config & Packs                                              |
|  - monad.config.yaml                                         |
|  - governance/packs/monad-default-v0.1/                      |
|      - policies/*.yaml (ownership, boundaries,              |
|        compliance, naming)                                  |
|      - topology/rules.yaml                                  |
|      - pack.config.yaml                                     |
+-------------------------------------------------------------+
      │                         │                         │
      │                         │                         │
      │                         │                         │
      ▼                         ▼                         ▼
+-------------+        +----------------+        +--------------------+
| Topology    |        | Policy Engine  |        | AI Hooks Engine    |
| Engine      |        | (Governance)   |        | (v0.1)             |
+-------------+        +----------------+        +--------------------+
| engines/topology     | engines/policy          | engines/ai         |
| - scanner.ts         | - parser.ts             | - lint.ts          |
| - rules.ts           | - evaluator.ts          | - suggest.ts       |
| - violations.ts      | - rules/ownership.ts    | - doc.ts           |
| - report.ts          | - rules/compliance.ts   |                    |
|                      | - rules/naming.ts       |                    |
+-------------+        +----------------+        +--------------------+
      │                         │                         │
      │                         │                         │
      │                         │                         │
      ▼                         ▼                         ▼
+-------------------------------------------------------------+
|                    Monorepo / Repo Layer                     |
+-------------------------------------------------------------+
|  Governed project structure                                  |
|  - /domains/<domain>/                                       |
|      - src/                                                 |
|      - tests/                                               |
|      - OWNERS                                               |
|      - domain.config.yaml                                   |
|  - /shared/                                                 |
|  - /policies/ (repo‑local overrides)                        |
|  - /.monad/ (cache, logs)                                   |
+-------------------------------------------------------------+

                              │
                              │ (future)
                              ▼
+-------------------------------------------------------------+
|                 Orchestration & External Engines             |
+-------------------------------------------------------------+
|  engines/orchestration                                       |
|  - adapters/build (Nx, Bazel, Turborepo, etc.)              |
|  - adapters/test                                             |
|  - adapters/graph                                            |
|  - adapters/ai (LLM providers)                               |
|  - orchestrator.ts                                           |
+-------------------------------------------------------------+

                              │
                              ▼
+-------------------------------------------------------------+
|                     Observability / Dashboard                |
+-------------------------------------------------------------+
|  Governance & Health (future)                                |
|  - Repo health score                                         |
|  - Policy violations                                         |
|  - Topology violations                                       |
|  - Domain & ownership maps                                   |
+-------------------------------------------------------------+
