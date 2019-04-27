---
title: MQTT代理服务器之EMQTT
date: 2017-07-08 16:27:29
category: 
- 万物互联
tags:
- MQTT
---

> [EMQTT](http://emqtt.com/) 是一个MQTT代理服务器

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