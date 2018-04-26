### 工厂方法
实例化bean：
* 通过构造函数实例化
* 使用静态工厂方法实例化
* 使用实例工厂方法实例化


我们知道 Bean 包装的是 Object，而 Object 必然有数据，如何给这些数据提供生存环境就是 Context 要解决的问题，
对 Context 来说他就是要发现每个 Bean 之间的关系，为它们建立这种关系并且要维护好这种关系。所以 Context 就是一个 Bean 关系的集合，
这个关系集合又叫 Ioc 容器，一旦建立起这个 Ioc 容器后 Spring 就可以为你工作了。
那 Core 组件又有什么用武之地呢？其实 Core 就是发现、建立和维护每个 Bean 之间的关系所需要的一些列的工具，从这个角度看来，Core 这个组件叫 Util 更能让你理解。

[Spring 框架的设计理念与设计模式分析](https://www.ibm.com/developerworks/cn/java/j-lo-spring-principle/)

[深入解析spring中用到的九种设计模式](https://www.cnblogs.com/jifeng/p/7398852.html)

[Spring学习总结（一）——Spring实现IoC的多种方式](https://www.cnblogs.com/best/p/5727935.html)

[Spring Framework Reference Documentation](http://spring.cndocs.ml/)
