---
title: RESTful API 的正确响应
date: 2018-10-28 13:20:46
category: 
- 后端开发
tags:
- HTTP
---

```java
public static ResponseEntity<Object> ResponseEntity(HttpStatus httpStatus, ResponseEnum stateEnum, Object data){
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Content-Type", "application/json; charset=utf-8");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", stateEnum.getCode());
		map.put("msg", stateEnum.getMsg());
		map.put("data", data);
		return new ResponseEntity<Object>(JSON.toJSONString(map), httpHeaders, httpStatus);
}
```


```java
return APIResultBean.ResponseEntity(HttpStatus.OK, ResponseEnum.SUCCESS, "suscess data");
return APIResultBean.ResponseEntity(HttpStatus.FORBIDDEN, ResponseEnum.FAILED, "failed data");
```


```verilog
13:15:48.982 [main] DEBUG o.s.t.w.s.TestDispatcherServlet - Successfully completed request

MockHttpServletRequest:
      HTTP Method = POST
      Request URI = /OAuthClient/clientData/sucess
       Parameters = {}
          Headers = {Accept=[application/json]}

MockHttpServletResponse:
           Status = 200
    Error message = null
          Headers = {Content-Type=[application/json; charset=utf-8], Content-Length=[47]}
     Content type = application/json; charset=utf-8
             Body = {"msg":"成功","code":1,"data":"suscess data"}
    Forwarded URL = null
   Redirected URL = null
          Cookies = []
```


参考文献  

[RESETful API 设计规范](https://godruoyi.com/posts/resetful-api-design-specifications)  
[HTTP 响应代码](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status/204)  
[RESTful API 最佳实践](http://www.ruanyifeng.com/blog/2018/10/restful-api-best-practices.html)  


