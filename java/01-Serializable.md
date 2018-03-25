Serializable 没有任何方法和字段，仅用于标识是否可以序列化。

可序列化类的所有子类型本身都是可序列化的。在序列化和反序列化过程中，如果类需要特殊处理，则必须实现以下签名的特殊方法：
```
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

