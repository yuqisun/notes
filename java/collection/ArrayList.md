##### 实现
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

##### add
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

Arrays.copyOf 又调用 System.arraycopy 方法来把原来的数组 copy 到容量变大的 数组中，所以如果频繁插入，扩容就要考虑 LinkedList。
```
public static <T,U> T[] copyOf(U[] original, int newLength, Class<? extends T[]> newType) {
    @SuppressWarnings("unchecked")
    T[] copy = ((Object)newType == (Object)Object[].class)
        ? (T[]) new Object[newLength]
        : (T[]) Array.newInstance(newType.getComponentType(), newLength);
    System.arraycopy(original, 0, copy, 0,
                     Math.min(original.length, newLength));
    return copy;
}
```

##### remove
操作数组的根本就是找到对应元素的下标，remove 有两种，一个是直接传入下标来删除，另一个是传入对象，进行对比查找之后删除，这就有两种情况，一个是该元素存在，一个不存在。所以按 index 删除返回的是被remove的元素，按元素删除返回的是 true/false。
```
public E remove(int index) {
    rangeCheck(index);

    modCount++;
    E oldValue = elementData(index);

    int numMoved = size - index - 1;
    if (numMoved > 0)
        System.arraycopy(elementData, index+1, elementData, index,
                         numMoved);
    elementData[--size] = null; // clear to let GC do its work

    return oldValue;
}
```

```
public boolean remove(Object o) {
    if (o == null) {
        for (int index = 0; index < size; index++)
            if (elementData[index] == null) {
                fastRemove(index);
                return true;
            }
    } else {
        for (int index = 0; index < size; index++)
            if (o.equals(elementData[index])) {
                fastRemove(index);
                return true;
            }
    }
    return false;
}
```

##### get
直接用数组下标获取
```
E elementData(int index) {
    return (E) elementData[index];
}
```

##### indexOf
如果是 null则遍历元素是否为 null `elementData[i]==null`，`==` 较调用 `equals` 快一些，否则调用 equals 方法比较。
```
public int indexOf(Object o) {
    if (o == null) {
        for (int i = 0; i < size; i++)
            if (elementData[i]==null)
                return i;
    } else {
        for (int i = 0; i < size; i++)
            if (o.equals(elementData[i]))
                return i;
    }
    return -1;
}
```

##### 当作参数传入
把 ArrayList当作参数传入的时候，因为传的是引用，所以如果要避免数组被修改，要考虑到用 Arrays.copyOf 来复制一个新的数组。

在指定 index 的地方插入元素，要调用`System.arraycopy`把数组向后移动，然后在当前位置加入元素。
```
public void add(int index, E element) {
    rangeCheckForAdd(index);

    ensureCapacityInternal(size + 1);  // Increments modCount!!
    System.arraycopy(elementData, index, elementData, index + 1,
                     size - index);
    elementData[index] = element;
    size++;
}
```




