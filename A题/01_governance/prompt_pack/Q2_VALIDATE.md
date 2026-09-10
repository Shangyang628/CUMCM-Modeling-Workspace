# A题专用 Prompt Q2：独立验证

```text
$math-modeling-model-validator

只读验证Q2指定run：【待填写 run_id】。

逐项核验附录3四个经验式、C/T单位与指数括号；附件1 0–10800 s边界插值；ρ/cp/k/D在全场的有限性和合理范围；变物性更新是否使用当前状态；热质耦合是否严格符合MODEL_CONTRACT；r=0、r=2 cm边界；质量/能量残差；0.5 h间隔论文采样与1 s结果轴；至少两级网格/时间步收敛。

独立重算0.5、1.5、3 h在r=0、1、2 cm的T/C和全场极值。回读result2.xlsx，核验两个sheet、10800 s覆盖、21个径向点（或冻结规则）、四位小数、与Q2_RESULT.json同run同值。

输出：07_validation/Q2_VALIDATION_REPORT.md、Q2_constraint_check.csv、Q2_recalculated_result.json、Q2_numerical_stability.csv。

只有Q2答案、约束、数值与结果文件均PASS，才写READY FOR Q3=YES；完成后停止。
```

