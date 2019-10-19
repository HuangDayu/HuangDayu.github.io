---
title: 树莓派Python3安装TensorFlow
categories:
 - 人工智能
tags:
 - 树莓派
 - TensorFlow
 - Python3
photos:
 - https://www.huangdayu.cn/assets/private/images/image-38.png
date: 2017-10-03 18:26:30
---

## 使用GitHub项目安装

### 克隆项目
```shell
git clone https://github.com/HuangDayu/Raspberry-TensorFlow.git
``` 
### 安装TensorFlow库
```shell
sudo pip3 install  tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl
```
### 克隆基础模型
```shell
git clone https://github.com/tensorflow/models.git
```
### 将模型文件夹移动到TensorFlow项目下
```shell
sudo mv /home/pi/models /usr/local/lib/python3.4/dist-packages/tensorflow
```
### 使用shell脚本运行项目
```shell
sh UserTensorFlow.sh cat.jpg
```
- cat.jpg 是需要TensorFlow需要识别的图片
- 第一次执行会比较慢，需要联网下载深度学习图像识别库model

----

## 使用官方方法安装

### 安装依赖
```shell
sudo apt-get install python3-pip python3-dev
```
### 下载库文件
```shell
wget https://github.com/samjabrahams/tensorflow-on-raspberry-pi/releases/download/v1.1.0/tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl
```
### 安装TensorFlow
```shell
sudo pip3 install tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl
```
### 克隆模型
```shell
git clone https://github.com/tensorflow/models.git
```
### 将模型文件夹移动到TensorFlow项目下
```shell
sudo mv /home/pi/models /usr/local/lib/python3.4/dist-packages/tensorflow
```
### 新建文件夹并且将需要识别的图片保存到该目录下
```shell
mkdir /home/pi/Raspberry-TensorFlow
```
### 运行识别脚本
```shell
sudo python3 /usr/local/lib/python3.4/dist-packages/tensorflow/models/tutorials/image/imagenet/classify_image.py --model_dir /home/pi/tensorflow/model --image_file /home/pi/tensorflow/cat.jpg
```

---

> 说明
> * /usr/local/lib/python3.4/dist-packages/tensorflow/models/tutorials/image/imagenet 这个路径是TensorFlow的 Python图像分类程序 classify_image.py 所在的路径。
> * --model_dir 参数传入的是我们前面解压出来的模型文件所在的路径，在model文件夹里面已经自动下载并解压了inception-2015-12-05.tgz，它是tensorflow的一个深度学习图像识别库。
> * --image_file 是我们需要别识别的图片的路径。
> * .whl文件是python库文件的压缩包格式
