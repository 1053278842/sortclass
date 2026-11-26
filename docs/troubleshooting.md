# 常见问题

<a id="maven"></a>

## mvn 卡在下载依赖 / 报 `app.finedo.cn` 连接超时

全局 `settings.xml` 把 central 镜像指到了内网私服。用一个镜像可用的 settings 文件覆盖（注意 `-gs` 也要给，
否则 Maven 仍会读全局配置）：

```bash
mvn -s my-settings.xml -gs my-settings.xml clean package -DskipTests
```

```xml
<settings>
  <mirrors>
    <mirror>
      <id>aliyun</id>
      <url>https://maven.aliyun.com/repository/public</url>
      <mirrorOf>*</mirrorOf>
    </mirror>
  </mirrors>
</settings>
```

## 部署后 404 / 500，日志里是 `NoClassDefFoundError: javax/servlet/...`

用了 Tomcat 10+。换 **Tomcat 9.0.x**（Tomcat 10 起包名变成 `jakarta.servlet`）。

## JSP 报 `Unable to compile class for JSP`

JDK 比 Tomcat 自带的 JDT 新太多时会这样。Tomcat 9.0.6x 以上 + JDK 8/11/17 实测都可用。

## 页面上班级、课程都是空

先确认 `db.properties` 连的库里有数据：

```bash
docker exec sortclass-mysql mysql -uroot -psortclass -e "select count(*) from sortclass.course;"
```

空库就导入 `db/seed.sql`（见 [getting-started](getting-started.md)），或按 [usage](usage.md) 走一遍上传流程。

## 上传 Excel 后课程数不对 / 少了最后几节

解析扫描的是 `行数-3` 行，表格行数太少会漏掉“第 7、8 节”——样例文件末尾特意留了几行空行。
另外 A1 必须是“班级名+课表”，格子里必须是 `课程名/1-13周/理论 35-3jt/刘明/42/4.0` 这种格式，
详见 [`samples/README.md`](../samples/README.md)。

## 想换 MySQL 8.0

`mysql-connector-java` 是 5.1.6，不支持 MySQL 8 默认的 `caching_sha2_password`。三种做法：

1. 演示环境直接用 5.7（最省事）；
2. 升依赖到 `8.0.33`，驱动类改 `com.mysql.cj.jdbc.Driver`，URL 加 `serverTimezone=Asia/Shanghai&useSSL=false`；
3. 给 MySQL 8 建一个 `mysql_native_password` 用户。

## 排班表里有的课程没人（红字为空）

算法是贪心：志愿者总量（人数 × `Frequency`）不够覆盖所有课程时，靠后的课程分不到人。
调大 `Frequency`、让更多学生登记，或缩小 `Week Section Range`。

## 重启数据库后第一次访问报 `Communications link failure`

c3p0 池里握着的是旧连接。再刷一次即可（池子会自动重建），或重启 Tomcat 让连接池重新初始化。

## 容器起来了但页面 502 / 空白

```bash
docker logs sortclass-web | head -20     # 看 [entrypoint] 有没有等到 MySQL
docker logs sortclass-mysql | tail -20   # 看首次启动有没有跑 01-schema.sql
```

`web` 依赖 `mysql` 的 healthcheck，正常日志顺序是：`MySQL ... 已就绪` → 解压 war → 启动 Tomcat。

## 端口 8080 被占用

改 `docker/docker-compose.yml` 里 `"8080:8080"` 左边；或用 `docker run -p 18080:8080`。
Tomcat 部署方式则改 `conf/server.xml` 的 `<Connector port>`。

## 数据集想恢复成初始状态

```bash
docker compose -f docker/docker-compose.yml down -v && docker compose -f docker/docker-compose.yml up -d
```

删卷 = 下次启动重新执行 `schema.sql` + `seed.sql`。

## 截图在 GitHub 上显示不出来

`raw.githubusercontent.com` 在国内常被解析到 `0.0.0.0`，README 里的相对路径图片就会裂。
本仓库的文档一律用 jsDelivr CDN 指向同一批文件（`docs/screenshots/*.png`），原图随时可下载。