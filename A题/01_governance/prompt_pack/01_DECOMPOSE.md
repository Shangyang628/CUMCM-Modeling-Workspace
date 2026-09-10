# A题专用 Prompt 01：题意拆解与数学对象冻结

```text
$math-modeling-problem-decomposer

读取 A题.pdf、全部附件、01_governance/PROJECT_CONTEXT.yaml、INPUT_AUDIT.md、PROJECT_GOVERNANCE.md。只做问题分解；禁止推荐数值格式、算法或求解器，禁止写代码。

按原题冻结4问问题树：
- Q1：固定圆柱（长25 cm、半径2 cm），初始药材温度28°C、干基含水率2.55 kg/kg；利用附件1环境时序与附录2常参数/扩散系数，描述0–1800 s径向温度和含水率。
- Q2：固定尺寸框架下描述整个烘干过程，但本问论文/结果只要求0–3 h；材料参数按附录3随 C、T 变化。
- Q3：继承Q2模型，求首次满足药材各处 C<0.15 kg/kg 的烘干时间，并输出至该时刻的含水率场。
- Q4：考虑附件2给出的随时间收缩半径，参数改用附录4，求烘干时长与移动域内含水率场。

逐问建立：研究对象、时空域、状态量 T/C、外部环境量、给定参数、候选控制/决策量（若原题没有则写 NONE）、初边值条件需求、硬约束、输出字段、前序依赖和验收口径。四类陈述必须分开：STATED FACT、VERIFIED FACT、ASSUMPTION、DECISION。

必须登记并评估这些会改变答案的歧义，不得自行定案：
1. 25 cm长圆柱是否可忽略轴向与端面传热传质，仅做轴对称一维径向模型；
2. 单个初始温度/含水率是否表示空间均匀初场；
3. 环境数据60 s采样而结果需1 s时采用何种插值；
4. 附件1仅到14400 s，Q3/Q4长时段环境边界如何外推，恒温阶段的温湿度是否取稳定值、均值或其他定义；
5. 温度与含水率是否仅通过系数 C、T 耦合，还是还应含蒸发潜热/收缩对能量守恒的影响；题目没有给出相关参数；
6. 对流传质系数8×10^-7 m/s与干基含水率 C 的表面通量边界如何量纲一致地定义；
7. Q2“整个烘干过程”与只要求3 h结果的范围关系；
8. Q3严格不等式“各处低于0.15”的连续时间判定、时间精度与四位小数报告规则；
9. Q4“距离每隔0.1 cm”在移动表面下是固定物理坐标、随时间缩放坐标，还是每行变长；
10. Q4结果模板矩形结构中“药材表面”列与0.1 cm步长如何兼容；
11. Q4长25 cm是否也收缩、质量守恒如何处理；附件2只给半径；
12. 题首页所指官方论文格式规范未提供。

生成 machine-readable ANSWER_SCHEMAS.json，至少包括：
- Q1论文表：t={100,300,600,900,1200,1500,1800}s，r={0,0.5,1,1.5,2}cm，T(°C)、C(kg/kg)，四位小数；result1 两sheet，t按1 s、r按0.1 cm。
- Q2论文表：t={0.5,1,1.5,2,2.5,3}h，r同上，T/C四位小数；result2 两sheet，t按1 s至3 h、r按0.1 cm。
- Q3：烘干时间(h)及论文每6 h/0.5 cm表；result3 单sheet，t按60 s至烘干结束、r按0.1 cm。
- Q4：烘干时间(h)及论文每6 h/0.5 cm至移动表面表；result4 单sheet，t按60 s、空间0.1 cm和表面列；未决坐标规则标 BLOCKED。

输出到 02_problem_analysis/：FORMAL_PROBLEM_SPEC.md、PROBLEM_FACT_LEDGER.csv、VARIABLES_UNITS_LEDGER.csv、CONSTRAINT_UNCERTAINTY_LEDGER.csv、QUESTION_DEPENDENCY_MAP.md、AMBIGUITY_REGISTER.md、ANSWER_SCHEMAS.json。未确认解释不得写成决定。

验收：4问均可追溯到PDF原文；公式指数、单位和适用问题逐项核对；12项歧义均有影响与解决路径；输出 schema 不把模板省略号当真实数据。完成后给出 DECOMPOSITION STATUS、MATERIAL QUESTIONS FOR USER，并停止。
```

