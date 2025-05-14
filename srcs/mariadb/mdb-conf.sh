#!/bin/bash

#--------------mariadb start--------------#
service mariadb start # start mariadb
sleep 5 # wait for mariadb to start

#--------------mariadb config--------------#
# Create database if not exists
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

# Create user if not exists
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant privileges to user
mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"

# Flush privileges to apply changes
mariadb -e "FLUSH PRIVILEGES;"

#--------------mariadb restart--------------#
# Shutdown mariadb to restart with new config
mysqladmin -u root -p $MYSQL_ROOT_PASSWORD shutdown

# Restart mariadb with new config in the background to keep the container running
exec "$@" --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'

# exce "$@" will execute the command(s) specified in dockerfile
# in this case, mysql_safe is excuted
# The reason why I used 'exec "$@" ' instead of directly use mysql_safe
# is because exec will change mysql_safe program as PID 1 instead of 
# shell process as PID 1. 
# Bash scripts do not naturally forward OS signals to child processes
# For more info, visit https://cloud.theodo.com/en/blog/docker-processes-container
