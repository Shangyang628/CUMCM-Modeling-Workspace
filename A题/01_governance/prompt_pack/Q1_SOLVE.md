# A题专用 Prompt Q1：预热平衡阶段求解

```text
$math-modeling-code-experiment

只解决Q1，不进入Q2、不写论文。读取冻结的MODEL_CONTRACT、VALIDATION_PLAN、公共核心、附件1、附录2参数和Q1答案schema。

权威事实：圆柱长25 cm、初始半径2 cm；初始T=28°C、C=2.55 kg/kg；Q1时段0–1800 s；ρ=820 kg/m³、cp=2600 J/(kg·K)、k=0.36 W/(m·K)、对流换热系数25 W/(m²·K)、对流传质系数8×10^-7 m/s、D=7×10^-9 exp(-0.89/C) m²/s。附件1提供每60 s环境T与C；边界插值按冻结契约。

执行：
1. 复核初场、空间域、端面处理、中心/表面边界均已冻结；
2. 运行解析/常系数baseline与主模型；
3. 记录Δr、内部Δt、求解器容差、非线性迭代与运行时间；
4. 至少做一组更细网格/时间步，量化论文采样点与全场最大差异；
5. 用独立evaluator核验边界、正性、温度/水分合理范围及质量/能量残差；
6. 生成Q1_RESULT.json：t={100,300,600,900,1200,1500,1800}s，r={0,0.5,1,1.5,2}cm的T(°C)、C(kg/kg)，四位小数；
7. 复制附件3/result1.xlsx到11_submission/result1.xlsx。按冻结填表规则扩展“温度”“水分浓度”两sheet；时间按每1 s，空间按0.1 cm，表头/单位语义不变；写入前保持全精度，单元格显示/数值均按四位小数；
8. 回读工作簿，核对时间序列、21个径向位置、两sheet、无省略号残留、无公式错误，并逐字段与JSON比对。

输出：06_questions/Q1/src、config、runs/<run_id>、Q1_RESULT.json、Q1_SOLUTION_NOTES.md、11_submission/result1.xlsx。更新manifest与台账。

硬验收：Q1 schema PASS；中心/表面边界PASS；网格/时间收敛PASS或有已批准容差；独立重算PASS；result1回读PASS。任一硬项FAIL则停止并进入Q1_VALIDATE。
```

