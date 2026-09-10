# A题专用 Prompt 00：输入审计与项目治理

```text
$math-modeling-orchestrator

项目根目录：C:\Users\LENOVO\OneDrive\文档\ChatGPT\数学建模\A题

本轮只做输入审计、治理初始化和4问工作流规划，不选择模型、不写求解代码、不运行仿真、不写论文。

必须读取：
- 01_governance/PROJECT_CONTEXT.yaml；
- A题.pdf（4页，题名“药材的烘干问题”）；
- 附件/附件1.xlsx、附件/附件2.xlsx；
- 附件/附件3/result1.xlsx 至 result4.xlsx；
- 本 prompt_pack/PROMPT_PACK_INDEX.md。

已知文件身份仅作复核起点，必须重新计算 SHA-256：A题.pdf=052D8014...1736；附件1=7EF32870...9DD7；附件2=5563ACBF...04AF；result1=result2=23B261B2...8FF4；result3=07E4793D...2859；result4=86E9300F...EEAC。若不一致，报告冲突并停止使用旧摘要。

任务：
1. 建立完整来源登记，区分赛题/附件/结果模板与非官方手册；原始文件及模板全部只读。
2. 核验真实问题数为4，分别关联 result1–result4；核验“所有结果保留四位小数”。
3. 核验附件可打开、工作表完整、没有隐藏 sheet/公式/缺失文件；记录字节数、修改时间和哈希。
4. 明确附件1为环境温度与环境水分浓度时序，附件2为半径时序，附件3为4个示意结果模板。
5. 明确当前缺失：题首页引用的《全国大学生数学建模竞赛论文格式规范》、独立论文模板、截止时间、队伍能力、语言/求解器/联网政策。缺失格式规则只阻塞最终格式确认，不自动阻塞题意拆解。
6. 创建缺少的治理文件与目录角色映射，不移动、不覆盖现有文件：PROJECT_GOVERNANCE.md、SOURCE_REGISTRY.csv、PROJECT_STATE.json、decision_log.md、artifact_ledger.csv、AI_USAGE_LOG.md、INPUT_AUDIT.md、WORKFLOW_PLAN.md、BLOCKERS.md。
7. 在 decision_log 中只记录“Prompt包已编译”和材料状态；不得记录任何模型路线已选。

验收：所有7个权威输入实际可读且哈希已记录；官方/非官方来源分开；4问及4个结果文件关系明确；缺失规则标记 NOT VERIFIED；未推荐算法。

输出：01_governance/INPUT_AUDIT.md、WORKFLOW_PLAN.md、BLOCKERS.md及上述治理文件。完成后报告 CURRENT GATE、BLOCKERS、下一条 01_DECOMPOSE.md，并停止。
```

