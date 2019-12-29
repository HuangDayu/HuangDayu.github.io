---
title: Spring项目中获取Java命令的参数
date: 2018-10-27 22:35:46
category: 
- 后端开发
tags:
- Spring
---

spring-property.xml  

```xml
<?xml version="1.0" encoding="utf-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xmlns:context="http://www.springframework.org/schema/context" 
xsi:schemaLocation="http://www.springframework.org/schema/beans     
http://www.springframework.org/schema/beans/spring-beans.xsd     
http://www.springframework.org/schema/context     
http://www.springframework.org/schema/context/spring-context.xsd">  
  <!-- ${url} -->  
  <context:property-placeholder location="classpath:application.properties"/>  

  <!-- 使用Spring自带的占位符替换功能 -->  
  <!-- nohup java -Ddubbo.service.server.port=20883 -jar falsework-provider-app.jar > 2018-10-27-falsework-provider-app.log & -->  
  <bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"> 
    <!-- 系统-D参数覆盖 -->  
    <property name="systemPropertiesModeName" value="SYSTEM_PROPERTIES_MODE_OVERRIDE"/>  
    <!-- 指定properties配置所在位置 -->  
    <property name="location" value="classpath:application.properties"/> 
  </bean> 
</beans>
```

指定Dubbo协议的端口  

```xml
<dubbo:protocol name="dubbo" port="${dubbo.service.server.port}"/>
```

示例    

```shell
nohup java -Ddubbo.service.server.port=20880 -jar falsework-provider-app.jar > 2018-10-27-falsework-provider-app.log &
```

参考文献  

[dubbo常见问题--使用多个进程启动服务，端口冲突怎么办？](http://zh-ka-163-com.iteye.com/blog/2258834)  