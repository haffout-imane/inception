#!/bin/bash


service mysql start

mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'wordpress.inception_network' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'wordpress.inception_network' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"

service mysql stop
echo "MariaDB service stopped"

exec "$@"
