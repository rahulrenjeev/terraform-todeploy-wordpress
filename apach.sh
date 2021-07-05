#!/bin/sh

sudo yum update -y

sudo yum install -y httpd24
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum -y install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} --skip-broken

sudo wget https://wordpress.org/latest.zip

sudo unzip latest.zip

sudo mv wordpress/* /var/www/html/
sudo chown -R apache. /var/www

sudo cd /var/www/html/
sudo mv wp-config-sample.php wp-config.php
sudo sed -i 's/database_name_here/wordpress1/' wp-config.php
sudo sed -i 's/username_here/wordpress1/' wp-config.php
sudo sed -i 's/password_here/BVK3oVFPC9xAQ/' wp-config.php
sudo sed -i 's/localhost/172.16.96.0/' wp-config.php
