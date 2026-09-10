# A题专用 Prompt 02：数据与模板专项审计

```text
$math-modeling-problem-decomposer

本轮只读审计6个XLSX，不清洗、不插值、不建模、不填写模板。

已知结构必须实际复核：
- 附件1/Sheet1：A:C，1行表头+241行数据；字段“时间/s、温度/°C、水分浓度/(kg/kg)”；t=0..14400，步长60 s；无公式、隐藏行列或合并单元格。
- 附件2/Sheet1：A:B，1行表头+145行数据；字段“时间/s、半径/cm”；t=0..259200，步长1800 s；半径2.000降至1.198 cm；无公式、隐藏项或合并单元格。
- result1/result2：两个可见sheet“温度”“水分浓度”；模板仅示意 A1:F5，含“…”占位；result1与result2源文件哈希相同。
- result3/result4：一个可见Sheet1；模板仅示意 A1:F5；result4末列表头为“药材表面”。

对附件1/2逐列输出类型、行语义、缺失率、重复时间、唯一性、单调性、异常范围、单位、首末值、采样间隔；检查附件1在1800 s、10800 s和14400 s处的边界值，检查附件2是否严格/非严格单调及平台段。这里只描述，不拟合。

对每个模板记录 sheet、单元格坐标、表头语义、样式ID/数值格式、列宽、占位符、应扩展的真实行列数及不确定处。尤其区分：
- Q1预计1..1800 s × r=0..2 cm/0.1，共1800×21数据点/每sheet；t=0是否应包含标 UNKNOWN。
- Q2预计1..10800 s × 21点/每sheet；t=0是否包含标 UNKNOWN。
- Q3行数由烘干结束时刻和60 s采样规则决定；末时刻若非60 s整数倍如何写入标 UNKNOWN。
- Q4空间列因半径随时间变化而不固定；“每0.1 cm+表面”的矩形编码规则标 BLOCKED，禁止猜测。

建立环境边界与半径插值风险：采样数据不是泄漏问题，但插值/外推会直接影响PDE边界与移动网格；列出可供策略阶段比较的保形、分段线性等候选及验证指标，不在本轮选择。

输出：03_data_audit/DATASET_DESCRIPTION.md、DATA_DICTIONARY.csv、SHEET_STRUCTURE.json、ENTITY_TIME_LEDGER.csv、LEAKAGE_AVAILABILITY_LEDGER.csv、TEMPLATE_FILLING_SPEC.md、DATA_QUALITY_RISKS.md。

验收：全工作簿和全sheet实际读取；统计覆盖全量而非前5行；所有模板省略号被识别为占位符；原文件哈希前后不变。完成后停止。
```

