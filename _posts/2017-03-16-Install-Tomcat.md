---
title: Install Tomcat
date: 2017-03-16 18:22:22
category: 
- 后端开发
tags:
- Apache
- Tomcat
---

> Apache-Tomcat 是一个Java服务器容器

### 下载清华源安装包
```shell
wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-9/v9.0.2/bin/apache-tomcat-9.0.2.tar.gz 
```

### 移动到指定目录
```shell
mv apache-tomcat-9.0.2 /usr/local/src/tomcat
```

### 开启服务
```shell
/usr/local/src/tomcat/apache-tomcat-9.0.2/bin/startup.sh
```

### 关闭服务
```shell
/usr/local/src/tomcat/apache-tomcat-9.0.2/bin/shutdown.sh
```