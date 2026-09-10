# Skill Test Results

测试日期：2026-08-30

## 官方结构校验

使用 `skill-creator/scripts/quick_validate.py`，并以 Python UTF-8 模式加载临时 PyYAML 6.0.2。10/10 Skill 均返回 `Skill is valid!`。

## 自定义静态完整性校验

最终结果：25 PASS / 0 FAIL。

通过项包括：

- 10 个预期 Skill 目录和 10 个唯一 name；
- 全部 `SKILL.md`、`agents/openai.yaml` 和显式 `$skill-name` 默认提示；
- 全部本地 Markdown 引用有效；
- 正式 Skill 内没有 EXE、脚本、bundled dependency 或 Windows 绝对路径；
- 没有可执行形式的 `matplotlib.use('TkAgg')` 硬编码；
- 路线竞争、同质化风险、简洁性 Gate、baseline、切分、消融、敏感性、稳健性、泄漏、写作事实约束和一致性审计条款齐全；
- 30 个触发案例覆盖每个 Skill 的 positive/negative/boundary；
- 评价、预测、优化、时间序列、机理建模五类反模板案例齐全。

第一轮自定义检查为 14 PASS / 6 FAIL；检查器把“不要硬编码 TkAgg”的说明误判为硬编码，并错误统计触发覆盖。修正检查语义后复测通过。该中间失败未被当作 Skill 通过证据。

## 六项 Smoke Test 静态前向审查

| Test | 提示摘要 | 期望 | description/边界审查 |
|---|---|---|---|
| 1 | 先不要建模，分析题目 | problem-decomposer | PASS |
| 2 | 已拆解，比较不同路线 | strategy-designer | PASS |
| 3 | 路线 B 已确定，开始实现 | code-experiment | PASS |
| 4 | 实验完成，写模型建立 | methodology-writer | PASS |
| 5 | 根据最终 Excel 和图片写求解 | solution-writer | PASS |
| 6 | 提交前检查代码/结果/公式/论文 | consistency-auditor | PASS |

30 个案例的期望路由与每个 Skill 的 `description`、进入条件和禁止条件逐项一致。边界案例包括“只有代码无结果仍要求具体指标”，其预期行为是触发 solution writer 但拒绝编造并返回 `NOT READY`。

## 反模板检查

五类题目的验收标准要求先形成不同数学范式并记录问题特异性、数据适用性和最小判别实验。优化后的策略 Skill 不含“评价 -> TOPSIS”“预测 -> XGBoost/LSTM”“优化 -> GA/PSO”的默认映射；上述算法只在“算法名本身不是创新”的否定性清单中出现。

## Codex 发现与运行时路由

通过 `codex debug prompt-input` 创建新的只读提示上下文，10/10 新 Skill 名称都出现在模型可见输入中，因此 Codex 发现/识别为 `PASS`。

随后尝试用一次批量的只读、无工具、ephemeral `codex exec` 调用测试六条提示。三次调用都成功创建临时 thread 并输出 `turn.started`，但没有产生 `turn.completed` 或模型分类文本；因此这些尝试不能作为路由通过证据，也没有被写成 6/6 PASS。

最终边界：文件级结构、行为契约、30 个触发案例和六项 description 语义审查为 `PASS`；Codex Skill 发现为 `PASS`；真实模型隐式路由为 `NOT VERIFIED`，所以总触发测试状态为 `PARTIAL`。显式 `$skill-name` 调用不受此限制。
