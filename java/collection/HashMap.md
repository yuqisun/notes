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
获取 key 的hash值，`key.hashCode()`调用的

```
static final int hash(Object key) {
    int h;
    return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
```
