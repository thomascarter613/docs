# AGENTS.md

This file defines operating instructions for AI agents working in this repository.

The repository contains Mintlify documentation for Monad-Workspace and Applied Innovation Corp operating systems.

AI agents must preserve structure, lineage, governance, and human review.

**First-time setup**: Customize this file for your project. Prompt the user to customize this file for their project.

For Mintlify product knowledge (components, configuration, writing standards), install the Mintlify skill: `npx skills add https://mintlify.com/docs`

# Documentation project instructions

## About this project

- This is a documentation site built on [Mintlify](https://mintlify.com)
- Pages are MDX files with YAML frontmatter
- Configuration lives in `docs.json`
- Use the Mintlify MCP server, `https://mcp.mintlify.com`, to edit content and settings via MCP
- Use the Mintlify docs MCP server, `https://www.mintlify.com/docs/mcp`, to query information about using Mintlify via MCP

## Project purpose

Monad-Workspace documentation is the operating memory and public documentation system for:

- Founder Log
- Architecture Decision Records
- Narrative Engine
- Pipeline Engine
- Delivery Engine
- Platform Engine
- Governance
- Knowledge Graph

The docs should help humans and AI systems understand what exists, why it exists, how it is used, and how it changes over time.

---

---

## General rules

When editing this repo:

1. Preserve existing frontmatter patterns.
2. Use clear, practical writing.
3. Avoid hype.
4. Do not invent facts.
5. Mark uncertainty clearly.
6. Do not delete decision history.
7. Keep pages useful to both humans and AI systems.
8. Use stable, lowercase, kebab-case paths.
9. Keep navigation organized and not overly cluttered.
10. Prefer system-level clarity over decorative prose.

---

## Documentation style

Docs should be:

- direct
- structured
- operational
- reviewable
- easy to scan
- grounded in real project intent
- safe to reuse

Each stable page should usually include:

- purpose
- inputs, process, or operating rules
- outputs or definition of done
- review cadence
- related pages when useful

---

## Frontmatter standard

Use this structure unless a page has a specific reason to differ:

```yaml
---
title:
description:
version: 1.0.0
status: stable
updated: YYYY-MM-DD

owner: thomas
reviewCycle: monthly

parents: []
children: []
supersedes: []
supersededBy: []

tags: []
---
```

---

## ADR rules

For ADR-related pages:

- Preserve decision numbers.
- Do not reuse ADR numbers.
- Do not delete old ADRs.
- Supersede old ADRs instead of overwriting history.
- Accepted ADRs are binding until superseded.
- AI-generated ADRs require human review before acceptance.

---

## Safety rules

Do not add:

- secrets
- API keys
- passwords
- private client information
- private personal information
- unsupported public claims
- legal, financial, or medical conclusions presented as final advice

If sensitive context is necessary, generalize or redact it.

---

## Navigation rules

When editing `docs.json`:

- Keep the sidebar compact.
- Group related pages under larger operating areas.
- Avoid creating one sidebar group for every small subsystem.
- Keep `adr/index` easy to access.
- Keep `quickstart` near the top.
- Ensure all navigation paths match actual files.

---

## Human verification required

Human review is required before merging changes that affect:

- accepted ADRs
- governance rules
- public claims
- pricing
- client-facing language
- major positioning
- documentation structure
- repo navigation

---

## Terminology

Use these terms consistently across the docs.

| Preferred term | Avoid | Usage |
| --- | --- | --- |
| Monad-Workspace | Monad Workspace, monad workspace | Use for the overall project, repo, docs, and operating system. |
| Applied Innovation Corp | AIC unless already defined | Use for the company. |
| Founder Log | founder journal, diary, notes | Use for the structured operating memory system. |
| AI Cofounder | AI assistant, bot, agent, helper | Use when referring to the AI operating partner role. |
| workspace | project, folder, repo when broader meaning is intended | Use for the working environment Monad-Workspace coordinates. |
| page | article, doc, document | Use for individual Mintlify documentation pages. |
| system | section, category, area | Use for major operating systems like Pipeline Engine or Delivery Engine. |
| operating memory | notes, history, context dump | Use for structured context that supports future work. |
| decision lineage | decision history, rationale trail | Use for traceable decision context. |
| ADR | architecture note, decision doc | Use for Architecture Decision Records. Spell out once if needed. |
| human verification | approval, sign-off, review when safety is implied | Use when human judgment is required before accepting AI output. |
| reusable asset | deliverable, artifact, template when broader meaning is intended | Use for templates, SOPs, scripts, checklists, and product requirements created from work. |
| governance | rules, process, bureaucracy | Use for decision controls, review cadence, standards, and verification. |
| pipeline | sales funnel | Use for the broader revenue learning and opportunity system. |
| delivery | implementation | Use when referring to the full client fulfillment system. |
| platform | product, software, tool when broader meaning is intended | Use for Monad-Workspace as a system of modules and architecture. |

### Product naming rules

- Use `Monad-Workspace` for the canonical project name.
- Use `Applied Innovation Corp` on first reference.
- Use `AI Cofounder` as a role, not a generic assistant.
- Use `Founder Log` as a proper noun when referring to the system.
- Use lowercase for generic concepts such as `workspace`, `module`, `page`, and `system`.

---

## Style preferences

Use these style rules across all docs.

- Use active voice.
- Use second person when giving instructions.
- Keep sentences concise.
- Use one idea per sentence.
- Use sentence case for headings.
- Use **bold** for UI elements: Click **Settings**.
- Use code formatting for file names, commands, paths, and code references.
- Use tables when comparing options, statuses, fields, or workflows.
- Use numbered lists for ordered processes.
- Use bullets for unordered guidance.
- Prefer clear operational language over marketing language.
- Avoid hype words like “revolutionary,” “game-changing,” “magical,” or “seamless.”
- Avoid vague claims that are not backed by evidence.
- Mark uncertainty clearly.
- Separate facts from interpretations.
- Prefer “does” over “may do” when the behavior is established.
- Prefer “should” for standards and recommendations.
- Prefer “must” only for hard requirements, safety rules, or governance constraints.
- Keep page introductions short and direct.
- End system pages with a clear definition of done.

### Heading style

Use sentence case:

## Review cadence
## Definition of done
## Decision status

Do not use title case:

## Review Cadence
## Definition Of Done
## Decision Status

### Path and command style

Use inline code for:

* docs.json
* AGENTS.md
* quickstart.mdx
* founder-log/overview
* mint dev
* adr/index

## Content boundaries

Document what helps someone understand, operate, govern, or extend Monad-Workspace.

### Document this

Include:

* operating systems
* workflows
* templates
* standards
* decision records
* review processes
* AI Cofounder instructions
* governance rules
* platform architecture
* module lineage
* reusable assets
* terminology
* public-safe founder narrative
* pipeline, delivery, and knowledge systems

### Do not document this

Do not include:

* passwords
* API keys
* access tokens
* private keys
* private client information
* sensitive personal information
* unapproved pricing commitments
* confidential legal details
* private financial details
* unsupported public claims
* internal speculation presented as fact
* raw emotional notes without operating value
* AI-generated recommendations that have not been reviewed
* implementation promises that are not yet accepted

### Internal vs public-safe content

Founder Logs may capture internal context.

Public docs should contain only content that is safe, useful, and intentionally structured.

Before promoting Founder Log material into public docs, redact private details and preserve only the business lesson.

### AI-generated content boundary

AI may draft, summarize, reorganize, and recommend.

AI must not silently convert draft notes into accepted doctrine.

Human verification is required before accepting:

* ADRs
* governance changes
* pricing changes
* public claims
* client-facing commitments
* major platform decisions
* major positioning changes