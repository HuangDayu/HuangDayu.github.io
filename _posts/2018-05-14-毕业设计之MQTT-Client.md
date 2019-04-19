---
title: 毕业设计之MQTT Client
date: 2018-05-14 22:19:35
category: 
- 毕业设计
tags: 
- MQTT
---

# MQTT协议说明
  
[MQTT](http://mqtt.org/)（消息队列遥测传输）是IBM开发的一个即时通讯协议，是当今物联网的网络层的重要组成部分，该协议的开发也主要是面向物联网的。MQTT协议是为大量计算能力有限，且工作在低带宽，不可靠网络的远程传感器设。  

# MQTT协议特点

1. 使用发布/订阅消息模式，提供一对多的消息发布，解除应用程序耦合；
1. 对负载内容屏蔽的消息传输；
1. 使用 TCP/IP 提供网络连接；
1. 有三种消息发布服务质量：
1. “至多一次”，消息发布完全依赖底层 TCP/IP 网络。会发生消息丢失或重复。这一级别可用于如下情况，环境传感器数据，丢失一次读记录无所谓，因为不久后还会有第二次发送。
1. “至少一次”，确保消息到达，但消息重复可能会发生。
1. “只有一次”，确保消息到达一次。这一级别可用于如下情况，在计费系统中，消息重复或丢失会导致不正确的结果。
1. 小型传输，开销很小（固定长度的头部是 2 字节），协议交换最小化，以降低网络流量；
1. 使用 Last Will 和 Testament 特性通知有关各方客户端异常中断的机制；

<!-- more -->

# MQTT 函数说明

Arduino可以使用[pubsubclient库](https://pubsubclient.knolleary.net/index.html)，用于连接订阅EMQTT搭建的Mqtt Broker（mqtt代理服务器），接收和发送Mqtt消息。

## 创建mqtt客户端

PubSubClient(ip,port,[callback],client,[stream])  

## 连接打开服务器

boolean connect (clientID, username, password)  

## 断开连接

void disconnect ()  

## 发送消息

int publish (topic, payload)  

## 点阅主题

boolean subscribe (topic, [qos])  

## 取消订阅

boolean unsubscribe (topic)  

## 判断是否连接

int connected ()  

## 获取连接状态

int state ()  

## 设置代理服务器IP地址和端口

PubSubClient setServer (server, port)  

## 设置回调

PubSubClient setCallback (callback)  

## 设置客户端信息

PubSubClient setClient (client)  

## 设置消息存储流

PubSubClient setStream (stream)