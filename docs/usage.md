# 使用流程：5 步跑出整张排班表

> 每一步都对应一张截图。其实 `db/seed.sql` 已经把「跑完 1~3 步」的数据准备好了，
> 想直接看结果可以跳到第 4 步。
>
> 图片走 jsDelivr CDN（GitHub 的 `raw.githubusercontent.com` 在国内常被解析成 `0.0.0.0`），
> 原图在 [`screenshots/`](screenshots) 目录里。

## 第 1 步：登录后台

打开 `/pages/login.jsp`，用 `admin / admin` 登录，进入「志愿者列表」首页。

![登录](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/01-login.png)
![首页](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/02-volunteer-list.png)

首页那张表是志愿者列表：分页、按列排序、模糊搜索、每人出勤次数 `+1 / -1 / 清零`。

## 第 2 步：上传班级课表

左侧菜单「数据录入 → 班级课表录入」，填入班级人数，选 `samples/timetable_1_17jike.xls`，提交。

![上传课表](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/03-upload-timetable.png)

系统会解析 Excel：A1 的「17计科（2+3）课表」变成班级名，每个有课的格子变成一条课程记录，
格子位置决定它是周几第几大节。**重复上传同一个班级不会产生重复数据**：同名班级更新人数、
删掉该班旧课程和关系后重建。`samples/` 里三个文件各传一次，就得到 3 个班级 / 32 条课程。

字段格式与表格布局要求见 [`samples/README.md`](../samples/README.md)。

## 第 3 步：学生登记空闲时间

把志愿者登记页地址发给学生（无需登录）：

![志愿者登记](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/04-volunteer-register.png)

学号、姓名、班级 + 勾选空闲的大节，提交后回显：

![登记成功](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/05-volunteer-success.png)

同一个学号重复提交是**覆盖更新**（不会重复插入）。学号框旁的「新用户！/老朋友！」提示走
`/Student/isExistBySno.do` 这个 AJAX 接口。

## 第 4 步：设置排班参数

左侧菜单「排班生成 → 参数设置」：

| 参数 | 含义 | 本次演示取值 |
| --- | --- | --- |
| Week | 第几周（用来筛掉不在该周上的课） | `8` |
| Frequency | 一名志愿者一周最多跑几个节次 | `3` |
| Number Of One Frequency | 一个节次里一名志愿者最多负责几门课 | `2` |
| Volunteer Data Range | 只统计该时间段内报名的志愿者 | `2026/11/01 - 2026/12/31` |
| Week Section Range | 参与排班的周段（可多选） | 周一 ~ 周五 |

![参数设置](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/06-generate-params.png)

> 参数不同结果差很多：`Frequency` 越大越好排但越累人；演示数据（9 人 × 3 趟）刚好够覆盖 32 门课，
> `Frequency=2` 就会有课程分不到人。

## 第 5 步：查看最终排班表

点 Submit 会**新开一个窗口**：行是大节，列是星期，每格列出该节次的所有课程
（`班级 / 应到人数 / 课程 / 教室 / 教师`），**红色的是分到的志愿者**；
人不够时没分出去的课程会留在格子里（来自 `singleClassesQueue`）。

![最终排班](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/07-final-table.png)

点「确定为最终表格后请点击我」，这批志愿者的出勤次数 `times` 各 +1（`AdminTable/addTimes.do`）。

## 附：只看某班课表

「基础数据 → 课程管理」，班级下拉是动态从数据库读的（`/Grade/getAllGrade.do`），周次留空表示整学期：

![单班课表](https://gcore.jsdelivr.net/gh/1053278842/sortclass@master/docs/screenshots/08-class-timetable.png)

## 排不满怎么办

排班是贪心：志愿者总量（人数 × `Frequency`）不够覆盖所有课程时，靠后的课程就分不到人。三种解法：

1. 调大 `Frequency`；
2. 让更多学生来登记空闲时间；
3. 缩小 `Week Section Range`，只排真正需要巡查的那几天。