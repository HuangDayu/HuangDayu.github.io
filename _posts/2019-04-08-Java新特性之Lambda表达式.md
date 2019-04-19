---
title: Java新特性之Lambda表达式
date: 2019-04-08 14:35:29
categories:
- 后端开发 
tags:
- Java
- Java新特性
layout: post
published: true
---

# 什么是Lambda表达式

&emsp;&emsp;Lambda是Java 8引入的新特性，可以替代匿名函数，类似于JS的闭包。没有声明的方法，也即没有访问修饰符、返回值声明和名字，它将函数作为参数传入方法中。标志性符号是**`->`**,**`() ->`**或者**`() -> {}`**   
&emsp;&emsp;Lambda表达式是隐式地赋值给函数式接口，也就是必须用在函数式接口上，函数式接口是指被`@FunctionalInterface`注解的接口，例如`java.lang.Runnable`。   
&emsp;&emsp;Lambda表达式会隐式的将成员变量或局部变量变成`final`终态类型。

<!-- more -->

# 为什么需要Lambda表达式

&emsp;&emsp;以简洁而紧凑的语言结构来替代匿名内部类。

# 怎么样使用Lambda表达式

## Lambda在循环中使用

```java
public static void main(String[] args) {
Map<String,String> map = new LinkedHashMap<>();
map.put("0","h");
map.put("1","u");
map.put("2","a");
map.put("3","n");
map.put("4","g");
map.put("5","d");
map.put("6","a");
map.put("7","y");
map.put("8","u");
map.put("9",".");
map.put("10","c");
map.put("11","n");

//--------------Java7--------------

for (Map.Entry<String,String> m : map.entrySet()) {
	System.out.print(m.getKey()+":"+m.getValue()+",");
}

//--------------Java 8--------------

map.forEach((K,V)->{
	System.out.print(K+":"+V+",");
});
	}
```

## Lambda在线程中使用

```java
//--------------Java7--------------

Thread t1 = new Thread(new Runnable() {
    public void run() {
    	System.out.println("Java7：规规矩矩的写法。");
    }
});
t1.start();

new Thread(new Runnable() {
	@Override
	public void run() {
System.out.println("Java7：节省引用的写法。");
	}
}).start();

new Thread() {
	@Override
	public void run() {
System.out.println("Java7：节省内部匿名类的写法。");
	}
}.start();

new Thread(()-> {
	System.out.println("Java 8：Lambda写法，节省匿名内部类与方法。");
}).start();

new Thread(System.out::println).start();

new Thread(Test3::print).start();

Runnable r = () -> {
	System.out.println("Java 8：直接使用函数式接口");
};
r.run();
```

# 参考文献

[Java 8 新特性](http://www.runoob.com/java/java8-new-features.html)  
[Java 8新特性终极指南](http://www.importnew.com/11908.html)  
