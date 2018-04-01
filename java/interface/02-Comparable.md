`Interface Comparable<T>`，T 是可能与此对象对比的对象们的类型

这个接口强行对实现它的类进行全排序，这种排序被称为自然排序，类的`comapreTo`方法被称为自然比较方法。？？？

List(和Array)中的对象如果实现了这个接口就可以使用 `Collections.sort` (和 `Arrays.sort`)自动排序。实现了这个接口的对象，
可以作为 [sorted map](https://docs.oracle.com/javase/8/docs/api/java/util/SortedMap.html) 的 key 或者
[sorted set](https://docs.oracle.com/javase/8/docs/api/java/util/SortedSet.html) 的元素，而无需指定 comparator。


对于类 C 的每一个 e1 和 e2 来说，当且仅当 e1.compareTo(e2) == 0 与 e1.equals(e2) 具有相同的 boolean 值时，类 C 的自然排序才叫做与 equals 一致。
***注意，null 不是任何类的实例，即使 e.equals(null) 返回 false，e.compareTo(null) 也将抛出 NullPointerException。***

强烈建议自然排序与 equals一致。这是因为对于没有 comparators 的 sorted sets(和sorted maps)来说，当其所包含的元素的
自然排序与 equals不一致时，表现奇怪(strangely)。尤其是，这样一个 sorted set (or sorted map) 违反了set (or map) 在
`equals` 方法上定义的 general contract。

例如，向一个没有指定比较器的 sorted set中添加两个 keys a 和 b，其中 `(!a.equals(b) && a.compareTo(b) == 0)` 
即 equals方法判定两个对象不同而 compareTo方法判断两个方法相同(compareTo 与 equals不一致)，第二次 `add`操作返回 false
(并且sorted set的 size不会增加)，因为 a 和 b对于sorted set来说是相等的。

实际上，所有实现 Comparable 的 Java 核心类都具有与 equals 一致的自然排序。java.math.BigDecimal 是个例外，
它的自然排序将值相等但精确度不同的 BigDecimal 对象（比如 4.0 和 4.00）视为相等。

