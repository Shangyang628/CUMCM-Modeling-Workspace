# A题专用 Prompt Q1：独立验证

```text
$math-modeling-model-validator

只读验证Q1指定run：【待填写 run_id】。不得改代码、答案或Excel。

核查：附录2公式/单位与输入哈希；附件1插值在60 s节点的回代；初始均匀性/一维径向等决定是否有decision log证据；r=0对称与r=2 cm表面对流边界；非线性D(C)更新；温度和含水率的正性/有界性；质量/能量收支；Δr/Δt收敛；输出1 s×0.1 cm采样是否来自求解值而非错误索引；论文35个温度值和35个含水率值是否从同一run提取。

独立路径重算100、900、1800 s在r=0、1、2 cm的T/C及全场极值，比较容差。回读11_submission/result1.xlsx，要求两个sheet、时间/半径顺序正确、四位小数、无“…”占位、与Q1_RESULT.json一致。

输出：07_validation/Q1_VALIDATION_REPORT.md、Q1_constraint_check.csv、Q1_recalculated_result.json、Q1_numerical_stability.csv。

只有CONSTRAINTS、INDEPENDENT RECALCULATION、NUMERICAL、RESULT FILE均无FAIL，才写READY FOR Q2=YES。完成后停止。
```

