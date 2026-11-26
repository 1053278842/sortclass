# Docker 镜像

镜像地址、环境变量、compose 用法、重新构建与推送，统一写在 [../docs/docker.md](../docs/docker.md)。

这里只放本目录的内容清单：

```
docker/
├── Dockerfile.web       # tomcat:9.0-jdk17-temurin + ssm_web.war
├── Dockerfile.mysql     # mysql:5.7 + db/schema.sql + db/seed.sql
├── entrypoint.sh        # 等 DB → 解压 war → 写 db.properties → 启动 Tomcat
└── docker-compose.yml   # 一键起 mysql + web
```

最短路径：

```bash
docker compose -f docker/docker-compose.yml up -d
# http://localhost:8080/ssm_web/pages/login.jsp   admin / admin
```

> 构建命令要在**仓库根目录**执行（Dockerfile 里的 `COPY` 路径是相对根目录的）：
> `docker build -f docker/Dockerfile.web -t <tag> .`