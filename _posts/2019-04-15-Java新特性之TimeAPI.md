---
title: Java新特性之TimeAPI
date: 2019-04-15 13:29:38
categories:
- 后端开发
tags:
- Java
- Java新特性
layout: post
published: true
comments: true
---

# 什么是TimeAPI

&emsp;&emsp;`java.time.*`是Java 8引入的**Date&Time&Zone**类库，提供日期，时间，瞬间和持续时间的主要API。   


# 为什么要TimeAPI

&emsp;&emsp;旧的` java.util.Date`以及`java.util.Calendar`被开发者普遍吐槽，所以借鉴了 [Joda Time](https://www.joda.org/joda-time/) 的优点，开发了新的API。  

**旧API的问题**  

- 非线程安全  ：` java.util.Date` 是非线程安全的，所有的日期类都是可变的，这是Java日期类最大的问题之一。
- 设计很差 ：Java的日期/时间类的定义并不一致，在`java.util`和`java.sql`的包中都有日期类，此外用于格式化和解析的类在`java.text`包中定义。`java.util.Date`同时包含日期和时间，而`java.sql.Date`仅包含日期，将其纳入`java.sql`包并不合理。另外这两个类都有相同的名字，这本身就是一个非常糟糕的设计。
- 时区处理麻烦 ： 日期类并不提供国际化，没有时区支持，因此Java引入了`java.util.Calendar`和`java.util.TimeZone`类，但他们同样存在上述所有的问题。

**新API的优点**  

- Local(本地)  ： 简化了日期时间的处理，没有时区的问题。
- Zoned(时区)  ： 通过制定的时区处理日期时间。
- 新的`java.time`包涵盖了所有处理日期，时间，日期/时间，时区，时刻（instants），过程（during）与时钟（clock）的操作。

<!-- more -->

# 如何使用TimeAPI

## 类说明

| 类     | 说明    |
| ------------------- | ------------------------------- |
| [Clock](https://docs.oracle.com/javase/8/docs/api/java/time/Clock.html) | 一个时钟，使用时区提供对当前时刻，日期和时间的访问。 |
| [Duration](https://docs.oracle.com/javase/8/docs/api/java/time/Duration.html) | 基于时间的时间量，例如'34.5秒'。 |
| [Instant](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html) | 时间线上的瞬时点。            |
| [LocalDate](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html) | ISO-8601日历系统中没有时区的日期，例如2007-12-03。 |
| [LocalDateTime](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html) | ISO-8601日历系统中没有时区的日期时间，例如2007-12-03T10：15：30。 |
| [LocalTime](https://docs.oracle.com/javase/8/docs/api/java/time/LocalTime.html) | 在ISO-8601日历系统中没有时区的时间，例如10:15:30。 |
| [MonthDay](https://docs.oracle.com/javase/8/docs/api/java/time/MonthDay.html) | ISO-8601日历系统中的一个月 - 例如 -  12-03。 |
| [OffsetDateTime](https://docs.oracle.com/javase/8/docs/api/java/time/OffsetDateTime.html) | 在ISO-8601日历系统中与UTC / Greenwich偏移的日期时间，例如2007-12-03T10：15：30 + 01:00。 |
| [OffsetTime](https://docs.oracle.com/javase/8/docs/api/java/time/OffsetTime.html) | 在ISO-8601日历系统中与UTC / Greenwich偏移的时间，例如10：15：30 + 01:00。 |
| [Period](https://docs.oracle.com/javase/8/docs/api/java/time/Period.html) | ISO-8601日历系统中基于日期的时间量，例如“2年，3个月和4天”。 |
| [Year](https://docs.oracle.com/javase/8/docs/api/java/time/Year.html) | ISO-8601日历系统中的一年，例如2007。 |
| [YearMonth](https://docs.oracle.com/javase/8/docs/api/java/time/YearMonth.html) | ISO-8601日历系统中的年度月份，例如2007-12。 |
| [ZonedDateTime](https://docs.oracle.com/javase/8/docs/api/java/time/ZonedDateTime.html) | ISO-8601日历系统中具有时区的日期时间，例如2007-12-03T10：15：30 + 01:00欧洲/巴黎。 |
| [ZoneId](https://docs.oracle.com/javase/8/docs/api/java/time/ZoneId.html) | 时区ID，例如Europe / Paris。 |
| [ZoneOffset](https://docs.oracle.com/javase/8/docs/api/java/time/ZoneOffset.html) | 与格林威治/ UTC的时区偏移，例如+02：00。 |

## 枚举类说明

| 枚举类       | 说明                       |
| ------------------ | ------------ |
| [DayOfWeek](https://docs.oracle.com/javase/8/docs/api/java/time/DayOfWeek.html) | 星期几，例如'星期二'。 |
| [Month](https://docs.oracle.com/javase/8/docs/api/java/time/Month.html) | 一个月，例如'七月'。 |

## 异常

| 异常  | Description |
| -------------------------- | -------- |
| [DateTimeException](https://docs.oracle.com/javase/8/docs/api/java/time/DateTimeException.html) | 用于表示计算日期时间问题的异常。 |

## 实例

```java
import java.time.Clock;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class Test11 {

	public static void main(String[] args) {
		Clock clock = Clock.systemUTC();
		System.out.println(clock.instant());
		System.out.println(clock.millis());
		System.out.println(clock.getZone());

		// 获取本地日期
		final LocalDate date = LocalDate.now();
		final LocalDate dateFromClock = LocalDate.now(clock);

		System.out.println(date);
		System.out.println(dateFromClock);

		// 获取本地时间
		final LocalTime time = LocalTime.now();
		final LocalTime timeFromClock = LocalTime.now(clock);

		System.out.println(time);
		System.out.println(timeFromClock);

		// 获取本地日期和本地时间，是LocalTime和LocalDate的集合
		final LocalDateTime datetime = LocalDateTime.now();
		final LocalDateTime datetimeFromClock = LocalDateTime.now(clock);

		System.out.println(datetime);
		System.out.println(datetimeFromClock);

		// 获取分区日期/时间
		final ZonedDateTime zonedDatetime = ZonedDateTime.now();
		final ZonedDateTime zonedDatetimeFromClock = ZonedDateTime.now(clock);
		final ZonedDateTime zonedDatetimeFromZone = ZonedDateTime.now(ZoneId.of("America/Los_Angeles"));

		System.out.println(zonedDatetime);
		System.out.println(zonedDatetimeFromClock);
		System.out.println(zonedDatetimeFromZone);

		// 获取两个日期之间的间隔时间
		final LocalDateTime from = LocalDateTime.of(2014, Month.APRIL, 16, 0, 0, 0);
		final LocalDateTime to = LocalDateTime.of(2015, Month.APRIL, 16, 23, 59, 59);

		final Duration duration = Duration.between(from, to);
		System.out.println("间隔多少天: " + duration.toDays());
		System.out.println("间隔多少小时: " + duration.toHours());
	}

}
```

## 输出结果

```verilog
2019-04-15T05:54:13.750Z
1555307653835
Z
2019-04-15
2019-04-15
13:54:13.850
05:54:13.850
2019-04-15T13:54:13.850
2019-04-15T05:54:13.850
2019-04-15T13:54:13.850+08:00[Asia/Shanghai]
2019-04-15T05:54:13.850Z
2019-04-14T22:54:13.850-07:00[America/Los_Angeles]
间隔多少天: 365
间隔多少小时: 8783
```

# 参考文献

[Java 8 官方文档](https://docs.oracle.com/javase/8/docs/api/index.html)    
[Java 8 新特性](http://www.runoob.com/java/java8-new-features.html)  
[Java 8 新特性终极指南](http://www.importnew.com/11908.html)  