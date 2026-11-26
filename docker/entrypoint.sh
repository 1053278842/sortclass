#!/bin/bash
# 容器启动前：等待数据库 → 解压 war → 按环境变量写 db.properties → 启动 Tomcat
set -e

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_NAME="${DB_NAME:-sortclass}"
DB_USER="${DB_USER:-root}"
DB_PASSWORD="${DB_PASSWORD:-sortclass}"
DB_PARAMS="${DB_PARAMS:-useUnicode=true&characterEncoding=utf8&useSSL=false}"
APP_NAME="${APP_NAME:-ssm_web}"

WAR="/usr/local/tomcat/webapps/${APP_NAME}.war"
APP_DIR="/usr/local/tomcat/webapps/${APP_NAME}"

# 1. 等数据库端口可连（最多 90 秒，超时也继续启动，让页面自己报错，方便排查）
WAIT_SECONDS="${DB_WAIT_SECONDS:-90}"
for i in $(seq 1 "${WAIT_SECONDS}"); do
    if (echo > "/dev/tcp/${DB_HOST}/${DB_PORT}") >/dev/null 2>&1; then
        echo "[entrypoint] MySQL ${DB_HOST}:${DB_PORT} 已就绪"
        break
    fi
    if [ "${i}" = "${WAIT_SECONDS}" ]; then
        echo "[entrypoint] 警告：${DB_HOST}:${DB_PORT} 仍不可达，继续启动 Tomcat"
    else
        sleep 1
    fi
done

# 2. 解压 war（jdk 自带 jar 命令），并删掉 war 避免 Tomcat 重复热部署
if [ -f "${WAR}" ]; then
    echo "[entrypoint] 解压 ${WAR} -> ${APP_DIR}"
    rm -rf "${APP_DIR}"
    mkdir -p "${APP_DIR}"
    (cd "${APP_DIR}" && "${JAVA_HOME}/bin/jar" xf "${WAR}")
    rm -f "${WAR}"
fi

# 3. 生成数据源配置（覆盖 war 里打包的 db.properties）
cat > "${APP_DIR}/WEB-INF/classes/db.properties" <<EOF
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}?${DB_PARAMS}
jdbc.username=${DB_USER}
jdbc.password=${DB_PASSWORD}
EOF
echo "[entrypoint] db.properties -> jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME} (user=${DB_USER})"

exec "$@"