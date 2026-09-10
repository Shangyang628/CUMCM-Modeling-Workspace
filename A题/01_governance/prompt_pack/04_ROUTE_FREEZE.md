# A题专用 Prompt 04：路线确认与模型契约冻结

```text
$math-modeling-orchestrator

用户确认：主路线=【待填写】；适用范围=【Q1/Q2-Q3/Q4或统一框架，待填写】；备用路线=【待填写】。

只核对并冻结，不运行正式仿真。若用户尚未选择路线，或以下核心定义未明确，返回 BLOCKED：空间维度/端面处理、环境边界在14400 s后的规则、热质耦合边界、Q4移动坐标与result4矩形编码。

生成：
1. ROUTE_DECISION.md：逐问题主/备路线、淘汰理由、判别证据、回退阈值；
2. MODEL_CONTRACT.md：T与C的域、方程、物性公式、单位、初边值条件、r=0处理、r=R(t)处理、附件插值/外推、阈值 C<0.15、四位小数仅用于报告而非内部计算；
3. VALIDATION_PLAN.md：解析/制造解、质量/能量收支、正性/有界性、网格与时间步收敛、插值敏感性、Q3事件定位、Q4移动域守恒、模板回读；
4. COMPUTE_BUDGET.md：粗网格、精网格、收敛停止、失败回退；
5. 更新 decision_log 与 PROJECT_STATE。

参数来源逐项标 STATED、ESTIMATED、TUNED 或 UNKNOWN；没有来源的潜热、端面对流、收缩轴向律等不得填入。若策略选择需要新增参数而题目无依据，必须明确估计方案与敏感性或回退。

验收：4问全部有可实现契约和答案 schema；Q3/Q4终止事件有精度要求；result1–4填表规则已冻结。最后报告 ROUTE GATE、EXECUTION READY、OPEN RISKS 并停止。
```

