`<logger>`用来设置某一个包或者具体某一个类的日志打印级别、以及指定`<appender>`。 `<logger>`可以包含零个或者多个`<appender-ref>`元素，
标识这个appender将会添加到这个logger。`<logger>`仅有一个name属性、一个可选的level属性和一个可选的additivity属性:
* name：用来指定受此logger约束的某一个包或者具体的某一个类
* level：用来设置打印级别，五个常用打印级别从低至高依次为TRACE、DEBUG、INFO、WARN、ERROR，如果未设置此级别，那么当前logger会继承上级的级别
* additivity：是否向上级logger传递打印信息，默认为true

`<root>`也是<logger>元素，但是它是根logger，只有一个level属性，因为它的name就是ROOT。

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<configuration scan="false" scanPeriod="60000" debug="false">
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <layout class="ch.qos.logback.classic.PatternLayout">
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - %msg%n</pattern>
        </layout>
    </appender>
    
    <logger name="java" />
    
    <root level="debug">
        <appender-ref ref="STDOUT" />
    </root>

</configuration>
```
注意这个**name表示的是LoggerFactory.getLogger(XXX.class)，XXX的包路径，包路径越少越是父级**，我们测试代码里面是Object.class，即name="java"是name="java.lang"的父级，root是所有<logger>的父级。

* `<logger>`中没有配置level，即继承父级的level，`<logger>`的父级为`<root>`，那么level=debug
* 没有配置additivity，那么additivity=true，表示此`<logger>`的打印信息向父级`<root>`传递
* 没有配置`<appender-ref>`，表示此`<logger>`不会打印出任何信息


由此可知，`<logger>`的打印信息向<root>传递，`<root>`使用"STDOUT"这个`<appender>`打印出所有大于等于debug级别的日志。
举一反三，我们将`<logger>`的additivity配置为false，那么控制台应该不会打印出任何日志，因为`<logger>`的打印信息不会向父级`<root>`传递且`<logger>`没有配置任何`<appender>`。

---

`<encoder>`和`<layout>`定义`<pattern>`:
* `<encoder>`是0.9.19版本之后引进的，以前的版本使用`<layout>`，logback极力推荐的是使用`<encoder>`而不是`<layout>`
* 最常用的FileAppender和它的子类的期望是使用`<encoder>`而不再使用`<layout>`


##### 异步写日志

#### 引用
* [Java 日志框架：logback 详解](https://mp.weixin.qq.com/s/UckDkMTmhiJnPsYiSnNoPw)

