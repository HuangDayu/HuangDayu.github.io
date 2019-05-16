---
title: Dubbo Admin 填坑记
date: 2019-05-16 15:46:25
category:
- 后端开发
---

# 前言

&emsp;&emsp;[Dubbo Admin](https://github.com/apache/incubator-dubbo-admin)是RPC框架Dubbo的服务管理端，新的版本采用前后端分离架构。这个Dubbo Admin的部署，一度让我怀疑阿里开源的可靠性.....所以有了这个填坑记。

<!-- more -->

# 安装dubbo-admin-ui

作为后端开发，我在对Vue零了解的情况下，看着官方readme文档来，搞了好久也是一脸懵逼！

## 安装npm

```shell
sudo yum install npm
```

## 设置npm代理


```shell
vim ~/.npmrc
```
.npmrc文件可能不存在，可以直接用vim协议一下内容；  

```shell
registry=https://registry.npm.taobao.org
```

## 安装vue-cli

```shell
npm install -g vue-cli
```

新项目可以初始化一下Vue webpack项目,dubbo-admin-ui就不需要了。  

```shell
vue init webpack my-project
```

## 安装WebPack项目

```shell
npm install
```

## 运行

```shell
npm run dev
```

- dev : 开发环境
- test : 测试环境
- prod ：正式黄金

## 问题一：无法访问

原因：  

本地的话需要设置成真实的机器IP(局域网地址)；  

解决办法：  

将`index.js`中的dev的host改为：`0.0.0.0`;  


## 问题二： Invalid Host header

原因：  

新版的webpack-dev-server出于安全考虑，默认检查hostname，如果hostname不是配置内的，将中断访问。  

解决办法：  

将package.json的scripts下的dev的值追加 `--disableHostCheck=true`


# 运行dubbo-admin-server

## 进入文件夹

```shell
cd dubbo-admin-server
```

## 修改Dubbo注册地址

```shell
zookeeper://165.165.46.1:2181
```

## 构建Spring Boot项目

```shell
mvn clear package
```

## 使用maven运行项目

```shell
mvn --projects dubbo-admin-server spring-boot:run
```

## 使用java运行jar

```shell
nohup java -jar dubbo-admin-server/target/dubbo-admin-0.1.jar --server.port=8080
```

# 参考文献

[关于webpack 'Invalid Host header' 错误](https://www.jianshu.com/p/111806476add)  
[Webpack Quickstart](http://vuejs-templates.github.io/webpack/)  
[Dubbo Admin 官方中文文档](https://github.com/apache/incubator-dubbo-admin/blob/develop/README_ZH.md)  