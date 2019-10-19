---
title: 树莓派Python实现超声波测距+人体红外报警+温湿度+LED灯
categories:
 - 万物互联
tags:
 - 树莓派
 - 传感器
 - Python
date: 2017-06-06 22:40:30
photos:
- https://www.huangdayu.cn/assets/private/images/image-32.jpg
---

# 硬件模块

- Raspberry Pi 3
- 超声波测距模块 HY-SRF05
- 人体红外传感器模块 HC-SR501
- 温湿度模块 DHT11
- LED灯模块

<!-- more -->

## HY-SRF05

![HY-SRF05](https://www.huangdayu.cn/assets/private/images/image-35.png)

## HC-SR501

![HC-SR501](https://www.huangdayu.cn/assets/private/images/image-33.png)
![HC-SR501](https://www.huangdayu.cn/assets/private/images/image-34.png)

# 编程语言

- Python  

# 源码

```python
#! /usr/bin/python
# -*- coding:utf-8 -*-

#热体红外+超声波测距+湿度温度#第一脚为VCC，由于该模块工作电压为5V，因此需接在树莓派GPIO的2号针上；
#第二只脚为TRIG，输入触发信号#第三只脚为ECHO，输出回响信号#第四只脚为接地脚，接在树莓派GPIO的第6号针上。
#第1、3只脚分别为GPIO2和GPIO3，分别作发送和接收用，分别于Trig和Echo相连接。
#树莓派引脚有BOARD和BCM两种编号方式( 使用python时? 似乎使用C还有一种wringPi编号方式 ), 
#GPIO.setmode(GPIO.BOARD):数引脚对应编号模式
#GPIO.setmode(GPIO.BOARD):数引脚对应编号模式
import RPi.GPIO as GPIO #( 导入模块 )
import sys
import time
#( 引脚编号 )
Trig=2 #第3号针，GPIO2
Echo=3 #第5号针，GPIO3
GPIO_IN=22 #人体红外传感器输入 GPIO22
LED_OUT=21 #LED电平输出 GPIO21
dht11_rpi_pin=4 #湿度温度连接的引脚号 GPIO4
# 用于获取湿度温度
# dht11_rpi_pin : 湿度温度连接的引脚号
# 返回二元组 [ 湿度 , 温度 ]
def get_dht11(dht11_pin):        
    buff=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] 
    #定义一个长度为40的整型数组        
    GPIO.output(dht11_pin,0)#输出低电平                
    time.sleep(0.02)    # 拉低20ms（延迟）        
    GPIO.output(dht11_pin,1)#输出高电平        
    GPIO.setup(dht11_pin,GPIO.IN)  # 这里需要拉高20-40us,但更改模式需要50us,因此不调用延时    
    while not GPIO.input(dht11_pin): # 检测返回信号 检测到启示信号的高电平结束        
          pass        
    
    while GPIO.input(dht11_pin): # 检测到启示信号的高电平则循环         
          pass        
          
    i=40        
    
    while i:
        start=time.time()*1000000 # 为了严格时序 循环开始便计时             
        i-=1              
        while not GPIO.input(dht11_pin):
              pass                
        while GPIO.input(dht11_pin):  
              pass                
        
        buff=time.time()*1000000-start #为了严格时序 每次测得数据后都不马上处理 先存储
        GPIO.setup(dht11_pin,GPIO.OUT) # 读取结束 复位引脚
        GPIO.output(dht11_pin,1)
        # print "buff - ",buff
        # 开始处理数据
        for i in range(len(buff)): # 将时间转换为 0 1
                if buff>100: # 上方测试时是测试整个位的时间
                             # 因此是与100比较 大于100为1(位周期中 低电平50us)
                        buff=1
                else:
                        buff=0
        # print "After - ",buff
        i=40
        hum_int=0
        while i>32:  # 湿度整数部分
                i-=1
                hum_int<<=1
                hum_int+=buff
        #print "湿度:",hum_int
        tmp_int=0
        i=24
        while i>16: # 温度整数部分
                i-=1
                tmp_int<<=1
                tmp_int+=buff
                
        #print("温度:",tmp_int,"湿度:",hum_int)
        return ["当前湿度:",hum_int,"温度:",tmp_int]
#超声波测距
def get_HYSRF05():
        #发出触发信号
        GPIO.output(Trig,GPIO.HIGH)#gaodianpin
        #保持10us以上（我选择15us）
        time.sleep(0.000015)
        GPIO.output(Trig,GPIO.LOW)
        while not GPIO.input(Echo):
                pass
        #发现高电平时开时计时
        t1 = time.time()
        while GPIO.input(Echo):
                pass
        #高电平结束停止计时
        t2 = time.time()
        #返回距离，单位为米
        return (t2-t1)*340/2
#GPIO.setmode(GPIO.BOARD) erro:已经设置了不同的模式！
#(检测使用的是哪种编号方式): mode = GPIO.getmode()
#避免警告: GPIO.setwarnings(False)
#初始化引脚
GPIO.setmode(GPIO.BCM)
#(设置通道)
#第3号针，GPIO2
GPIO.setup(Trig,GPIO.OUT,initial=GPIO.LOW)
#第5号针，GPIO3
GPIO.setup(Echo,GPIO.IN) #输入的引脚. 
#人体红外传感器输入
GPIO.setup(GPIO_IN,GPIO.IN)
#LED电平输出
GPIO.setup(LED_OUT,GPIO.OUT) #输出的引脚
# 输出模式 初始状态给高电平 (dht11_rpi_pin)
GPIO.setup(dht11_rpi_pin, GPIO.OUT)
GPIO.output(dht11_rpi_pin, 1)
        
time.sleep(2)
try:
        while True:
                #print ("距离: %0.2f m" %checkdist())
                #( 读输入引脚的值 ):
                inValue=GPIO.input(GPIO_IN)  
                if inValue!=0:  
                   print("警告：有人! 距离: %0.2f m" %get_HYSRF05())#,get_dht11(dht11_rpi_pin)
                   GPIO.output(LED_OUT,True)
                   #get_dht11(dht11_rpi_pin)#获取湿度温度
                   #LED接在BCM编号方式下的21引脚, 每隔1s亮一次,
                   #time.sleep(), 延时秒数. 类似Arduino中的delay(), 当然,后者是延时的ms数.
                   time.sleep(1)  
                else:  
                   print("安全：沒人。")
                   #设置输出引脚的状态(电平: 0/1)
                   GPIO.output(LED_OUT,False)
                   time.sleep(1)
except KeyboardInterrupt:
        GPIO.cleanup()#清除引脚设置恢复默认 程序结束时, 最好清除引脚设置并恢复默认.
        #有可能程序退出时, 不想清除某些通道的设置, 你可以使用python的列表或元组 来只清除某几个通道:
        #GPIO.cleanup(channel)
        #GPIO.cleanup( (channel1, channel2) )
        #GPIO.cleanup( [channel1, channel2] )
        #设置上拉下拉电阻
           #GPIO.setup(channel, GPIO.IN, pull_up_down=GPIO.PUD_UP)
        # or
           #GPIO.setup(channel, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

```
