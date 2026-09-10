# A题专用 Prompt 03：多范式建模路线设计

```text
$math-modeling-strategy-designer

读取已冻结的 FORMAL_PROBLEM_SPEC、ANSWER_SCHEMAS、AMBIGUITY_REGISTER、数据审计和4问依赖图。只设计/比较路线，不写生产代码，不预填参数或答案。

围绕本题“圆柱药材内非稳态传热—水分扩散、物性随C/T变化、Q4移动边界”提出3–5条数学上真正不同的路线。路线差异应来自空间维度、守恒形式、固定/移动域处理、耦合方式和数值离散，而不是仅更换ODE/PDE库或优化器。可比较解析/半解析基线、有限差分/有限体积方法线、有限元线、坐标变换移动域线等，但不得因示例措辞直接选定。

每条路线写清：控制方程/守恒对象、初边值条件、固定/移动几何、附件1与附件2如何进入、物性公式适用范围、0点奇异项处理、表面通量定义、时间/空间插值、数值稳定与收敛、质量/能量守恒核验、Q1–Q4复用关系、最小可信baseline、实现成本、失败回退。

必须设计低成本判别实验：
1. 固定系数/常边界小样例与解析或高精度oracle对照；
2. Q1在Δr=0.1 cm、输出1 s要求下的网格/步长收敛；
3. 附件1的60 s边界插值敏感性；
4. Q3阈值时刻对长时环境外推规则的敏感性；
5. Q4移动边界的质量守恒、坐标映射和附件2插值敏感性。

对是否采用1D径向、长时环境边界、潜热耦合、Q4坐标/模板编码这4个核心定义给出推荐解释、备选、证据与风险；证据不足时标记 AWAITING USER DECISION。不得把题目没给出的参数悄悄补齐。

评分维度：Problem Fit、守恒/量纲可靠性、固定/移动域适应性、可验证性、数值稳定、计算成本、实现风险、4问复用、论文表达、同质化风险。明确复杂路线超过baseline的最低证据和回退触发条件。

输出：04_model_candidates/ROUTE_*.md、ROUTE_SCORECARD.csv、INNOVATION_HOMOGENIZATION_AUDIT.md、MINIMUM_DISCRIMINATION_EXPERIMENT.md、RECOMMENDATION.md。

结束状态必须为 AWAITING ROUTE DECISION；不得进入实现。
```

