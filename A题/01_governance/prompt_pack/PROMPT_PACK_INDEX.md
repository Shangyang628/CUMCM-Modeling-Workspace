# 2026 A题“药材的烘干问题”专用 Prompt 包索引

## 1. 本包边界

本包由《数学建模新题 Codex 全流程 Prompt 系统 V2.0》第六部分编译得到。本轮只生成执行指令，未选择模型、未写求解代码、未运行仿真、未填写结果工作簿、未撰写论文。原始 ZIP、PDF、附件1/2及附件3模板均保持只读。

标准入口是 `00_START.md`。每个Prompt完成后必须停止；只有索引所列完成Gate通过后才进入下一条。验证失败时不得继续下游，使用对应求解Prompt做最小修复并生成新run，再回到验证Prompt。

## 2. 已核验材料

| 材料 | 结构/用途 | SHA-256 | 状态 |
|---|---|---|---|
| `A题.zip` | 原始归档，含1 PDF+6 XLSX | `AF414C2A9C367449BD9208CF97379687189F4A7E0D57D53D99034A05537B507B` | PASS，只读 |
| `A题/A题.pdf` | 4页赛题，真实问题数4 | `052D8014BFF5727C019B72E44FDFFAF5C145CE04050DD938BAAF3527DB331736` | PASS |
| `附件1.xlsx` | Sheet1，242×3；t=0..14400 s/60 s；环境温度、环境水分浓度 | `7EF32870ABEEF420B89560B2530FF60DFE4255917805151D89988D0311AF9DD7` | PASS |
| `附件2.xlsx` | Sheet1，146×2；t=0..259200 s/1800 s；半径2.000→1.198 cm | `5563ACBFA4B4AFB10CC6C03E2207E5369BF39DA27576672AFF14CC5C32E704AF` | PASS |
| `result1.xlsx` | 2 sheet示意模板：温度、水分浓度 | `23B261B295C1B787D000EEBBCA6521C37075107B6FCF78724F8D395CE1798FF4` | PASS |
| `result2.xlsx` | 与result1字节级相同的2 sheet示意模板 | `23B261B295C1B787D000EEBBCA6521C37075107B6FCF78724F8D395CE1798FF4` | PASS |
| `result3.xlsx` | 1 sheet含水率示意模板 | `07E4793D620A7F899804C0298D49A16A197960440FD47F8BB780C57EC27E2859` | PASS |
| `result4.xlsx` | 1 sheet移动表面示意模板 | `86E9300FFA3D30C43DE895EA6723DA943E85B8740B137BCAE5AF7107F076EEAC` | PASS |
| `Codex_Modeling_Prompts_V2.md` | 1568行非官方工作手册 | `0765FC2C4848E00B455646C7A32CB9A5CE4A8D214982EE8732C8C7F5BD2B28DD` | PASS，非官方 |
| 全国大学生数学建模竞赛论文格式规范 | 题首页明确引用，但包内没有 | UNKNOWN | MISSING |
| 独立论文模板/补充通知/提交细则 | 包内没有 | UNKNOWN | NOT VERIFIED |

附件1、附件2均无公式、合并单元格、隐藏工作表或隐藏行列。四个结果模板均只有少量示意行列和“…”占位，正式提交时必须在副本上扩展并回读验证，不能把占位符当数据。

## 3. 题目输出契约摘要

| 问题 | 论文必答 | 工作簿必答 | 依赖 |
|---|---|---|---|
| Q1 | 100/300/600/900/1200/1500/1800 s × r=0/0.5/1/1.5/2 cm 的T与C | `result1.xlsx`：两sheet；每1 s、每0.1 cm、至1800 s | 附件1、附录2、公共核心 |
| Q2 | 0.5–3.0 h每0.5 h × 同5个半径的T与C | `result2.xlsx`：两sheet；每1 s、每0.1 cm、至3 h | 附件1、附录3、公共核心 |
| Q3 | 全域C<0.15 kg/kg的首次烘干时长；每6 h×0.5 cm含水率 | `result3.xlsx`：每60 s、每0.1 cm、至结束 | 经验证Q2模型、长时环境规则 |
| Q4 | 收缩条件下烘干时长；每6 h×0.5 cm至表面含水率 | `result4.xlsx`：每60 s、每0.1 cm及表面 | 附件2、附录4、移动域契约 |

所有报告结果保留四位小数；内部计算不得提前舍入。

## 4. 影响求解的歧义与人工决策点

1. 是否忽略25 cm圆柱的轴向/端面效应，仅采用一维径向轴对称域。
2. 单个初值是否代表全空间均匀初场。
3. 附件1的60 s数据如何插值到1 s输出与内部时间步。
4. 附件1只到4 h；Q3/Q4长时段环境温湿边界如何定义。此项未决会阻塞Q3/Q4。
5. 题目缺少蒸发潜热等参数；热质耦合应达到何种程度。
6. 对流传质系数与干基含水率表面通量的量纲/边界定义。
7. Q2“整个烘干过程”与仅要求3 h结果的语义关系。
8. Q3/Q4严格阈值的连续时间精度，以及终止时刻并非60 s整数倍时的工作簿末行规则。
9. Q4移动半径下0.1 cm是固定物理坐标还是归一化/移动坐标。
10. `result4.xlsx`矩形表如何同时表达变动空间列和“药材表面”。
11. 收缩是否只发生在半径，轴向长度/质量守恒如何处理。
12. 官方论文格式、匿名、AI声明、支撑材料和提交渠道/截止时间均未提供。

这些定义先在 `01_DECOMPOSE.md` 建立证据与选项，再由 `03_STRATEGY.md` 给出后果与推荐，最终在 `04_ROUTE_FREEZE.md` 由用户/硬约束冻结。

## 5. 标准使用顺序

| 顺序 | Prompt | 进入输入/Gate | 交付物 | 完成验收 | 停止位置 |
|---:|---|---|---|---|---|
| 1 | `00_START.md` | 当前材料与PROJECT_CONTEXT | INPUT_AUDIT、治理文件、WORKFLOW_PLAN、BLOCKERS | 7个权威输入读全、哈希和4问/4模板关系确认 | Problem Decomposer之前 |
| 2 | `01_DECOMPOSE.md` | 输入审计完成 | FORMAL_PROBLEM_SPEC、事实/变量/约束台账、依赖图、歧义表、ANSWER_SCHEMAS | 4问及12类关键歧义可追溯；无算法预选 | 等待关键定义处理 |
| 3 | `02_DATA_AUDIT.md` | 分解已识别字段与输出 | 数据字典、sheet结构、模板填写规范、质量风险 | 6工作簿逐sheet审计、插值/模板风险明确 | Strategy之前 |
| 4 | `03_STRATEGY.md` | 分解+数据审计可用 | 候选路线、评分卡、判别实验、推荐 | 固定/移动域、守恒、收敛、回退均比较 | AWAITING ROUTE DECISION |
| 5 | `04_ROUTE_FREEZE.md` | 用户选择主/备路线和关键解释 | ROUTE_DECISION、MODEL_CONTRACT、VALIDATION_PLAN、COMPUTE_BUDGET | 路线Gate PASS、4问和模板编码可实现 | 实现之前 |
| 6 | `05_COMMON_CORE.md` | ROUTE GATE=PASS | 公共src/tests/config/oracle、TEST_REPORT、manifest | 单位/公式/插值/解析基线/守恒/模板小样例PASS | Q1之前 |
| 7 | `Q1_SOLVE.md` | 公共核心PASS | Q1 run、JSON、说明、result1副本 | schema/边界/收敛/独立重算/回读PASS | Q1验证前 |
| 8 | `Q1_VALIDATE.md` | Q1指定run | Q1独立验证4件套 | Q1全部硬项PASS | Q2之前 |
| 9 | `Q2_SOLVE.md` | Q1/公共核心PASS | Q2 run、JSON、说明、result2副本 | 附录3/3 h/非线性/收敛/回读PASS | Q2验证前 |
| 10 | `Q2_VALIDATE.md` | Q2指定run | Q2独立验证4件套 | Q2硬项PASS | Q3/Q4之前 |
| 11 | `Q3_SOLVE.md` | Q2 PASS+长时边界冻结 | Q3 run、t_end、JSON、result3副本 | 首次全域阈值、夹逼、敏感性、回读PASS | Q3验证前 |
| 12 | `Q3_VALIDATE.md` | Q3指定run | Q3独立验证4件套 | 连续事件与长时边界PASS | Q4或全局验证前 |
| 13 | `Q4_SOLVE.md` | Q2 PASS+移动域/模板规则冻结 | Q4 run、t_end、JSON、result4副本 | R插值、移动域守恒、阈值、收敛、回读PASS | Q4验证前 |
| 14 | `Q4_VALIDATE.md` | Q4指定run | Q4独立验证4件套 | 移动域全部硬项PASS | 全局验证前 |
| 15 | `GLOBAL_VALIDATE.md` | Q1–Q4验证通过 | FINAL_VALIDATION、final_run_registry、复现报告 | 无FAIL、关键项非NOT VERIFIED | FINAL RUN冻结处 |
| 16 | `METHODOLOGY.md` | FINAL RUN FROZEN | 方法章节与来源台账 | 公式/代码/配置一致，无结果混入 | 结果写作前 |
| 17 | `RESULTS.md` | 最终JSON/Excel/验证齐全 | 结果章节与claim证据台账 | 所有数字可追溯，4问直接回答 | 图表/组装前 |
| 18 | `FIGURES_TABLES.md` | final run与结果章节可用 | 最终图表、表1–6、图表台账/图题 | 全部来自final run、单位/移动边界正确 | 论文组装前 |
| 19 | `AI_DISCLOSURE.md` | AI_USAGE_LOG等真实记录形成 | 匿名AI使用详情 | 不补造、用途与人工核验可追溯 | 组装/最终审计前 |
| 20 | `PAPER_ASSEMBLY.md` | 章节齐全；官方格式规则应已取得 | DOCX、PDF、格式报告 | 全页渲染；格式/匿名/引用核验 | 最终审计前 |
| 21 | `FINAL_AUDIT.md` | 论文、代码、4工作簿、AI详情齐全 | 最终审计5件套 | 无FAIL、无关键NOT VERIFIED才READY | 提交前终点 |

Q4数学上可在Q2验证后、Q3完成前启动，但标准模式保持串行以避免公共配置和台账并发写入。若并行，必须独立输出目录并由单一主流程合并。

## 6. 非标准入口

- `EMERGENCY_MODE.md`：仅在补充明确剩余时间后使用；它只压缩路线数量、次要敏感性和美化，不取消4个硬Gate。
- `RESUME.md`：项目中断后使用；它只识别真实状态与最小下一动作，不从头重做。

## 7. Skills 可发现性

手册列出的8项数学建模Skills均在 `D:\Codex\skills\` 下发现有效 `SKILL.md`：

- `math-modeling-orchestrator`
- `math-modeling-problem-decomposer`
- `math-modeling-strategy-designer`
- `math-modeling-code-experiment`
- `math-modeling-model-validator`
- `math-modeling-methodology-writer`
- `math-modeling-solution-writer`
- `math-modeling-consistency-auditor`

本次Prompt编译轮实际调用的是用户指定的 `math-modeling-orchestrator`；其余7项只被写入对应未来Prompt，尚未执行。PDF和Spreadsheet读取规范仅用于本轮材料检查。

## 8. 当前必须由用户补充

1. 剩余小时数或明确截止时间；
2. 官方《全国大学生数学建模竞赛论文格式规范》及任何2026补充通知/提交说明；
3. 官方或用户指定论文模板（若有）；
4. 队伍人数、专业背景、编程/数学/写作能力与算力；
5. 偏好语言、已安装求解器、联网和依赖安装政策；
6. 比赛模式（正式比赛/模拟/教学）与目标层级；
7. 经分解/策略阶段澄清后，对关键物理与result4编码歧义的最终决定。

当前下一动作：执行 `00_START.md`。完成后必须停止，不自动进入 `01_DECOMPOSE.md`。

