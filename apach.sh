#!/bin/sh

sudo yum update -y

sudo yum install -y httpd24
systemctl  enable httpd.service


amazon-linux-extras enable php7.4
yum clean metadata
yum -y install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} --skip-broken

wget https://wordpress.org/latest.zip

unzip latest.zip

mv wordpress/* /var/www/html/
chown -R apache. /var/www
cp -pr /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i 's/database_name_here/wordpress1/' /var/www/html/wp-config.php
sudo sed -i 's/username_here/wordpress1/' /var/www/html/wp-config.php
sudo sed -i 's/password_here/BVK3oVFPC9xAQ/' /var/www/html/wp-config.php
sudo sed -i 's/localhost/172.16.97.0/' /var/www/html/wp-config.php

systemctl start httpd
