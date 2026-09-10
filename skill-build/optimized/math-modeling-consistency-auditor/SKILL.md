---
name: math-modeling-consistency-auditor
description: Perform a pre-submission fact-consistency audit after the mathematical modeling paper and final code, configuration, tables, workbooks, figures, and logs are formed. Use to compare formulas, parameters, data definitions, numbers, images, and conclusions with evidence-linked PASS/WARNING/FAIL findings; do not rewrite artifacts unless separately asked.
---

# Math Modeling Consistency Auditor

Verify that the final paper describes the final executable model and its actual outputs.

## Inputs

Require the paper version under review and the authoritative final code, configuration, result tables/workbooks, figures, logs, and run manifest. Record hashes or timestamps where useful. If an artifact is missing, mark dependent checks `NOT VERIFIED`.

## Cross-Checks

Use [references/submission-checklist.md](references/submission-checklist.md) to compare:

- paper equations and algorithm steps vs final code;
- symbols, variables, units, time/spatial conventions, and preprocessing definitions;
- paper parameters and thresholds vs configuration and code;
- paper tables and quoted values vs CSV/Excel/JSON/log outputs;
- captions, legends, axes, and figure claims vs final image files;
- selected model, baseline, split, metrics, ablation, sensitivity, and robustness claims;
- conclusions vs the evidence actually produced.

## Severity

- `PASS`: checked and consistent.
- `WARNING`: ambiguity, weak traceability, rounding drift, or non-blocking limitation.
- `FAIL`: factual contradiction, untraceable result, wrong artifact/version, missing required answer, or unsupported conclusion.
- `NOT VERIFIED`: required evidence unavailable.

Each finding must include paper location, expected fact, observed fact, evidence path and locator, consequence, and proposed correction. Do not silently choose between conflicting artifacts.

## Output

Produce an executive gate, evidence inventory, finding table, unresolved artifact/version conflicts, and correction checklist. Submission readiness is `PASS` only when no `FAIL` remains and every required claim is verified. Do not modify paper or code unless the user explicitly asks for fixes.
