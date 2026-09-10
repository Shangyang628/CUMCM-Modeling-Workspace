# 数学建模新题 Codex 全流程 Prompt 系统 V2.0

> 适用对象：全国大学生数学建模竞赛及相近数学建模赛事；适用于新题启动、题目拆解、数据审计、路线选择、代码实验、模型验证、论文写作、提交审计与 AI 使用说明。
>
> 推荐环境：已安装 `math-modeling-orchestrator`、`math-modeling-problem-decomposer`、`math-modeling-strategy-designer`、`math-modeling-code-experiment`、`math-modeling-model-validator`、`math-modeling-methodology-writer`、`math-modeling-solution-writer`、`math-modeling-consistency-auditor` 等 Skills 的 Codex。

---

## 0. 这套 Prompt 系统解决什么问题

这不是一条“帮我完成整道题并写论文”的超长指令，而是一套有状态、有证据、有 Gate 的执行协议。它要解决的核心问题是：

1. 防止 Codex 未完整读题就按题型标签套用常见算法；
2. 防止把算法名称当成数学模型或创新点；
3. 防止题目事实、个人经验、模型假设和 AI 推测混在一起；
4. 防止代码未运行、结果未核验时提前撰写论文并补造数字；
5. 防止不同问题、不同随机种子、不同版本的表格和图片相互串用；
6. 防止复杂模型没有 baseline、消融、敏感性、稳健性和失败诊断；
7. 防止只看优化器打印的目标值，不做独立重算和约束核验；
8. 防止覆盖原始题目、官方附件和官方提交模板；
9. 防止比赛中途更换模型后，旧图、旧表、旧结论仍进入最终论文；
10. 让每一轮对话都产生可以检查的工件，并能从中断点可靠恢复。

### 核心原则

完整 Prompt 的价值不在于堆叠角色、形容词和模型名，而在于同时写清：

> 当前目标 + 权威材料 + 当前范围 + 事实与约束 + 方法边界 + 交付物 + 验证方式 + 停止条件 + 状态更新。

推荐把它理解为“项目宪法 + 分阶段施工单”。项目宪法只建立一次；每个阶段只发送当前施工单，不把整份手册反复粘贴给 Codex。

---

# 第一部分　从现有材料中提炼出的改进结论

## 1. 已有材料中应继续保留的优点

现有提示词、论文模板、培训材料和优化后的 Skills 已经形成以下正确共识，应作为冻结基线：

- 先读题和审计附件，再选择模型；
- 大问题拆成连续、可检查的小任务；
- 每一轮都产生中间工件；
- 模型路线与求解器分开，算法名称不能代替数学建模思想；
- 复杂模型必须有可信 baseline；
- 代码实验与论文写作分离；
- 模型建立只写变量、假设、公式、约束和求解流程；
- 模型求解与结果分析只使用实际运行产物；
- 结果、图表、Excel、论文和代码必须进行最终一致性核对；
- 不虚构数据、字段、文献、实验、指标、运行状态和创新点；
- AI 参与建模、代码或结果分析时，应保留真实提示与人工核验记录；
- 第一次完整做题显式调用 `$skill-name`，隐式路由另行测试。

## 2. 原提示词仍存在的结构性不足

### 2.1 过度依赖“角色扮演”

“你是一名资深数学建模专家”只能影响语气，不能约束事实、版本和执行边界。新版把角色降为辅助信息，把权威输入、验收条件和停止规则放到前面。

### 2.2 固定问题数量和固定论文结构

旧提示词常默认问题一至问题五、摘要八段、每问一段。新赛题可能只有三问、六问，或一问包含多个子任务。新版一律先从原题提取真实问题树，再动态生成结构。

### 2.3 数据说明与建模脱节

旧版数据说明能列字段和前几行，但没有强制记录：字段在决策时是否可用、是否是结果发生后产生、同一实体是否重复观测、表间主外键、数据版本和文件哈希。新版加入“时间可用性/泄漏台账”和数据身份。

### 2.4 缺少事实优先级

培训资料、学长模板和 AI 建议不是官方规则。新版明确：当年官方文件优先，经验模板只作参考；发生冲突时停止并报告，不自行折中。

### 2.5 缺少执行权限说明

“读取文件”与“允许修改项目”是不同授权。新版每个 Prompt 明确只读或可写、允许创建哪些目录、禁止覆盖哪些文件、是否允许联网和安装依赖。

### 2.6 缺少失败后的版本治理

旧版要求 PASS 才进入下一阶段，但没有规定失败后如何使旧结果失效。新版要求新建 run ID，标记 stale artifacts，更新证据台账，禁止旧图表进入论文。

### 2.7 验收口径仍可能模糊

“结果准确”“模型合理”“可运行”不足以作为验收。新版要求可量化验收：约束逐项 PASS、独立重算一致、步长/容差收敛、重复运行稳定、结果可追溯到指定文件和键值。

### 2.8 效率规则不够明确

新版明确可并行与必须串行的任务，并引入时间预算、停止损失和降级路线：完成且验证过的可信简单模型，优于未完成或无法复现的复杂模型。

---

# 第二部分　统一 Prompt 契约

## 3. 九块式 Prompt 结构

以后编写任何数学建模 Prompt，尽量包含下列九块。若某块不适用，写明“不适用”，不要无声省略。

| 模块 | 必须回答的问题 |
|---|---|
| 1. 当前目标 | 这一轮只完成什么，明确不完成什么？ |
| 2. 权威输入 | 必须读取哪些文件、版本、工作表和既有工件？ |
| 3. 当前状态 | 已通过哪些 Gate，选定了哪条路线，最终 run 是哪个？ |
| 4. 事实与约束 | 题目硬条件、单位、范围、时序、匿名与格式要求是什么？ |
| 5. 方法边界 | 允许判断到什么程度，禁止提前选择、实现或写作什么？ |
| 6. 执行权限 | 哪些文件只读，允许新建/修改什么，能否联网或安装依赖？ |
| 7. 交付物 | 文件名、目录、格式、字段、图表和报告分别是什么？ |
| 8. 验收与证据 | 怎样证明完成，哪些检查必须 PASS，证据保存在哪里？ |
| 9. 停止条件 | 缺什么必须停止，完成后在哪里停，下一步由谁确认？ |

## 4. 全局事实优先级

所有阶段统一采用下列优先级，后者不得覆盖前者：

1. 当年赛事官网发布的正式赛题、格式规范、补充说明和官方附件；
2. 用户在当前项目中明确确认并写入 `decision_log.md` 的决定；
3. 已冻结的最终代码、配置、数据版本与最终 run 工件；
4. 经核验的原始文献、标准、官方数据和权威技术资料；
5. 用户提供的学长模板、培训材料、往届经验和非官方范例；
6. Codex 的推导、经验判断或一般性建议。

若不同层级冲突：

- 不得静默选择；
- 列出冲突位置、双方内容和影响；
- 高优先级来源明确时按高优先级执行；
- 高优先级本身不完整或含歧义时标记 `BLOCKED`，请求用户决定。

## 5. 四类陈述必须分开

项目中的每项重要条件必须标记为以下一种：

- `STATED FACT`：原题或官方附件明确给出；
- `VERIFIED FACT`：通过文件、代码运行、计算或权威来源核验；
- `ASSUMPTION`：为使问题可解而引入，必须说明目的、影响和验证方式；
- `DECISION`：在多种可行路线中由用户或硬约束选定。

严禁将 `ASSUMPTION` 写成题目事实，将 `DECISION` 写成唯一正确路线，将 `NOT VERIFIED` 写成已经通过。

## 6. 统一状态词

所有审计和 Gate 使用固定状态：

- `PASS`：已实际检查，证据充分且满足要求；
- `WARNING`：存在限制或不确定性，但不直接否定当前结论；
- `FAIL`：违反硬约束、结果无效或阻塞下游；
- `NOT VERIFIED`：缺少执行、文件或证据，不能判断；
- `BLOCKED`：继续工作需要用户决定、缺失关键文件或新增授权；
- `STALE`：工件来自已淘汰模型、旧数据或旧 run，不得继续引用。

## 7. 全局不可违反规则

以下规则建议写入项目的 `PROJECT_GOVERNANCE.md`，后续 Prompt 只要求 Codex 读取，不再重复全文：

1. 原题、官方附件、原始数据和官方提交模板只读；
2. 所有填写后的提交文件另存到 `submission/`，不得覆盖模板；
3. 不根据文件名猜测内容，必须实际读取；
4. 不补造字段、单位、文献、公式、算法步骤、运行结果和检验结论；
5. 不把缺失值随意填 0，不把“未观测”解释为“没有发生”；
6. 不把预测发生后才知道的字段用于预测；
7. 同一实体的重复观测不得跨训练集和测试集，除非任务和部署场景明确允许；
8. 时间序列和动态问题保护时间顺序，不使用未来信息；
9. 所有预处理、归一化、特征选择和调参仅在训练折内拟合；
10. 任何复杂模型先建立可信 baseline；
11. 每个新增模块必须说明独立作用，并有消融或对照证据；
12. 求解器只是工具，不能替代模型定义，也不能仅凭一次随机运行声称全局最优；
13. 最终候选必须交给独立 evaluator 重算目标和约束；
14. 论文数字必须定位到最终 artifact 的文件、sheet/key/row/figure 和 run ID；
15. 论文不能隐藏负指标、失败模型、边界条件或重要限制；
16. 外部文献必须真实可核验；无法核验时不生成具体作者、年份、题名或 DOI；
17. 图题与表题按论文模板放置，科学图表由真实数据生成，不用生成式图片伪造精确结果；
18. 任何参数、模型或数据变更都要追加 decision log，不覆盖旧决定；
19. 验证失败后，相关结果、图、表和文字立即标记 `STALE`；
20. 不在论文、代码、路径、截图、文件属性和支撑材料中泄露队伍身份、账号或密钥；
21. 只声明真实发生的 AI 用途、采纳、人工修改和核验；
22. 未经授权不删除旧文件、不执行来源不明的程序、不安装依赖、不上传数据；
23. 完成当前 Prompt 后停止，不擅自越过 Gate 开始下一阶段。

---

# 第三部分　新题启动前只需填写一次的信息

## 8. `PROJECT_CONTEXT` 填写模板

在新建 Codex Task 后，将下列内容填好。未知项写 `UNKNOWN`，不得猜测。

```yaml
PROJECT_CONTEXT:
  competition:
    name: "【赛事名称】"
    year: "【年份】"
    problem_id: "【A/B/C/...】"
    problem_title: "【题目名称】"
    official_rules_file: "【路径；没有则 UNKNOWN】"
  project:
    root: "【绝对路径】"
    mode: "正式比赛 | 完整模拟 | 教学练习 | Skill验收"
    current_stage: "NEW"
  goal:
    primary: "【完整交付/冲奖/学习某模型/验证Skills】"
    secondary: "【可选】"
    quality_priority: "正确性 > 可验证性 > 题目匹配 > 完整性 > 创新性 > 表达"
  team:
    members_background: "【专业与能力】"
    strengths: "【编程/数学/写作/领域知识】"
    weaknesses: "【真实短板】"
  time:
    total_remaining_hours: "【小时】"
    internal_deadline: "【时间】"
    official_deadline: "【时间】"
  inputs:
    problem_files:
      - "【题目PDF/图片/Word路径】"
    official_attachments:
      - "【数据/说明/模板路径】"
    non_official_references:
      - "【培训材料/学长模板/往届材料路径】"
  required_submission:
    paper_format: "DOCX | PDF | LaTeX | UNKNOWN"
    result_files:
      - "【官方要求的Excel/CSV/其他】"
    support_materials: "【代码、数据、AI详情等】"
  tools:
    preferred_language: "Python | MATLAB | R | 混合"
    available_solvers: "【已安装工具；未知写 UNKNOWN】"
    internet_policy: "禁止 | 只查权威来源 | 允许公开检索"
    dependency_policy: "禁止安装 | 可在确认后安装 | 允许安装"
  permissions:
    raw_inputs: "READ_ONLY"
    create_project_files: true
    modify_existing_work: "【允许/仅确认后/禁止】"
    delete_files: false
  language:
    analysis: "中文"
    paper: "中文"
    code_comments: "中文或英文"
  preferences:
    explicit_skill_calls: true
    preserve_failed_runs: true
    ask_only_material_questions: true
```

## 9. 推荐项目目录

```text
Competition_Project/
├─ 00_input_official/              # 原题、官方附件、官方模板，只读
├─ 01_governance/
│  ├─ PROJECT_CONTEXT.yaml
│  ├─ PROJECT_GOVERNANCE.md
│  ├─ SOURCE_REGISTRY.csv
│  ├─ PROJECT_STATE.json
│  ├─ decision_log.md
│  ├─ artifact_ledger.csv
│  └─ AI_USAGE_LOG.md
├─ 02_problem_analysis/
├─ 03_data_audit/
├─ 04_model_candidates/
├─ 05_common_core/
├─ 06_questions/
│  ├─ Q1/
│  ├─ Q2/
│  └─ Qn/
├─ 07_validation/
├─ 08_figures/
├─ 09_tables/
├─ 10_paper/
├─ 11_submission/
├─ 12_audit/
├─ 13_ai_disclosure/
├─ logs/
└─ README.md
```

若已有项目结构，不应为了匹配模板大规模搬迁。建立目录角色映射，只补齐实际缺少的文件夹。

---

# 第四部分　推荐执行方式

## 10. 三种使用模式

### 模式 A：标准分阶段执行（推荐）

依次使用 Prompt 0 至 Prompt 13。每个阶段通过 Gate 后才进入下一阶段。适合正式比赛、完整模拟和 Skills 验收。

### 模式 B：先生成本题专用 Prompt 包

先使用“Prompt 编译器”，让 Codex 只读题和附件，不求解，生成适配本题问题数量、数据类型和提交物的 Prompt 包。人工审阅后，再按包执行。

### 模式 C：比赛应急执行

时间紧张时使用应急 Prompt。仍保留题意审计、baseline、最终独立重算和提交一致性四个硬 Gate，但缩减候选路线、重复实验和非关键图表。

## 11. 可并行与必须串行

### 可安全并行的只读工作

- 输入文件清单、哈希和格式审计；
- Excel 各 sheet 的结构读取；
- 官方论文模板的格式与提交字段审计；
- 已有代码、日志和结果文件的版本盘点；
- 已确定检索范围后的不同权威来源检索。

### 必须串行的工作

- 题意冻结之后的路线选择；
- 路线选择之后的正式实现；
- 验证失败后的修复与新 run；
- 最终 run 冻结之后的论文数字写入；
- 多人或多代理对同一文件的修改；
- 提交文件填充与最终一致性审计。

### 并行写入规则

若使用多个代理或并行任务，每个任务必须拥有独立输出目录，禁止同时编辑同一文件；最终由一个主流程合并并进行一致性审计。

---

# 第五部分　标准分阶段 Prompt

## Prompt 0：新题正式启动与项目治理

```text
$math-modeling-orchestrator

请读取我提供的 PROJECT_CONTEXT、完整赛题、全部官方附件、官方提交模板，以及非官方参考材料。

本轮只做“输入审计、项目初始化和全流程规划”，不得开始选择模型、编写优化代码或撰写论文。

【事实优先级】
当年官方赛题/规则/附件 > 用户确认的 decision log > 冻结代码与最终 run > 经核验权威资料 > 非官方模板与培训材料 > AI推测。
非官方材料只能作为建议，不得被当作官方要求。发现冲突时必须报告。

【权限】
1. 原题、官方附件、原始数据和官方模板全部只读；
2. 允许在项目根目录内创建标准目录和治理文件；
3. 不得删除、覆盖或移动用户现有文件；
4. 不得执行来源不明的 EXE/脚本；
5. 不得未经授权安装依赖、联网或上传数据。

【执行任务】
1. 实际读取并列出所有输入文件，不根据文件名猜测；
2. 对每个输入记录：规范路径、文件类型、字节数、修改时间、SHA-256、来源类别、是否官方、用途、只读状态；
3. 检查题目页是否完整，附件是否能打开，官方结果模板是否齐全；
4. 识别问题数量、必要提交物、论文格式、匿名规则和时间限制，但不做数学建模；
5. 将官方硬要求与非官方写作建议分栏记录；
6. 检查现有项目目录并建立角色映射，只创建缺少的目录；
7. 创建或补齐：
   - 01_governance/PROJECT_CONTEXT.yaml
   - 01_governance/PROJECT_GOVERNANCE.md
   - 01_governance/SOURCE_REGISTRY.csv
   - 01_governance/PROJECT_STATE.json
   - 01_governance/decision_log.md
   - 01_governance/artifact_ledger.csv
   - 01_governance/AI_USAGE_LOG.md
   - README.md
8. 设计与真实问题数量一致的阶段计划、依赖关系和 Gate；
9. 给出比赛剩余时间的阶段预算，但将其标记为计划而非题目事实；
10. 明确当前最小下一交付物。

【状态要求】
所有未实际检查的项目标记 NOT VERIFIED；缺少文件时列出其影响，不要编造替代内容。非关键附件缺失时可继续不依赖它的工作；关键输入缺失时标记 BLOCKED。

【本轮输出文件】
01_governance/INPUT_AUDIT.md
01_governance/WORKFLOW_PLAN.md
01_governance/BLOCKERS.md

【最终只报告】
INPUT AUDIT
PROJECT STRUCTURE
SOURCE CONFLICTS
WORKFLOW PLAN
CURRENT GATE
BLOCKERS
NEXT SKILL AND EXACT NEXT DELIVERABLE

完成后停止，等待进入 Problem Decomposer。
```

### Prompt 0 验收

- [ ] 所有输入均被实际读取并有哈希；
- [ ] 官方与非官方来源分开；
- [ ] 原始文件未被修改；
- [ ] 问题数量与提交物来自原题；
- [ ] 已建立 decision log、artifact ledger 和 AI usage log；
- [ ] 未提前推荐算法。

---

## Prompt 1：完整题意拆解与数学对象冻结

```text
$math-modeling-problem-decomposer

读取完整赛题、全部相关附件、INPUT_AUDIT、PROJECT_CONTEXT 和 PROJECT_GOVERNANCE。

本轮只进行正式 Problem Decomposition。禁止推荐算法、禁止写代码、禁止把常见题型直接映射为 TOPSIS、XGBoost、LSTM、GA、PSO、DE、SA 或其他固定方法。

【逐项提取】
1. 坐标系、时间基准、空间范围、对象、实体、组、状态和事件；
2. 题目明确给出的常数、参数、范围、单位、精度和边界；
3. 每个问题的研究对象、输入、输出、决策变量、状态变量、控制变量、外生变量和目标变量；
4. 硬约束、软偏好、行业标准和输出格式；
5. 确定关系、可能因果关系、仅统计相关关系；
6. 各问题依赖哪些前序结果，哪些公共模块可以复用；
7. 数据在时间、空间、实体和采样频率上的粒度；
8. 不确定性、不可辨识性、缺失信息、未来不可用信息和潜在标签泄漏；
9. 每个问题本质上属于预测、评价、优化、仿真、反演、分类、机理或耦合任务中的哪一种；判断必须解释，不能由动词直接决定；
10. 每个问题最终必须回答的数值、方案、图表、文件或论证。

【关键定义】
找出题目中会直接改变答案、但自然语言可能有多种解释的核心定义。为每个定义建立：
- 原文位置；
- 可选数学解释；
- 各解释的后果；
- 题意支持程度；
- 需要用户决定还是可以通过验证比较。

【假设边界】
仅提出使问题适定所需的最小假设。每条假设写明：目的、依据、适用范围、若不成立的影响、后续验证方式。不得用假设掩盖缺失数据，不得假设模型正确或算法一定全局最优。

【输出契约】
对每一问定义 machine-readable 的答案 schema，包括字段、单位、允许范围、精度、来源和验收条件。

【输出文件】
02_problem_analysis/FORMAL_PROBLEM_SPEC.md
02_problem_analysis/PROBLEM_FACT_LEDGER.csv
02_problem_analysis/VARIABLES_UNITS_LEDGER.csv
02_problem_analysis/CONSTRAINT_UNCERTAINTY_LEDGER.csv
02_problem_analysis/QUESTION_DEPENDENCY_MAP.md
02_problem_analysis/AMBIGUITY_REGISTER.md
02_problem_analysis/ANSWER_SCHEMAS.json

更新 PROJECT_STATE、artifact_ledger 和 decision_log。不要把尚未确认的解释写成决定。

最后只给出：
DECOMPOSITION STATUS = PASS / WARNING / FAIL / NOT VERIFIED
READY FOR DATA AUDIT = YES / NO
READY FOR STRATEGY DESIGN = YES / NO
MATERIAL QUESTIONS FOR USER

完成后停止。
```

---

## Prompt 1B：复杂数据与附件专项审计

无数据或附件很简单时可以跳过。多工作表、多级表头、重复检测、时间序列、空间数据或官方填写模板存在时建议强制执行。

```text
$math-modeling-problem-decomposer

现在只做数据与附件审计，不做清洗、建模、训练、优化、绘图和论文写作。

必须实际读取所有文件和每个工作表。对每个文件/工作表输出：
1. 文件类型、路径、哈希、工作表名、可见/隐藏状态；
2. 数据区域、表头所在行、行列数、合并单元格、多级表头、公式、备注行、空白区；
3. 全部字段名称、原始数据类型、典型值、推定含义、单位、缺失率、唯一值情况；
4. 每一行代表的实体/事件/时间点；
5. 可能的主键、外键、实体ID、时间字段和表间连接关系；
6. 重复记录、同一实体多次观测、异常编码、单位混用和时间格式；
7. 目标字段与特征字段；
8. 每个字段在真实预测/决策时点是否可用：AVAILABLE / FUTURE / TARGET_DERIVED / UNCERTAIN；
9. 可能的数据泄漏路径；
10. 官方结果模板的 sheet、行列、字段、公式、格式和填写区域；
11. 原始数据是否足以回答每一问；不足处具体影响什么。

前5行仅作为结构示例，不得把示例当作全量统计。任何含义或单位无法从附件确认时标记 UNKNOWN 或 INFERENCE，并给出依据。

输出：
03_data_audit/DATASET_DESCRIPTION.md
03_data_audit/DATA_DICTIONARY.csv
03_data_audit/SHEET_STRUCTURE.json
03_data_audit/ENTITY_TIME_LEDGER.csv
03_data_audit/LEAKAGE_AVAILABILITY_LEDGER.csv
03_data_audit/TEMPLATE_FILLING_SPEC.md
03_data_audit/DATA_QUALITY_RISKS.md

原始文件只读，不保存清洗后的数据。本轮完成后停止。
```

---

## Prompt 2：多范式建模路线设计

```text
$math-modeling-strategy-designer

基于已冻结的 FORMAL_PROBLEM_SPEC、数据审计、问题依赖和提交要求，为【指定问题或公共模型】设计建模路线。

本轮不写正式生产代码，不直接采用单一方案，不把不同优化器当作不同建模路线。

【候选要求】
在证据支持的前提下提出 3–5 条真正不同的建模范式。可考虑但不限于：
- 解析/半解析机理模型；
- 数值仿真或状态空间模型；
- 统计推断或概率模型；
- 数学规划、动态规划、网络流、分解优化；
- 时空离散覆盖或图模型；
- 数据驱动模型；
- 机理—数据混合模型。

同一模型仅更换 GA、PSO、DE、SA、CMA-ES 或不同树模型，不算不同路线。

【每条路线必须写清】
1. 数学对象与核心 formulation；
2. 输入、输出、决策变量、目标函数和约束；
3. 必要假设与数据要求；
4. 公共 evaluator 或损失函数如何定义；
5. 最简单可信 baseline；
6. 求解器只是如何实现该模型；
7. 验证、消融、敏感性和稳健性方案；
8. 计算复杂度和比赛时间内可行性；
9. 可能失败的条件及可降级路线；
10. 可写入论文的题目特异性，而不是算法名包装。

【评分】
按 1–5 分分别评价并给证据：
Problem Fit、Mathematical Soundness、Data Suitability、Interpretability、Robustness、Computational Cost、Implementation Risk、Paper Expressiveness、Originality Potential、Homogenization Risk。

风险维度 5 分表示风险低。不要只给总分；列出决定性差异与不确定性。权重若改变，必须来自团队能力、比赛剩余时间或硬交付约束。

【创新审计】
分别检查：问题定义创新、模型结构创新、验证设计创新。算法名称本身不构成创新。删除题目背景后仍能原封不动用于大量题目的内容，标记为高同质化风险。

【简洁性 Gate】
每个附加模块都回答：它独立解决什么问题？什么消融或证据能证明贡献？没有独立作用或无法验证的模块不进入主方案。

【路线判别】
提出一个最小、低成本、可复现的判别实验，用于比较最有竞争力的两条路线。若路线仍有实质差异，不得假装用户已选择。

输出：
04_model_candidates/ROUTE_A.md ... ROUTE_E.md（按实际数量）
04_model_candidates/ROUTE_SCORECARD.csv
04_model_candidates/INNOVATION_HOMOGENIZATION_AUDIT.md
04_model_candidates/MINIMUM_DISCRIMINATION_EXPERIMENT.md
04_model_candidates/RECOMMENDATION.md

最后只给出：推荐主路线、可靠备选、决定性证据、主要风险、最小判别实验、AWAITING ROUTE DECISION。
完成后停止，不进入实现。
```

---

## Prompt 3：路线确认与模型契约冻结

```text
$math-modeling-orchestrator

我确认选择【路线名称/编号】作为【问题范围】的主路线；【备用路线】作为失败回退。

本轮只记录决定并冻结实现契约，不开始大规模实验。

请核对该选择是否与 FORMAL_PROBLEM_SPEC、数据条件、团队能力、剩余时间和提交物冲突。若存在硬冲突，标记 BLOCKED，不要强行记录。

生成并冻结：
1. ROUTE_DECISION.md：选择、被淘汰路线、决定性证据、风险、回退触发条件；
2. MODEL_CONTRACT.md：变量、参数、单位、目标、约束、状态转移、核心定义、允许近似、输出 schema；
3. VALIDATION_PLAN.md：baseline、oracle、单测、独立重算、误差容差、数值收敛、消融、敏感性、稳健性、重复运行；
4. COMPUTE_BUDGET.md：粗搜、精修、重复实验和停止条件；
5. 更新 decision_log 与 PROJECT_STATE。

参数若尚未确定，标记 TO_BE_ESTIMATED 或 TO_BE_TUNED，不得预填一个看似合理的值。

最后给出：
ROUTE GATE = PASS / FAIL
EXECUTION READY = YES / NO
FROZEN CONTRACT PATHS
OPEN RISKS

完成后停止。
```

---

## Prompt 4：公共 evaluator、baseline 与 oracle

```text
$math-modeling-code-experiment

路线已经冻结。现在只实现多个问题共享的最小公共计算核心、baseline 和可验证 oracle；暂不进行后续问题的大规模优化。

【入口】
必须读取 MODEL_CONTRACT、VALIDATION_PLAN、变量单位台账、数据字典和官方答案 schema。若路线或定义仍有争议，返回 Strategy Designer。

【实现要求】
1. 将物理/统计/几何/约束 evaluator 与 optimizer 或训练器解耦；
2. 所有常量和阈值集中进入配置，不散落 magic numbers；
3. 每个数据变换有输入输出 schema、单位和异常处理；
4. 实现最简单可信 baseline；
5. 为关键定义同时保留必要的低保真 baseline 与高保真实现；
6. 建立可人工推导的小样例、边界样例、反例和官方已知条件作为 oracle；
7. 单测覆盖正常、边界、非法输入和数值异常；
8. 记录 seed、依赖版本、输入哈希、代码哈希、配置和时间戳；
9. 生成 run manifest 和 artifact ledger；
10. 仅在公共核心验证通过后，计算最简单或原题给定参数的问题作为首个真实 Gate。

【数值要求】
检查 NaN/Inf、溢出、奇异性、边界命中、单位一致性、求根/积分/步长误差。若使用离散近似，预先定义收敛试验和可接受容差。

【输出】
05_common_core/src/
05_common_core/tests/
05_common_core/config/
05_common_core/oracles/
05_common_core/diagnostics/
05_common_core/BASELINE_SPEC.md
05_common_core/TEST_REPORT.md
05_common_core/run_manifest.json

若任何核心单测或真实 oracle 失败：停止，不进入复杂问题；保留失败日志并标记 COMMON CORE = FAIL。

最后报告：执行状态、测试数量与结果、实际运行命令、工件路径、已知限制、是否 READY FOR MODEL VALIDATOR。
```

---

## Prompt 5：单个问题正式求解通用模板

对每一问分别使用一次，将方括号内容替换为真实信息。

```text
$math-modeling-code-experiment

现在只解决【Q编号与原题任务】。不要进入下一问，不要写论文。

【已通过 Gate】
- FORMAL_PROBLEM_SPEC：【路径】
- ROUTE_DECISION：【路径】
- MODEL_CONTRACT：【路径】
- COMMON CORE VALIDATION：【状态与路径】
- 可继承的前序最终结果：【路径；没有写 NONE】

【本问必须回答】
【从 ANSWER_SCHEMAS.json 复制真实字段、单位、精度和官方文件要求】

【决策与约束】
【列出本问变量、推导变量、硬约束、软偏好、时间/空间边界。不得把由运动学、守恒或业务逻辑推导的量再当作独立自由变量。】

【执行顺序】
1. 验证本问输入与前序依赖，拒绝使用 STALE 工件；
2. 运行 baseline 并保存完整结果；
3. 做可行域、尺度、边界和目标函数诊断；
4. 运行主模型；若为优化，采用“可行性构造/粗搜索 → 全局搜索 → 局部精修 → 独立重算”；
5. 至少使用一个独立策略或确定性小规模 oracle 交叉检查；
6. 随机方法固定多个 seed，保存每次结果和候选 archive；
7. 记录收敛、运行时间、最优界/最优性 gap（若可获得）和失败案例；
8. 对多模块模型执行预定消融；
9. 对关键参数与主要不确定性执行任务相关敏感性/稳健性分析，不机械堆砌无关检验；
10. 将最终变量交给独立 evaluator，重新计算目标、约束和答案字段；
11. 仅使用独立重算通过的候选作为 final candidate；
12. 复制官方提交模板到 submission 后填写，保持 sheet、结构、格式、公式、单位和字段语义不变；
13. 重新读取填写后的文件，逐字段与最终 JSON 比对；
14. 更新 run manifest、artifact ledger、AI usage log 和 PROJECT_STATE。

【禁止】
- 不得只跑一次随机算法就宣称全局最优；
- 不得相信 optimizer 打印值而跳过独立重算；
- 不得删除差结果或失败日志；
- 不得覆盖原始模板；
- 不得把本问中间结果写成其他问题的 final 结果。

【输出目录】
06_questions/【Q编号】/src
06_questions/【Q编号】/config
06_questions/【Q编号】/runs/【run_id】
06_questions/【Q编号】/candidates
06_questions/【Q编号】/figures
06_questions/【Q编号】/tables
06_questions/【Q编号】/【Q编号】_RESULT.json
06_questions/【Q编号】/【Q编号】_SOLUTION_NOTES.md

【验收】
ANSWER SCHEMA = PASS
HARD CONSTRAINTS = PASS
INDEPENDENT RECALCULATION = PASS
NUMERICAL STABILITY = PASS / WARNING
REPRODUCIBILITY = PASS / PARTIAL
OFFICIAL RESULT FILE = PASS / NOT APPLICABLE

任何硬项 FAIL 时停止并进入 Model Validator，不得进入下一问。
```

---

## Prompt 6：单问独立模型验证

```text
$math-modeling-model-validator

只验证【Q编号】的最终候选和指定 run，不修改答案、不修代码、不进入下一问。

【权威 run】
run_id = 【填写】
manifest = 【路径】
final result = 【路径】

【验证任务】
1. 核对题目事实、变量、单位、参数和全部硬约束；
2. 区分静态代码审查与实际执行验证；未运行项标记 NOT VERIFIED；
3. 使用独立路径重新计算所有最终答案字段，不直接复用 optimizer 的 objective；
4. 对每个决策变量逐项输出范围与约束 PASS/FAIL；
5. 检查数据泄漏、时间顺序、实体分组、训练折内预处理；
6. 检查数值稳定性、收敛、边界命中、NaN/Inf、容差和离散步长；
7. 检查 baseline、公平比较、指标选择和模型选择规则；
8. 检查多 seed、重复运行、候选 archive 和最优性声明；
9. 检查消融是否能支持新增模块的贡献；
10. 检查敏感性/稳健性是否针对主不确定性；
11. 检查 JSON、Excel、表和图是否来自同一 run；
12. 检查结果能否直接回答原题，而非仅报告模型指标。

若采用时间离散、数值积分、网格或近似几何，执行合理的分辨率收敛实验，并报告最终结果随精度变化的幅度。若存在解析或小规模穷举 oracle，应交叉比较。

每项发现包含：对象、测试、证据路径/命令、观察值、期望值、影响、建议修复。使用 PASS/WARNING/FAIL/NOT VERIFIED。

输出：
07_validation/【Q编号】_VALIDATION_REPORT.md
07_validation/【Q编号】_constraint_check.csv
07_validation/【Q编号】_recalculated_result.json
07_validation/【Q编号】_numerical_stability.csv

最后给出：
QUESTION ANSWER = PASS / FAIL
PHYSICS/LOGIC = PASS / FAIL / N/A
DATA/LEAKAGE = PASS / FAIL / N/A
CONSTRAINTS = PASS / FAIL
NUMERICAL = PASS / WARNING / FAIL
REPRODUCIBILITY = PASS / PARTIAL / FAIL
RESULT FILE = PASS / FAIL / N/A
READY FOR NEXT QUESTION = YES / NO

完成后停止。
```

---

## Prompt 6B：验证失败后的最小修复

```text
$math-modeling-code-experiment

【Q编号】验证未通过。读取验证报告，只修复其中编号为【Finding IDs】的问题。

本轮不得借机更换已冻结的主路线、扩大模型、润色论文或修改无关文件。若修复必须改变 MODEL_CONTRACT，停止并返回 Strategy Designer/Orchestrator 重新决策。

要求：
1. 对每个 finding 做根因分析；
2. 提出最小安全修复与可能副作用；
3. 先新增回归测试，使旧错误能够稳定复现；
4. 实施修复；
5. 使用新 run_id 重新运行受影响实验；
6. 将旧 run 的相关 JSON、Excel、图、表和文字标记 STALE，不删除；
7. 重新生成受影响工件并更新 artifact ledger；
8. 不覆盖原始数据和官方模板；
9. 完成后返回 Model Validator 重新独立验证。

报告：FIXED / NOT FIXED、改动文件、回归测试、旧/新结果差异、新 run_id、仍存风险。
```

---

## Prompt 7：全问题集成验证与最终 run 冻结

```text
$math-modeling-model-validator

所有问题已分别完成单问验证。现在进行全局集成验证，不修改代码或答案。

【检查范围】
1. 每一问的最终 run_id、输入哈希、代码哈希和配置；
2. 前序问题输出被后序问题使用时，字段、版本、单位和语义一致；
3. 公共 evaluator 在各问中没有被复制成不同实现；
4. 所有硬约束、答案 schema 和官方要求逐问通过；
5. baseline、消融、敏感性、稳健性和误差分析与题目风险匹配；
6. 所有最终变量和 objective 独立重算；
7. 多随机种子与重复运行结论稳定；
8. JSON、CSV、Excel、图片和日志绑定到同一最终 run；
9. submission 文件重新读取后与内部结果逐字段一致；
10. 任何 STALE 工件未被列为 final；
11. 运行入口、依赖、相对路径、seed 和执行顺序足以复现；
12. 从干净输出目录运行主入口，确认能生成核心结果；若环境不允许，标记 NOT VERIFIED，不得声称通过。

输出：
07_validation/FINAL_VALIDATION_REPORT.md
07_validation/final_run_registry.json
07_validation/global_constraint_check.csv
07_validation/recalculated_objectives.json
07_validation/ablation_summary.xlsx
07_validation/sensitivity_robustness_summary.xlsx
07_validation/REPRODUCIBILITY_REPORT.md

最终评级：
PROBLEM COVERAGE
DATA IDENTITY
MODEL IDENTITY
CONSTRAINTS
NUMERICAL VALIDITY
BASELINE/ABLATION
SENSITIVITY/ROBUSTNESS
REPRODUCIBILITY
RESULT FILES

只有必需项无 FAIL 且关键结果均非 NOT VERIFIED 时，才写 FINAL RUN FROZEN = YES。
完成后停止，等待论文写作。
```

---

## Prompt 8：模型建立章节

```text
$math-modeling-methodology-writer

FINAL_VALIDATION_REPORT 已通过，最终模型、代码和配置已经冻结。现在只撰写论文“模型的建立/方法”部分，不写经验结果和结果解释。

必须读取：
- 完整原题与 FORMAL_PROBLEM_SPEC；
- ROUTE_DECISION 与 decision_log；
- 最终代码、配置和变量单位台账；
- 最终 validation plan；
- 当年官方论文格式与用户选定模板。

【内容】
1. 问题表述与建模目标；
2. 必要且真实使用的模型假设；
3. 统一符号、下标、集合和单位；
4. 数据/样本/状态的构造；
5. 核心机理、统计关系、状态转移或几何定义；
6. 目标函数、约束和可行域；
7. 参数来源：题目给定、预先设定、估计或调参必须区分；
8. baseline 与主模型；
9. 求解器/训练/搜索流程；
10. 验证、消融、敏感性和稳健性设计，但不写观测结果；
11. 各问题之间真实的变量和结果继承关系。

【硬边界】
不得写入观测到的 RMSE、MAE、R²、准确率、排序、预测值、最终策略、敏感性响应或“结果表明”。预先冻结的常数可写，但要标明是设计常数。不得把代码未实现的理论写进论文。

公式使用规范 LaTeX，符号先定义后使用；代码函数名和临时变量名替换为数学含义，但不得改变实现逻辑。

输出：
10_paper/METHODOLOGY.md
10_paper/METHODOLOGY_SOURCE_LEDGER.csv

若代码、配置和拟写公式冲突，停止并列出冲突，不要自行美化理论。
```

---

## Prompt 9：模型求解与结果分析章节

```text
$math-modeling-solution-writer

根据冻结的最终 run 和已验证工件，只撰写“模型求解与结果分析”。

每一个数字必须来自：最终 Q*_RESULT.json、最终 submission 工作簿、FINAL_VALIDATION_REPORT、最终日志或最终图表。必须保留 run_id、单位、对象、时点、总体/样本口径和舍入规则。

按真实问题树组织，而不是按文件顺序组织。每问至少回答：
1. 本问要求解决什么；
2. 实际采用什么模型和求解策略；
3. baseline 与主方案如何比较；
4. 最终可核验答案是什么；
5. 图表揭示什么可靠规律；
6. 验证、误差、消融、敏感性或稳健性说明了什么；
7. 结果在什么条件下成立，有什么限制。

不得只说“效果良好”“显著提高”“具有较强鲁棒性”。每项性能或稳定性结论必须有指标或实验支持。负 R²、弱指标、失败模型、边界敏感和反直觉结果不得隐藏。

重要性、相关性和敏感性不自动等于因果关系。若图与表冲突，标记 WARNING，不自行选择更好看的结论。

输出：
10_paper/SOLUTION_AND_RESULTS.md
10_paper/CLAIM_TO_EVIDENCE_LEDGER.csv

台账字段至少包括：claim_id、论文陈述、数值、单位、artifact_path、sheet/key/figure、row/condition、run_id、verification_status。
```

---

## Prompt 10：图表与流程图定稿

```text
$math-modeling-code-experiment

模型和最终结果已冻结。本轮只整理论文所需图、表和流程图，不改变模型、参数或结果。

【科学图表】
1. 必须由最终数据/JSON/CSV/Excel直接生成；
2. 图表脚本读取最终 run registry，不手工复制数字；
3. 标明坐标轴、单位、图例、样本范围和必要误差；
4. 不用图和表重复表达同一信息；
5. 主结论图优先，调试图和冗余图放附录或删除；
6. 检查颜色可辨识、灰度打印、分辨率和字体；
7. 保存 PNG，并在适合时保存 PDF/SVG；
8. 图文件不包含图题，图题在论文中排版；
9. 不使用生成式图片伪造精确几何、数据曲线或数值图；
10. 每张图/表建立 data lineage：源数据、脚本、run_id、生成时间。

【流程图/架构图】
只展示本题真实的数据流、模型模块、问题依赖和验证流程。删除题目背景后仍适用于所有题目的通用框图不得作为核心创新图。精确流程图优先使用 Mermaid、Visio、PPT 原生形状或其他可编辑矢量方式。

【文字解释】
每张图表对应三部分：为什么展示、可靠地显示了什么、如何回答题目。不得解释图中没有证据支持的原因。

输出：
08_figures/final/
09_tables/final/
08_figures/FIGURE_LEDGER.csv
09_tables/TABLE_LEDGER.csv
10_paper/FIGURE_TABLE_CAPTIONS.md

完成后核对图表与 JSON/Excel 数值一致。
```

---

## Prompt 11：标题、摘要、关键词与模型评价

```text
$math-modeling-solution-writer

完整论文主体、最终结果和验证报告已经形成。现在生成论文题目、摘要、关键词和模型评价；不得重新计算或补造结果。

【题目】
准确体现主要研究对象、核心数学结构或主模型；不堆砌多个次要算法；不加入正文未使用的方法。

【摘要】
先从真实问题数量生成结构，不预设固定五问或八段。
第一部分用1–2句话说明背景和核心任务；主体按真实问题逐一写“任务—方法—关键结果—验证”；结尾只总结有证据的创新、适用范围和限制。
所有量化结果必须来自 CLAIM_TO_EVIDENCE_LEDGER。摘要不放公式、图表编号、参考文献和未经解释的缩写。

【关键词】
通常选择4–6个，覆盖研究对象/核心问题、主模型、关键求解或验证方法。不得用“数学建模”“数据分析”等空泛词凑数。

【模型评价】
优点必须有证据；缺点说明来源、影响范围和对应改进；推广要区分可复用核心与必须重新设计的变量、参数、目标和约束。不得声称适用于所有场景。

输出：
10_paper/TITLE_ABSTRACT_KEYWORDS.md
10_paper/MODEL_EVALUATION.md
10_paper/ABSTRACT_EVIDENCE_CHECK.csv

最后内部检查：是否覆盖全部问题、是否含关键量化结果、是否与正文一致、是否虚构检验或创新、是否机械套固定段数。
```

---

## Prompt 12：论文组装与格式核验

```text
$math-modeling-orchestrator

论文各章节已经完成。本轮只按当年官方规范和用户指定模板组装论文，不改变模型和结果。

【规则】
1. 当年官方格式规范优先于学长模板和往届习惯；
2. 官方未规定的字体、字号和结构才采用用户冻结的模板；
3. 不得默认添加目录；是否有目录以当年赛事规则为准；
4. 摘要页数、正文页数、页码起始、页边距、匿名要求、AI声明位置均从正式规则核验；
5. 原模板只读，另存最终论文；
6. 标题层级、公式编号、图表编号、交叉引用、参考文献、附录编号统一；
7. 图表不截断，表头跨页重复，公式和图题不与对象分离；
8. 参考文献必须真实、正文与文末一一对应；
9. 代码、绝对路径、文档属性、截图和文件名中不得泄露身份或密钥；
10. 最终 DOCX/PDF 必须渲染检查每一页，不只做文本检查。

【输出】
10_paper/final_paper.docx（或用户指定格式）
10_paper/final_paper.pdf
10_paper/FORMAT_COMPLIANCE_REPORT.md

若官方规则文件缺失或版本无法确认，将相关项目标记 NOT VERIFIED，不得把非官方模板说成官方标准。
```

---

## Prompt 13：提交前最终一致性审计

```text
$math-modeling-consistency-auditor

对整个项目执行提交前最终一致性审计。本轮只读，不自动修改任何文件。

逐项建立以下链条：
题目/官方要求
↔ FORMAL_PROBLEM_SPEC
↔ MODEL_CONTRACT
↔ 最终代码与配置
↔ final run manifest
↔ Q结果JSON/CSV
↔ 官方Excel提交文件
↔ 最终图表
↔ 论文公式、数值与结论
↔ AI工具使用声明和详情

重点检查：
1. 题目所有小问和指定文件是否完整回答；
2. 公式、变量、单位、时点、坐标、目标和约束是否与代码一致；
3. 论文参数是否与最终配置一致；
4. 每个数字是否能定位到 final artifact；
5. 图、表、标题、坐标轴、图例和正文结论是否一致；
6. baseline、模型选择、split、metric、seed、消融、敏感性与稳健性是否真实执行；
7. 是否存在旧版本图、stale result、旧 optimizer 输出、人工复制错误和跨 run 混用；
8. 官方结果模板结构、sheet、字段、公式、单位和格式是否保持；
9. 文献是否真实，正文引用是否对应；
10. AI声明是否覆盖真实使用环节、主要提示、采纳、修改与人工核验；
11. 是否存在身份信息、账号、路径、API密钥和文档元数据泄露；
12. 支撑材料能否从相对路径运行并复现主要结果。

每个 finding 必须包括：论文/文件位置、期望事实、观察事实、证据路径与定位、影响、严重度、建议更正。不得在冲突中擅自选择一个版本。

输出：
12_audit/FINAL_CONSISTENCY_AUDIT.md
12_audit/SUBMISSION_FILE_CHECK.csv
12_audit/CLAIM_TRACEABILITY_CHECK.csv
12_audit/ANONYMITY_PRIVACY_CHECK.md
12_audit/CORRECTION_CHECKLIST.md

最终状态逐问和逐提交文件列出 PASS/WARNING/FAIL/NOT VERIFIED。
FINAL SUBMISSION STATUS 只有在无 FAIL、所有必答结果已验证、提交文件一致时才为 READY；否则为 NOT READY。
```

---

# 第六部分　Prompt 编译器：为任意新题自动生成专用 Prompt 包

## 12. Prompt 编译器（只生成指令，不解题）

```text
$math-modeling-orchestrator

你现在充当“数学建模 Prompt 编译器”，不是解题者。

读取我提供的新赛题、官方附件、数据文件、官方结果模板、PROJECT_CONTEXT 和已安装 Skills。你本轮不得选择最终模型、写正式代码、运行优化或撰写论文。

目标：基于真实题目结构，把《数学建模新题 Codex 全流程 Prompt 系统 V2.0》编译为本题专用 Prompt 包。

要求：
1. 实际识别问题数量和子问题，不固定为Q1–Q5；
2. 将题目事实、数据字段、单位、硬约束、提交文件和关键歧义嵌入对应阶段 Prompt；
3. 对每一问写出明确的答案 schema、前序依赖和 Gate；
4. 只保留与本题相关的验证，不机械复制所有检查；
5. 根据任务类型加入泄漏、时间顺序、几何精度、守恒、可行性、最优性 gap、实体分组等适用检查；
6. 明确原始文件只读、输出目录、命名、run ID、证据台账、停止条件；
7. 每条 Prompt 只负责一个阶段，完成后停止；
8. 保留显式 $skill-name；
9. 提供标准模式和时间紧张模式；
10. 生成 Prompt 使用顺序、进入条件、退出条件和人工决策点；
11. 不在 Prompt 中预填未经题目或用户确认的模型、参数和答案；
12. 对仍未知的信息使用【待填写】或 UNKNOWN，不猜测。

输出目录：
01_governance/prompt_pack/

至少生成：
00_START.md
01_DECOMPOSE.md
02_DATA_AUDIT.md（适用时）
03_STRATEGY.md
04_ROUTE_FREEZE.md
05_COMMON_CORE.md（适用时）
Q*_SOLVE.md
Q*_VALIDATE.md
GLOBAL_VALIDATE.md
METHODOLOGY.md
RESULTS.md
FIGURES_TABLES.md
PAPER_ASSEMBLY.md
FINAL_AUDIT.md
AI_DISCLOSURE.md
EMERGENCY_MODE.md
RESUME.md

另外生成 PROMPT_PACK_INDEX.md，列出每条 Prompt 的用途、输入、输出、进入 Gate 和完成 Gate。

完成后只报告 Prompt 包清单、仍需用户填写的字段和使用顺序；不得开始执行这些 Prompt。
```

---

# 第七部分　高频专项 Prompt（现有“小何学长提示词”的强化版）

## 13. 数据集说明强化版

```text
请实际读取我上传的全部数据文件，生成可供另一名建模人员或AI直接使用的数据集说明。本轮只做只读审计，不清洗、不建模、不绘图、不修改原文件。

逐文件、逐工作表说明：
1. 真实文件名、格式、路径、哈希和文件大小；
2. 工作表名、可见状态、数据区域、表头行、行列数；
3. 合并单元格、多级表头、公式、隐藏行列、备注和空白分区；
4. 全部字段的原始名称、类型、典型值、缺失率、含义、单位和依据；
5. 每行代表什么实体、事件或时间点；
6. 主键、外键、实体ID、时间字段及表间关系；
7. 同一实体重复记录、重复检测和时间顺序；
8. 目标字段、候选特征及其在预测/决策时是否可用；
9. 可能的标签、时间、目标派生、归一化和分组泄漏；
10. 异常编码、单位混用、日期格式、缺失值符号和明显质量风险；
11. 展示每表前5行，但明确它们只是样例；
12. 给出使用真实 sheet 和字段名的最小读取代码，不写死仅在本机有效的用户路径。

无法确认的内容标记 UNKNOWN；基于结构推断的内容标记 INFERENCE 并给依据。最后输出一段可直接发送给其他AI的完整数据集描述，并提醒路径可能只在当前环境有效。
```

## 14. 选题比较强化版

```text
$math-modeling-strategy-designer

请比较我提供的全部候选赛题，目标是帮助本队在限定时间内选择最适合完成且最有竞争力的一题。本轮只做选题，不进入具体建模。

队伍信息：【专业、人数、编程、数学、写作、领域知识、可用软件】
比赛目标：【完整交付/省奖/国奖】
剩余时间：【小时】

每题实际读取后，从以下维度评分并给证据：
- 题意清晰度与歧义风险；
- 数据完整性、清洗成本和泄漏风险；
- 数学建模深度与可验证性；
- 队伍能力匹配；
- 编程/算力/求解器需求；
- 问题间继承是否有利；
- baseline 是否容易建立；
- 结果能否独立验证；
- 论文表达与图表潜力；
- 题目特异性与同质化风险；
- 三天内完成的风险与回退路线。

不得因为熟悉某个算法就偏向对应题目。输出首选、次选、应急备选、决定性理由、最大风险、开题前30–60分钟最小验证任务。若附件不完整，明确其对选题的影响。
```

## 15. 模型假设强化版

```text
$math-modeling-methodology-writer

依据原题、FORMAL_PROBLEM_SPEC、最终代码和配置，生成模型假设。本轮只输出真实使用且必要的假设。

对每条假设标记来源：
- 题目明确条件；
- 为使问题适定的合理简化；
- 最终模型的适用前提。

每条说明适用范围、简化对象、理由、若不成立的影响，以及后续由哪项分析检验。不得假设“数据绝对正确”“模型完全正确”“算法一定获得全局最优”“所选指标全面有效”。可由数据检验的条件写成“经检验满足后使用”，不得无证据断言。

删除未被后续公式、代码或讨论实际使用的假设。只输出可直接放入论文的假设及其必要说明。
```

## 16. 符号说明强化版

```text
$math-modeling-methodology-writer

从最终 METHODOLOGY、代码、配置和公式中提取正文实际使用的主要符号，生成符号台账和论文三线表。

要求：
1. 同一符号只能有一个含义；同字母冲突时提出重命名建议，不静默改公式；
2. 区分标量、向量、矩阵、集合、索引、随机变量和函数；
3. 写明单位或“无量纲”；
4. 写明下标/上标含义和首次出现位置；
5. 不收录代码函数名、临时循环变量、文件名和绘图变量；
6. 公式中出现但未定义、表中定义但正文未使用的项分别列为问题；
7. 按正文首次出现顺序排列。

输出：SYMBOL_LEDGER.csv、论文可用符号表、冲突与缺失清单。
```

## 17. 代码转“模型建立”强化版

```text
$math-modeling-methodology-writer

请阅读最终代码、配置、变量台账和 route decision，将实际实现转化为论文“模型建立”文字。

采用连续、严谨的段落和规范公式，按真实执行顺序说明输入定义、状态/样本构造、核心数学关系、目标函数、约束、参数来源和求解流程。程序函数名、类名和临时变量替换为实际数学含义；循环、判断和矩阵运算概括为数学逻辑。

禁止：
- 写入代码没有实现的理论；
- 自行补参数选择依据；
- 把运行环境、绝对路径、库导入和绘图格式写进正文；
- 写结果数值和“结果表明”；
- 为了文字更漂亮而改变公式、参数、单位或执行顺序。

若理论描述与代码不一致，先输出冲突清单并停止，不得自行选择。
```

## 18. 图、表和数值结果描述强化版

```text
$math-modeling-solution-writer

根据我提供的最终图/表及其数据源、run_id 和题目要求，撰写可直接进入论文的结果分析。

先核验图表与源数据一致，再用连续段落回答：
1. 为什么展示该结果；
2. 哪些主要数值、趋势、分布、排序、极值或拐点最能回答当前问题；
3. 与 baseline、其他方案或理论预期相比有何可核验差异；
4. 该差异对当前任务意味着什么；
5. 结论的适用范围和必要限制。

不得机械罗列全部数据，不描述颜色和线型，不重复模型原理，不凭图猜测因果原因，不补造图中没有的数值。所有数字保留对象、单位和舍入口径。若图表冲突，输出 WARNING 而不是写正文。

目标字数：【例如180–250字；按内容调整】。
```

## 19. 背景与研究现状强化版

```text
请基于赛题背景和我提供的真实资料撰写“问题背景”和“研究现状”。

如果允许联网，只检索与本题直接相关的权威来源、标准、官方统计和原始论文，并保存来源、标题、作者/机构、年份、链接/DOI、访问日期和支持的具体陈述。如果不允许联网或无法核验，不得生成具体文献事实，只能作一般性方法概述并标记证据缺口。

问题背景按“现实场景—核心矛盾—实际影响—为何需要量化建模—引出赛题”组织，不提前写本文模型和结果。

研究现状按真实方法范式组织，比较数学思想、数据要求、优势、限制和适用场景，不只罗列模型名称，不把本文方案写成研究现状，不写“有学者认为”之类无来源归因。

输出正文草稿以及 CLAIM_SOURCE_LEDGER。任何无法验证的政策、数字、年份和研究结论不得进入正文。
```

## 20. 摘要强化版

```text
$math-modeling-solution-writer

读取最终论文、FINAL_VALIDATION_REPORT、CLAIM_TO_EVIDENCE_LEDGER 和所有官方提交结果，生成题目、摘要和关键词。

不要预设固定问题数量。先识别真实问题树，再为每一问提取：任务、模型、求解、关键量化结果和验证。第一段仅用1–2句话说明现实背景和核心问题；结尾总结有证据的创新、模型有效范围和主要限制。

摘要中的每个数字必须能定位到 evidence ledger；正文未明确的信息写入“待核对事项”，不得补造。避免“首先、其次、最后”式流水账，不写公式、图表号、参考文献、代码和未经解释的缩写。

关键词4–6个，覆盖研究对象/问题、主模型和关键方法，不加入正文未使用的算法。

输出：题目、摘要、关键词、摘要事实核对表、待核对事项。
```

## 21. 模型优缺点与推广强化版

```text
$math-modeling-solution-writer

根据最终模型、验证报告、失败案例、敏感性和稳健性结果，撰写模型评价、改进与推广。

优点必须指向证据，例如约束满足、误差、计算成本、可解释性、稳定性或对照实验；不使用“科学合理、结果准确、效果显著”等空话。

缺点说明其来源、在哪些场景影响结论、当前结果是否仍可用。足以否定全文的缺陷不作为普通缺点包装，应标记为需要回到模型阶段修复。

改进逐项对应缺点，说明所需新增数据、参数、结构、验证或计算成本。

推广按“可复用的核心思想—相似场景—需重定义的变量/目标/约束—验证要求—推广边界”写，不夸大通用性，不虚构实际应用成果。
```

## 22. 批判性评审强化版

```text
$math-modeling-consistency-auditor

请以严格竞赛评委和复现审稿人的双重视角只读审查当前论文与支撑材料，不进行泛泛的语言挑刺。

按优先级寻找：
P0：题意错误、硬约束违反、结果伪造/不可追溯、数据泄漏、公式与代码不一致；
P1：baseline缺失、验证无效、最优性夸大、关键不确定性未分析、提交文件错误；
P2：模型选择证据不足、假设不合理、问题间假联动、图表与结论冲突；
P3：表达、结构、符号、图表和参考文献问题。

每项问题给出位置、证据、为什么重要、最小修复动作、修复后需要重跑哪些结果。不要无限扩展可选优化；区分“必须修复”“有时间再做”“不建议在本次比赛新增”。
```

---

# 第八部分　恢复、调试和时间紧张场景

## 23. 中断后恢复 Prompt

```text
$math-modeling-orchestrator

我们正在恢复一个未完成的数学建模项目。请只读检查项目树、PROJECT_STATE、decision_log、artifact_ledger、final run registry、验证报告和最近修改文件。

不要从头重做，不要因为存在代码就假设路线已确认，不要因为存在结果文件就假设已验证。

请判断：
1. 当前处于哪个阶段和哪一问；
2. 哪些 Gate 有可核验证据；
3. 哪些工件是 final、candidate、failed、stale 或 unknown；
4. 最近一次完整成功 run 是哪个；
5. 是否存在跨版本冲突、未提交修改或部分生成文件；
6. 继续工作所需的最小下一动作；
7. 是否需要用户做实质决策。

输出 CURRENT STATE、VERIFIED GATES、STALE/CONFLICTED ARTIFACTS、NEXT SKILL、EXACT NEXT DELIVERABLE、BLOCKERS。完成后停止。
```

## 24. 程序报错调试 Prompt

```text
$math-modeling-code-experiment

当前目标是定位并修复【具体报错/验证失败】，不是重构整个项目或更换模型。

权威输入：报错日志【路径】、失败命令【命令】、对应 run【ID】、预期行为【说明】、最近改动【路径/commit】。

执行：
1. 稳定复现；
2. 区分输入、环境、依赖、路径、数据、数值、模型或输出层故障；
3. 找到最小根因；
4. 新增失败回归测试；
5. 实施最小修复；
6. 重跑受影响测试和最小实验；
7. 若结果变化，生成新 run 并标记旧产物 STALE；
8. 不修改无关模块，不删除失败证据。

报告根因、改动、测试、结果变化、剩余风险和是否需要重新验证。
```

## 25. 比赛应急模式 Prompt

```text
$math-modeling-orchestrator

进入比赛应急模式。剩余时间：【小时】。目标是获得“完整、可信、可复现、可提交”的方案，不追求无法验证的复杂度。

保留四个不可取消的硬 Gate：
1. 题意和硬约束审计；
2. 最简单可信 baseline；
3. 最终答案独立重算与约束检查；
4. 论文—代码—Excel—图表提交一致性。

允许压缩：候选路线由3–5条缩为2–3条；只对主风险做敏感性/稳健性；非关键美化与冗余图表延后；复杂模型若在预定时间内未超过 baseline 或无法稳定运行，立即回退到已验证方案。

请按剩余时间给出：
- 必须完成；
- 应完成；
- 有余力再做；
- 明确放弃。

为每阶段设置截止时间、最低交付物、失败回退和负责人。不得删除验证步骤来为论文美化让路。
```

### 推荐时间比例（可按题型调整）

| 阶段 | 建议比例 |
|---|---:|
| 输入、题意、数据审计 | 10%–15% |
| 路线比较与冻结 | 8%–12% |
| 公共核心与 baseline | 12%–18% |
| 各问实现与求解 | 30%–40% |
| 验证、消融、稳健性 | 12%–18% |
| 论文与图表 | 12%–18% |
| 最终提交审计 | 至少 5%–8% |

这只是项目计划，不是所有题型的固定公式。机理/优化题可能增加公共 evaluator 时间，数据题可能增加数据审计和泄漏检查时间。

---

# 第九部分　AI 使用记录与匿名提交

## 26. 从第一轮就记录，而不是最后回忆

每次 AI 对论文产生实质影响时，追加到 `AI_USAGE_LOG.md`：

| 字段 | 内容 |
|---|---|
| record_id | A-01、A-02…… |
| date_time | 实际时间 |
| tool_model | 能确认的工具与模型；不能确认时如实写界面未显示 |
| stage | 题意/数据/路线/代码/验证/写作/格式等 |
| purpose | 本轮具体目标 |
| inputs | 提供给 AI 的文件和上下文 |
| prompt_path | 保存的真实提示词或摘要 |
| main_output | AI 主要建议或产物 |
| adoption | 未采纳/部分采纳/采纳 |
| human_changes | 人工修改了什么 |
| verification | 对照原题、独立推导、运行代码、交叉计算、文献核验等 |
| artifact_paths | 受影响文件 |
| privacy_check | 是否去除身份和敏感信息 |

## 27. AI 使用详情生成 Prompt

```text
请根据项目中的真实 AI_USAGE_LOG、保存的 Prompt、decision_log、代码变更、验证报告和最终论文，生成匿名版《AI工具使用详情》。不得依据记忆补造记录。

必须包含：
1. 所用AI工具名称、版本或型号；
2. 具体使用目的和环节；
3. 主要提示方式与使用过程；
4. AI输出的采纳、人工修改和人工核验；
5. 典型交互示例（仅真实存在时）；
6. 提交前一致性与匿名检查。

无法确认的工具版本写“使用期间界面未显示具体版本”，不得猜测。只记录实际发生的用途，不把未采用模型写成最终模型。建模、数据、代码、验证和结果分析必须写明具体人工核验；纯语言润色可按赛事规则简化。

匿名要求：不得出现学校、赛区、队伍编号、姓名、教师、联系方式、账号、头像、签名、绝对用户路径、API密钥和其他身份信息。

先输出材料完整性检查；若关键信息缺失，列出待补充项，不生成虚假成稿。信息充分后再输出最终内容和一致性检查。
```

---

# 第十部分　如何让 Prompt 更高效而不是更长

## 28. 推荐的上下文复用方式

不要在每轮重复粘贴完整原题、全部规则和整份本手册。让 Codex 每轮读取以下冻结文件：

- `PROJECT_CONTEXT.yaml`
- `PROJECT_GOVERNANCE.md`
- `PROJECT_STATE.json`
- `decision_log.md`
- 当前阶段的权威输入和上一阶段 Gate 报告。

当前 Prompt 只写本轮新增信息：要解决哪一问、读取哪些 final 工件、生成什么、在哪里停止。

## 29. 一轮只保留一个主要动词

高质量阶段 Prompt 通常只包含一个主动作：审计、拆解、比较、冻结、实现、验证、修复、撰写或核对。若同时出现“分析并实现并优化并写论文并填Excel”，应拆分。

## 30. 只问会改变结果的问题

Codex 只有在下列情况才应询问用户：

- 多种解释会改变数学定义或答案；
- 路线存在实质取舍且硬约束不能唯一决定；
- 缺少关键文件或权限；
- 需要联网、安装依赖、覆盖文件或使用凭据；
- 需要用户确定比赛目标、时间预算或评分偏好。

字体微调、目录命名、普通绘图风格等可由 Codex按冻结模板判断，不要阻塞主线。

## 31. 报告增量而非重复全过程

每轮最终回复固定为：

```text
STATUS
WHAT CHANGED
EVIDENCE / ARTIFACTS
GATE RESULT
RISKS / BLOCKERS
NEXT EXACT ACTION
```

长推导、表格和日志保存到文件，聊天中只报告关键结果和路径。

## 32. 复杂度停止损失

为每条复杂路线预先设置：

- 时间上限；
- 最低性能/可行性提升；
- 稳定性要求；
- 无法通过时回退到哪个 baseline；
- 哪些工件标记 STALE。

复杂模型若不能在预算内完成、不能超过 baseline、无法解释或无法复现，应停止继续堆叠模块。

---

# 第十一部分　提交前总检查清单

## 33. 题目与数据

- [ ] 完整题目和所有附件已实际读取；
- [ ] 当年官方规则与非官方建议已区分；
- [ ] 所有关键常量、单位、范围和时点已记录；
- [ ] 各问输出 schema 明确；
- [ ] 多表关系、实体、重复观测和时间顺序明确；
- [ ] 特征在真实预测/决策时点可用；
- [ ] 原始文件未被修改。

## 34. 模型与代码

- [ ] 路线先比较后冻结；
- [ ] 模型与求解器分开；
- [ ] evaluator 独立且有单测/oracle；
- [ ] 复杂模型有可信 baseline；
- [ ] 新增模块有独立作用和消融；
- [ ] 目标函数、约束和推导变量正确；
- [ ] 多 seed、候选 archive、失败日志保留；
- [ ] 最终结果由独立 evaluator 重算；
- [ ] 数值步长、容差和边界已检查；
- [ ] run manifest 包含数据/代码/配置/环境身份。

## 35. 结果与论文

- [ ] 每问直接回答原题，而不只报告模型指标；
- [ ] JSON、Excel、表和图来自同一 final run；
- [ ] 论文公式与代码一致；
- [ ] 模型建立不混入结果；
- [ ] 求解章节不编造数字；
- [ ] 每个核心 claim 有 artifact 定位；
- [ ] 负结果和限制未被隐藏；
- [ ] 相关、重要性和敏感性没有被误写为因果；
- [ ] 摘要覆盖真实问题数量和关键量化答案；
- [ ] 图表不重复、不失真、单位完整。

## 36. 提交与匿名

- [ ] 官方模板未被覆盖；
- [ ] submission 文件重新读取并逐字段验证；
- [ ] 页边距、页码、摘要页数、目录规则按当年官方文件检查；
- [ ] 文献真实且正文与文末一一对应；
- [ ] 附录和支撑材料含必要、可运行代码与说明；
- [ ] 使用相对路径，无本机用户目录依赖；
- [ ] 无学校、姓名、赛区、账号、头像、密钥和个人元数据；
- [ ] AI 使用声明与真实日志一致；
- [ ] 最终一致性审计无 FAIL；
- [ ] `FINAL SUBMISSION STATUS = READY`。

---

# 第十二部分　最短可用版：临时发给 Codex 的单轮通用 Prompt

仅用于范围较小、定义清楚、无需完整比赛工作流的单个任务。复杂新题仍应使用分阶段模式。

```text
请处理【当前唯一任务】。

权威输入：【文件/路径/版本】。
当前状态：【已通过Gate、已选路线、final run；未知写UNKNOWN】。
题目硬约束与单位：【逐项列出】。
本轮允许：【只读/允许创建哪些文件/是否可运行代码】。
本轮禁止：【不选模型/不进入下一问/不写论文/不覆盖原文件等】。

执行时：
1. 先实际读取输入并检查版本；
2. 区分 STATED FACT、VERIFIED FACT、ASSUMPTION 和 DECISION；
3. 不虚构数据、字段、文献、运行结果或检验；
4. 使用与任务匹配的最小充分方法；
5. 保存可复现证据；
6. 对最终结果执行独立核验；
7. 未检查项标记 NOT VERIFIED；
8. 碰到会改变答案的歧义、关键文件缺失或新增权限需求时停止并报告。

交付物：【精确文件名、格式、字段和目录】。
验收条件：【可量化PASS项】。
完成后只报告 STATUS、ARTIFACTS、GATE、RISKS、NEXT ACTION，并停止。
```

---

# 结语

## 附录：本版对所提供材料的吸收映射

| 材料 | 保留的有效内容 | 在 V2.0 中的强化方式 |
|---|---|---|
| `小何学长提示词(1).docx` | 数据说明、问题分析、假设、符号、代码转论文、图表描述、摘要、模型评价等高频微 Prompt | 为每类 Prompt 增加权威输入、事实边界、证据定位、执行权限、验证状态和停止条件 |
| `小何学长国赛论文标准模版(1).docx` | 摘要—问题重述—问题分析—假设—符号—模型建立与求解—检验—评价—参考文献—附录的基本论文骨架 | 不再把该骨架当作所有赛事的官方固定格式；组装前由当年正式规则决定目录、页码、篇幅和匿名要求 |
| `2026年数学建模竞赛论文模板.docx` | 论文各章节的写作边界、图表规范、AI使用说明、附录与复现检查 | 加入“官方硬要求 vs 非官方经验”的来源优先级；把 AI 日志、claim-to-evidence、匿名和文档元数据检查前置到项目全过程 |
| `2026 AI+数模竞赛(1).pptx` | 角色/任务/细节/语气/分步/输出，以及“目标—材料—边界—交付—验收”；先实验、验证证据、再写论文 | 重构为九块式 Prompt 契约；增加当前状态、权限、停止条件和状态更新，并明确可并行/必须串行任务 |
| `skill与转换软件(1).zip` | 代码实验、模型建立、模型求解三类能力 | 吸收原始审计发现，避免代码 Skill 擅自选路线、常见题型直接套算法、无 baseline、写作事实源不明确和环境硬编码等问题；压缩包中的 EXE 不参与本 Prompt 系统 |
| `skill-workbench.zip` | 优化后的 orchestrator、decomposer、strategy、experiment、validator、methodology、solution、consistency 流程 | 将其 Skill 边界扩展成可直接执行的阶段 Prompt，并补入 final run registry、artifact stale 机制、答案 schema、独立重算、AI 使用留痕和应急降级 |
| 2025 A 题截图 | 展示了多问题递进、物理—几何 evaluator、时间区间并集、多主体协同和官方 Excel 结果文件的典型复杂结构 | 用于验证通用 Prompt 能表达公共核心、问题依赖、推导变量、约束逐项核验、独立重算和提交模板回读，而未把该题的固定模型写入新题模板 |

### 未机械继承的内容

- 固定“五问”“摘要八段”“一问一段”等仅在题目结构确实匹配时使用；
- “常见题型 → 常见算法”的直接映射不进入主流程；
- 学长模板中的经验性字体、章节和目录建议不冒充当年官方规定；
- 任何示例中的数值、模型和结论不得迁移到新题；
- 来源不明的可执行安装程序不作为 Prompt 设计或数学建模步骤执行。

一条优秀的数学建模 Prompt 不应替参赛者预设答案，而应把 Codex 限定在一个可验证的科研与工程流程中：先冻结题意和数据身份，再比较建模范式；先建立公共 evaluator 和 baseline，再运行复杂模型；先独立验证并冻结 final run，再写论文；最后让每一个公式、数字、图表和提交文件都能回到真实证据。

这套系统的衡量标准不是“输出看起来多专业”，而是：

> 能否复现、能否核对、能否解释、能否在失败时回退、能否保证最终提交中的每个事实来自同一个可信版本。
