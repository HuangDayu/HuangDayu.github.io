---
title: Install Java
date: 2017-03-15 12:22:22
category: 
- 后端开发
tags:
- Java
---

> Java JDK 环境安装

### 下载安装包
`http://www.oracle.com/technetwork/java/javase/downloads`

### 移动到指定目录
```shell
mv jdk-8u151-linux-x64.tar.gz /usr/local/src/java
```

### 解压压缩包
```shell
cd /usr/local/src/java
tar -zxvf jdk-8u151-linux-x64.tar.gz
```

### 修改环境变量配置文件
```shell
vim /etc/profile
# 在文件最后添加一下这几行,JAVA_HOME 是Java安装路径
export JAVA_HOME=/usr/local/src/java/jdk1.8.0_151  
export JRE_HOME=${JAVA_HOME}/jre    
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib    
export PATH=${JAVA_HOME}/bin:$PATH
```

### 使环境变量生效
```shell
source /etc/profile
```

### 验证
```shell
echo $JAVA_HOME
java -version
java
javac
```

### 使用rpm安装
```shell
rpm -ivh jdk-8u161-linux-x64.rpm 
rpm -e  jdk-8u161-linux-x64
```