### Spring创建代理的规则为：
1. 默认使用Java动态代理来创建AOP代理，这样就可以为任何接口实例创建代理了
2. 当需要代理的类不是代理接口的时候，Spring会切换为使用CGLIB代理，也可强制使用CGLIB

### AOP核心概念
1. 横切关注点: 对哪些方法进行拦截，拦截后怎么处理，这些关注点称之为横切关注点
2. 切面（aspect）: 类是对物体特征的抽象，切面就是对横切关注点的抽象
3. 连接点（joinpoint）: 被拦截到的点，因为Spring只支持方法类型的连接点，所以在Spring中连接点指的就是被拦截到的方法，实际上连接点还可以是字段或者构造器
4. 切入点（pointcut）: 对连接点进行拦截的定义
5. 通知（advice）: 所谓通知指的就是指拦截到连接点之后要执行的代码，通知分为前置、后置、异常、最终、环绕通知五类
6. 目标对象: 代理的目标对象
7. 织入（weave）: 将切面应用到目标对象并导致代理对象创建的过程
8. 引入（introduction）: 在不修改代码的前提下，引入可以在运行期为类动态地添加一些方法或字段

### 引用
* [Chapter 6. 使用Spring进行面向切面编程（AOP）](http://shouce.jb51.net/spring/aop.html)
* [Spring3：AOP](http://www.cnblogs.com/xrq730/p/4919025.html)
* [什么是面向切面编程AOP？](https://www.zhihu.com/question/24863332)
* [Spring AOP 实现原理](https://blog.csdn.net/moreevan/article/details/11977115/)
