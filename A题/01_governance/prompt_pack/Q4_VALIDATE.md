# A题专用 Prompt Q4：独立验证

```text
$math-modeling-model-validator

只读验证Q4指定run：【待填写 run_id】。

核查附件2全部145个半径点、1800 s步长、插值无过冲且节点精确；附录4公式与K单位；移动坐标映射、网格速度/守恒项、r=0与r=R(t)边界；固定R退化；总水分质量收支；全移动域阈值首次穿越；Δr/Δt/R插值敏感性；Q4与Q3差异能否由冻结变更解释。

独立重算选定的6 h、24 h、接近结束时刻的R(t)、表面/中心C与全域最大C，并验证终止前后。回读result4.xlsx，逐行检查有效坐标、表面列、空值/越界规则、60 s时间轴、四位小数及同一run一致性。

输出：07_validation/Q4_VALIDATION_REPORT.md、Q4_constraint_check.csv、Q4_recalculated_result.json、Q4_numerical_stability.csv。

只有MOVING DOMAIN、MASS CONSERVATION、THRESHOLD EVENT、NUMERICAL和RESULT FILE均PASS，才写READY FOR GLOBAL VALIDATION=YES。完成后停止。
```

