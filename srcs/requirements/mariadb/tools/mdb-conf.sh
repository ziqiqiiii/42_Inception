#!/bin/bash


sleep 5 # wait for mariadb to start

#--------------Initialize database manually if not already done--------------#
if [ ! -d "/var/lib/mysql/${MYSQL_DB}" ]; then
  mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

#--------------Start the DB in the background so we can issue setup commands--------------#
mysqld_safe --skip-networking &
sleep 5

#--------------mariadb config--------------#
mariadb <<-EOSQL
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO \`${MYSQL_USER}\`@'%';
FLUSH PRIVILEGES;
EOSQL

#--------------mariadb restart--------------#
# Shutdown mariadb to restart with new config
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

# Restart mariadb with new config in the background to keep the container running
exec "$@" --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'

# exce "$@" will execute the command(s) specified in dockerfile
# in this case, mysql_safe is excuted
# The reason why I used 'exec "$@" ' instead of directly use mysql_safe
# is because exec will change mysql_safe program as PID 1 instead of 
# shell process as PID 1. 
# Bash scripts do not naturally forward OS signals to child processes
# For more info, visit https://cloud.theodo.com/en/blog/docker-processes-container
