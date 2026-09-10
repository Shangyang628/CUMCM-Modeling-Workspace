# A题专用 Prompt：模型求解与结果分析章节

```text
$math-modeling-solution-writer

只根据 final_run_registry、Q1–Q4_RESULT.json、四个已回读Excel、验证报告和最终图表写“模型求解与结果分析”。不得重算、补造或挑选更好看的旧run。

按4问回答：
- Q1：表1/2指定7×5温度和含水率、场随时间/半径变化及收敛/守恒证据；
- Q2：表3/4指定6×5结果、变物性相对baseline的可核验差异；
- Q3：烘干时间、限制位置、表5每6 h结果、阈值前后与边界敏感性；
- Q4：收缩下烘干时间、表6移动表面结果、与固定尺寸baseline/Q3的差异及移动域守恒。

每个数字保留对象、单位、时点、空间位置、舍入和run_id。不能把重要性/敏感性写成因果。负面结果、误差、边界外推影响不得隐藏。若图/表/JSON/Excel冲突，标WARNING并停止正文定稿。

输出：10_paper/SOLUTION_AND_RESULTS.md、CLAIM_TO_EVIDENCE_LEDGER.csv。台账必须能定位到文件、sheet/key/row/figure与run_id。
```

