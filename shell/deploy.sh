#!/bin/bash

mkdir -p /tmp/jasperreports-deploy

# Install required software
yum -y install unzip httpd tomcat mariadb-server

# Setup and configure mariadb
systemctl enable mariadb
systemctl start mariadb

mysqladmin -u root password jasper1!

cd /tmp/jasperreports-deploy
unzip /vagrant/files/jasperreports-server-cp-6.0.1-bin.zip

cd jasperreports-server-cp-6.0.1-bin/buildomatic
cp /vagrant/config/mysql_master.properties default_master.properties
./js-install-ce.sh minimal

cp /vagrant/config/proxy_ajp.conf /etc/httpd/conf.d/

systemctl enable tomcat
systemctl start tomcat

systemctl enable httpd
systemctl start httpd