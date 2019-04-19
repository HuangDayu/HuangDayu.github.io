---
title: Java新特性之JavaScript引擎
date: 2019-04-17 10:04:19
categories:
- 后端开发
tags:
- Java
- Java新特性
layout: post
published: true
comments: true
---

# 什么是JavaScript引擎

&emsp;&emsp;早在Java 6时就引入了JavaScript引擎`Rhino`，它支持ECMAScript 5.1规范，它使用JSR 292言特性。Java 7时引入了`invokedynamic`，将JavaScript编译成`Java字节码`。Java 8引入的新的JavaScript引擎`Nashorn`比`Rhino`性能提高多倍，`Nashorn`就是`javax.script.ScriptEngine`的另一种实现。   

## 什么是jjs

&emsp;&emsp;`jjs`是个基于`Nashorn`引擎的命令行工具。它可以接受JavaScript源代码为参数，并且执行这些源代码。  

# 为什么要JavaScript引擎

&emsp;&emsp;为了使`Java`和`JavaScript`两门语言在`JVM`环境下能相互调用。  

<!-- more -->

# 如何使用JavaScript引擎

## jjs命令行实例

```verilog
C:\Users\Administrator\Desktop\back\new 
λ touch test.js                         
                                        
C:\Users\Administrator\Desktop\back\new 
λ vim test.js                           
                                        
C:\Users\Administrator\Desktop\back\new 
λ cat test.js                           
print("This is JavaScript test code."); 

C:\Users\Administrator\Desktop\back\new 
λ jjs test.js                           
This is JavaScript test code.           

# 交互式编程

C:\Users\Administrator\Desktop\back\new
λ jjs
jjs> print("this is JavaScript test code")
this is JavaScript test code
jjs>

# 传递参数

C:\Users\Administrator\Desktop\back\new
λ jjs -- a b c
jjs> print("传递的参数："+arguments.join(","))
传递的参数：a,b,c
jjs>
```

## Java调用JavaScript

### 实例

**Test.java**  

```java
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

public class Test13 {
	public static void main(String[] args) {
		java_JavaScript();
	}
	
	private static void java_JavaScript() {
		ScriptEngineManager scriptEngineManager = new ScriptEngineManager();
		ScriptEngine nashorn = scriptEngineManager.getEngineByName("nashorn");

		String name = "huangdayu.cn";
		Integer result = null;

		try {
			nashorn.eval("print('" + name + "')");
			result = (Integer) nashorn.eval("10 + 2");

		} catch (ScriptException e) {
			System.out.println("执行脚本错误: " + e.getMessage());
		}

		System.out.println(result.toString());
	}
	
}
```

### 输出结果

```verilog
huangdayu.cn
12
```

## JavaScript调用Java

### 实例

**test2.js**  

```js
var BigDecimal = Java.type('java.math.BigDecimal');

function calculate(amount, percentage) {
	var result = new BigDecimal(amount).multiply(
    	new BigDecimal(percentage)).divide(new BigDecimal("100"), 2, BigDecimal.ROUND_HALF_EVEN);
    	return result.toPlainString();
}

var result = calculate(568000000000000000023,13.9);
print(result);
```

### 输出结果

```verilog
F:\Android\Java\Eclipse Project SSM\NewCharacteristic\js
λ touch test2.js

F:\Android\Java\Eclipse Project SSM\NewCharacteristic\js
λ jjs test2.js
78952000000000002017.94
```


# 参考文献

[Java 8 官方文档](https://docs.oracle.com/javase/8/docs/api/index.html)    
[Java 8 新特性](http://www.runoob.com/java/java8-new-features.html)  
[Java 8 新特性终极指南](http://www.importnew.com/11908.html)  