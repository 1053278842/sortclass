# 接口一览

`DispatcherServlet` 只映射 `*.do`，页面（`.jsp`）由容器直接返回。除 `/Student/**` 外，全部要求 `ROLE_ADMIN`。

| 方法 | 路径 | 作用 | 权限 |
| --- | --- | --- | --- |
| POST | `/pages/login` | Spring Security 表单登录 | 匿名 |
| POST | `/upload/fileUpload.do` | 上传并解析课表 | ADMIN |
| POST | `/Student/addStudent.do` | 志愿者登记（按学号覆盖更新） | 匿名 |
| GET | `/Student/isExistBySno.do` | 学号是否已存在（返回 `{"status":"新用户！"}`） | 匿名 |
| GET | `/AdminStudent/findAllByMoreCondition.do` | 志愿者分页 / 搜索 / 排序（JSON，PageInfo） | ADMIN |
| GET | `/AdminStudent/deleteById.do` | 删除志愿者 | ADMIN |
| GET | `/AdminStudent/updateAddTimesById.do` | 出勤次数 +1 | ADMIN |
| GET | `/AdminStudent/updateMinusTimesById.do` | 出勤次数 -1 | ADMIN |
| GET | `/AdminStudent/updateClearTimesById.do` | 出勤次数清零 | ADMIN |
| GET | `/Grade/getAllGrade.do` | 班级列表（JSON，下拉框用） | ADMIN |
| POST | `/AdminTable/generateTable.do` | **生成最终排班表** | ADMIN |
| POST | `/AdminTable/addTimes.do` | 确认最终表 → 志愿者出勤次数 +1 | ADMIN |
| GET | `/AdminTable/excelPrint.do` | 导出排班表 Excel（前端入口暂时关闭） | ADMIN |
| POST | `/Course/showCourseTable.do` | 单班级课表（`week` 为空 = 整学期） | ADMIN |

## 关键参数

### `generateTable.do`

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `week` | int | 第几周，用于过滤不在此周上的课 |
| `frequency` | int | 一名志愿者一周最多跑几个节次 |
| `numberOfOneFrequency` | int | 一个节次里一名志愿者最多负责几门课 |
| `dateRange` | String | 志愿者报名日期区间，`2026/11/01 - 2026/12/31` 或 `至` 分隔都可以 |
| `weekSectionRange` | String[] | 参与排班的周段：`Mon` / `Tue` / `Wed` / `Thu` / `Fri`（可多选，周三这里写 `Wed`） |

返回视图 `weekTable_hasStudents`，模型里带 `tables`（`WeekTables`），同时写进 `session.tables`
供 `addTimes.do` 使用。

### `fileUpload.do`

`multipart/form-data`：

| 字段 | 说明 |
| --- | --- |
| `ClassSize` | 班级人数 |
| `upload` | `.xls` 文件（jxl 只认 BIFF8，不认 `.xlsx`） |

### `addStudent.do`

`application/x-www-form-urlencoded`：`sno`、`name`、`classes`、`freeClass`（可重复，如
`freeClass=Mon1&freeClass=Mon3`）。成功后会带着 `Message` 模型回到 `inputVolunteerInfo.jsp` 并回显。

## 权限说明

`spring-security.xml` 里放行了这些路径（`security="none"`）：
`/pages/login.jsp`、`/pages/failer.jsp`、`/pages/InputPages/inputVolunteerInfo.jsp`、`/Student/**`、
`/css/**`、`/img/**`、`/js/**`、`/plugins/**`。

> 原仓库没有放行 `/Student/**`，导致匿名学生填完表提交时被 302 到登录页——这是本次修复的一项，
> 见 [changes](changes.md)。