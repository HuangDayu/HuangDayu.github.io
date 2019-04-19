---
title: Install MySQL
date: 2017-03-16 20:22:22
category: 
- 后端开发
tags:
- MySQL
- Ubuntu
- CentOS
description: MySQL 是一个开源的关系型数据库，可以选择分支版本Mariadb
photos: https://raw.githubusercontent.com/HuangDayu/huangdayu.github.io/master/assets/private/images/image-41.jpeg
---


# Ubuntu & MySQL

---

## Install

### 使用命令安装
```shell
sudo apt install mysql-server mysql-common
```

### 修改配置文件
```shell
vim /etc/mysql/my.cnf
```

### 开启服务
```shell
sudo systemctl start mysql
# 或者
sudo service mysql start
```

### 关闭服务
```shell
sudo systemctl stop mysql
# 或者
sudo service mysql stop
```

### 本地登录MySQL
```shell
mysql -u root -p passwd
```

> dpkg: error processing mysql-server (--configure) 问题的解决办法是完整卸载重新安装

## Remove

```shell
sudo apt-get remove -y mysql-server
sudo apt-get autoremove -y mysql-server
sudo apt-get remove -y mysql-common
sudo rm /var/lib/mysql/ -R
sudo rm /etc/mysql/ -R
sudo apt-get autoremove -y mysql* --purge
sudo apt-get remove -y apparmor
sudo apt-get dist-upgrade
sudo reboot
```

### 查看是否运行
```shell
sudo netstat -tap | grep mysql
#或者
netstat -anp | grep 3306
```

### 远程失败解决
```shell
vim /etc/mysql/mysql.conf.d/mysqld.cnf
#注释掉下面这个配置项
#bind-address           = 127.0.0.1
```

# CentOS & MySQL

---

## Install

### 切换源
```shell
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
rpm -ivh mysql57-community-release-el7-11.noarch.rpm
```

### 使用命令安装
```shell
yum install -y mysql-server
```

### 开启服务
```shell
sudo systemctl start mysqld
# 或者
sudo service mysqld start
# 或者
systemctl start mysqld.service
```

### 重启服务
```shell
sudo systemctl restart mysqld
# 或者
sudo service mysqld restart
# 或者
systemctl restart mysqld.service
```

### 关闭服务
```shell
sudo systemctl stop mysqld
# 或者
sudo service mysqld stop
# 或者
systemctl stop mysqld.service
```

### 查看是否成功启动服务
```shell
ps aux|grep mysqld
```

### 设置开机启动

```shell
# 添加开机启动
chkconfig --add mysqld
# 开机启动：
chkconfig mysqld on
# 查看开机启动设置是否成功
chkconfig --list | grep mysql* mysqld 
# 0:关闭 1:关闭 2:启用 3:启用 4:启用 5:启用 6:关闭停止

# 开机自启动 
chkconfig mysqld on
# 或者 
systemctl enable mysqld.service
# 取消开机自启动 
chkconfig mysqld off
# 或者 
systemctl disable mysqld.service
```

## Remove

```shell
sudo rpm -qa | grep mysql*
sudo yum -y remove mysql*
sudo rm -rf /var/lib/mysql/*
```



# Mariadb

## Install 

### 换国内源

```shell
touch /etc/yum.repos.d/MariaDB.repo && vim /etc/yum.repos.d/MariaDB.repo
```

```repo
[mariadb]
name = MariaDB
baseurl = http://mirrors.ustc.edu.cn/mariadb/yum/10.2/centos7-amd64/
gpgkey=http://mirrors.ustc.edu.cn/mariadb/yum/RPM-GPG-KEY-MariaDB
gpgcheck=1
```

# 安装

```shell
yum install MariaDB-server MariaDB-client
```

### 进程管理

```shell
sudo systemctl start mariadb
sudo systemctl status mariadb
sudo systemctl stop mariadb
sudo systemctl restart mariadb
# 开启自启动
sudo systemctl enable mariadb
# 关闭自启动
sudo systemctl disable mariadb
```

### 远程连接

```shell
mysql -uroot -hhostname.com -psqlpassword
```


## Remove

```shell
sudo rpm -qa | grep maria*
sudo yum -y remove maria*
sudo rm -rf /var/lib/mysql/*
```
<br>
# 填坑一
<br>
<span style="color:#ff0000;font-weight:bold;">ERROR 1045 (28000): Access denied for user 'root'@'192.168.1.249' (using password: NO)</span>  

`原因`：密码错误!  

```shell
vim my.ini
```

添加 `skip-grant-tables`，然后重启；  

```shell
mysql -u root -p
```

```sql
use mysql;
update user set password=password("newpassword") where user="root";
flush privileges;
quit;
```

第二种办法  

```shell
mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
mysql -u root mysql
MariaDB [mysql]> UPDATE user SET PASSWORD=PASSWORD('newpassword') where USER='root';
MariaDB [mysql]> FLUSH PRIVILEGES;
MariaDB [mysql]> QUIT;
```
<br>
# 填坑二
<br>
<span style="color:#ff0000;font-weight:bold;">ERROR 1045 (28000): Access denied for user 'root'@'192.168.1.249' (using password: YES)</span>  

`原因`：密码正确，但是禁止远程连接!    

```sql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'newpassword' WITH GRANT OPTION;
FLUSH PRIVILEGES;
QUIT;
```

GRANT ALL PRIVILEGES ON *.* TO '用户名'@'要指定的IP地址' IDENTIFIED BY '设置的密码' WITH GRANT OPTION;  

<br>
# 填坑三
<br>
<span style="color:#ff0000;font-weight:bold;">ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)</span>  

`原因`：密码正确，但是禁止本地登录！    

```shell
[root@izwz951e3fbtauq6d7ez9gz mariadb]# systemctl stop mariadb
[root@izwz951e3fbtauq6d7ez9gz mariadb]# mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
# 命令行键入
mysql -u root mysql

MariaDB [mysql]> use mysql;
MariaDB [mysql]> UPDATE user SET Password=PASSWORD('newpassword') where USER='root' and host='root' or host='localhost';
MariaDB [mysql]> flush privileges;
MariaDB [mysql]> quit;
sudo reboot
```
<br>
# 填坑四
<br>
<span style="color:#ff0000;font-weight:bold;">ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2 "No such file or directory")</span>  

`原因`：找不到socket连接文件!    

```shell
[root@izwz951e3fbtauq6d7ez9gz ~]# find / -name "*.sock"
/var/lib/mysql/mysql.sock
mysql --socket=/var/lib/mysql/mysql.sock
```

或者使用如下命令进行远程连接  

```shell
mysql -uroot -hhostname.com -psqlpassword
```

# 参考文献

[yum安装MariaDB（使用国内镜像快速安装，三分钟安装完毕）](https://blog.csdn.net/p__csdn/article/details/72675840)  
[sojson](https://www.sojson.com/blog/197.html)  
