---
name: math-modeling-methodology-writer
description: Write the methodology-only “模型的建立” section after the final mathematical model, variables, code, and configuration are fixed. Use for assumptions, symbols, formulas, objective functions, constraints, estimation, training, and algorithm flow; exclude empirical metrics, final predictions, rankings, and result interpretation.
---

# Math Modeling Methodology Writer

Write a model-establishment chapter whose facts are traceable to the final adopted model, code, variables, and configuration.

## Evidence Gate

Read the problem statement, selected-route decision, final code, final configuration, and variable/unit ledger. Result artifacts may be read only to check names and workflow consistency. If several versions conflict, use the user-designated final artifact; otherwise flag the conflict instead of guessing.

## Allowed Content

- task formulation and why the adopted structure matches it;
- assumptions with scope and testability;
- symbols, variables, units, and data/sample construction;
- mathematical equations, objective functions, constraints, and state transitions;
- parameter estimation, preprocessing, split principles, training protocol, and solver flow;
- baseline and candidate comparison criteria without empirical outcomes;
- ablation, sensitivity, and robustness design without results.

## Hard Boundary

Do not include observed RMSE, MAE, R-squared, accuracy, fitted result rankings, final predictions, class proportions, sensitivity responses, or “results show” claims. Fixed standards and predeclared design constants may be included and must be identified as such. Read [references/method-result-boundary.md](references/method-result-boundary.md) when a value is ambiguous.

Do not reconstruct a cleaner theory that the final code does not implement. If the implementation deviates from the intended model, report the discrepancy for correction or consistency audit.

## Drafting

Build a coherent argument from problem requirement to variables, formulation, estimation, validation design, and output definition. Use strict LaTeX, define symbols before use, keep units consistent, and separate mechanism from empirical approximation. Prefer natural paragraphs and purposeful tables.

When `nature-writing` and `humanizer-zh` are installed, their drafting and language principles may refine prose, but they may not change facts, formulas, definitions, parameters, or boundaries.

## Output

Name every authoritative source used and every unresolved mismatch. Mark the chapter `METHODOLOGY READY` only when its formulas and procedure agree with the final code/configuration.
