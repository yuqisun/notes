门面模式要求一个子系统的外部与其内部的通信必须通过一个统一的门面(Facade)对象进行。门面模式提供一个高层次的接口，使得子系统更易于使用。

门面(Facade)角色：客户端可以调用这个角色的方法。此角色知晓相关的(一个或者多个)子系统的功能和责任。在正常情况下，本角色会将所有从客户端发来的请求委派到相应的子系统去。

子系统(subsystem)角色：可以同时有一个或者多个子系统。每一个子系统都不是一个单独的类，而是一个类的集合。每一个子系统都可以被客户端直接调用，或者被门面角色调用。子系统并不知道门面的存在，对于子系统而言，门面仅仅是另外一个客户端而已。

一个service就类似一个facade，在比较简单的系统中，就是对数据库进行增删改查，一个service中可能会调用 DB 的多种操作(增删改查)，不就相当于给 db 操作做了一个facade么。

#### 引用
* [门面（Facade）模式](http://www.cnblogs.com/skywang/articles/1375447.html)
* [门面（Facade）模式](http://www.cnblogs.com/zhenyulu/articles/55992.html)
* [23种设计模式(1)-Facade设计模式](https://blog.csdn.net/duchao123duchao/article/details/51425085)
* [外观模式（Facade Pattern） - 最易懂的设计模式解析](https://www.jianshu.com/p/1b027d9fc005)

