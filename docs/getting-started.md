# 从零跑起来（源码 / WAR + Tomcat）

镜像启动见 [docker.md](docker.md)。这里是没有 Docker 时的完整步骤。

## 环境要求

| 组件 | 版本 | 说明 |
| --- | --- | --- |
| JDK | 8 / 11 / 17 | 本次复现用的是 **JDK 17.0.11**，编译目标 `1.8` |
| Maven | 3.6+ | 本次用 3.8.5 |
| MySQL | 5.7（推荐）/ 8.0 | 8.0 要换驱动，见 [troubleshooting](troubleshooting.md) |
| Tomcat | **9.0.x** | 本次用 9.0.124；**切勿用 Tomcat 10+**（`javax.servlet` → `jakarta.servlet`） |
| Docker | 可选 | 只为起 MySQL；本机已有 MySQL 可跳过 |

## 1. 起数据库

```bash
cd db
docker compose up -d          # 宿主机 13306 端口，账号 root / sortclass
```

容器首次启动会自动执行 `schema.sql` + `seed.sql`，所以起来就有演示数据（3 班级 / 32 课 / 9 志愿者）。

不用 Docker 就自己建库再导入：

```sql
CREATE DATABASE sortclass DEFAULT CHARACTER SET utf8mb4;
```

```bash
mysql -uroot -p < db/schema.sql
mysql -uroot -p < db/seed.sql
```

连接配置在 [`ssm_web/src/main/resources/db.properties`](../ssm_web/src/main/resources/db.properties)：

```properties
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://127.0.0.1:13306/sortclass?useUnicode=true&characterEncoding=utf8
jdbc.username=root
jdbc.password=sortclass
```

> 换成自己的 MySQL 只改这个文件（端口/账号/密码）。
> **库名必须叫 `sortclass`**：所有 SQL 都写死了 `sortclass.表名` 前缀。

## 2. 打包

```bash
mvn clean package -DskipTests
```

产物：`ssm_web/target/ssm_web.war`（约 35 MB，大头是 AdminLTE / ckeditor 等前端资源）。

公司内网 `settings.xml` 指向不可用私服时，可以临时换镜像：

```bash
mvn -s settings.xml -gs settings.xml clean package -DskipTests
```

镜像源配置示例见 [troubleshooting](troubleshooting.md#maven)。

<a id="from-source"></a>

## 3. 部署到 Tomcat 9

```bash
cp ssm_web/target/ssm_web.war $CATALINA_HOME/webapps/
$CATALINA_HOME/bin/startup.sh        # Windows: startup.bat
```

默认 8080 被占用时改 `$CATALINA_HOME/conf/server.xml` 里的 `<Connector port="8080" ...>`。
本次复现用的是 18090。

部署后 `<Context path>` 是 war 名，所以地址带 `/ssm_web`。

## 4. 访问与账号

| 入口 | 地址 | 是否需要登录 |
| --- | --- | --- |
| 后台登录 | `http://localhost:8080/ssm_web/pages/login.jsp` | — |
| 志愿者登记（发给学生） | `http://localhost:8080/ssm_web/pages/InputPages/inputVolunteerInfo.jsp` | 否（匿名可填） |
| 后台首页 | `http://localhost:8080/ssm_web/pages/main.jsp` | 是 |

账号是 `spring-security.xml` 里的内存用户：

| 账号 | 密码 | 角色 | 能否进后台 |
| --- | --- | --- | --- |
| `admin` | `admin` | `ROLE_ADMIN` | ✅ |
| `user` | `user` | `ROLE_USER` | ❌（后台要求 ROLE_ADMIN） |

## 5. 验一下

```bash
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8080/ssm_web/pages/login.jsp   # 期望 200
docker exec sortclass-mysql mysql -uroot -psortclass \
  -e "select count(*) from sortclass.course;"    # 期望 32
```

页面能不能正常出排班表，按 [usage](usage.md) 走一遍即可。