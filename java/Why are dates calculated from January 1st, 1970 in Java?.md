早期的 unix系统度量时间的粒度是 1/60s。这意味着一个 32位无符号的 integer 只能表示不到829天。即：
32位为 2^32 种变化，每60种变化才能表示一秒，2^32/60 = 71582788.266666666666666666666667 s = 828.50449382716049382716049382716 days

因为这个原因，数字 0(被称为新纪元 epoch)表示的时间必须设置的非常近。因为当时是在 1970s，所以就把 epoch设置成了 1970-1-1。

之后，系统时间由 1/60s递增改为每 1s 递增，这样 32位无符号 integer 就可以表示 2^32s = 49710.26962962962962962962962963 days = 136.19251953323186199898528665652 years

一个 32位有符号的 integer 比无符号少一位，即 2^31s，可以表示大概 68years，从 1970-1-1 -> 2038-1-19，之后将会变成 ???。

```
System.out.println(new Date(Integer.MAX_VALUE*1000L));

> 2038-01-19
```

对于现在 64位的时间可以表示 2^63s = 106751991167300.64592592592592593 days = 292471208677.53601623541349568747 years，大概 2924.7 亿年。不必担心时间越界的问题。

#### 引用
* [关于编程语言中的“1970年1月1日0点”](https://www.cnblogs.com/xingzoudeyishu/p/5400927.html)
* [Why are dates calculated from January 1st, 1970 in Java?](https://www.quora.com/Why-are-dates-calculated-from-January-1st-1970-in-Java)
* [Why is 1/1/1970 the “epoch time”?](https://stackoverflow.com/questions/1090869/why-is-1-1-1970-the-epoch-time/1090945#1090945)
