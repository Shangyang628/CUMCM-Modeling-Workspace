# Workflow Plan — Problems 1–5

## Current stage

Intake is complete. No mathematical route has been selected and no optimization algorithm has started. The next stage is `$math-modeling-problem-decomposer`.

## Stage gates

1. **Input and decomposition gate** — inventory authoritative inputs; decompose Problems 1–5 into objectives, variables, constraints, data, uncertainty, scales, and dependencies.
2. **Route gate** — use `$math-modeling-strategy-designer` to compare mathematically distinct routes. Record an explicit selected route before implementation.
3. **Execution gate** — after route selection and validation design, use `$math-modeling-code-experiment` for reproducible code, configurations, logs, tables, figures, and workbook copies.
4. **Validation gate** — use `$math-modeling-model-validator` for geometry/physics checks, numerical validity, feasibility, ablation, sensitivity, robustness, and reproducibility.
5. **Writing gate** — after model/configuration freeze, use `$math-modeling-methodology-writer`; after outputs are verified, use `$math-modeling-solution-writer`.
6. **Submission gate** — use `$math-modeling-consistency-auditor` across paper, code, configs, logs, figures, tables, and all three final workbooks. No unresolved FAIL finding is allowed.

## Problem sequence and dependencies

| Problem | Smallest stage deliverable | Dependency before route selection | Required final artifact |
|---|---|---|---|
| Q1 | Structural statement of fixed FY1–M1 trajectory, release/detonation events, and effective-occlusion criterion | Official wording and coordinate/physics definitions | Final effective shielding duration plus verification evidence |
| Q2 | Decision-variable, feasible-domain, and objective ledger for one FY1 bomb against M1 | Q1 geometry/dynamics and shielding criterion | FY1 direction, speed, release/detonation time and point, maximum duration |
| Q3 | Multi-release constraint and coverage aggregation structure for three FY1 bombs | Q2 single-bomb structure; at least 1 s release spacing | Three-bomb strategy and copied `result1.xlsx` |
| Q4 | Three-UAV joint decision and coverage aggregation structure | Q2 single-bomb structure and cross-UAV timing rules | FY1/FY2/FY3 strategy and copied `result2.xlsx` |
| Q5 | Multi-UAV, multi-bomb, multi-missile task-allocation and coverage structure | Q1–Q4 validated definitions and constraints | Full five-UAV strategy for M1/M2/M3 and copied `result3.xlsx` |

## Planned production evidence

- Core source code and frozen configurations.
- Per-run logs and a versioned run manifest.
- Main tables and figures linked to exact run IDs.
- Validation report with PASS/WARNING/FAIL findings.
- Ablation, sensitivity, and robustness results.
- Methodology and solution chapters based only on frozen models and verified outputs.
- Final cross-artifact consistency audit and Skill workflow acceptance report.

## Template-independent continuation

Structural decomposition, route design, implementation scaffolding, model execution, and most validation can proceed without the Excel templates. Exact workbook population and submission-format consistency checks remain blocked until the untouched official templates are supplied.

