---
title: MQTT代理服务器之Mosquitto
date: 2018-01-28 10:22:50
category: 
- 万物互联
tags:
- MQTT
---

> Mosquitto 是一个MQTT代理服务器

### 安装
```shell
sudo apt install mosquitto
```

### 查看帮助
```shell
mosquitto --help
```

 > mosquitto [-c config_file] [-d] [-h] [-p port]
 > * -c : specify the broker config file.
 > * -d : put the broker into the background after starting.
 > * -h : display this help.
 > * -p : start the broker listening on the specified port.
 > *      Not recommended in conjunction with the -c option.
 > * -v : verbose mode - enable all logging types. This overrides
 > *      any logging options given in the config file.

### 修改配置文件
```shell
vim /etc/mosquitto/mosquitto.conf
```

### 运行
```shell
sudo systemctl start mosquitto
```

### 停止
```shell
sudo systemctl stop mosquitto
```
