# 页面截图

8 张图都是**真实运行的系统**截的（Tomcat 9.0.124 + JDK 17.0.11 + MySQL 5.7），不是设计稿。

> 图片走 jsDelivr CDN：`raw.githubusercontent.com` 在国内常被解析成 `0.0.0.0`，用相对路径会导致图裂。
> 原图就在本目录（`docs/screenshots/*.png`），可以直接下载。

| # | 截图 | 说明 |
| --- | --- | --- |
| 01 | [登录页](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/01-login.png) | Spring Security 表单登录 |
| 02 | [志愿者列表](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/02-volunteer-list.png) | 首页：分页 / 搜索 / 出勤次数 ±1 |
| 03 | [班级课表上传](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/03-upload-timetable.png) | 填班级人数 + 选 `.xls` |
| 04 | [志愿者登记](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/04-volunteer-register.png) | 学生端匿名页，勾选空闲大节 |
| 05 | [登记成功](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/05-volunteer-success.png) | 回显「xxx 同学于 … 选课成功！」 |
| 06 | [排班参数](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/06-generate-params.png) | 周次 / Frequency / 日期区间 / 周段 |
| 07 | [最终排班表](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/07-final-table.png) | **核心页面**：5 天 × 4 大节，红字为志愿者 |
| 08 | [单班课表](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/08-class-timetable.png) | 不带志愿者的班级课表 |

## 最终排班表（大图）

![最终排班表](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/07-final-table.png)

## 复现这几张图

按 [usage](usage.md) 走一遍即可。演示数据（3 班级 / 32 课程 / 9 志愿者）已经写进 `db/seed.sql`，
所以只要数据库起来，第 4、5 步直接就能出这张表。