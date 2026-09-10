---
name: math-modeling-strategy-designer
description: Compare and select mathematically distinct modeling routes after a contest subproblem has been structurally decomposed but before implementation. Use for route generation, fit scoring, originality and homogenization-risk review, simplicity gating, and a human-visible route decision; do not write production experiment code.
---

# Math Modeling Strategy Designer

Design competing routes from the problem structure, not from a memorized mapping between question labels and algorithms.

## Preconditions

Require a clear objective, variables, data availability, constraints, scales, and required outputs. If these are missing, return to `$math-modeling-problem-decomposer`.

## Candidate Routes

Create three to five genuinely distinct routes when the evidence supports them. Prefer different paradigms such as mechanism, statistical inference, classical machine learning, time series, mathematical optimization, graph/network, simulation, or a justified hybrid. Four tree ensembles are one paradigm, not four routes.

Each route must specify formulation, required data, core assumptions, validation design, expected deliverables, implementation risk, and failure conditions. Include a simple credible route; complexity is not a scoring bonus.

## Scoring and Audits

Use [references/route-scorecard.md](references/route-scorecard.md). Score and explain:

- Problem Fit, Mathematical Soundness, Data Suitability, Interpretability;
- Robustness, Computational Cost, Implementation Risk, Paper Expressiveness;
- Originality Potential and Homogenization Risk.

Homogenization risk assesses method commonness, template-likeness, problem specificity, and ease of generic prompt generation. Never claim knowledge of other teams' actual submissions.

Audit innovation at three levels: problem formulation, model structure, and validation design. An algorithm name alone is not innovation. `Originality != obscure algorithm`.

## Simplicity Gate

For every added component answer: “Which independent problem does this solve, and what evidence will show its contribution?” Reject components without a distinct role or ablation plan. Prefer, in order: problem fit, mathematical correctness, data support, validation reliability, interpretability, originality, then spectacle.

## Decision Gate

Present recommended route, viable alternative, score differences, decisive evidence, risks, and the minimum experiment needed to discriminate them. When routes remain materially different, do not pretend the user selected one. Record the decision only after explicit choice or a hard constraint that makes one route uniquely feasible.

Output `ROUTE SELECTED` only with evidence of selection; otherwise output `AWAITING ROUTE DECISION`.
