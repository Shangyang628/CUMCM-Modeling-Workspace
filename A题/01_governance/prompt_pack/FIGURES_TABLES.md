# A题专用 Prompt：图表与流程图定稿

```text
$math-modeling-code-experiment

最终模型/结果已冻结。本轮只从final run生成论文图表，不改模型、参数或结果。

优先生成能回答题目的最小图表集：
1. 附件1环境T/C随时间；
2. Q1温度/含水率径向剖面或时空图；
3. Q2前三小时变物性场及与baseline差异；
4. Q3全域最大C与0.15阈值、事件局部放大；
5. 附件2半径R(t)及Q4移动边界含水率场；
6. 网格/时间步收敛、质量/能量残差和关键敏感性（正文只留决定性图）；
7. 本题真实流程图：环境输入→固定/移动域求解→独立evaluator→结果模板。

图表脚本只读final_run_registry；坐标轴写单位；内部空间坐标和物理cm不得混淆；Q4图要画出移动表面。表1–表6直接从结果JSON/工作簿生成，不手抄。不得用生成式图片伪造曲线或数值。

输出：08_figures/final、09_tables/final、FIGURE_LEDGER.csv、TABLE_LEDGER.csv、10_paper/FIGURE_TABLE_CAPTIONS.md。每项记录源数据、脚本、run_id、哈希。完成后数值交叉核对并停止。
```

