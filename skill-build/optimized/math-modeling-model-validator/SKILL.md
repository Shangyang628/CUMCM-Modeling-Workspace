---
name: math-modeling-model-validator
description: Audit an implemented mathematical model and its executed experiment artifacts for data quality, leakage, numerical and statistical validity, ablation, sensitivity, robustness, and reproducibility. Use after code or outputs exist and before paper writing or submission; do not select the initial route or silently rewrite the model.
---

# Math Modeling Model Validator

Evaluate the implemented model against the question, code, configuration, run manifest, data, and outputs. This is an evidence audit, not a request to make weak results look stronger.

## Scope

Identify the exact run and authoritative artifacts. If outputs are missing, distinguish static code review from executed-result validation. Do not mark execution-dependent checks as passed when the code was not run.

## Risk-Based Validation

Use [references/validation-matrix.md](references/validation-matrix.md) to select checks relevant to the model. At minimum consider:

- data integrity: missingness, duplicates, outliers, ranges, units, sample alignment;
- leakage: target, temporal, normalization, feature-selection, cross-validation, autoregressive;
- numerical behavior: NaN/Inf, overflow, singularity, convergence, parameter bounds;
- statistical behavior: overfitting, multicollinearity, heteroskedasticity, residual structure, unstable parameters;
- experimental evidence: baseline, split protocol, metrics, error analysis, ablation;
- stability: sensitivity, robustness, seeds/windows/resampling as relevant;
- reproducibility: hashes, versions, seed, configuration, timestamp, and run-to-artifact traceability.

Do not mechanically run irrelevant diagnostics. Explain why each chosen check matters and why omitted families are not applicable.

## Findings

Use:

- `PASS`: checked with sufficient evidence and acceptable result;
- `WARNING`: limitation or uncertainty that does not invalidate the main conclusion;
- `FAIL`: invalidates a result, violates a hard constraint, or blocks downstream use;
- `NOT VERIFIED`: evidence or execution is unavailable.

Each finding must include object, test, evidence path or command/output, consequence, and corrective action. A failed ablation means the claimed improvement is unsupported; it does not require hiding the full model.

## Gate

Output overall readiness for methodology writing and solution writing separately. Methodology may be writable from final code/configuration even when numerical validation is incomplete; solution claims require verified result artifacts. Do not alter code unless the user separately asks for a fix.
