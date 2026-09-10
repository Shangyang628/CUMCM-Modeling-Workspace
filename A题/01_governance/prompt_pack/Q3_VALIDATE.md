# A题专用 Prompt Q3：独立验证

```text
$math-modeling-model-validator

只读验证Q3指定run：【待填写 run_id】。

重点验证：Q2模型与附录3未被静默改动；长时环境边界有正式决定且不越界取数；t_end是连续时间首次满足全域C<0.15，而非采样网格伪命中；t_end-ε处不满足、t_end+ε处满足；限制位置搜索覆盖全空间；严格不等号与舍入前原值区分；网格/时间步细化导致的t_end变化在容差内。

独立重算每6 h表、事件三点和最大C位置；回读result3.xlsx的60 s轴、21个径向点、终止行规则和四位小数。检查Q3结果没有混用Q2仅3 h的工作簿或旧run。

输出：07_validation/Q3_VALIDATION_REPORT.md、Q3_constraint_check.csv、Q3_recalculated_result.json、Q3_numerical_stability.csv。

只有阈值事件、长时边界、数值稳定和结果文件均PASS，才写READY FOR Q4=YES。完成后停止。
```

