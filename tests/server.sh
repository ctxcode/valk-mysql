#!/usr/bin/env bash
# Starts or removes the MySQL the tests run against: 127.0.0.1:3306, user `test`, password
# `root`. The tests create and use the database `valk_mysql_tests`.
#
# A machine that already runs MySQL on 3306 needs none of this; the tests use whatever answers
# there, as long as the user `test` may create that database.
set -e

NAME=valk-mysql-test
PORT=${MYSQL_PORT:-3306}
IMAGE=${MYSQL_IMAGE:-mysql:8.0}

case "${1:-up}" in
    up)
        if [ -n "$(docker ps -aq -f name=^${NAME}$)" ]; then
            docker start ${NAME} >/dev/null
        else
            docker run -d --name ${NAME} \
                -e MYSQL_ROOT_PASSWORD=root \
                -e MYSQL_USER=test \
                -e MYSQL_PASSWORD=root \
                -p ${PORT}:3306 ${IMAGE} >/dev/null
        fi
        # The server takes a moment to come up, and the tests create their own database, which
        # the user it logs in as has to be allowed to do
        until docker exec ${NAME} mysqladmin ping -h 127.0.0.1 -uroot -proot --silent >/dev/null 2>&1; do
            sleep 2
        done
        docker exec ${NAME} mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'test'@'%'; FLUSH PRIVILEGES;" >/dev/null
        echo "mysql listening on 127.0.0.1:${PORT}"
        ;;
    down)
        docker rm -f ${NAME} >/dev/null 2>&1 || true
        echo "removed ${NAME}"
        ;;
    *)
        echo "usage: $0 [up|down]" >&2
        exit 1
        ;;
esac
