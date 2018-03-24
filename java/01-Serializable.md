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

在序列化运行时，每一个可序列化类有一个version数，叫做serialVersionUID。用于反序列化验证发送者和接受者加载的类是否兼容，
如果serialVersionUID不同，会抛出`InvalidClassException`。该字段必须是 `static final long`。

