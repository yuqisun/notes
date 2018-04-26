我们知道 Bean 包装的是 Object，而 Object 必然有数据，如何给这些数据提供生存环境就是 Context 要解决的问题，
对 Context 来说他就是要发现每个 Bean 之间的关系，为它们建立这种关系并且要维护好这种关系。所以 Context 就是一个 Bean 关系的集合，
这个关系集合又叫 Ioc 容器，一旦建立起这个 Ioc 容器后 Spring 就可以为你工作了。
那 Core 组件又有什么用武之地呢？其实 Core 就是发现、建立和维护每个 Bean 之间的关系所需要的一些列的工具，从这个角度看来，Core 这个组件叫 Util 更能让你理解。

##### Bean 组件
Bean 的定义、Bean 的创建以及对 Bean 的解析，他的顶级接口是 BeanFactory。

##### Core 组件
包含了很多的关键类，其中一个重要组成部分就是定义了资源的访问方式。

##### Context 相关的类结构图
ApplicationContext 继承了 BeanFactory，这也说明了 Spring 容器中运行的主体对象是 Bean，另外 ApplicationContext 继承了 ResourceLoader 接口，使得 ApplicationContext 可以访问到任何外部资源。


### 引用
* [Spring 框架的设计理念与设计模式分析](https://www.ibm.com/developerworks/cn/java/j-lo-spring-principle/)

