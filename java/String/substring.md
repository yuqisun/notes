jdk6中substring()将会导致的问题  

如果你有一个非常长的字符串，但是你仅仅只需要这个字符串的一小部分，这就会导致性能问题，因为你需要的只是很小的部分，而这个子字符串却要包含整个字符数组，
因为在jdk6中，String 由 value，offset，count 控制，subString() 只是更改了 offset和 count，还是会指向原来的字符串。  

在jdk6中解决办法就是使用下面的方法，它会指向一个真正的子字符串。
```
// 这样就创建了一个新的字符串，原来的字符串将会被回收
x = x.substring(x, y) + ""
```

### 引用
* [JDK6和JDK7中的substring()方法](http://www.importnew.com/7418.html)
* [The substring() Method in JDK 6 and JDK 7](https://www.programcreek.com/2013/09/the-substring-method-in-jdk-6-and-jdk-7/)

