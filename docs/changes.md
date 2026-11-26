# 相对原仓库的改动

原仓库 clone 下来是**编译不过、也跑不通**的（缺库、缺数据、几个页面必炸）。为了能真实复现效果做了下面这些改动，
**业务逻辑本身没有重写**。

## 1. 让它能编译

| 文件 | 问题 | 处理 |
| --- | --- | --- |
| `pom.xml` | `packaging=war` 的聚合工程，模块列表里还有个根本不存在的 `com.ssm.utils` | 改成 `pom` 打包、删掉不存在的模块、统一 `source/target=8` |
| `pom.xml` | `maven-war-plugin` 里塞了 `<source>/<target>` 这种插件不认识的参数 | 换成正确的 compiler 插件配置 |
| `AdminTableController.java` | `import jdk.internal.util.xml.impl.Input;`（JDK 9+ 无法访问） | 删掉这个没用到的 import |
| `ssm_web/pom.xml` | 编译级别 1.7，JDK 17 已不支持 | 改 1.8 |

## 2. 让它跑得通

| 位置 | 问题 | 处理 |
| --- | --- | --- |
| `AdminTableController.generateTable()` | 日期区间用 `split("-")`，而页面日期控件输出的是 `2026/11/01 - 2026/12/31`，**必然数组越界 500** | 改成用正则抓两个日期（兼容 `/`、`-`、`年月日`、`至`），结束日期补 `23:59:59` |
| 同上 | 某节次“有课但没志愿者”时会 `student.isCanSelected()` 空指针，甚至死循环 | 加空判断 + 跳出该节次 |
| `AdminStudentController.findAllByMoreCondition()` | 参数上同时写了 `@RequestBody` 和 `@RequestParam`，GET 请求没有请求体 → **400** | 去掉 `@RequestBody` |
| `StudentController.isExistBySno()` | 同上，学号提示接口必失败 | 同上 |
| `spring-security.xml` | 志愿者登记页是匿名的，但提交接口 `/Student/**` 被拦成 302 跳登录页 → 学生永远提交不成功 | 放行 `/Student/**` |
| `inputVolunteerInfo.jsp` | 匿名页里有个调 `/AdminStudent/*` 的 AJAX，必然报错弹窗 | 删掉这段只 `$("#data_list").html("")` 的死代码 |
| `setTableViewParam.jsp` | 班级下拉写死了 Alabama / Texas 等州名，选不到真实班级 | 改成 AJAX 调 `/Grade/getAllGrade.do` 动态填充 |
| `db.properties` | 指向作者自己的公网数据库（`117.50.175.251`） | 改为本地 `127.0.0.1:13306`，账号见 docker-compose |

## 3. 新增的文件

```
db/schema.sql                # 4 张表的建表语句
db/seed.sql                  # 演示数据（真实走完流程后 mysqldump 出来的）
db/docker-compose.yml        # 本地起 MySQL 5.7 并自动初始化
docker/Dockerfile.web        # Tomcat 9 + JDK 17 + war
docker/Dockerfile.mysql      # MySQL 5.7 + schema + seed
docker/entrypoint.sh         # 等 DB → 解压 war → 按环境变量写 db.properties
docker/docker-compose.yml    # 用镜像一键起整套
docker/README.md             # 镜像构建/推送/排查
samples/*.xls                # 3 个班级课表样例
samples/README.md            # 课表格式说明
docs/*.md                    # 本套文档
docs/screenshots/*.png       # 8 张页面截图
.dockerignore                # 构建上下文瘦身
.gitattributes               # *.sh 强制 LF（否则 Windows 下 entrypoint 会坏）
README.md                    # 落地页
```

## 4. 没有改的部分

- **业务逻辑**：解析规则、排班算法、表结构、接口签名都没动，改的都是“跑不起来”的硬伤。
- **导出 Excel**：`excelPrint()` 后端是能用的，但前端按钮原本就是 `alert('此功能维护中！')`，保持原样。
- **周三叫 `Web`**：原代码的拼写错误，全链路都在用，改名收益低风险高，保持原样。
- **20 个 `<c:if>` 的表格渲染**：复制粘贴风格，重构收益低于风险，保持原样。

## 5. 提交记录

| commit | 内容 |
| --- | --- |
| `046b15c`→`67b1551` | 补齐数据库脚本、样例课表、截图与文档；修复编译/运行硬伤 |
| `51b043c` | 新增阿里云 ACR 镜像与 compose 部署；README 图片改走 jsDelivr |
| `f6bf1dc` | 加固 entrypoint 换行处理（`.gitattributes`） |
| 本次 | README 重构为落地页 + 文档拆到 `docs/` |