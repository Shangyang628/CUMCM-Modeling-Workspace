# Competition Project Workflow

Use this layout when creating or normalizing a competition project:

```text
Competition/
├── 00_problem/
├── 01_sources/
├── 02_data_raw/
├── 03_data_processed/
├── 04_problem_analysis/
├── 05_model_candidates/
├── 06_models/Q1/ ... Q4/
├── 07_experiments/
├── 08_results/
├── 09_figures/
├── 10_tables/
├── 11_paper/
├── 12_audit/
└── decision_log.md
```

Do not move existing projects merely to match this template. Map current folders to these roles and create only missing folders the user needs.

## Evidence by stage

| Stage | Minimum evidence |
|---|---|
| decomposition | problem structure record and attachment inventory |
| strategy | candidate-route scorecard and route decision |
| experiment | code, configuration, split protocol, run manifest, outputs |
| validation | evidence-linked PASS/WARNING/FAIL report |
| methodology | final code/configuration and variable ledger |
| solution | verified tables, figures, logs, and run identifier |
| consistency | paper plus every final artifact named by the paper |

The decision log should record why a model was chosen, why alternatives were rejected, assumptions or parameters changed, and which run produced final results.
