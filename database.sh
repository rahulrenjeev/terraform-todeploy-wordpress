#!/bin/sh

cd /etc/yum.repos.d/

wget https://raw.githubusercontent.com/rahulrenjeev/maria-repo/main/mariadb.repo

yum makecache

yum repolist

yum install MariaDB-server MariaDB-client -y

systemctl enable --now mariadb

systemctl status mariadb


yum  install expect -y

PASSWORD=abcd1234

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn sudo mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"Remove anonymous users?\"
send \"n\r\"
expect \"Disallow root login remotely?\"
send \"n\r\"
expect \"Remove test database and access to it?\"
send \"n\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

mysql -e "CREATE DATABASE wordpress1 /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -e "CREATE USER wordpress1@’localhost’ IDENTIFIED BY 'BVK3oVFPC9xAQ';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress1.* to 'wordpress1'@'%' IDENTIFIED BY 'BVK3oVFPC9xAQ';"
mysql -e "FLUSH PRIVILEGES;"
