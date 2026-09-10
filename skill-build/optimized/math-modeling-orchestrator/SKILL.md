---
name: math-modeling-orchestrator
description: Coordinate an end-to-end mathematical modeling competition workflow when the user wants to start, resume, or manage multiple modeling stages or subproblems. Use for stage detection, handoffs, dependencies, decision logging, and next-step planning; do not replace a clearly requested decomposer, strategy, coding, validation, writing, or consistency-audit task.
---

# Math Modeling Orchestrator

Coordinate the competition workflow without pretending to perform every specialist task.

## Intake

Inspect the problem statement, attachments, project tree, existing question folders, final-artifact labels, and `decision_log.md` when present. Identify:

- current subproblem and dependencies on earlier questions;
- current stage and completed gates;
- authoritative inputs and unresolved conflicts;
- the smallest next deliverable.

Do not infer that a route has been selected merely because code exists. Prefer an explicit decision-log entry or the user's statement.

## Stage Routing

Route work by the evidence available:

1. Problem not structurally understood -> `$math-modeling-problem-decomposer`.
2. Structure clear but route not selected -> `$math-modeling-strategy-designer`.
3. Route explicitly selected -> `$math-modeling-code-experiment`.
4. Executed artifacts exist and need technical review -> `$math-modeling-model-validator`.
5. Final model/configuration fixed -> `$math-modeling-methodology-writer`.
6. Verified numerical outputs exist -> `$math-modeling-solution-writer`.
7. Paper and final artifacts are ready -> `$math-modeling-consistency-auditor`.

If the user explicitly requests one specialist stage, hand off directly instead of replaying earlier stages.

## Gates

- **Route gate:** when candidate routes differ materially, present recommendation, alternative, evidence, and risk. Ask the user to select unless one route dominates by stated hard constraints.
- **Execution gate:** do not send work to implementation without a selected route, target outputs, and split/validation plan.
- **Writing gate:** methodology may begin after final model/configuration is fixed; solution writing requires actual result artifacts.
- **Submission gate:** do not call the project ready while unresolved `FAIL` findings remain.

## Decision Log

When file changes are authorized, maintain `decision_log.md` with timestamp, subproblem, decision, alternatives rejected, evidence paths, assumptions changed, configuration/run identifier, and open risks. Never silently rewrite an earlier decision; append a superseding entry.

For the recommended directory layout and stage evidence, read [references/project-workflow.md](references/project-workflow.md).

## Output

Return a compact status containing current stage, verified inputs, completed gates, blocked gates, selected next skill, exact next deliverable, and any user decision required. Mark anything not directly checked as `NOT VERIFIED`.
