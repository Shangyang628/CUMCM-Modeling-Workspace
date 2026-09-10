---
name: math-modeling-problem-decomposer
description: Decompose a new mathematical modeling problem or subproblem into objectives, variables, constraints, data, uncertainty, scales, and dependencies before any model is chosen. Use when the user asks to understand, restate, audit, or structurally analyze a contest problem; do not recommend or implement algorithms.
---

# Math Modeling Problem Decomposer

Translate the contest prompt into a testable mathematical problem structure. Stop before algorithm selection.

## Read First

Read the exact problem statement and relevant attachments. Inventory data files, sheets, units, time spans, spatial coverage, missing fields, target availability, and required deliverables. Distinguish stated facts from inferred assumptions.

## Decomposition

For each subproblem identify:

- objective and required answer form;
- observable inputs and target outputs;
- decision, state, target, control, and exogenous variables;
- parameters, hard constraints, soft preferences, and standards;
- time and spatial scales, sampling interval, groups, and entities;
- deterministic relations, plausible causal directions, and mere associations;
- uncertainty sources, unavailable future information, and identifiability risks;
- dependencies on earlier subproblems and reusable processed data.

Audit whether the question is truly prediction, evaluation, optimization, inference, simulation, classification, or a coupled task. Do not let a verb such as “评价” or “预测” predetermine a model family.

## Assumptions

List only assumptions needed to make the problem well-posed. For each, state its purpose, evidence or reason, consequence if false, and whether it must later be tested. Never hide missing data behind an assumption.

## Output Contract

Produce:

1. concise task restatement;
2. per-subproblem structure table;
3. variable and unit ledger;
4. constraint and uncertainty ledger;
5. dependency graph in text or Mermaid when useful;
6. data/attachment audit with evidence paths;
7. unresolved questions and readiness status.

End with either `READY FOR STRATEGY DESIGN` or `NOT READY`, with reasons. Do not name a preferred algorithm or route.
