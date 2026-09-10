# Experiment Protocol

## Leakage checks

- target and future information unavailable at prediction time;
- temporal ordering and autoregressive rollout;
- preprocessing, normalization, feature selection, and tuning fitted on training data only;
- group or entity overlap between folds;
- target-derived aggregates and post-outcome features;
- evaluation-set reuse during model selection.

## Baseline and metrics

Use the simplest credible comparator: persistence or seasonal naive for time series, linear/additive models for regression, rule or historical policy for optimization/evaluation, and a transparent mechanism baseline for hybrid models. Select metrics from the decision consequence and data distribution; do not emphasize a metric that is undefined or misleading.

## Ablation, sensitivity, robustness

For each added component, compare against the nearest simpler model. For key parameters, test `-10%, -5%, baseline, +5%, +10%` when meaningful, otherwise justify another range. Choose robustness methods relevant to the data: bootstrap, Monte Carlo, noise perturbation, random seeds, time windows, split variants, or parameter settings. Do not run every method mechanically.

## Required run manifest

Record run ID, timestamp, source hashes, code hash, environment/dependencies, seed, features, split boundaries, parameters, metrics, artifacts, warnings, and whether each artifact was actually generated.

## Numerical and data diagnostics

Check relevant missingness, duplicates, outliers, invalid ranges, units, NaN/Inf, overflow, singularity, convergence, parameter bounds, and residual behavior. Preserve diagnostics even when a model fails.
