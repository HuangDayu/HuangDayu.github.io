---
title: Install Zookeeper
date: 2018-10-19 14:42:46
category: 
- 后端开发
tags:
- Zookeeper
---

安装  

```shell
wget http://www.apache.org/dist/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz
tar zxvf zookeeper-3.4.10.tar.gz && mv zookeeper-3.4.10 zookeeperzookeeper
cd zookeeper
cp conf/zoo_sample.cfg conf/zoo.cfg
```

运行  

```shell
./bin/zkServer.sh start
```

查看  

```shell
netstat -anp | grep 2181
```