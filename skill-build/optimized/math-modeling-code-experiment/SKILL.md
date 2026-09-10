---
name: math-modeling-code-experiment
description: Implement and run a mathematical modeling experiment only after the main route has been explicitly selected. Use for reproducible Python, MATLAB, or R code, baselines, leakage-safe splits, ablations, result tables, figures, and run manifests; do not choose the initial modeling route or write paper chapters.
---

# Math Modeling Code Experiment

Turn an approved route into reproducible code and verified artifacts.

## Entry Gate

Require the selected route, target subproblem, authoritative data, required outputs, and validation protocol. A direct user instruction such as “use route B” or “implement this specified model” satisfies route selection. If the route is absent or still contested, return to `$math-modeling-strategy-designer`.

## Implementation Contract

1. Inspect existing preprocessing, schemas, units, and prior question outputs; preserve raw data.
2. Establish a credible baseline before a complex model.
3. Choose split protocol from task structure: random only for genuinely exchangeable observations; otherwise group, time, rolling-window, or leave-one-group-out.
4. Fit preprocessing, feature selection, imputation, scaling, and tuning inside training folds only.
5. Implement selected route and only those extra modules that pass the simplicity gate.
6. If multiple improvements exist, run an ablation ladder such as M0, M0+A, M0+A+B, full model.
7. Produce error analysis and task-relevant sensitivity/robustness experiments.
8. Save code, configuration, run manifest, tables, figures, and diagnostics with stable paths.

Read [references/experiment-protocol.md](references/experiment-protocol.md) before finalizing an experiment.

## Reproducibility

Record random seed, dependency versions, input file hashes or dataset version, feature set, parameters, split method, timestamp, code path/hash, and output paths. Never label an unexecuted or failed run as verified.

## Plotting

Do not hard-code `TkAgg` for every environment. Select a backend before importing `pyplot` only when needed: a GUI backend may be used in an interactive Windows session, while a headless run should use a safe non-interactive backend such as `Agg`. Every final plot must save to PNG and, when suitable for paper use, PDF.

## Outputs

At minimum provide an executable script or project, machine-readable configuration, result table, diagnostics, run manifest, and paper-ready figures when the task needs them. Preserve poor or negative metrics and failed-model diagnostics; do not improve results in prose.

End with execution status, checks actually performed, artifact paths, known limitations, and whether the artifacts are ready for `$math-modeling-model-validator`.
