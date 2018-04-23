LinkedList 既实现 List接口，又实现 Deque接口，所以既有 List的功能又有 Deque的功能(peek, pop ...)。

##### 实现
使用类 Node 类生成链表，一个是自身，一个指向前边Node，一个指向后边Node：
```
private static class Node<E> {
    E item;
    Node<E> next;
    Node<E> prev;

    Node(Node<E> prev, E element, Node<E> next) {
        this.item = element;
        this.next = next;
        this.prev = prev;
    }
}
```

##### add
add 默认是加在末尾，另外也可以指定 index 或者加在头上。
```
void linkLast(E e) {
    final Node<E> l = last;
    final Node<E> newNode = new Node<>(l, e, null);
    last = newNode;
    if (l == null)
        first = newNode;
    else
        l.next = newNode;
    size++;
    modCount++;
}
```
```
public void add(int index, E element) {
    checkPositionIndex(index);

    if (index == size)
        linkLast(element);
    else
        linkBefore(element, node(index));
}
```

其中，通过 index 获取到 node这一步，因为 LinkedList 不是数组实现，所以要一个一个的去遍历，为了加快速度，使用了一次二分法从中间分开，然后进行查找。如果 index 在前半部分就从前向中间查找，如果在后半部分则从后到中间查找。
```
Node<E> node(int index) {
    // assert isElementIndex(index);

    if (index < (size >> 1)) {
        Node<E> x = first;
        for (int i = 0; i < index; i++)
            x = x.next;
        return x;
    } else {
        Node<E> x = last;
        for (int i = size - 1; i > index; i--)
            x = x.prev;
        return x;
    }
}
```

##### get(int index)
`E get(int index)`就是调用上边的 `Node<E> node(int index)`通过下标来找到 node。
```
public E get(int index) {
    checkElementIndex(index);
    return node(index).item;
}
```

##### remove
默认移除第一个。

##### indexOf
通过遍历比较对象，下标自增。
```
public int indexOf(Object o) {
    int index = 0;
    if (o == null) {
        for (Node<E> x = first; x != null; x = x.next) {
            if (x.item == null)
                return index;
            index++;
        }
    } else {
        for (Node<E> x = first; x != null; x = x.next) {
            if (o.equals(x.item))
                return index;
            index++;
        }
    }
    return -1;
}
```




