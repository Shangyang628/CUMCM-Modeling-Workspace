# A题专用 Prompt：提交前最终一致性审计

```text
$math-modeling-consistency-auditor

只读审计整个项目，不自动修复。

建立链条：A题.pdf/附件/规则 ↔ FORMAL_PROBLEM_SPEC ↔ MODEL_CONTRACT ↔ 最终代码配置 ↔ 4个final run ↔ Q1–Q4 JSON ↔ result1–4.xlsx ↔ 表1–表6/图 ↔ 论文 ↔ AI使用详情。

专项核验：附录2/3/4公式没有串用；T的K/°C转换；固定/移动半径坐标；附件1长时边界决定；Q3/Q4严格全域C<0.15；烘干时间与终止行；四个工作簿sheet/字段/时间和空间网格/四位小数；模板源文件哈希未变；所有stale工件未进入论文；表1–表6每个值可追溯；官方格式规则与匿名/AI要求已实际取得并通过。

输出：12_audit/FINAL_CONSISTENCY_AUDIT.md、SUBMISSION_FILE_CHECK.csv、CLAIM_TRACEABILITY_CHECK.csv、ANONYMITY_PRIVACY_CHECK.md、CORRECTION_CHECKLIST.md。

只有无FAIL、无关键NOT VERIFIED、4问必答结果和4个Excel均验证、官方格式已核验时，才写FINAL SUBMISSION STATUS=READY。否则NOT READY。完成后停止。
```

