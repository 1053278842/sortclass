# 架构与原理

## 技术栈

| 层 | 技术 |
| --- | --- |
| 表现层 | JSP + JSTL + AdminLTE 2 / Bootstrap 3 / jQuery 2（后台模板） |
| 控制层 | Spring MVC 5.3.7（`DispatcherServlet` 映射 `*.do`） |
| 业务层 | Spring 5.3.7（IoC + 声明式事务）、PageHelper 5.1.2 分页 |
| 持久层 | MyBatis 3.4.5（**纯注解 Mapper，无 XML**）、c3p0 连接池 |
| 数据库 | MySQL 5.7 |
| 其它 | jxl 2.6.12 读 Excel、POI 3.9 导出 Excel、Spring Security 5（表单登录）、Maven 多模块 |

> 这是“老派 Java Web”：`javax.servlet` + 外置 Tomcat + JSP。**必须 Tomcat 9**。

## 目录结构

```
sortclass/
├── pom.xml                     # 父 POM（聚合 + 依赖版本管理）
├── ssm_domain/                 # 实体：Student、Course、Grade、SingleClass、ClassSection、WeekTables
├── ssm_dao/                    # MyBatis 注解 Mapper：IStudentDao、ICourseDao、IGradeDao、ISingleClassDao
├── ssm_service/                # 业务接口与实现（事务在这一层）
├── ssm_utils/                  # 工具：CourseSectionUtils（坐标→节次）、DateUtils
├── ssm_web/                    # Web 层
│   ├── src/main/java/com/ssm/controller/
│   │   ├── UploadController.java        # 课表 Excel 解析入库
│   │   ├── StudentController.java       # 志愿者登记（匿名可访问）
│   │   ├── AdminStudentController.java  # 志愿者列表 JSON、出勤次数维护
│   │   ├── AdminTableController.java    # ★ 排班算法、导出 Excel
│   │   ├── CourseController.java        # 单班级课表查看
│   │   └── GradeController.java         # 班级下拉数据
│   ├── src/main/resources/              # applicationContext.xml / spring-mvc.xml / spring-security.xml / db.properties
│   └── src/main/webapp/                 # JSP 页面、AdminLTE 静态资源
├── db/                         # schema.sql、seed.sql、本地 docker-compose.yml
├── docker/                     # 镜像构建：Dockerfile.web、Dockerfile.mysql、entrypoint.sh、compose
├── samples/                    # 三个班级课表 .xls + 格式说明
└── docs/                       # 文档与截图
```

## 数据流

```mermaid
flowchart LR
    X["班级课表 .xls"] -->|jxl 读单元格| P["UploadController<br/>坐标→节次，正则→课程"]
    P -->|insert/reuse| C[("course")]
    P -->|upsert| G[("classes_grades")]
    P -->|关系去重| R[("grades_course_relationship")]
    S["志愿者匿名页"] -->|freeClass[] → 逗号串| ST[("student")]
    C --> Q["ISingleClassDao<br/>按周次 + 节次查询"]
    ST --> W["WeekTables<br/>20 个 ClassSection"]
    Q --> W
    W --> A["AdminTableController<br/>权重贪心"]
    A --> J["weekTable_hasStudents.jsp<br/>4×5 表格"]
```

## 1. 课表上传：正则 + 坐标

`UploadController.fileUpload()` 做三件事：

1. **班级**：读 A1 标题（如 `17计科（2+3）课表`），去掉 `课表` 两字得到班级名，配合表单填的人数写入
   `classes_grades`。已存在同名班级则改人数、删旧课程、删旧关系，等于“覆盖导入”。
2. **节次**：靠**单元格坐标**反推。列 3~7 → `Mon/Tue/Web/Thu/Fri`，行 3~6 → `1/3/5/7`，拼成 `Mon1`、`Web5`
   这种大节名（`CourseSectionUtils.getCourseSectionByXY`）。
3. **课程**：靠**正则**拆单元格文本，规则在 `regular_expression.properties`：

   ```
   (课程名)/(起始周-结束周)周/(性质) (教室)/(教师)/(人数)/(学分)
   ```

   一格多门课就多 `matcher.find()` 几次。课程按“名称+周次+教室+教师+节次”去重：存在就复用，
   不存在才插入，最后写中间表。

> 周三的大节名是 `Web` 而不是 `Wed`，这是原代码的拼写，全链路（解析、查询、JSP 判断）都沿用它；
> 只有前端下拉的周段值用 `Wed`，后端在 `WeekTables.allocationClassSection` 里做了 `Web → Wed` 的映射。

## 2. 空闲时间登记

前端 20 个 `checkbox`（5 天 × 4 大节，`name="freeClass"`，`value="Mon1"`…），提交时 Spring 绑成
`String[] freeClass`，后端拼成 `,Mon1,Mon3,...` 存一列。按学号 upsert：存在则
`updateStudentBySno`，不存在才 `insert`。

## 3. 排班算法：带容量约束的权重贪心

核心在 `AdminTableController.generateTable()`，配合 `WeekTables`、`ClassSection` 两个领域对象。

1. **建骨架**：`WeekTables` 构造时固定生成 20 个 `ClassSection`（Mon1 ~ Fri7）。
2. **装课程**：按 `week` 过滤（`left(course_time,2) <= week <= right(course_time,2)`），再按表单选的
   `weekSectionRange` 丢掉不参与的周段，剩下的进各节次的 `singleClassesQueue`。
3. **装志愿者**：报名时间落在 `dateRange` 内的学生，按 `freeClasses` 拆开，匹配到的节次进
   `selectedStudentQueue`。
4. **动态出勤数**：每个节次按课程数算“一个志愿者最多管几门课”——
   `d = ceil(课程数 / 单频次上限)`，`每人间隔 = ceil(课程数 / d)`。
   这样不会出现“10 门课让一个人跑 9 门、第二个只跑 1 门”的极端分配。
5. **贪心主循环**：
   - 权重 `weight = 该节次待排课程数 / 该节次可用志愿者数`（没志愿者记 0），越高说明“课多人心”，越该先排；
   - 每轮取权重最高的节次，两个队列各取队首（课程按班级名、志愿者按到达顺序），配成一个 `SingleClass`
     （= 一次查课任务），课程出队并塞进用于渲染的 `singleClasses`；
   - 同一节次里一个志愿者排满“每人间隔”门课就出队，其 `hasSelectedTimes + 1`；当
     `hasSelectedTimes >= frequency` 时该志愿者**全局停用**；
   - 每轮结束重算权重并降序排序，直到所有节次权重都为 0（课排完或没人可用）。
6. **落地**：结果对象丢进 `request` + `session`。JSP 用 JSTL 遍历 20 个节次渲染成 4×5 表格：
   已分配的从 `singleClasses` 出来（红字带志愿者名），没排上的从 `singleClassesQueue` 出来。
   放 session 是为了“确定为最终表格”时能拿到同一份数据给志愿者加出勤次数。

### 复杂度与边界

- 20 个节次 × 课程数 × 志愿者数，规模很小（几十门课），`O(轮数 × 节次 × 队列)` 完全够用；
- 某节次“有课但没志愿者”时权重为 0，会被排到最后；内层循环里显式判空跳出，避免原来那种空指针/死循环；
- 志愿者被 `Frequency` 用尽后只是 `canSelected=false`，仍留在其他节次的队列里，被跳过时 poll 掉并重算权重；
- 课程数超过 `人数 × Frequency` 时，靠后的课程排不上，会留在格子里（这是算法设计上的“如实暴露资源不足”）。

## 4. 前端

JSP + JSTL 服务端渲染，AdminLTE 2 的后台框架（左侧菜单 `aside.jsp`、顶栏 `header.jsp`、
首页内容 `student_list.jsp`）。志愿者登记页和单班课表用另一套 CSS，不套后台框架。

表格页 `weekTable_hasStudents.jsp` 里 20 个格子是 20 段几乎一样的 `<c:if>`，典型的“复制粘贴式渲染”，
想加“周六”就得再复制 4 段——原项目风格，本次没有重构它。

> 导出 Excel 的按钮目前是“维护中”：`AdminTableController.excelPrint()` 用 POI 生成了 `.xls`，
> 但前端按钮被改成了 `alert('此功能维护中！')`，属于原仓库遗留状态，未改动。