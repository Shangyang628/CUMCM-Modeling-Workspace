# A题专用 Prompt 05：公共计算核心、baseline 与 oracle

```text
$math-modeling-code-experiment

前提：ROUTE GATE=PASS，MODEL_CONTRACT、VALIDATION_PLAN、ANSWER_SCHEMAS、TEMPLATE_FILLING_SPEC均已冻结。若空间维度、边界条件、长时环境、Q4坐标规则仍未决，停止并返回编排阶段。

本轮只实现Q1–Q4共享的最小计算核心和验证样例，不生成最终答案。

按冻结契约实现并解耦：
1. 单位系统（内部统一SI；输入/输出显式转换°C↔K、cm↔m、h↔s）；
2. 附件1环境 T_air(t)、C_air(t)读取与冻结插值器；附件2 R(t)读取与冻结插值器；禁止无记录外推；
3. 固定域和移动域状态/网格接口，r=0对称边界与r=R(t)表面边界；
4. 物性接口：附录2常参数及 D(C)，附录3/4的ρ(C)、cp(C)、k(C)、D(C,T)；验证T在指数项中为K；
5. 与求解器独立的物理 evaluator：正性、边界、质量/能量收支、阈值 max_r C、答案采样；
6. 输出采样器：1 s/60 s时间网格、0.1 cm径向网格、论文指定时刻/半径和四位小数；内部值不得提前舍入；
7. 模板复制/扩展/回读器，只写11_submission中的副本，绝不覆盖附件3；
8. run manifest：源文件哈希、代码/配置哈希、依赖、命令、seed（如适用）、网格、步长、时间戳。

建立baseline/oracle：零通量守恒样例、常系数常边界圆柱扩散/导热解析或高精度参考、小时间连续性、均匀场不变性、中心奇异项处理、固定半径下移动域退化一致性。对附件边界插值做节点回代，必须精确复现原始采样点。

输出：05_common_core/src、tests、config、oracles、diagnostics、BASELINE_SPEC.md、TEST_REPORT.md、run_manifest.json。

验收：单位/公式/插值单测通过；制造解或解析基线误差满足VALIDATION_PLAN；无NaN/Inf；守恒残差有量化阈值；模板回读小样例通过。任何核心硬项FAIL则停止，不进入Q1。
```

