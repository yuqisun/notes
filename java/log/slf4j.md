Simple Logging Facade for Java ([SLF4J](https://www.slf4j.org/))

我们为什么要使用slf4j，举个例子：

> 我们自己的系统中使用了logback这个日志系统  
我们的系统使用了A.jar，A.jar中使用的日志系统为log4j  
我们的系统又使用了B.jar，B.jar中使用的日志系统为slf4j-simple

这样，我们的系统就不得不同时支持并维护logback、log4j、slf4j-simple三种日志框架，非常不便。
解决这个问题的方式就是引入一个适配层，由适配层决定使用哪一种日志系统，而调用端只需要做的事情就是打印日志而不需要关心如何打印日志，slf4j或者commons-logging就是这种适配层，slf4j是本文研究的对象。

从上面的描述，我们必须清楚地知道一点：**slf4j只是一个日志标准，并不是日志系统的具体实现。** 理解这句话非常重要，slf4j只做两件事情：
1. 提供日志接口
2. 提供获取具体日志对象的方法

slf4j-simple、logback都是slf4j的具体实现，log4j并不直接实现slf4j，但是有专门的一层桥接slf4j-log4j12来实现slf4j。

#### 引用
* [Java日志框架：slf4j作用及其实现原理](https://www.cnblogs.com/xrq730/p/8619156.html)

