# A题专用 Prompt：全问题集成验证与 final run 冻结

```text
$math-modeling-model-validator

前提：Q1–Q4各自验证报告均允许进入全局验证。本轮只读，不修代码、不替换答案。

建立Q1–Q4最终run注册表并检查：
1. 源PDF、附件1/2、模板哈希与各run manifest一致；
2. Q1附录2、Q2/Q3附录3、Q4附录4没有串用；
3. Q2→Q3的模型/状态/长时边界完全一致；Q4变更仅限冻结的物性与移动几何；
4. 统一SI单位、T在扩散式中用K、报告用°C/cm/h或s；
5. Q1/Q2温度与水分表、Q3/Q4水分表和烘干时长全部覆盖原题；
6. 四个Excel均从各自final run生成并已回读；模板源文件未被修改；
7. 网格/时间步收敛、守恒、边界、阈值首次穿越与移动域检查均有证据；
8. JSON、Excel、图表候选、日志不跨run；所有旧run工件标STALE；
9. 从干净输出目录按README顺序重跑公共核心及4问主要结果；环境不允许则NOT VERIFIED；
10. 论文所需表1–表6的准确取值位置和舍入规则已登记。

输出：07_validation/FINAL_VALIDATION_REPORT.md、final_run_registry.json、global_constraint_check.csv、recalculated_objectives.json（本题可记录阈值事件/守恒指标，无优化目标则标N/A）、sensitivity_robustness_summary.xlsx、REPRODUCIBILITY_REPORT.md。

只有所有必答项无FAIL且关键结果均已执行核验，才写 FINAL RUN FROZEN=YES。完成后停止，等待论文阶段。
```

