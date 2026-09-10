# Validation Matrix

| Model/data pattern | Priority checks |
|---|---|
| time series or panel | chronological split, rolling validation, future features, shifted target aggregates, window stability |
| grouped entities | group leakage, leave-one-group-out behavior, entity imbalance |
| ranking/evaluation | indicator direction and units, hard-vs-soft rules, weight sensitivity, rank reversal, missing-value effect |
| optimization | feasibility, constraint satisfaction, baseline policy, optimality gap/bounds when available, seed stability |
| mechanism model | dimensional consistency, conservation, parameter identifiability, boundary hits, residual structure |
| supervised ML | target leakage, nested preprocessing/tuning, calibration or task metrics, baseline, seed stability |
| statistical regression | residuals, multicollinearity, heteroskedasticity, influential points, interval assumptions |

For multi-module models, require component-wise ablation. For key parameters, inspect conclusion or ranking changes, not only metric changes. Robustness should test the dominant uncertainty source rather than accumulate unrelated procedures.
