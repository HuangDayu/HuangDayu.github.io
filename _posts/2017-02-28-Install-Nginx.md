---
title: Install Nginx
date: 2017-02-28 15:22:22
category: 
- 后端开发
tags:
- Nginx
---

> Nginx 是一个异步框架的 Web服务器，也可以用作反向代理，负载平衡器 和 HTTP缓存。

### 安装Nginx
```shell
# ubuntu
sudo apt install nginx
# centos
sudo yum install nginx
```

### 详细安装

```shell
yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel

wget http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz
tar zxvf pcre-8.35.tar.gz 
cd pcre-8.35
./configure 
make 
make install
pcre-config --version
wget http://nginx.org/download/nginx-1.6.2.tar.gz
tar zxvf nginx-1.6.2.tar.gz 
cd nginx-1.6.2
./configure --prefix=/usr/local/src/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre-8.35
make
make install
./sbin/nginx -s reload
./sbin/nginx -s reopen
./sbin/nginx -s stop
/usr/local/src/nginx/sbin/nginx -s stop
ps -ef | grep nginx
```
### 关闭防火墙

```shell
firewall-cmd --state
sduo systemctl stop firewalld.service
sudo systemctl disable firewalld.service
```


### 其他说明

- 服务目录：cat /etc/init.d/nginx
- 启动服务：sudo service  start nginx
- 暂停服务：sudo systemctl stop nginx
- 重启服务：sudo systemctl restart nginx
- 修改配置文件后平滑加载（不断开用户访问）：sudo systemctl reload nginx
- 重启服务：sudo service nginx restart
- 重启服务：sudo systemctl restart nginx.service
- Nginx运行状态：systemctl status nginx
- 禁止开机启动：sudo systemctl disable nginx
- 允许开启自启动：sudo systemctl enable nginx
- /var/www/html: 网站文件存放的地方, 默认只有我们上面看到nginx页面，可以通过改变nginx配置文件的方式来修改这个位置。
- /etc/nginx: nginx配置文件目录。所有的nginx配置文件都在这里。
- /etc/nginx/nginx.conf: Nginx的主配置文件. 可以修改他来改变nginx的全局配置。
- /etc/nginx/sites-available/: 这个目录存储每一个网站的"server blocks"。nginx通常不会使用这些配置，除非它们陪连接到  sites-enabled 目录 (see below)。一般所有的server block 配置都在这个目录中设置，然后软连接到别的目录 。
- /etc/nginx/sites-enabled/: 这个目录存储生效的 "server blocks" 配置. 通常,这个配置都是链接到 sites-available目录中的配置文件
- /etc/nginx/snippets: 这个目录主要可以包含在其它nginx配置文件中的配置片段。重复的配置都可以重构为配置片段。
- /var/log/nginx/access.log: 每一个访问请求都会记录在这个文件中，除非你做了其它设置。
- /var/log/nginx/error.log: 任何Nginx的错误信息都会记录到这个文件中。

### 参考文献

[runoob.com](http://www.runoob.com/linux/nginx-install-setup.html)  
[segmentfault.com](https://segmentfault.com/a/1190000002797601)  