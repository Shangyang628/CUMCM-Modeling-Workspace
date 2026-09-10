# A题专用 Prompt：论文组装与格式核验

```text
$math-modeling-orchestrator

只组装论文，不改变模型/结果。开始前必须取得并登记题首页引用的《全国大学生数学建模竞赛论文格式规范》及用户指定模板；当前均为UNKNOWN。若仍缺失，可生成内容版草稿，但FORMAT COMPLIANCE必须为NOT VERIFIED，禁止声称符合官方要求。

读取METHODOLOGY、SOLUTION_AND_RESULTS、图表/表格台账、最终验证、真实参考文献、AI使用日志、匿名要求。按真实4问结构组装标题、摘要、问题重述、假设、符号、模型建立、求解与结果、检验、评价、参考文献、附录；具体章节、目录、页数、页码、字体、页边距以取得的当年规则为准。

核验表1–表6、公式编号、图表题、交叉引用、四位小数与单位。不得泄露学校、队伍、姓名、账号、绝对路径或文档作者元数据。原模板只读，最终稿另存。

输出：10_paper/final_paper.docx、final_paper.pdf、FORMAT_COMPLIANCE_REPORT.md。逐页渲染检查；若官方规则缺失，输出文件名可生成但不得通过格式Gate。完成后停止。
```

