---
title: MQTT Client
type: Java
date: 2017-09-01 10:15:46
category: 
- 万物互联
tags:
- MQTT
description: MQTT Client From Java
---

> pom.xml

```xml
<dependency>
	<groupId>org.eclipse.paho</groupId>
	<artifactId>org.eclipse.paho.client.mqttv3</artifactId>
	<version>1.0.2</version>
</dependency>
```

> Config.java

```java

public class Config {
	// http api publish mqtt payload
	public final static String EMQTT_HTTP_API_URL = "http://yibuwulianwang.com:18000/api/v2/mqtt/publish";
	public final static String EMQTT_USER_PASSWORD = "admin:public";
	public final static String EMQTT_CLIEND_ID = "iot";
	public final static String EMQTT_TOPIC = "yibuwulianwang";
	public final static int QOS = 1;
	public final static String BROKER = "tcp://yibuwulianwang.com:1883";
	public final static String USER_NAME = "SpringMVC";
	public final static String USER_PASSWORD = "yibuwulianwang";
	public final static String OAUTH_SCOPE="basic email";
}

```


> MyMqttClient.java

```java
package com.yibuwulianwang.mqtt;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttPersistenceException;
import org.eclipse.paho.client.mqttv3.MqttTopic;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.fastjson.JSONObject;
import com.yibuwulianwang.config.Config;
import com.yibuwulianwang.http.HttpResponseStatus;

public class MyMqttClient {
	private static MemoryPersistence persistence = null;
	private static MqttClient sampleClient = null;
	private static MqttConnectOptions connOpts = null;
	private static MqttTopic topic11 = null;
	static {
		try {
			persistence = new MemoryPersistence();
			sampleClient = new MqttClient(Config.BROKER, Config.EMQTT_CLIEND_ID, persistence);
			connOpts = new MqttConnectOptions();
			connOpts.setCleanSession(true);
			connOpts.setUserName(Config.USER_NAME);
			connOpts.setPassword(Config.USER_PASSWORD.toCharArray());
			// 设置超时
			connOpts.setConnectionTimeout(10);
			// 设置心跳
			connOpts.setKeepAliveInterval(130);
			// 设置回调
			sampleClient.setCallback(new MyMqttCallback());

			topic11 = sampleClient.getTopic(Config.EMQTT_TOPIC);
			// 创建连接
			sampleClient.connect(connOpts);

			if (sampleClient.isConnected()) {
				System.out.println("Mqtt Client Success Connecting To Mqtt Broker Server");
			}

			// 订阅主题
			sampleClient.subscribe(Config.EMQTT_TOPIC, Config.QOS);
			// 断开连接
			// sampleClient.disconnect();

		} catch (MqttException me) {
			System.out.println("/mqtt","reason " + me.getReasonCode()+"msg " + me.getMessage()
			+"loc " + me.getLocalizedMessage()+"cause " + me.getCause()+"excep " + me);
			//me.printStackTrace();
		}
	}


	public static void publishMqttPayload(String json) {
		try {
			MqttMessage message = new MqttMessage(json.getBytes());
			message.setRetained(true);//设置是否保留消息
			message.setQos(Config.QOS);
			if (sampleClient.isConnected()) {
				sampleClient.publish(Config.EMQTT_TOPIC, message);
			} else {
				// 客户端连接
				sampleClient.connect(connOpts);
				publishMqttPayload(json);
			}
		} catch (MqttPersistenceException e) {
			e.printStackTrace();
		} catch (MqttException e) {
			e.printStackTrace();
		}
	}
	
	public static MqttClient getSampleClient() {
		return sampleClient;
	}

	public static MqttConnectOptions getConnOpts() {
		return connOpts;
	}
}

```

> MyMqttCallback.java

```java
package com.yibuwulianwang.mqtt;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttSecurityException;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.yibuwulianwang.config.Config;

public class MyMqttCallback implements MqttCallback {
	static int  connects=0;
	public void connectionLost(Throwable cause) {
		if(connects>=5) {
			System.out.println("MyMqttCallback.connectionLost()","MQTT多次重连失败，可能存在客户端ID冲突："+Config.EMQTT_CLIEND_ID);
    		try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
    		connects=0;
		}
        if(!MyMqttClient.getSampleClient().isConnected() && connects<5) {
        	try {
				connects++;
				MyMqttClient.getSampleClient().connect(MyMqttClient.getConnOpts());
        		System.out.println("MyMqttCallback.connectionLost()","MQTT正在重连-cause:"+cause.toString());
			} catch (MqttSecurityException e) {
        		System.out.println("MyMqttCallback.connectionLost()","MQTT正在重-MqttSecurityException-"+e.getStackTrace());
				//e.printStackTrace();
			} catch (MqttException e) {
				//e.printStackTrace();
        		System.out.println("MyMqttCallback.connectionLost()","MQTT正在重连-MqttException-"+e.getStackTrace());
			}
        }
        if(MyMqttClient.getSampleClient().isConnected()) {
    		System.out.println("MyMqttCallback.connectionLost()","MQTT重连成功。");
    	}else {
    		System.out.println("MyMqttCallback.connectionLost()","MQTT重连失败！");
    	}
    }  

    public void deliveryComplete(IMqttDeliveryToken token) {
		System.out.println("MyMqttCallback.deliveryComplete()","MQTT消息发送结果："+token.isComplete());
    }  

    public void messageArrived(String topic, MqttMessage message) throws Exception {
//        System.out.println("接收消息主题 : " + topic);  
//        System.out.println("接收消息Qos : " + message.getQos());  
//        System.out.println("接收消息内容 : " + new String(message.getPayload()));
    	  String str = new String(message.getPayload());
    	if(isJSONValid(str)) {
    		//com.yibuwulianwang.mqtt.publish.MqttPayloadRoot payload = JSON.parseObject(str,com.yibuwulianwang.mqtt.publish.MqttPayloadRoot.class);
		com.yibuwulianwang.json.me.MyPayloadJson payload = JSON.parseObject(str,new TypeReference<com.yibuwulianwang.json.me.MyPayloadJson>() {});
        	try {
        		if(!payload.getClientId().equals(Config.EMQTT_CLIEND_ID)) {//判断是不是自己发出去的
            		System.out.println("MyMqttCallback.messageArrived()","MQTT收到Json消息："+str);
            		ProcessingMessages.processingMsg(str);
            	}
    		} catch (Exception e) {
    			System.out.println("MyMqttCallback.messageArrived()", "Json Analysis Exception");
    		}
    	}else {
    		System.out.println("MyMqttCallback.messageArrived()","MQTT收到字符串消息："+str);
    	}
    } 
}

/**
 * 判断是不是json
 * 暴力解析:Alibaba fastjson
 * @param test
 * @return
 */
public final static boolean isJSONValid(String test) {
    try {
        JSONObject.parseObject(test);
    } catch (JSONException ex) {
        try {
                JSONObject.parseArray(test);
        } catch (JSONException ex1) {
                return false;
        }
    }
     return true;
} 

```