---
title: ADR-0000 — ADR Governance Policy
version: 1.0.0
status: active
updated: {{DATE}}

owner: thomas
reviewCycle: annual

parents: []
children: []
supersedes: []
supersededBy: []

tags:
  - adr
  - governance
  - monad
---

# ADR-0000 — ADR Governance Policy

## Purpose
Define how ADRs are created, reviewed, approved, superseded, and archived.

## ADR Lifecycle
1. Draft  
2. Proposed  
3. Accepted  
4. Active  
5. Deprecated  
6. Superseded  

## Numbering Rules
- Sequential  
- Immutable  
- Never reused  

## Supersession Rules
- Superseding ADR must reference the old ADR  
- Old ADR must be updated with `supersededBy`  
- Lineage must remain intact  

## Review Cadence
- Annual review  
- Triggered review when architecture changes  

## Required Sections
- Context  
- Decision  
- Rationale  
- Consequences  
- Lineage  

## Tooling Requirements
- CI validation  
- Drift detection  
- Index regeneration  
