# Decision Log

> Append-only. Later decisions must be added as new entries; earlier entries must not be silently rewritten.

## 2026-09-02T23:41:32+08:00 — Project intake and initialization

- **Scope:** Problems 1–5; intake stage only.
- **Run/configuration ID:** `init-20260902T234132+0800`
- **Decision:** Initialize the standard competition project structure without starting model selection, optimization, or numerical experiments.
- **Authoritative inputs verified:** One received JPG screenshot of the A-problem statement. It is evidence of the displayed statement, but it is not a complete official PDF package.
- **Alternatives rejected:**
  - Treating the JPG screenshot as the complete official A-problem PDF.
  - Reconstructing `result1.xlsx`, `result2.xlsx`, or `result3.xlsx` from memory or inferred columns.
  - Selecting or implementing an optimization route before structural decomposition and the route gate.
- **Evidence:**
  - Source: `D:\weixin\xwechat_files\wxid_14uqb6rsj6il22_fe33\temp\RWTemp\2026-09\42a7492cf08253b6156775d2a3b7631c\3f6cb8b4f662c51d15ad386ce458302c.jpg`
  - Archived copy: `00_problem/received/3f6cb8b4f662c51d15ad386ce458302c.jpg`
  - SHA-256: `20C355E6FE3DEF923EB6C90018F8D302A4AF772DC265B65E7E5F6C4A51933D80`
  - Audit record: `12_audit/input_audit.md`
- **Assumptions changed:** None. No mathematical interpretation has been adopted at this stage.
- **Open risks/blockers:** The complete official A-problem PDF and official templates `result1.xlsx`, `result2.xlsx`, and `result3.xlsx` are missing. Other official attachments, if any, are not verified.
- **Gate status:** Intake structure complete; Problem Decomposer is next. Route, execution, writing, and submission gates remain closed.

## 2026-09-02T23:50:21+08:00 — Official input recovery and formal decomposition

- **Scope:** Problems 1–5; formal problem decomposition only.
- **Run/configuration ID:** `decomposition-20260902T235021+0800`
- **Authoritative-input decision:** Use the Chinese problem bundle linked by the CUMCM organizer-authorized China College Student Online release page. Archive the original ZIP, A-problem PDF, and all three A-problem templates as read-only files.
- **Verified evidence:**
  - `00_problem/official/2025_CUMCM_Chinese_Problems.zip`, SHA-256 `CEF6262C24EE3017BDAB4CA255299C7B47B2700AD89FD773ADDDE7E241E7E4DE`.
  - `00_problem/official/A题.pdf`, SHA-256 `A37F6AAD30B16EA09DA9CB320CE194B12D3A28874008CF9FF19549F6C6079447`.
  - `02_data_raw/official_templates/result1.xlsx`, SHA-256 `AF04B16E6A4719628971BCF5A03D230C9DA6738E67EEBAC9276D254FDD4DF1A7`.
  - `02_data_raw/official_templates/result2.xlsx`, SHA-256 `C681D5E378538F71C77FCA199A3CA8303A04DBCFC7BD95F870AE22F01AB69F91`.
  - `02_data_raw/official_templates/result3.xlsx`, SHA-256 `B648C82D63E459BA6E6B3711AE79875E373521CD543B45571C4D8FF1AD5EC54A`.
- **Geometry decision:** The high-fidelity criterion requires the smoke sphere to intercept every line of sight from the missile to the visible silhouette of the actual radius-7 m, height-10 m cylinder. This is the main model. The geometric-center point criterion is retained only as a baseline.
- **Time-aggregation decision:** For each missile, total effective shielding time is the measure of the union of all effective intervals. Overlaps are never added twice. For Q5, the working primary objective is the unweighted sum of the three missile-specific union durations, with all three durations reported separately.
- **Assumptions introduced and exposed:** The problem does not state a numerical gravitational acceleration; use `g=9.8 m/s^2` provisionally and test sensitivity to `9.80665`. A released bomb inherits the UAV's horizontal velocity and has zero initial vertical velocity. Drag, wind, horizontal cloud drift, radius growth, and guidance feedback are absent because the statement supplies none.
- **Alternatives rejected:**
  - Treating the bottom-center coordinate `(0,200,0)` as the whole target without disclosure.
  - Using infinite-line distance instead of the missile-to-target line segment.
  - Adding individual smoke durations without removing overlaps.
  - Treating release and detonation points as independent of flight and ballistic dynamics.
  - Selecting or implementing an optimization algorithm during decomposition.
- **Evidence paths:** `01_problem_analysis/FORMAL_PROBLEM_SPEC.md`, `01_problem_analysis/VARIABLES_AND_CONSTRAINTS.md`, `01_problem_analysis/GEOMETRY_DEFINITION.md`, `01_problem_analysis/QUESTION_DEPENDENCY_MAP.md`.
- **Open risks:** The official statement leaves the exact obscuration semantics, numerical `g`, and Q5 cross-missile aggregation implicit. They are now parameterized and must be covered by model comparison, sensitivity analysis, and final reporting rather than hidden.
- **Gate status:** Input and decomposition gates pass. Route gate is next. Execution, writing, and submission gates remain closed.

## 2026-09-03T00:03:00+08:00 — Candidate-route design and recommendation (not selected)

- **Scope:** Problems 1–5; model-route comparison only. No production implementation was started.
- **Run/configuration ID:** `strategy-design-20260903T000300+0800`
- **Candidate routes:**
  - ROUTE A: perspective analytic geometry with continuous-time event isolation.
  - ROUTE B: adaptive high-fidelity geometry evaluator with continuous parameter optimization.
  - ROUTE C: time-expanded candidate actions and explicit maximum-coverage formulation.
  - ROUTE D: obscuration-kernel/UAV-reachability decomposition with assignment, continuous refinement, and final joint reevaluation.
- **Recommendation, not decision:** ROUTE D is recommended as the main route; ROUTE B is the viable fallback and independent evaluator route. ROUTE A and ROUTE C are retained for cross-validation and ablation roles.
- **Decisive evidence:** ROUTE D directly exploits the problem-specific cylinder visibility kernel, ballistic reachability, per-UAV shared heading/speed, release spacing, missile-specific interval unions, and Q5 task structure. It offers a clearer validation chain than a monolithic joint black box.
- **Alternatives not rejected:** All four routes remain technically viable. ROUTE A has high derivation risk at Q5; ROUTE B has cost and homogenization risk; ROUTE C has discretization and candidate-growth risk.
- **Q5 recommendation:** Use multiple retained task assignments plus continuous parameter refinement and final limited joint reconciliation. Keep a reduced fully joint formulation as a discriminator, not as the sole production structure.
- **Independent evaluator decision:** Every route must call the same deterministic, optimizer-agnostic evaluator that returns per-pair intervals, missile-wise interval unions, geometry margins, tolerance diagnostics, and certification status.
- **Simplicity gate:** Retain only components with independent roles and ablation evidence: strict evaluator, obscuration kernel, reachability screen, multiple task structures, continuous refinement, and final joint reevaluation. Do not treat a change of outer optimizer as a new model component.
- **Evidence paths:** `02_model_candidates/ROUTE_A.md`, `ROUTE_B.md`, `ROUTE_C.md`, `ROUTE_D.md`, `ROUTE_COMPARISON.md`, `RECOMMENDATION.md`.
- **Open risks:** Reachability false negatives, task-locking, continuous boundary miss, evaluator cost, and Q5 aggregation sensitivity.
- **Gate status:** Candidate generation and recommendation complete. `selected_route` remains unset; route gate awaits explicit user confirmation. Execution gate remains closed.
