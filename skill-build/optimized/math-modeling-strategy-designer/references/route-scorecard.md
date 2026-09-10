# Route Scorecard

Score each dimension from 1 (poor) to 5 (strong). For risk dimensions, 5 means low risk. Show evidence and uncertainty; do not hide tradeoffs in a single total.

| Dimension | Question |
|---|---|
| Problem Fit | Does the formulation answer the exact required deliverable? |
| Mathematical Soundness | Are assumptions, objective, constraints, and estimators coherent? |
| Data Suitability | Are sample size, labels, resolution, and future inputs sufficient? |
| Interpretability | Can variables and mechanisms be explained at the required level? |
| Robustness | Can conclusions survive plausible perturbations or resampling? |
| Computational Cost | Is runtime feasible under contest limits? |
| Implementation Risk | Can the team implement and debug it reliably? |
| Paper Expressiveness | Can formulation and evidence be communicated clearly? |
| Originality Potential | Is novelty tied to the problem, structure, or validation? |
| Homogenization Risk | Is the route problem-specific rather than a common template? |

Suggested default weights are equal. Change weights only for an explicit contest priority or hard delivery constraint, and record the reason.

## Innovation audit

- **Level 1 — problem:** improved state definition, units, dynamics, or decision framing.
- **Level 2 — model:** mechanism features, custom objective, constraints, state transitions, residual correction, or justified composition.
- **Level 3 — validation:** rolling evaluation, bootstrap, ablation, sensitivity, uncertainty, or stress testing appropriate to the task.

XGBoost, Random Forest, LightGBM, LSTM, Transformer, TOPSIS, AHP, PCA, K-means, PSO, GA, NSGA-II, or simulated annealing is not an innovation claim by itself.
