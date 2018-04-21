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
