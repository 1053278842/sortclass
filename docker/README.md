# Docker 镜像

命名空间 `liunidie`，阿里云个人版镜像仓库（上海）：

```
crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie/sortclass-web:1.0.0     # Tomcat 9 + JDK 17 + war
crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie/sortclass-mysql:1.0.0   # MySQL 5.7 + 建表脚本 + 演示数据
```

## 一条命令启动

```bash
docker compose -f docker/docker-compose.yml up -d
# 打开 http://localhost:8080/ssm_web/pages/login.jsp   账号 admin / admin
```

## 手动启动

```bash
REG=crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie
docker network create sortclass

docker run -d --name sortclass-mysql --network sortclass \
  -e MYSQL_ROOT_PASSWORD=sortclass -v sortclass-mysql-data:/var/lib/mysql \
  $REG/sortclass-mysql:1.0.0

docker run -d --name sortclass-web --network sortclass \
  -e DB_HOST=sortclass-mysql -e DB_PASSWORD=sortclass -p 8080:8080 \
  $REG/sortclass-web:1.0.0
```

## 重新构建 & 推送

```bash
# 1) 先出 war（镜像里 COPY 的就是这个文件）
mvn clean package -DskipTests

# 2) 构建（在仓库根目录执行，Dockerfile 里的路径是相对根目录的）
REG=crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com/liunidie
docker build -f docker/Dockerfile.web   -t $REG/sortclass-web:1.0.0   .
docker build -f docker/Dockerfile.mysql -t $REG/sortclass-mysql:1.0.0 .

# 3) 推
docker login crpi-jjrtzj5uuz1ioat1.cn-shanghai.personal.cr.aliyuncs.com
docker push $REG/sortclass-web:1.0.0
docker push $REG/sortclass-mysql:1.0.0
```

## web 镜像的工作方式

`docker/entrypoint.sh`：

1. 用 bash 的 `/dev/tcp` 轮询 `DB_HOST:DB_PORT`，最多等 `DB_WAIT_SECONDS`（默认 90s）；
2. 用 JDK 自带的 `jar xf` 把 `webapps/ssm_web.war` 解压成目录（然后删掉 war，避免重复热部署）；
3. 用环境变量重写 `WEB-INF/classes/db.properties`；
4. `exec catalina.sh run`。

所以同一份镜像可以连任意 MySQL，只换环境变量即可，不用重新打包。

## 排查

```bash
docker logs sortclass-web          # 看 [entrypoint] 有没有等到 MySQL
docker logs sortclass-mysql        # 首次启动会跑 01-schema.sql / 02-seed.sql
docker exec -it sortclass-mysql mysql -uroot -psortclass -e "select count(*) from sortclass.course;"
```