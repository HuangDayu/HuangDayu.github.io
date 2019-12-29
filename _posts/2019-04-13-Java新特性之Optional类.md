---
title: Java新特性之Optional类
date: 2019-04-13 15:27:43
categories:
- 后端开发
tags:
- Java新特性
layout: post
published: true
comments: true
---

# 什么是Optional类

&emsp;&emsp;`Optional`类是Java 8引入的新类，所在类库是`java.util.Optional<T>`。Optional  是个容器，可以存储类型为`T`的值，也可以存储为null的对象，也就是说，即使对象为null，也不报`java.lang.NullPointerException`空对象异常。   

# 为什么要Optional类

&emsp;&emsp;从上面就可以看出，该类就是为了解决臭名昭著的空对象异常而生。  

<!-- more -->

# 如何使用Optional类

## 提供的方法

| 方法 | 说明 |
| ---- | ------------------------------------------------------------ |
| static <T> Optional<T> empty()    | 返回空的 Optional 实例。   |
| boolean equals(Object obj)    | 判断其他对象是否等于 Optional。 |
| Optional<T> filter(Predicate<? super <T> predicate)   | 如果值存在，并且这个值匹配给定的 predicate，返回一个Optional用以描述这个值，否则返回一个空的Optional。 |
| <U> Optional<U> flatMap(Function<? super T,Optional<U>> mapper)    | 如果值存在，返回基于Optional包含的映射方法的值，否则返回一个空的Optional |
| T get()    | 如果在这个Optional中包含这个值，返回值，否则抛出异常：NoSuchElementException |
| int hashCode()    | 返回存在值的哈希码，如果值不存在 返回 0。  |
| void ifPresent(Consumer<? super T> consumer)    | 如果值存在则使用该值调用 consumer , 否则不做任何事情。 |
| boolean isPresent()    | 如果值存在则方法会返回true，否则返回 false。 |
| <U>Optional<U> map(Function<? super T,? extends U> mapper)    | 如果有值，则对其执行调用映射函数得到返回值。如果返回值不为 null，则创建包含映射返回值的Optional作为map方法返回值，否则返回空Optional。 |
|  static <T> Optional<T> of(T value)   |返回一个指定非null值的Optional，value为null则直接抛出空对象异常。 |
|  static <T> Optional<T> ofNullable(T value)   |如果为非空，返回 Optional 描述的指定值，否则返回空的 Optional。 |
| T orElse(T other)   | 如果存在该值，返回值， 否则返回 other，可以视为默认值。 |
| T orElseGet(Supplier<? extends T> other)   | 如果存在该值，返回值， 否则触发 other（一个Lambda表达式），并返回 other 调用的结果。 |
|  <X extends Throwable> T orElseThrow(Supplier<? extends X> exceptionSupplier)   |如果存在该值，返回包含的值，否则抛出由 Supplier 继承的异常 |
| String toString()   | 返回一个Optional的非空字符串，用来调试  |

## 实例

```java
import java.util.Optional;

public class Test9 {
	public static void main(String[] args) {
	
		//如果为非空，返回 Optional 描述的指定值，否则返回空的 Optional。
		Optional<Object> a = Optional.ofNullable(null);
		Test9.test(a);
		
		//值为null则直接抛出空对象异常
		Optional<String> b = Optional.of("yes");
		Test9.test(b);
	}

	public static <T> void test(Optional<T> t) {

		if (t.isPresent()) {// 该值是否存在，否则为null
			T s = t.get();
			System.out.println("获取到的值："+s);
		} else {
			System.out.println("值为空！");
		}

		//如果存在该值，返回值， 否则返回Lambda表达式的结果。
		System.out.println(t.orElseGet(() -> {
			return (T) "Lambda表达式返回值！";
		}));

		//如果存在该值，返回值， 否则返回Lambda表达式的结果。
		System.out.println(t.orElse((T) "我是默认值-1!"));
		
		System.out.println(t.map(s -> "值是： " + s + "!\n").orElse("我是默认值-2!\n"));

	}

}
```

## 输出结果

```verilog
值为空！
Lambda表达式返回值！
我是默认值-1!
我是默认值-2!

获取到的值：yes
yes
yes
值是： yes!
```

# 参考文献

[Java 8 新特性](http://www.runoob.com/java/java8-new-features.html)  
[Java 8新特性终极指南](http://www.importnew.com/11908.html)  