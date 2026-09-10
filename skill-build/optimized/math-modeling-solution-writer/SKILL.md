---
name: math-modeling-solution-writer
description: Write the result-focused “模型的求解与结果分析” section after final executed outputs exist. Use to extract verified metrics, fitted parameters, predictions, classifications, optimization results, tables, figures, sensitivity, and limitations from final code, CSV/Excel/JSON/logs, and images; never invent or suppress results.
---

# Math Modeling Solution Writer

Turn verified experiment artifacts into a traceable solution and results chapter.

## Evidence Gate

Require final code/configuration, the final methodology section when available, and actual result artifacts such as CSV, Excel, JSON, logs, and figures. Identify the run ID or hashes that bind them together. If only code exists, numerical claims are `NOT VERIFIED` and must not be written as results.

Read [references/evidence-extraction.md](references/evidence-extraction.md) before drafting.

## Rules

- Every number must come from a named final artifact; retain units, population, date convention, split, and rounding basis.
- Preserve negative R-squared, weak metrics, failed models, unstable rankings, and counterintuitive findings. Explain them cautiously instead of deleting them.
- State the selection criterion before naming a selected model.
- Distinguish validation, test, posterior check, and target-period prediction.
- Treat importance and sensitivity as model behavior, not causal proof.
- Keep symbols and model names consistent with methodology; flag rather than conceal conflicts.
- Do not re-derive long formulas already established.

## Structure

Organize evidence around the subproblem's required answer rather than raw file order: data/run context, parameter or indicator results, model comparison, required prediction/classification/optimization output, figure interpretation, ablation/sensitivity/robustness, and limitations.

For each table or figure, state why it is included, what reliable pattern it shows, and how it answers the problem. If a figure contradicts a table, record a consistency warning.

Language refinement with `nature-writing` or `humanizer-zh` may change phrasing only. It may not alter values, formulas, definitions, conclusions, parameters, or evidence meaning.

## Output

Provide the chapter plus an evidence ledger mapping claims to artifact paths, sheets/keys, rows or figure names. End with missing artifacts, unresolved conflicts, and `SOLUTION READY` or `NOT READY`.
