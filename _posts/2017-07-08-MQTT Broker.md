---
title: MQTT Broker
date: 2017-07-08 16:27:29
category: 
- 万物互联
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

# MQTT Broker

比较出名的有以下几个MQTT代理服务器：  

- [EMQTT](http://emqtt.com/) 
- [Apache-Apollo](http://activemq.apache.org/apollo) 
- [Mosquitto](https://mosquitto.org/) 

<!-- more -->

## EMQTT

### 下载编译之后的软件包

```shell
wget http://emqtt.com/static/brokers/emqttd-ubuntu16.04-v2.3.6.zip
sudo unzip emqttd-ubuntu16.04-v2.3.6.zip
```

### 打开
```shell
./emqttd/bin/emqttd start
```

### 关闭
```shell
./emqttd/bin/emqttd stop
```

### 查询状态

```shell
./emqttd/bin/emqttd_ctl status
```

### 通过API发送消息给EMQTT代理服务器

> Http Post To EMQTT 封装

```java
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectionRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.util.EntityUtils;
public static void httpAPIPublishMqttPayload(String json) {
		final Base64.Encoder encoder = Base64.getEncoder();
		byte[] textByte;
		// 编码
		String encodedText=null;
		try {
			textByte = "admin:public".getBytes("UTF-8");//对账号和密码进行编码
			encodedText = encoder.encodeToString(textByte);// 编码
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		RequestConfig config = RequestConfig.custom().setConnectTimeout(5000).setSocketTimeout(3000).build();
		HttpClient httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();

		HttpPost httppost = new HttpPost(“http://yibuwulianwang.com:18000/api/v2/mqtt/publish”);

		httppost.setHeader("Authorization", "Basic " + encodedText);
		httppost.setHeader("Content-Type", "application/json");
		// httppost.setHeader("Content-Length", String.valueOf(postStrBytes.length));

		String postjson = JSON.toJSONString(“json”));//payload json
		// 构建消息实体
		StringEntity entity = new StringEntity(postjson, Charset.forName("UTF-8"));
		entity.setContentEncoding("UTF-8");
		// 发送json格式的请求
		entity.setContentType("application/json");
		httppost.setEntity(entity);

		HttpResponse response;
		try {
			response = httpClient.execute(httppost);
			// 消息返回码
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != HttpStatus.SC_OK) {
				System.out.println("REQUEST EMQTT HTTP API ERR:" + statusCode);
			} else {
				System.out.println("REQUEST EMQTT HTTP API SUCCESS:" + statusCode);
			}
			HttpEntity httpEntity = response.getEntity();
			String result = null;
			if (httpEntity != null) {
				result = EntityUtils.toString(httpEntity, "utf-8");
				EntityUtils.consume(httpEntity);
				System.out.println("EMQTT HTTP API RESPONSE RESULT:"+result);
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
```

> Http Post 封装

```java
import java.io.IOException;
import java.nio.charset.Charset;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
public void postAPI(String url, Object json) {
		RequestConfig config = RequestConfig.custom().setConnectTimeout(35000).setConnectionRequestTimeout(35000)
				.setSocketTimeout(60000).build();
		HttpClient httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Content-Type", "application/json");
		String postjson = JSON.toJSONString(json);
		System.out.println("请求接口( " + url + " )的数据：\n" + postjson);
		StringEntity entity = new StringEntity(postjson, Charset.forName("UTF-8"));
		entity.setContentEncoding("UTF-8");
		entity.setContentType("application/json");
		httpPost.setEntity(entity);
		try {
			HttpResponse httpResponse = httpClient.execute(httpPost);
			HttpEntity httpEntity = httpResponse.getEntity();
			String result = EntityUtils.toString(httpEntity, "utf-8");
			EntityUtils.consume(httpEntity);
			System.out.println("接口( " + url + " )响应的数据：\n" + result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
```

## Apache-Apollo

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
  * users.properties：  
    * 用来配置可以使用服务器的用户以及相应的密码。  
    * 其在文件中的存储方式是：用户名=密码，如：admin=password  
    * 表示新增一个用户，用户名是：admin，密码是：password  
  * groups.properties：  
    * 持有群体的用户映射，可以通过组而不是单个用户简化访问控制列表。  
    * 可以为一个定义的组设置多个用户，用户之间用`|`隔开，如：`admins=admin|lily`,表示admins组中有admin和lily两个用户  
  * black-list.txt  
    * 用来存放不允许连接服务器的IP地址，相当于黑名单类似的东西。例如：`10.20.9.147`  
    * 表示上面IP不能够连接到服务器。   
  * login.config：  
    * 是一个服务器认证的配置文件，为了安全apollo1.6版本提供了认证功能，只有相应的  
    * 用户名和正确的密码才能够连接服务器。  
  * 服务器主配置文件`apollo.xml`：  
    * 该配置文件用于控制打开的端口，队列，安全，虚拟主机设置等。  
    * 认证：可以使用  
    ```xml
    <authenticationdomain="internal" />
    ```
    来配置是否需要连接认证，如果将其属性enable设置为false表示不用认证，任何人都可以连接服务器，默认为true   
    * access_rule：可以在broker或者virtual_host中用于定义用户对服务器资源的各种行为。如:  
    ```xml
    <access_rule allow="users" action="connect create destroy send receive consume"/>
    ```
    表示群组users里面的用户可以对服务器资源进行的操作有：connect 、create、 destroy、 send 、receive 、consume。详细的操作说明见：[文档](http://activemq.apache.org/apollo/documentation/user-manual.html)  
    * message stores：默认情况下apollo使用的是LevelDB store，但是推荐使用BDB store（跨平台的）只能够实用其中一种。使用LevelDB store的配置是:  
    ```xml
    <leveldb_store directory="${apollo.base}/data"/>
    ```
    默认有提供不用任何修改。使用BDB store需要到网站下[jar](http://download.oracle.com/maven/com/sleepycat/je/5.0.34/je-5.0.34.jar)包，支持将jar包放在服务器的lib目录下面，然后将配置文件改成：  
    ```xml
    <bdb_store directory="${apollo.base}/data"/>
    ```
    即可。  
    * connector：用于配置服务器支持的链接协议以及相应的端口。如：  
    ```xml
    <connector id="tcp" bind="tcp://0.0.0.0:61613" connection_limit="2000" protocol="mqtt"/>
    ```
    * 表示支持tcp链接，使用的端口是61613，链接限制是2000，自动侦听的协议是mqtt协议。具体查看：[文档](http://activemq.apache.org/apollo/documentation/user-manual.html)  

## Mosquitto

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
