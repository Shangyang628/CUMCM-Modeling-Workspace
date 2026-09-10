# Project Structure

The project follows the competition workflow below. Official source files and Excel templates are treated as immutable inputs. Final workbooks will be produced only from copies placed under `submission/`.

```text
_SmokeInterference/
├── 00_problem/
│   ├── official/              # complete official statement when supplied
│   └── received/              # received screenshot evidence
├── 01_sources/                # references and source ledger
├── 02_data_raw/
│   ├── official_attachments/  # immutable official attachments
│   └── official_templates/    # immutable result1/2/3.xlsx
├── 03_data_processed/         # derived data only
├── 04_problem_analysis/       # decompositions and variable/constraint ledgers
├── 05_model_candidates/       # route comparisons and explicit route decisions
├── 06_models/Q1/ ... Q5/      # final model implementations by problem
├── 07_experiments/
│   ├── configs/
│   ├── logs/
│   └── runs/
├── 08_results/
│   ├── intermediate/
│   └── final/
├── 09_figures/
├── 10_tables/
├── 11_paper/
│   └── sections/
├── 12_audit/                  # input, validation, and consistency evidence
├── submission/                # final copied deliverables only
├── decision_log.md
├── run_manifest.json
└── WORKFLOW_PLAN.md
```

