实现 Iterable 接口，即表示可遍历，要实现其 `Iterator<T> iterator();` 方法来获取 Iterator。另外也默认实现了 forEach 方法。

```
Iterator<T> iterator();

default void forEach(Consumer<? super T> action) {
    Objects.requireNonNull(action);
    for (T t : this) {
        action.accept(t);
    }
}
```

遍历器(iterator) 有两种实现，一种是单向的，向后遍历(Iterator)，一种是双向，可以向后也可以向前遍历(ListIterator)，并且多了 `void set(E e);`和`void add(E e);` 方法。
