# Skill 优化报告

## 优化目标

把原有“三段式：选模型并写代码 -> 模型建立 -> 模型求解”重构为带阶段 Gate、事实源和提交审计的最小充分工作流。原只读 source 不修改；所有新文件先在独立构建区生成并验证。

## 新架构

```text
math-modeling-orchestrator
    ├── math-modeling-problem-decomposer
    ├── math-modeling-strategy-designer
    ├── math-modeling-code-experiment
    ├── math-modeling-model-validator
    ├── math-modeling-methodology-writer
    ├── math-modeling-solution-writer
    └── math-modeling-consistency-auditor

shared language skills
    ├── nature-writing
    └── humanizer-zh
```

这 8 个建模 Skill 对应不同工件成熟度，公共写作 Skill 只提供通用写作/语言能力。创新审计、简洁性 Gate、消融、敏感性与稳健性分别内聚到策略、实验和验证阶段，没有再拆成独立 Skill。

## 逐项修改

| 原问题 | 修改后机制 |
|---|---|
| 直接从题型跳算法 | `problem-decomposer` 禁止推荐算法，先产出变量、约束、尺度、依赖与附件审计 |
| 默认 TOPSIS/XGBoost/LSTM/GA/PSO | `strategy-designer` 要求 3–5 条不同范式路线并逐项给证据 |
| 缺少路线竞争 | 建立十维 route scorecard 与最小判别实验 |
| 缺少同质化风险 | 单列 Homogenization Risk，只评价方法常见度、模板化和问题特异性 |
| 把算法名当创新 | 三层创新审计：问题、模型、验证；明确算法名本身不是创新 |
| 模型堆砌 | 每个模块必须回答独立作用并设计对应消融，否则拒绝加入 |
| Code Skill 擅自选模型 | 新增 Entry Gate；只有用户明确选定路线或明确指定模型后才能实现 |
| baseline 可选 | 复杂模型强制可信 baseline |
| 数据泄漏 | 按 exchangeability/group/time/rolling/LOGO 选择切分，并要求训练折内预处理 |
| 缺少可复现性 | 统一 run ID、输入/代码 hash、依赖、seed、参数、split、timestamp、artifact paths |
| 硬编码 TkAgg | 改为运行环境自适应；GUI 可选交互 backend，headless 使用 `Agg` 等非交互 backend |
| 缺少消融 | 多模块模型使用 M0 -> M0+A -> M0+A+B -> full 的贡献链 |
| 缺少敏感性/稳健性 | 参数区间与 robustness 方法按主要不确定性选择，不机械全跑 |
| 缺少独立验证 | 新建 `model-validator`，用 PASS/WARNING/FAIL/NOT VERIFIED 和证据路径 |
| 模型建立混入结果 | methodology Skill 以最终 code/config/variable ledger 为事实源并设置硬边界 |
| 求解数字不可追溯 | solution Skill 强制 run identity 与 claim-to-evidence ledger |
| 论文与产物不一致 | 新建 consistency auditor，比对公式、参数、表、图、结论和运行产物 |
| 公共依赖重复 | 正式版 `nature-writing`、`humanizer-zh` 各保留一个 sibling Skill |
| nature-writing 缺依赖 | 删除失效 `_shared` 路由，重构为自包含的证据驱动写作 Skill |
| humanizer 范围过宽 | 收窄为“已有文本的语言编辑”，事实与证据完全不可变 |

## 新增 Skill 的必要性

- `math-modeling-orchestrator`：只有它需要跨问题/阶段维护 Gate 与 decision log；不承担计算。
- `math-modeling-problem-decomposer`：把问题抽象和算法选择分开，防止题型标签触发模板。
- `math-modeling-strategy-designer`：承载多范式竞争、评分、创新/同质化与简洁性 Gate。
- `math-modeling-model-validator`：实验作者与结果审计是不同职责，且验证需要独立证据等级。
- `math-modeling-consistency-auditor`：提交前跨论文/代码/配置/表图的事实核对不能由单一写作 Skill 兼任。

## 保留与收窄

- 保留 `math-modeling-code-experiment`，仅负责选定路线后的实现与实验。
- 保留 `math-modeling-methodology-writer`，仅写“模型建立”。
- 保留 `math-modeling-solution-writer`，仅从真实输出写“模型求解与结果分析”。
- 保留一个 `nature-writing` 与一个 `humanizer-zh`，作为共享 sibling Skill。

## 删除/合并

- 正式运行版删除两个主写作 Skill 下的 `bundled_dependencies`；source 内原副本不删除。
- 没有创建独立 Originality Auditor、Ablation Skill、Sensitivity Skill 或 Robustness Skill。这些能力分别合并进 strategy/code/validator，避免过度拆分和触发竞争。
- 原 `nature-writing` 的大规模通用示例库不进入正式版；它与数学建模主流程无必要运行关系，且路由不完整。原资料仍完整保留在 source。

## 触发边界

| Skill | 进入条件 | 不应进入 |
|---|---|---|
| orchestrator | 开始/恢复/协调全流程或多问 | 用户已明确请求单一专业阶段 |
| problem-decomposer | 题目尚未结构化 | 已经开始比较模型路线 |
| strategy-designer | 结构明确、路线未定 | 路线已明确选定 |
| code-experiment | 路线已选，需实现/实验 | “我没思路，随便选模型” |
| model-validator | code 或输出已存在，需有效性审计 | 初始选型或论文写作 |
| methodology-writer | 最终模型/code/config 已定 | 要求写真实指标/预测值 |
| solution-writer | 实际最终输出已产生 | 只有模型设想或只有未运行代码 |
| consistency-auditor | 论文和最终产物已形成 | 单纯写作或模型实现 |
| nature-writing | 通用科研章节草拟/重构 | 专门的数模模型建立/求解 |
| humanizer-zh | 已有文本的语言润色 | 从零设计研究或模型 |

## 测试集

- `tests/trigger-cases.yaml`：每个 Skill 至少一个 positive、negative、boundary case；包含用户指定的六条 smoke-test 文案。
- `tests/modeling-route-cases.md`：评价、横截面预测、优化、时间序列、机理建模五类反模板题。
- 静态验证覆盖 frontmatter、唯一 name、description、`agents/openai.yaml`、显式默认提示、相对引用、危险脚本/路径、UTF-8 与关键行为条款。

运行结果在复制到正式工作台后写入测试报告；当前文档不预先声称运行通过。

## 比赛项目建议

标准结构由 orchestrator 的 `references/project-workflow.md` 提供，核心是保留 `decision_log.md`，记录路线选择/淘汰、假设与参数变更以及最终 run ID。现有项目不强制迁移，只做角色映射和必要补齐。
