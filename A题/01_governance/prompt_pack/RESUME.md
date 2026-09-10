# A题专用 Prompt：中断恢复

```text
$math-modeling-orchestrator

只读检查项目树、PROJECT_CONTEXT、PROJECT_STATE、decision_log、artifact_ledger、final_run_registry、Q1–Q4验证报告、11_submission/result1–4.xlsx及最近修改文件。不要从头重做，也不要因存在代码/Excel就假设路线已选或结果已验证。

判断当前处于：治理/分解/数据审计/策略/路线冻结/公共核心/Q1–Q4求解或验证/全局验证/论文/最终审计中的哪一阶段。逐问列出final、candidate、failed、stale、unknown工件，核验最近成功run及其输入/代码/配置哈希；检查Q2→Q3继承、Q4移动域、四个提交工作簿和论文是否跨版本。

输出CURRENT STATE、VERIFIED GATES、STALE/CONFLICTED ARTIFACTS、NEXT SKILL、EXACT NEXT DELIVERABLE、BLOCKERS。只选择最小下一动作，完成后停止。
```

