---
title: Java新特性之Stream流
date: 2019-04-14 20:40:40
categories:
- 后端开发
tags:
- Java新特性
layout: post
published: true
comments: true
---

# 什么是Stream流

&emsp;&emsp;`java.util.stream.*`是Java 8引入的函数式编程类库，以一种声明的方式来处理元素集合里的数据，可以理解为`shell`脚本中`管道`（**|**）一样的概念。  
&emsp;&emsp;首先将`数据源`（**集合**，**数组**，**I/O channel**， **产生器generator**）的`元素`形成`队列`，然后管道中传输，并且可以在管道的`节点`上进行**`聚合操作`**， 比如`筛选`， `排序`，`聚合`，`计算`等，这个视为`中间操作`。`最终操作`将结果返回。Java中将这一系列操作抽象为**Stream流**。   

## Stream流的分类

- **stream()**：串行流
- **parallelStream()**：并行流 

**PS**：串行流与并行流的区别就是单线程与多线程的区别，并行流处理比串行流快很多。具体业务使用具体流，比如并行流对元素的排序（**sorted()**）就返回了错误的结果，对条件判断（**filter()**）则不影响结果。  

## Stream流的特征

- **Pipelining**：中间操作都会返回流对象本身， 如同流式风格（fluent style）的管道。 可以进行延迟执行(laziness)和短路( short-circuiting)等操作。
- **内部迭代**： 通常集合遍历都是通过Iterator或者For-Each的方式, 显式的在集合外部进行外部迭代。 Stream提供了内部迭代的方式， 通过访问者模式(Visitor)实现。


# 为什么要Stream流

&emsp;&emsp;为了让开发者能够快速，简洁，高效地对`数据源`（**集合**，**数组**，**I/O channel**， **产生器generator**）中的元素进行操作。  
&emsp;&emsp;凡是提供了**stream()**方法的集合都可以用流处理。如`Collection`接口。  

<!-- more -->

# 如何使用Stream流

##  接口说明

**java.util.stream.* 接口说明**  

| 接口 | 说明         |
| -------------- | ----------------- |
| [BaseStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/BaseStream.html)<T,S extends [BaseStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/BaseStream.html)<T,S>> | 流的基本接口，它是支持串行和并行聚合操作的元素序列。         |
| [Collector](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collector.html)<T,A,R> | 可变缩减操作，将输入元素累积到可变结果容器中，可选地在处理完所有输入元素后将累积结果转换为最终表示。 |
| [DoubleStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/DoubleStream.html) | 一系列原始双值元素，支持串行和并行聚合操作。                 |
| [DoubleStream.Builder](https://docs.oracle.com/javase/8/docs/api/java/util/stream/DoubleStream.Builder.html) | `DoubleStream`的可变构建器。                                 |
| [IntStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/IntStream.html) | 支持串行和并行聚合操作的一系列原始int值元素。                |
| [IntStream.Builder](https://docs.oracle.com/javase/8/docs/api/java/util/stream/IntStream.Builder.html) | `IntStream`的可变构建器。                                    |
| [LongStream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/LongStream.html) | 一系列原始长值元素，支持串行和并行聚合操作。                 |
| [LongStream.Builder](https://docs.oracle.com/javase/8/docs/api/java/util/stream/LongStream.Builder.html) | `LongStream`的可变构建器。                                   |
| [Stream](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html)<T> | 支持串行和并行聚合操作的一系列元素。                         |
| [Stream.Builder](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.Builder.html)<T> | `Stream`的可变构建器。                                       |

## Stream的方法说明

**java.util.stream.Stream 类的方法说明**    


| 返回值类型                     | 方法                                                         | 说明                                     |
| ------------------------------ | ----------------------------- | ----------------------------------------------------------------------- |
| `boolean`                      | `allMatch(Predicate<? super T> predicate)`                   | 返回此流的所有元素是否与提供的谓词匹配。 |
| `boolean`                      | `anyMatch(Predicate<? super T> predicate)` | 返回此流的任何元素是否与提供的谓词匹配。 |
| `static <T> Stream.Builder<T>` | `builder()`                 | 返回Stream的构建器。 |
| `<R,A> R`                      | `collect(Collector<? super T,A,R> collector)` | 使用收集器对此流的元素执行可变减少操作。 |
| `<R> R`                        | `collect(Supplier<R> supplier, BiConsumer<R,? super T> accumulator, BiConsumer<R,R> combiner)` | Performs a [mutable reduction](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html#MutableReduction) operation on the elements of this stream. |
| `static <T> Stream<T>`         | `concat(Stream<? extends T> a, Stream<? extends T> b)` | 创建一个延迟连接的流，其元素是第一个流的所有元素，后跟第二个流的所有元素。 |
| `long`                         | `count()`       | 返回此流中元素的数量。 |
| `Stream<T>`                    | `distinct()` | 返回由此流的不同元素（根据Object.equals（Object））组成的流。 |
| `static <T> Stream<T>`         | `empty()`               | 返回一个空的顺序Stream。 |
| `Stream<T>`                    | `filter(Predicate<? super T> predicate)` | 返回由与此给定谓词匹配的此流的元素组成的流。 |
| `Optional<T>`                  | `findAny()` | 返回描述流的某个元素的Optional，如果流为空，则返回空Optional。 |
| `Optional<T>`                  | `findFirst()` | 返回描述此流的第一个元素的Optional，如果流为空，则返回空Optional。 |
| `<R> Stream<R>`                | `flatMap(Function<? super T,? extends Stream<? extends R>> mapper)` | 返回一个流，该流包含将此流的每个元素替换为通过将提供的映射函数应用于每个元素而生成的映射流的内容的结果。 |
| `DoubleStream`                 | `flatMapToDouble(Function<? super T,? extends DoubleStream> mapper)` | 返回一个DoubleStream，它包含将此流的每个元素替换为通过将提供的映射函数应用于每个元素而生成的映射流的内容的结果。 |
| `IntStream`                    | `flatMapToInt(Function<? super T,? extends IntStream> mapper)` | 返回一个IntStream，它包含将此流的每个元素替换为通过将提供的映射函数应用于每个元素而生成的映射流的内容的结果。 |
| `LongStream`                   | `flatMapToLong(Function<? super T,? extends LongStream> mapper)` | 返回一个LongStream，它包含将此流的每个元素替换为通过将提供的映射函数应用于每个元素而生成的映射流的内容的结果。 |
| `void`                         | `forEach(Consumer<? super T> action)` | 对此流的每个元素执行操作。 |
| `void`                         | `forEachOrdered(Consumer<? super T> action)` | 如果流具有已定义的遭遇顺序，则按流的遭遇顺序对此流的每个元素执行操作。 |
| `static <T> Stream<T>`         | `generate(Supplier<T> s)` | 返回无限顺序无序流，其中每个元素由提供的Supplier生成。 |
| `static <T> Stream<T>`         | `iterate(T seed, UnaryOperator<T> f)` | 返回通过将函数f迭代应用于初始元素种子而生成的无限顺序有序流，生成由种子，f（seed），f（f（seed））等组成的流。 |
| `Stream<T>`                    | `limit(long maxSize)` | 返回由此流的元素组成的流，截断长度不超过maxSize。 |
| `<R> Stream<R>`                | `map(Function<? super T,? extends R> mapper)` | 返回一个流，该流包含将给定函数应用于此流的元素的结果。 |
| `DoubleStream`                 | `mapToDouble(ToDoubleFunction<? super T> mapper)` | 返回DoubleStream，其中包含将给定函数应用于此流的元素的结果。 |
| `IntStream`                    | `mapToInt(ToIntFunction<? super T> mapper)` | 返回一个IntStream，它包含将给定函数应用于此流的元素的结果。 |
| `LongStream`                   | `mapToLong(ToLongFunction<? super T> mapper)`Returns a `LongStream` consisting of the results of applying the given function to the elements of this stream. | 返回一个LongStream，它包含将给定函数应用于此流的元素的结果。 |
| `Optional<T>`                  | `max(Comparator<? super T> comparator)` | 根据提供的Comparator返回此流的最大元素。 |
| `Optional<T>`                  | `min(Comparator<? super T> comparator)` | 根据提供的Comparator返回此流的最小元素。 |
| `boolean`                      | `noneMatch(Predicate<? super T> predicate)` | 返回此流的元素是否与提供的谓词匹配。 |
| `static <T> Stream<T>`         | `of(T... values)` | 返回其元素为指定值的顺序有序流。 |
| `static <T> Stream<T>`         | `of(T t)` | 返回包含单个元素的顺序Stream。 |
| `Stream<T>`                    | `peek(Consumer<? super T> action)` | 返回由此流的元素组成的流，此外还在从结果流中消耗元素时对每个元素执行提供的操作。 |
| `Optional<T>`                  | `reduce(BinaryOperator<T> accumulator)` | 使用关联累加函数执行此流的元素的减少，并返回描述减少值的Optional（如果有）。 |
| `T`                            | `reduce(T identity, BinaryOperator<T> accumulator)` | 使用提供的标识值和关联累加函数执行此流的元素的减少，并返回减少的值。 |
| `<U> U`                        | `reduce(U identity, BiFunction<U,? super T,U> accumulator, BinaryOperator<U> combiner)` | 使用提供的标识，累积和组合功能，对此流的元素执行减少。 |
| `Stream<T>`                    | `skip(long n)` | 在丢弃流的前n个元素后，返回由此流的其余元素组成的流。 |
| `Stream<T>`                    | `sorted()` | 返回由此流的元素组成的流，按照自然顺序排序。 |
| `Stream<T>`                    | `sorted(Comparator<? super T> comparator)` | 返回由此流的元素组成的流，根据提供的Comparator进行排序。 |
| `Object[]`                     | `toArray()` | 返回包含此流的元素的数组。 |
| `<A> A[]`                      | `toArray(IntFunction<A[]> generator)` | 返回一个包含此流元素的数组，使用提供的生成器函数分配返回的数组，以及分区执行或调整大小可能需要的任何其他数组。 |



## 实例

### People.java

```java
public class People {
	private String name;
	private int age;
	private String address;
	
	public People(String name,int age,String address) {
		this.name = name;
		this.age = age;
		this.address = address;
	};

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "People [name=" + name + ", age=" + age + ", address=" + address + "]";
	}

}
```

### Test.java

```java
import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.Iterator;


public class Test10 {
	public static void main(String[] args) {
		Collection< People > peoples = Arrays.asList(
			    new People( "a",1,"aa" ),
			    new People( "b",2,"bb" ),
			    new People( "c",3,"cc" ), 
			    new People( "d",4,"dd" ),
			    new People( "e",5,"ee" ),
			    new People( "f",6,"ff" ),
			    new People( "g",7,"gg" ),
			    new People( "h",8,"hh" ), 
			    new People( "i",9,"ii" )
		);
		
		System.out.print("\n使用iterator\n");
		// 使用iterator
		for (Iterator iterator = peoples.iterator(); iterator.hasNext();) {
			People people = (People) iterator.next();
			System.out.println(people.toString());
		}

		System.out.print("\n使用lambda\n");
		// 使用lambda
		peoples.forEach(people -> {
			System.out.println(people.toString());
		});

		System.out.print("\n使用方法引用\n");
		// 使用方法引用
		peoples.forEach(System.out::println);

		System.out.print("\n使用Stream流limit()方法\n");

		// Stream提供了 forEach()方法来迭代（Iteration）流中的每个数据
		// Stream提供了limit()方法用于获取指定数量的流。
		peoples.stream().limit(8).forEach(s -> {
			System.out.println(s.toString());
		});

		System.out.print("\n使用Stream流map()方法\n");
		// Stream提供了map()方法用于映射每个元素到对应的结果
		peoples.stream().map(people -> {
			if (people.getAge() == 5) {
				people.setAge(0);
			}
			return people;
		}).forEach(System.out::println);

		System.out.print("\n使用Stream流filter()方法\n");
		// Stream提供了filter()方法用于通过设置的条件过滤出元素。
		// parallelStream提供了count()方法用于统计符合条件的元素的数量
		long a = peoples.parallelStream().filter(people -> {
			if (people.getAge() == 0 || people.getName().equals("a")) {
				return true;
			}
			return false;
		}).count();
		System.out.println("符合条件的总共：" + a);
		
		// Stream提供了sorted()方法用于对元素进行排序
		System.out.print("\n使用Stream流sorted()方法\n");
		peoples.stream().sorted(Comparator.comparing(People::getAge).reversed()).forEach(System.out::println);
	}
}
```

### 输出结果

```verilog

使用iterator
People [name=a, age=1, address=aa]
People [name=b, age=2, address=bb]
People [name=c, age=3, address=cc]
People [name=d, age=4, address=dd]
People [name=e, age=5, address=ee]
People [name=f, age=6, address=ff]
People [name=g, age=7, address=gg]
People [name=h, age=8, address=hh]
People [name=i, age=9, address=ii]

使用lambda
People [name=a, age=1, address=aa]
People [name=b, age=2, address=bb]
People [name=c, age=3, address=cc]
People [name=d, age=4, address=dd]
People [name=e, age=5, address=ee]
People [name=f, age=6, address=ff]
People [name=g, age=7, address=gg]
People [name=h, age=8, address=hh]
People [name=i, age=9, address=ii]

使用方法引用
People [name=a, age=1, address=aa]
People [name=b, age=2, address=bb]
People [name=c, age=3, address=cc]
People [name=d, age=4, address=dd]
People [name=e, age=5, address=ee]
People [name=f, age=6, address=ff]
People [name=g, age=7, address=gg]
People [name=h, age=8, address=hh]
People [name=i, age=9, address=ii]

使用Stream流limit()方法
People [name=a, age=1, address=aa]
People [name=b, age=2, address=bb]
People [name=c, age=3, address=cc]
People [name=d, age=4, address=dd]
People [name=e, age=5, address=ee]
People [name=f, age=6, address=ff]
People [name=g, age=7, address=gg]
People [name=h, age=8, address=hh]

使用Stream流map()方法
People [name=a, age=1, address=aa]
People [name=b, age=2, address=bb]
People [name=c, age=3, address=cc]
People [name=d, age=4, address=dd]
People [name=e, age=0, address=ee]
People [name=f, age=6, address=ff]
People [name=g, age=7, address=gg]
People [name=h, age=8, address=hh]
People [name=i, age=9, address=ii]

使用Stream流filter()方法
符合条件的总共：2

使用Stream流sorted()方法
People [name=i, age=9, address=ii]
People [name=h, age=8, address=hh]
People [name=g, age=7, address=gg]
People [name=f, age=6, address=ff]
People [name=d, age=4, address=dd]
People [name=c, age=3, address=cc]
People [name=b, age=2, address=bb]
People [name=a, age=1, address=aa]
People [name=e, age=0, address=ee]
```

# 参考文献

[Java 8 官方文档](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html#StreamOps)    
[Java 8 新特性](http://www.runoob.com/java/java8-new-features.html)  
[Java 8 新特性终极指南](http://www.importnew.com/11908.html)  