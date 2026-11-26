# Docker 镜像（阿里云 ACR）

已经在阿里云个人版镜像仓库里放好两个镜像（命名空间 `liunidie`，上海地域）：

| 镜像 | 内容 | 大小 |
| --- | --- | --- |
| `liunidie/sortclass-web:1.0.0` | Tomcat 9 + JDK 17 + `ssm_web.war`，启动时按环境变量生成数据源配置 | ≈533 MB |
| `liunidie/sortclass-mysql:1.0.0` | MySQL 5.7 + `schema.sql` + `seed.sql`，首次启动自动建表灌数据 | ≈501 MB |

完整地址：

```
crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie/sortclass-web:1.0.0
crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie/sortclass-mysql:1.0.0
```

## 最快启动：docker compose

```bash
git clone https://github.com/1053278842/sortclass.git
cd sortclass
docker compose -f docker/docker-compose.yml up -d
```

浏览器打开 <http://localhost:8080/ssm_web/pages/login.jsp>，`admin / admin` 登录。
首次启动会等 MySQL 初始化完（约 20~40 秒）再拉起 Tomcat，日志里能看到
`[entrypoint] MySQL ... 已就绪`。

常用命令：

```bash
docker compose -f docker/docker-compose.yml ps
docker compose -f docker/docker-compose.yml logs -f web
docker compose -f docker/docker-compose.yml down     # 停止，数据保留在卷里
docker compose -f docker/docker-compose.yml down -v  # 连数据一起删，下次重新导入演示数据
```

## 或者手动 docker run

```bash
REG=crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie

docker network create sortclass

docker run -d --name sortclass-mysql --network sortclass \
  -e MYSQL_ROOT_PASSWORD=sortclass \
  -v sortclass-mysql-data:/var/lib/mysql \
  $REG/sortclass-mysql:1.0.0

docker run -d --name sortclass-web --network sortclass \
  -e DB_HOST=sortclass-mysql -e DB_PASSWORD=sortclass \
  -p 8080:8080 \
  $REG/sortclass-web:1.0.0
```

## 可配置的环境变量（web 镜像）

| 变量 | 默认值 | 说明 |
| --- | --- | --- |
| `DB_HOST` | `mysql` | MySQL 主机名 |
| `DB_PORT` | `3306` | 端口 |
| `DB_NAME` | `sortclass` | 库名（**必须**叫 `sortclass`，SQL 里写死了库名前缀） |
| `DB_USER` | `root` | 账号 |
| `DB_PASSWORD` | `sortclass` | 密码 |
| `DB_PARAMS` | `useUnicode=true&characterEncoding=utf8&useSSL=false` | JDBC 连接参数 |
| `DB_WAIT_SECONDS` | `90` | 启动时等待数据库的最长秒数 |
| `JAVA_OPTS` | `-Duser.timezone=Asia/Shanghai -Dfile.encoding=UTF-8 -Xms256m -Xmx512m` | JVM 参数 |

容器启动脚本 [`../docker/entrypoint.sh`](../docker/entrypoint.sh) 做三件事：
等 MySQL 端口通 → 用 JDK 自带的 `jar` 解压 war → 用上面的变量覆盖
`WEB-INF/classes/db.properties`，然后 `exec catalina.sh run`。
所以同一份 war 镜像可以直连任何 MySQL，不用改代码重新打包。

## 自己重新构建 / 推送

```bash
mvn clean package -DskipTests          # 先出 war（镜像 COPY 的就是它）

REG=crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie
docker build -f docker/Dockerfile.web   -t $REG/sortclass-web:1.0.0   .
docker build -f docker/Dockerfile.mysql -t $REG/sortclass-mysql:1.0.0 .

docker login crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com
docker push $REG/sortclass-web:1.0.0
docker push $REG/sortclass-mysql:1.0.0
```

## 使用注意

- **数据持久化**：`sortclass-mysql` 的数据在 `/var/lib/mysql` 卷里；删卷 = 重新导入演示数据。
- **端口**：容器内固定 8080，宿主机映射随意（`-p 18080:8080` 也行）。
- **没有内置 Nginx / HTTPS**：仅适合演示 / 内网，正式环境建议前面加反向代理。
- 镜像里带了演示数据，**别把 root 密码就这么放公网**；改 `MYSQL_ROOT_PASSWORD` + `DB_PASSWORD` 即可。
- Windows 上 `git clone` 后如果 `.sh` 变成 CRLF，镜像里会报 `$'\r': command not found`；
  仓库已用 `.gitattributes` 强制 LF，Dockerfile 里另有一道 `sed` 兜底。