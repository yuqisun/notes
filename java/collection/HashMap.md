##### 实现
使用Node数组实现 `transient Node<K,V>[] table;`，Node 中有 hash, key, value, next：
```
static class Node<K,V> implements Map.Entry<K,V> {
    final int hash;
    final K key;
    V value;
    Node<K,V> next;
    ...
    ...
```

##### hash
获取 key 的hash值，`key.hashCode()`调用的是 native 方法`public native int hashCode();`，其描述是 `converting the **internal address** of the object into an integer, but this implementation technique is not required by the Java&trade; programming language`，其中 internal address 大概是虚拟机中的地址，所以hashcode在 jvm重启之后就未必和之前相同了。

```
static final int hash(Object key) {
    int h;
    return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
```
java 在取得由内部地址得来的 hash code 后，又把自身右移16 位再作 '与'运算。???
```
static final int hash(Object key) {
    int h;
    return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
```

