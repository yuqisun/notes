`Interface Comparable<T>`，T 是可能与此对象对比的对象们的类型

这个接口强行对实现它的类进行全排序，这种排序被称为自然排序，类的`comapreTo`方法被称为自然比较方法。？？？

List(和Array)中的对象如果实现了这个接口就可以使用 `Collections.sort` (和 `Arrays.sort`)自动排序。实现了这个接口的对象，
可以作为 [sorted map](https://docs.oracle.com/javase/8/docs/api/java/util/SortedMap.html) 的 key 或者
[sorted set](https://docs.oracle.com/javase/8/docs/api/java/util/SortedSet.html) 的元素，而无需指定 comparator。


