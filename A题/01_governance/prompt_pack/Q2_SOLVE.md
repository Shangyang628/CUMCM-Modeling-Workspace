# A题专用 Prompt Q2：前三小时变物性全过程模型

```text
$math-modeling-code-experiment

只解决Q2的0–3 h结果，不进入Q3。前提：Q1验证通过或公共核心对Q2所需部分已独立通过；读取附录3、附件1、冻结契约和Q2 schema。

权威公式（C为kg/kg，T为K）：ρ=650+128C；cp=1450+2736·C/(C+1)；k=0.21+0.38·C/(C+1)；D=2.4×10^-3·exp(-0.45/C)·exp(-3850/T)。不得把°C代入D，不得沿用附录2/4的系数。

执行：
1. 从t=0、T=28°C、C=2.55 kg/kg开始，按冻结的Q2几何、初边界与耦合规则运行至10800 s；
2. 附件1在0–10800 s内有60 s数据，不允许不必要外推；
3. 对ρ、cp、k、D的取值范围、更新频率和极端C/T做诊断；
4. 运行固定物性/粗网格baseline与主模型，进行Δr/Δt/容差收敛；
5. 独立evaluator核验守恒、中心/表面边界、连续性与物理范围；
6. Q2_RESULT.json保存t={0.5,1,1.5,2,2.5,3}h、r={0,0.5,1,1.5,2}cm的T/C，四位小数；
7. 复制模板为11_submission/result2.xlsx并扩展两个sheet；按每1 s至10800 s、每0.1 cm至2 cm写入，具体是否含t=0遵守TEMPLATE_FILLING_SPEC；
8. 回读核对两sheet、时间/空间轴、四位小数、占位符清除及JSON一致性。

输出：06_questions/Q2/...、Q2_RESULT.json、Q2_SOLUTION_NOTES.md、11_submission/result2.xlsx及新run manifest。

硬验收：公式/单位PASS；3 h覆盖PASS；非线性系数范围PASS；收敛与独立重算PASS；result2回读PASS。失败即停止。
```

