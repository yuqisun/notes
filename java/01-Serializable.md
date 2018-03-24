Serializable 没有任何方法和字段，仅用于标识是否可以序列化。

在序列化和反序列化过程中，如果类需要特殊处理，则必须实现以下签名的特殊方法：
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