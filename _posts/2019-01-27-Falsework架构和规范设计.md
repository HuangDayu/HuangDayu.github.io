---
title: Falsework架构和规范设计
date: 2019-01-27 22:57:00
category:
- 开源项目
---

# 需求规划

---

&emsp;&emsp;实现`OAuth 2.0`服务端和客户端，实现用户角色控制，Token权限控制和授权数据统计；围绕这个需求，将项目架构从单体架构，到分层架构，再到微服务架构的演变。

<!-- more -->

# 架构设计

---

## 架构图

![Falsework架构图](https://raw.githubusercontent.com/HuangDayu/huangdayu.github.io/master/assets/private/images/image-75.png "Falsework架构图")

## 架构设计

### Controller（访问控制转发层）

1. 校验token；
1. 用户权限校验；
1. 用户角色校验；
1. 参数校验；
2. 数据校验；
3. 数据序列化；
4. 轻业务逻辑；
5. 异常兜底；
6. 使用`DTO<VO>` 或者 `DTO<BO>` 作为对外领域模型；
6. 一个`Controller`应一个`Service`

### Service（业务逻辑服务层）

1. 复杂的业务编排逻辑处理；
2. 捕捉异常；
3. 复用性低；
4. 使用`DTO<BO>`作为领域模型（Business Object 业务对象）；
5. 一个`Controller`应一个`Service`；

### Mannager（通用业务处理层）

1. 对第三方平台封装的层，预处理返回结果及转化异常信息；
2. 对 `Service` 层通用能力的下沉，如缓存方案、中间件通用处理；
3. 与 `DAO` 层交互，对多个 `DAO` 的组合复用；
4. 复用性高；
5. 可以是单个服务，也可以是复合服务，比如多表查询；
6. 使用`DTO<BO>`作为领域模型；

### DAO（数据持久访问层）

1. 将对象与表结构简历ORM映射关系；
2. `Redis`缓存操作；
3. `Cache`缓存操作；
4. 只允许对应的`Service`访问；
5. 使用`DO`作为领域模型；

## 架构原则

1. 前后端分离架构
2. `Web`/`App`(`Android`/`iOS`)/`Open`(对外开放`OAuth`)共用一套接口；
3. 使用`JSON`作为交互协议；
4. 使用`Swagger`作为接口文档；
5. 使用`HATEOAS`构建`RESTful Web API JSON`;
6. `RESTful API`命名使用名词复数；

# 规范设计

---

## 表结构规范

1. 数据库表的命名**t_**为开头；
2. 表的主键有两个，表序号**id**，分布式的全球唯一标识**only_id**；
3. 字段命名`下划线规则`，无大写，下划线分离开单词。

## 请求规范

1. 创建使用**`post`**请求；
2. 删除使用**`delete`**请求；
3. 更新使用**`put`**请求；
4. 查询使用**`get`**请求；

## 入参规范

1. 使用`application/x-www-form-urlencoded`与`application/json;charset=UTF-8`并存。
2. 使用`Token`身份认证，解决判断和权限鉴定，采用`AOP`面向切面编程认证`Token`;

## 出参规范

1. 使用`application/json;charset=UTF-8`
2. `data`使用`List<T>`;
3. `code`使用`int`;
4. `msg`使用`String`;
5. 使用标准的`HTTP Status Code`；
6. `List`中包含分布式全球唯一标识；

## 参数校验规范

### 争议

#### 防御派

方法应该为自己负责，我不能保证调用者是否进行了校验，所以我必须要进行校验，从而保证程序的健壮性。

#### 简约派

方法应该校验，但是不应该重复校验。重复校验产生了冗余的代码，导致程序可读性差。

### 标准

#### 开发自用方法

权限：`private`,`protected` ,`default`  

参数是可控的，在方法中不必校验参数合法性，调用者在调用之前应确认传入参数的合法性。

#### 开发公共方法

权限：`public`  

参数是不可控的，在方法中必须校验参数的合法性，因为无法保证调用者的行为和传入参数的合法性。

# 参考文献

[你的项目应该如何正确分层？](https://juejin.im/post/5b44e62e6fb9a04fc030f216)  