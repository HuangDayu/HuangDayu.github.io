---
title: 树莓派安装DuerOS Python DCS SDK
categories:
 - 人工智能
tags:
 - DuerOS
 - 树莓派
 - Python
 - 语音交互
date: 2017-11-07 01:47:30
photos:
- https://raw.githubusercontent.com/HuangDayu/huangdayu.github.io/master/assets/private/images/image-36.jpg
---

> 2Mic麦克风阵列与4Mic麦克风阵列

![HC-SR501](https://raw.githubusercontent.com/HuangDayu/huangdayu.github.io/master/assets/private/images/image-37.png)

## 使用本人修改的开源的SDK的教程

### 运行环境及依赖
* Python2.7.14
* gstreamer1.0
* gstreamer1.0-plugins-good
* gstreamer1.0-plugins-ugly
* python-gi
* python-gst
* gir1.2-gstreamer-1.0

<!-- more -->

### 克隆DuerOS-Modularization项目源码
```shell
git clone https://github.com/HuangDayu/DuerOS-Modularization.git
```

### 运行shell脚本安装
```shell
sudo sh install.sh
```

### 修改config.ini配置文件
```shell
vim /home/pi/DuerOS-Modularization/config.ini
```

<!-- 内嵌标签 -->
{% highlight python %}
CLIENT_ID = '你在DuerOS设备开放平台创建的设备的CLIENT_ID'
CLIENT_SECRET = '你在DuerOS设备开放平台创建的设备的CLIENT_SECRET'
{% endhighlight %}

### 远程树莓派桌面，执行授权命令，登录百度DuerOS开发者账号，晚上OAuth授权
```shell
sh auth.sh
或者
./auth.sh
```

### 唤醒DuerOS，默认唤醒词是“小白”

#### 使用唤醒词唤醒模式
```shell
sh sh wakeup_trigger_start.sh 
或者 
./wakeup_trigger_start.sh
```

#### 使用回车键唤醒模式
```shell
sh enter_trigger_start.sh 
或者 
./enter_trigger_start.sh
```

## 使用百度官方工程师刘才权提供的Python SDk的详细教程

我在DuerOS论坛中有详细教程

 :point_right: <https://dueros.baidu.com/forum/topic/show/245089> :point_left:
