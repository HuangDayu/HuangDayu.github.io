---
title: SpringMVC分层思想
type: SpringMVC
date: 2017-05-15 12:49:49
category: 
- 后端开发
tags:
- SpringMVC
- Spring
---

### DAO层

> 数据持久层/数据访问层
> - 对外提供统一的数据操作接口
> - 可以使数据库操作，可以是文件操作，也可以使缓存操作
> - 专注于数据业务的处理 

<!-- more -->

### Entity层

> 实体类
> - 数据库表相对应的实体类
> - DAO层取出来的数据封装成一个对象，也称为Pojo
> - 用于层级之间的数据传输

### DTO层

> 数据传输层
> - 用于层级之间的数据传输，也称为VO
> - 比Entity层包含更多数据 ResultDTO<T>
> - 数据可以包含结果表示服

### Service层

> 业务逻辑层

#### 业务逻辑接口层
> - 站在使用者的角度设计的业务接口
> - 业务模块的逻辑应用设计

#### 业务逻辑实现层
> - 实现具体的业务的接口
> - 可以实现事务控制
> - 可以实现切面编程

### Controller层

> 业务逻辑控制层
> - 负责具体的业务模块流程的控制
> - 调用Service业务逻辑接口来操作具体的业务

### View层

> 展示层
> - 使用Model对象在View和Controller层传输数据
> - 负责前端jsp，html页面的展示
> - 前后端分离的架构已经很少用到这一层

### SpringMVC中文文档

[国内W3CSchool](https://www.w3cschool.cn/spring_mvc_documentation_linesh_translation/)  
[国外GitBook](https://linesh.gitbooks.io/spring-mvc-documentation-linesh-translation/content/)