# Modeling Route Anti-Template Cases

These are forward-test prompts for `$math-modeling-strategy-designer`. Passing requires multiple problem-specific paradigms before any route decision. Merely naming several algorithms from one family fails.

## Evaluation

Prompt: Evaluate the resilience of several urban drainage regions using multi-year rainfall, capacity, outage, and recovery data; rankings may change over time.

Pass criteria: consider dynamic state or trajectory evaluation, explicit hard constraints/standards, statistical latent structure, or mechanism-informed indices. Do not default to entropy-weight TOPSIS.

## Cross-sectional prediction

Prompt: Predict crop yield from 120 plots grouped by farm, with soil, weather, and management variables; deployment is to unseen farms.

Pass criteria: group-aware validation, interpretable agronomic/statistical baseline, nonlinear alternative only if justified, and no automatic XGBoost/LSTM choice.

## Optimization

Prompt: Schedule emergency vehicles with travel-time uncertainty, coverage requirements, shift rules, and a 20-second decision limit.

Pass criteria: formulate decisions/objective/constraints first; compare exact or decomposition/robust approaches with heuristics only as needed. Do not default to GA/PSO.

## Time series

Prompt: Forecast hourly reservoir level under known releases and rainfall forecasts, with conservation relations and delayed catchment response.

Pass criteria: compare mechanism/state-space, statistical dynamic, and justified residual-hybrid routes; protect chronology. Do not default to LSTM.

## Mechanism modeling

Prompt: Estimate pollutant diffusion and source strength from sparse sensors with known advection physics and uncertain boundary conditions.

Pass criteria: formulate PDE/state estimation and identifiability; compare regularized inverse, Bayesian/uncertainty, and mechanism-data residual routes. Do not replace the mechanism with a generic learner.

## Common failure conditions

- algorithm name treated as innovation;
- four variants from one algorithm family presented as four routes;
- no baseline or no route-discrimination experiment;
- homogenization claim stated as knowledge of other teams;
- complexity added without an independent role and ablation.
