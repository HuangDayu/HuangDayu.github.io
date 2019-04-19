---
title: ApacheApollo
type: ApacheApollo
date: 2018-01-15 20:22:22
category: 
- 万物互联
tags:
- Apache
- MQTT
---

> Apache-Apollo 是一个MQTT代理服务器

### 下载安装包
```shell
wget http://mirrors.tuna.tsinghua.edu.cn/apache/activemq/activemq-apollo/1.7.1/apache-apollo-1.7.1-unix-distro.tar.gz
```

### 创建实例
```shell

cd ./apache-apollo-1.7.1/bin

./apollo create mqttbroker

```

### 设置开机自启动服务
```shell
sudo ln -s "/root/apache-apollo/apache-apollo-1.7.1/bin/mqttbroker/bin/apollo-broker-service" /etc/init.d/apollo-broker-service start
```

### 修改配置文件
```shell
vim apollo.xml 
```

### 运行实例
```shell
./apache-apollo/apache-apollo-1.7.1/bin/mqttbroker/bin/apollo-broker run
```

### 结束实例
```shell
# 46535 是进程pid
killall 46535 -9 
```

### 端口
- 代理服务 61680
- 客户端 61613

### 账户和密码
- 账户 admin
- 密码 password

### 实例mqttbroker下的目录解释
* bin  运行脚本
* etc  环境配置
* data 存储持久化数据
* log  运行日志
* tmp 临时文件
* etc文件夹下配置文件说明
* - users.properties：
* - - 用来配置可以使用服务器的用户以及相应的密码。
* - - 其在文件中的存储方式是：用户名=密码，如：
* - - admin=password
* - - 表示新增一个用户，用户名是：admin，密码是：password
* - groups.properties：
* - - 持有群体的用户映射，可以通过组而不是单个用户简化访问控制列表。
* - - 可以为一个定义的组设置多个用户，用户之间用“|”隔开，如：
* - - admins=admin|lily
* - - 表示admins组中有admin和lily两个用户
* - black-list.txt
* - - 用来存放不允许连接服务器的IP地址，相当于黑名单类似的东西。
* - - 例如：10.20.9.147
* - - 表示上面IP不能够连接到服务器。
* - login.config：
* - - 是一个服务器认证的配置文件，为了安全apollo1.6版本提供了认证功能，只有相应的
* - - 用户名和正确的密码才能够连接服务器。
* - 服务器主配置文件apollo.xml：
* - - 该配置文件用于控制打开的端口，队列，安全，虚拟主机设置等。
* - - - 认证：可以使用<authenticationdomain="internal" />来配置是否需要连接认证，如果将其属性enable设置为false表示不用认证，任何人都可以连接服务器，默认为true
* - - - access_rule：可以在broker或者virtual_host中用于定义用户对服务器资源的各种行为。如：<access_rule allow="users" action="connect create destroy send receive consume"/>表示群组users里面的用户可以对服务器资源进行的操作有：connect 、create、 destroy、 send 、receive 、consume。详细的操作说明见：http://activemq.apache.org/apollo/documentation/user-manual.html
* - - - message stores：默认情况下apollo使用的是LevelDB store，但是推荐使用BDB store（跨平台的）只能够实用其中一种。使用LevelDB store的配置是：<leveldb_store directory="${apollo.base}/data"/>默认有提供不用任何修改。使用BDB store需要到网站下jar包支持http://download.oracle.com/maven/com/sleepycat/je/5.0.34/je-5.0.34.jar，将jar包放在服务器的lib目录下面，然后将配置文件改成：<bdb_store directory="${apollo.base}/data"/>即可。
* - - - connector：用于配置服务器支持的链接协议以及相应的端口。如：
* - - - <connector id="tcp" bind="tcp://0.0.0.0:61613" connection_limit="2000"
* - - - protocol="mqtt"/>表示支持tcp链接，使用的端口是61613，链接限制是2000，
* - - - 自动侦听的协议是mqtt协议。
* - 具体查看：http://activemq.apache.org/apollo/documentation/user-manual.html