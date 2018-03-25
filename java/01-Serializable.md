Serializable 没有任何方法和字段，仅用于标识是否可以序列化。

可序列化类的所有子类型本身都是可序列化的。在序列化和反序列化过程中，如果类需要特殊处理，则必须实现以下签名的特殊方法：
```java_holder_method_tree
 private void writeObject(java.io.ObjectOutputStream out)
     throws IOException
 private void readObject(java.io.ObjectInputStream in)
     throws IOException, ClassNotFoundException;
 private void readObjectNoData()
     throws ObjectStreamException;
```

存储对象的默认机制可以调用`out.defaultWriteObject`，恢复对象non-static 和 non-transient字段的默认机制
可以调用`in.defaultReadObject`

在序列化流不列出给定类作为将被反序列化对象的超类的情况下，readObjectNoData 方法负责初始化特定类的对象状态。
这种情况可能发生在接收方使用的反序列化实例类的版本不同于发送方，并且接收者版本扩展的类不是发送者版本扩展的类时发生。
在序列化流已经被篡改时也可能发生。

* 在序列化运行时，每一个可序列化类有一个version数，叫做serialVersionUID。用于反序列化验证发送者和接受者加载的类是否兼容，
如果serialVersionUID不同，会抛出`InvalidClassException`。该字段必须是 `static final long`。

* 序列化时不会保存静态变量，因为序列化保存的是对象的状态，静态变量属于类的状态，因此序列化并不保存静态变量。

* 要想将父类对象也序列化，就需要让父类也实现Serializable 接口。如果父类不实现的话的，就需要有默认的无参的
构造函数。在父类没有实现 Serializable 接口时，虚拟机是不会序列化父对象的，而一个 Java 对象的构造必须先有
父对象，才有子对象，反序列化也不例外。所以反序列化时，为了构造父对象，只能调用父类的无参构造函数作为默认的父对象。
因此当我们取父对象的变量值时，它的值是调用父类无参构造函数后的值。如果你考虑到这种序列化的情况，
在父类无参构造函数中对变量进行初始化，否则的话，父类变量值都是默认声明的值，如 int 型的默认是 0，string 型的默认是 null。

* Transient 关键字的作用是控制变量的序列化，在变量声明前加上该关键字，可以阻止该变量被序列化到文件中，在被反序列化后，
transient 变量的值被设为初始值，如 int 型的是 0，对象型的是 null。

> 特性使用案例
>
> 我们熟悉使用 Transient 关键字可以使得字段不被序列化，那么还有别的方法吗？根据父类对象序列化的规则，
我们可以将不需要被序列化的字段抽取出来放到父类中，子类实现 Serializable 接口，父类不实现，
根据父类序列化规则，父类的字段数据将不被序列化。
>
> 放在父类中的好处还在于当有另外一个子类被序列化时，父类中的字段依然不会被序列化，子类中不用重复写transient，
代码简洁。

* 在序列化过程中，虚拟机会试图调用对象类里的 writeObject 和 readObject 方法，进行用户自定义的序列化和反序列化，
如果没有这样的方法，则默认调用是 ObjectOutputStream 的 defaultWriteObject 方法以及 ObjectInputStream 的
defaultReadObject 方法。用户自定义的 writeObject 和 readObject 方法可以允许用户控制序列化的过程，
比如可以在序列化的过程中动态改变序列化的数值。基于这个原理，可以在实际应用中得到使用，用于敏感字段的加密工作。

```java_holder_method_tree
ObjectOutputStream out = new ObjectOutputStream(
new FileOutputStream("result.obj"));
Test test = new Test();
//试图将对象两次写入文件
out.writeObject(test);
out.flush();
System.out.println(new File("result.obj").length());
out.writeObject(test);
out.close();
System.out.println(new File("result.obj").length());

ObjectInputStream oin = new ObjectInputStream(new FileInputStream(
"result.obj"));
//从文件依次读出两个文件
Test t1 = (Test) oin.readObject();
Test t2 = (Test) oin.readObject();
oin.close();

//判断两个引用是否指向同一个对象
System.out.println(t1 == t2);
```

* 对同一对象两次写入文件，打印出写入一次对象后的存储大小和写入两次后的存储大小，然后从文件中反序列化出两个对象，比较这两个对象是否为同一对象。

> 一般的思维是，两次写入对象，文件大小会变为两倍的大小，反序列化时，由于从文件读取，生成了两个对象，判断相等时应该是输入 false 才对。

> Java 序列化机制为了节省磁盘空间，具有特定的存储规则，当写入文件的为同一对象时，并不会再将对象的内容进行存储，
而只是再次存储一份引用，因此增加的存储空间就是新增引用和一些控制信息的空间。反序列化时，恢复引用关系，二者相等，
使用`obj1 == obj2` 输出 true。该存储规则极大的节省了存储空间。

```java_holder_method_tree
ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("result.obj"));
Test test = new Test();
test.i = 1;
out.writeObject(test);
out.flush();
test.i = 2;
out.writeObject(test);
out.close();
ObjectInputStream oin = new ObjectInputStream(new FileInputStream(
"result.obj"));
Test t1 = (Test) oin.readObject();
Test t2 = (Test) oin.readObject();
System.out.println(t1.i);
System.out.println(t2.i);
```
* 目的是希望将 test 对象两次保存到 result.obj 文件中，写入一次以后修改对象属性值再次保存第二次，然后从 result.obj 中再依次读出两个对象，
输出这两个对象的 i 属性值。案例代码的目的原本是希望一次性传输对象修改前后的状态。
结果两个输出的都是 1， 原因就是第一次写入对象以后，第二次再试图写的时候，虚拟机根据引用关系知道已经有一个
相同对象已经写入文件，因此只保存第二次写的引用，所以读取时，都是第一次保存的对象。
在使用一个文件多次 writeObject 需要特别注意这个问题。
***这个问题注意使用的是同一个对象 Test。***

#### 引用
* [Interface Serializable](https://docs.oracle.com/javase/7/docs/api/)
* [某些java类为什么要实现Serializable接口](https://blog.csdn.net/summer_sy/article/details/70255421)

