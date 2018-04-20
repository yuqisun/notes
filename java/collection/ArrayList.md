ArrayList 内部是一个 Object 数组：

```
transient Object[] elementData; // non-private to simplify nested class access
...
public ArrayList(int initialCapacity) {
    if (initialCapacity > 0) {
        this.elementData = new Object[initialCapacity];
    } else if (initialCapacity == 0) {
        this.elementData = EMPTY_ELEMENTDATA;
    } else {
        throw new IllegalArgumentException("Illegal Capacity: "+
                                           initialCapacity);
    }
}
```

当 add一个元素的时候，首先检查 List容量，`ensureCapacityInternal(size + 1);`，如果 List为空则取 `minCapacity = Math.max(DEFAULT_CAPACITY, minCapacity);`，其中默认容量大小为 10。
```
public boolean add(E e) {
    ensureCapacityInternal(size + 1);  // Increments modCount!!
    elementData[size++] = e;
    return true;
}
```

扩容的时候，先把新值设置为原来的容量的 1.5倍，再和上边的 minCapacity 比较，取数值大的一个，再和 MAX_ARRAY_SIZE比较，最大容量是 Integer.MAX_VALUE - 8，如果大于这个数就属于 hugeCapacity 了，最最大的也就是 Integer的最大值了 MAX_VALUE = 0x7fffffff。最后调用 `elementData = Arrays.copyOf(elementData, newCapacity);`来 copy一个新的 List。
```
private void grow(int minCapacity) {
    // overflow-conscious code
    int oldCapacity = elementData.length;
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    if (newCapacity - minCapacity < 0)
        newCapacity = minCapacity;
    if (newCapacity - MAX_ARRAY_SIZE > 0)
        newCapacity = hugeCapacity(minCapacity);
    // minCapacity is usually close to size, so this is a win:
    elementData = Arrays.copyOf(elementData, newCapacity);
}
```


    
