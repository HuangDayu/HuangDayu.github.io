---
title: Java关键字之instanceof
date: 2018-10-14 22:04:35
category: 
- 后端开发
tags: 
- Java关键字
---

> Java关键字之instanceof

- instanceof 是 Java 的一个二元操作符，类似于 ==，>，< 等操作符。
- instanceof 是 Java 的保留关键字。它的作用是测试它左边的对象是否是它右边的类的实例，返回 boolean 的数据类型。

<!-- more -->

```java
import java.util.ArrayList;
import java.util.Vector;
 
public class Main {
 
public static void main(String[] args) {
   test(new ArrayList());
}
public static void test(Object o) {
      if (o instanceof Vector)
      System.out.println("对象是 java.util.Vector 类的实例");
      else if (o instanceof ArrayList)
      System.out.println("对象是 java.util.ArrayList 类的实例");
      else
      System.out.println("对象是 " + o.getClass() + " 类的实例");
   }
}
```