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
java 在取得由内部地址得来的 hash code 后，又把自身右移16 位再作 '异或'运算。*如果a、b两个值不相同，则异或结果为1。如果a、b两个值相同，异或结果为0*。这里异或的具体作用不是很清楚，jdk注释中有一段解释，大概是说用最低廉的方式减少系统负载，同时满足合并最高位冲突？？？

```
/**
 * Computes key.hashCode() and spreads (XORs) higher bits of hash
 * to lower.  Because the table uses power-of-two masking, sets of
 * hashes that vary only in bits above the current mask will
 * always collide. (Among known examples are sets of Float keys
 * holding consecutive whole numbers in small tables.)  So we
 * apply a transform that spreads the impact of higher bits
 * downward. There is a tradeoff between speed, utility, and
 * quality of bit-spreading. Because many common sets of hashes
 * are already reasonably distributed (so don't benefit from
 * spreading), and because we use trees to handle large sets of
 * collisions in bins, we just XOR some shifted bits in the
 * cheapest possible way to reduce systematic lossage, as well as
 * to incorporate impact of the highest bits that would otherwise
 * never be used in index calculations because of table bounds.
 */

static final int hash(Object key) {
    int h;
    return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
```

##### put
先比较 hashcode，如果相同再比较key，如果相同则覆盖这个 node。
```
if (p.hash == hash &&
    ((k = p.key) == key || (key != null && key.equals(k))))
    e = p;
```
碰撞之后的 Node会被放进一个 bin中，如果 binCount >= TREEIFY_THRESHOLD - 1，会调用`treeifyBin(tab, hash);`生成红黑树。
```
static final int TREEIFY_THRESHOLD = 8;
......
Node<K,V> e; K k;
if (p.hash == hash &&
    ((k = p.key) == key || (key != null && key.equals(k))))
    e = p;
else if (p instanceof TreeNode)
    e = ((TreeNode<K,V>)p).putTreeVal(this, tab, hash, key, value);
else {
    for (int binCount = 0; ; ++binCount) {
        if ((e = p.next) == null) {
            p.next = newNode(hash, key, value, null);
            if (binCount >= TREEIFY_THRESHOLD - 1) // -1 for 1st
                treeifyBin(tab, hash);
            break;
        }
        if (e.hash == hash &&
            ((k = e.key) == key || (key != null && key.equals(k))))
            break;
        p = e;
    }
}
```



### 引用
* [Java提高篇（二六）-----hashCode](http://www.cnblogs.com/chenssy/p/3651218.html)

