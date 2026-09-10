# 原始 Skill 审计报告

审计日期：2026-08-30  
原 ZIP：`D:\weixin\xwechat_files\wxid_14uqb6rsj6il22_fe33\msg\file\2026-08\skill与转换软件(1).zip`  
SHA-256：`703132A9763348B9940D6440E599FF8E98E47DB7004DC43E4216C3FCE36BE109`

## A1 概况与安全边界

- ZIP 共 198 个条目，解压后 157 个文件，全部位于 `D:\Codex\skill-workbench\source` 并已标记只读。
- 发现 1 个可执行文件：`mathpix_snipping_tool_setup.v03.00.0074.exe`，55,154,848 字节，SHA-256 为 `C17FCCDB00F5C337E5BD71E3DC5AB9A02BEF5DDD4F34F6A8D2958C876A502BEF`。
- 未执行 EXE；未发现 MSI/BAT/CMD/PS1/PY/SH/JS/VBS/DLL/SCR 或嵌套压缩包。
- 文本静态扫描未发现删除、注册表修改、凭据读取、下载执行、`shell=True`、`os.system`、用户目录递归扫描等可执行逻辑。
- 两处危险关键词命中来自相同论文示例中的普通英文 `generating`，属于误报。
- 原 ZIP 在解压后再次哈希，值未变化。

## 完整 Skill 清单

原包存在 7 个 `SKILL.md` 实例，对应 5 个唯一名称。

| Skill | 路径 | 用途 | 依赖 | 是否独立 | 是否重复 |
|---|---|---|---|---|---|
| `math-modeling-code-experiment` | `source\math-modeling-code-experiment` | 选择或实现模型并输出代码/实验材料 | 无显式依赖 | 是 | 否 |
| `math-modeling-methodology-writer` | `source\math-modeling-methodology-writer` | 撰写“模型的建立” | bundled `nature-writing`、`humanizer-zh` | 主 Skill 独立，依赖被内嵌 | 否 |
| `nature-writing` | `source\math-modeling-methodology-writer\bundled_dependencies\nature-writing` | 通用科研写作路由 | 清单声称依赖 `../_shared` | 否 | 与 solution 包内副本逐文件重复 |
| `humanizer-zh` | `source\math-modeling-methodology-writer\bundled_dependencies\humanizer-zh` | 学术语言润色/去模板化 | 无可执行依赖 | 可独立 | 与 solution 包内副本重复 |
| `math-modeling-solution-writer` | `source\math-modeling-solution-writer` | 从最终输出撰写“模型的求解” | bundled `nature-writing`、`humanizer-zh` | 主 Skill 独立，依赖被内嵌 | 否 |
| `nature-writing` | `source\math-modeling-solution-writer\bundled_dependencies\nature-writing` | 同上 | 同上 | 否 | 重复 |
| `humanizer-zh` | `source\math-modeling-solution-writer\bundled_dependencies\humanizer-zh` | 同上 | 同上 | 可独立 | 重复 |

哈希审计发现 69 个重复哈希组、69 个多余文件副本，共 170,105 字节；它们来自两套完全相同的 `nature-writing`/`humanizer-zh`。

## 逐个审计

### math-modeling-code-experiment

**当前职责与优点**

- 能读取题目、数据和既有清洗结果，生成代码、Excel/CSV、图片和诊断日志。
- 已意识到 baseline、时间切分、泄漏、随机种子、目标期不可当真值等问题。
- 区分代码实验与论文写作。

**缺点与风险**

- description 明确允许在“我没有思路”时自行设计模型，和应新增的策略设计职责冲突。
- 工作流第 3 步仍在本 Skill 内选择模型，没有人工路线 Gate。
- `method-patterns.md` 把“风险评价”直接列向熵权/CRITIC/TOPSIS，把“优化”直接列向 DE/PSO/GA，存在模板化诱导。
- 对路线竞争、同质化风险、三层创新审计、模型简洁性没有系统规则。
- baseline 仅写“when it helps”，不是复杂模型的强制条件。
- 缺少完整消融、系统敏感性和问题相关稳健性协议。
- `SKILL.md` 与泄漏检查清单均硬编码 `TkAgg`，并禁止无显式许可使用 `Agg`，会破坏无 GUI 环境。
- 可复现记录不完整：没有统一数据/代码 hash、run ID 和版本到产物的追踪契约。

**建议**：保留名称和实现职责，但删除初始路线选择权；加入 Entry Gate、强制 baseline、切分协议、消融、敏感性/稳健性、run manifest 与环境自适应 backend。

### math-modeling-methodology-writer

**当前职责与优点**

- description 对“模型建立”与“模型求解”的边界较清楚。
- 要求使用最终代码，禁止 RMSE/MAE/预测值等结果进入模型建立。
- 能从代码反向核对变量、公式和算法流程。

**缺点与风险**

- 依赖被重复内嵌，正式安装会产生多份相同 Skill。
- 强制依赖 `nature-writing`，但该依赖的 manifest 缺 4 个 `../_shared` 文件，按其自身路由无法完整执行。
- 缺少明确的 route-decision、最终配置和变量/单位台账作为事实源。
- 没有把消融、敏感性、稳健性的“设计”明确纳入方法章节。
- 没有形成可供一致性审计使用的证据清单。

**建议**：保留并收窄；以最终代码、配置、变量台账为事实源；写作依赖改为独立共享 Skill；增加实现偏差和结果边界 Gate。

### math-modeling-solution-writer

**当前职责与优点**

- 明确读取 final code、模型建立、Excel/CSV、日志和图片。
- 禁止编造，要求如实解释负指标和弱结果。
- 能区分方法推导和结果分析。

**缺点与风险**

- 同样重复内嵌两个公共依赖，并继承 `nature-writing` 缺失引用。
- “最终文件”主要依赖用户指定或文件位置，没有统一 run ID/hash 绑定。
- 没有系统 claim-to-evidence ledger，数值虽来自文件但仍可能来自不同运行版本。
- 对消融、敏感性、稳健性和表图冲突的追踪不够强。
- description 与通用 `nature-writing` 的结果/论文写作触发范围存在一定重叠。

**建议**：保留并收窄到有真实运行产物后的求解章节；强制证据台账、运行身份、差结果保留和表图冲突告警。

### nature-writing

**当前职责与优点**

- 有渐进加载和 section/paper type/language/journal 路由思想。
- 强调 claim-evidence、缺失证据占位和克制表达。

**缺点与风险**

- description 覆盖几乎所有学术写作，容易抢占两个数学建模写作 Skill。
- 两份完整副本重复安装。
- 两份 `manifest.yaml` 均引用 4 个不存在的 `_shared` 文件：`reader-workflow.md`、`paper-type-taxonomy.md`、`ethics.md`、`terminology-ledger.md`。
- 资源规模相对当前数学建模用途过大，包含大量与比赛工作流无关的通用论文示例。

**建议**：保留一个精简、独立、证据约束明确的共享版本；description 排除专门的模型建立/求解场景。

### humanizer-zh

**当前职责与优点**

- 基础原则明确要求保留事实、数据、公式和技术逻辑。
- 能减少空话、机械连接和夸张措辞。

**缺点与风险**

- 两份副本重复。
- description 还覆盖 EI 转化、敏感词规避、文献检索和 DOCX 样式，范围过宽，容易与文档/通用写作任务冲突。
- 含特定应用领域替换模板，可能在不合适场景改变术语范围。
- “去 AI 味”目标需要更明确地从规避检测转向语言质量与事实不变。

**建议**：保留一个共享版本；只承担既有文本的表达优化，并把数字、公式、定义、结论、参数、引用含义和证据强度设为不可变。

## 原架构缺口

| 能力 | 原状态 | 风险 |
|---|---|---|
| 总控与阶段识别 | 缺失 | 各 Skill 各自推断上下文，版本混乱 |
| 问题抽象/附件审计 | 分散且不完整 | 容易直接跳算法 |
| 多范式路线竞争 | 缺失 | 评价/预测/优化默认常见模板 |
| 同质化风险 | 缺失 | 无法识别通用 Prompt 方案 |
| 人工路线 Gate | 缺失 | 代码 Skill 擅自选择路线 |
| 独立模型验证 | 仅散落检查项 | 缺少统一证据等级和提交 Gate |
| 消融/敏感性/稳健性 | 不完整 | 复杂模块贡献无法证实 |
| 论文一致性审计 | 缺失 | 论文、代码、Excel、图片可能跨版本 |
| 共享依赖 | 双份 bundled | 重复、名称冲突、维护漂移 |

## 触发冲突

- `code-experiment` 的“没有思路也设计方法”覆盖了 problem decomposition 和 strategy design。
- `nature-writing` 的广泛“论文/章节/实验/方法”描述覆盖 methodology/solution writer。
- `humanizer-zh` 的“论文转化、文献插入、DOCX 同步”等范围超出纯语言润色。
- 两份相同 dependency 的 name 完全重复，若原样安装会出现重名发现问题。

## A1/A2 结论

原包不是危险执行包，但不满足正式安装 Gate。关键 FAIL 是：架构缺层、硬编码 `TkAgg`、公共依赖重复、`nature-writing` 缺失内部依赖、无路线选择 Gate、无一致性审计。应在只读 source 之外重构，完成静态与触发测试后再安装。
