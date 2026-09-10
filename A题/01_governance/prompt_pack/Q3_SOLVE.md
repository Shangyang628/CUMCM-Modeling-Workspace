# A题专用 Prompt Q3：固定尺寸烘干结束时间

```text
$math-modeling-code-experiment

只解决Q3。必须读取已通过验证的Q2模型/run、附录3、长时环境边界决定、Q3答案schema。若附件1在14400 s后的边界规则未在decision log冻结，立即BLOCKED。

任务定义：求首次满足 max_{0≤r≤2cm} C(r,t)<0.15 kg/kg 的连续时间t_end（h）；严格不等号、事件定位容差和四位小数规则以MODEL_CONTRACT为准，不得仅在6 h或60 s网格上粗略取首个命中点。

执行：
1. 从t=0连续运行Q2冻结模型至阈值事件；不得把Q2的3 h文件末态与另一次不一致运行拼接；
2. 用粗步长定位跨越区间，再用细化/根事件方法定位t_end；记录限制点r*与C最大值；
3. 检查全径向场而非仅中心；若最大点随时间变化需记录；
4. 对时间步、空间步、长时环境边界和关键耦合参数做针对阈值时刻的敏感性；
5. 使用独立evaluator重算t_end前/时/后的max C，验证严格阈值；
6. Q3_RESULT.json保存t_end、限制位置、容差、6 h整数时刻至结束的r={0,0.5,1,1.5,2}cm含水率；
7. 复制模板到11_submission/result3.xlsx，按每60 s及r=0..2 cm/0.1写入至结束；非60 s整数的终止时刻是否追加一行遵守冻结模板规范；
8. 回读Excel并与JSON/最终run核对。

输出：06_questions/Q3/...、Q3_RESULT.json、Q3_SOLUTION_NOTES.md、11_submission/result3.xlsx。

硬验收：首次穿越定义PASS；阈值前后夹逼PASS；全空间检查PASS；数值/边界敏感性有量化；result3回读PASS。完成后停止。
```

