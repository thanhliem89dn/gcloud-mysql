#!/bin/sh

set -e

TIMESTAMP="$(date +'%Y%m%d%H%M')"
BACKUP_DIR="/tmp"

if [ "$1" = 'mysql-backup-all' ]; then
    for DB in $(mysql --host="${MYSQL_HOST}" --user=${MYSQL_USER} --password=${MYSQL_PASS} -e "SHOW DATABASES;"|egrep -v "(|)"); do
	echo "backup ${DB}"
        mysqldump --opt --host="${MYSQL_HOST}" --user=${MYSQL_USER} --password=${MYSQL_PASS} ${DB} | gzip > /${BACKUP_DIR}/${TIMESTAMP}_${DB}.sql.gz
    done
else
    ${1}
fi
