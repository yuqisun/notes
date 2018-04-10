`<logger>`用来设置某一个包或者具体某一个类的日志打印级别、以及指定`<appender>`。 `<logger>`可以包含零个或者多个`<appender-ref>`元素，
标识这个appender将会添加到这个logger。`<logger>`仅有一个name属性、一个可选的level属性和一个可选的additivity属性。

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


