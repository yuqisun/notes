### 简单工厂
简单工厂模式的实质是由一个工厂类根据传入的参数，动态决定应该创建哪一个产品类。  
spring中的BeanFactory就是简单工厂模式的体现，根据传入一个唯一的标识来获得bean对象。

### 工厂方法
实例化bean：
* 通过构造函数实例化
* 使用静态工厂方法实例化
```java_holder_method_tree
import java.util.Random;
public class StaticFactoryBean {
      public static Integer createRandom() {
           return new Integer(new Random().nextInt());
       }
}
```
建一个config.xm配置文件，将其纳入Spring容器来管理,需要通过factory-method指定静态方法名称
```xml
<bean id="random"
class="example.chapter3.StaticFactoryBean" factory-method="createRandom" //createRandom方法必须是static的,才能找到 
scope="prototype" />
```

* 使用实例工厂方法实例化

### 单例模式
保证一个类仅有一个实例，并提供一个访问它的全局访问点。 
spring中的单例模式完成了后半句话，即提供了全局的访问点BeanFactory。但没有从构造器级别去控制单例，这是因为spring管理的是是任意的java对象。 
核心提示点：Spring下默认的bean均为singleton，可以通过singleton=“true|false” 或者 scope=“？”来指定

### 适配器


### 代理模式
代理模式就是给某一个对象创建一个代理对象，而由这个代理对象控制对原对象的引用，而创建这个代理对象就是可以在调用原对象是可以增加一些额外的操作。  
Spring Aop 中 Jdk 动态代理就是利用代理模式技术实现的。

![001-spring-overview.png](https://raw.githubusercontent.com/yuqisun/notes/master/spring/images/002-代理模式.png)


### 模板方法
定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。Template Method使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。
Template Method模式一般是需要继承的。这里想要探讨另一种对Template Method的理解。spring中的JdbcTemplate，在用这个类时并不想去继承这个类，
因为这个类的方法太多，但是我们还是想用到JdbcTemplate已有的稳定的、公用的数据库连接，那么我们怎么办呢？我们可以把变化的东西抽出来作为一个参数传入JdbcTemplate的方法中。
但是变化的东西是一段代码，而且这段代码会用到JdbcTemplate中的变量。怎么办？那我们就用回调对象吧。在这个回调对象中定义一个操纵JdbcTemplate中变量的方法，我们去实现这个方法，
就把变化的东西集中到这里了。然后我们再传入这个回调对象到JdbcTemplate，从而完成了调用。这可能是Template Method不需要继承的另一种实现方式吧。


### 引用
* [Spring 框架的设计理念与设计模式分析](https://www.ibm.com/developerworks/cn/java/j-lo-spring-principle/)
* [深入解析spring中用到的九种设计模式](https://www.cnblogs.com/jifeng/p/7398852.html)
* [Spring学习总结（一）——Spring实现IoC的多种方式](https://www.cnblogs.com/best/p/5727935.html)
* [Spring Framework Reference Documentation](http://spring.cndocs.ml/)
