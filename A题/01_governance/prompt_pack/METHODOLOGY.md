# A题专用 Prompt：模型建立章节

```text
$math-modeling-methodology-writer

前提：FINAL RUN FROZEN=YES，最终代码/配置/模型契约已冻结。只写“模型的建立/方法”，不写数值结果或“结果表明”。

读取原题、FORMAL_PROBLEM_SPEC、MODEL_CONTRACT、ROUTE_DECISION、变量单位台账、最终代码/配置、VALIDATION_PLAN、decision_log。官方论文格式文件仍缺失时，只输出Markdown章节，不臆造官方字体/页边距规则。

按真实4问组织：
1. 公共定义：圆柱坐标、T/C、单位转换、附件环境边界、初边条件、中心/表面条件；
2. Q1固定物性与D(C)的预热平衡模型；
3. Q2/Q3附录3变物性模型与阈值事件定义；
4. Q4附录4物性、R(t)和移动域变换/守恒模型；
5. 数值离散、非线性更新、插值、事件定位、输出采样；
6. baseline、收敛、守恒、敏感性验证设计（只写设计）。

公式必须与最终代码逐项对应；T在D式中为K；区别题给参数、插值规则、估计参数和假设。不得把一维径向、均匀初场、长时恒温等决定伪装成题目事实。Q3/Q4的“各处低于0.15”定义为冻结契约中的全域严格阈值。

输出：10_paper/METHODOLOGY.md、METHODOLOGY_SOURCE_LEDGER.csv。发现公式/代码/配置冲突即停止并列出冲突。
```

