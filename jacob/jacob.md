[[原创]jacob使用入门及问题解析 ~~~~~~~~~~~ 回网友](http://www.blogjava.net/lusm/archive/2007/03/27/106737.html)

[java调用outlook](https://blog.csdn.net/cbjcry/article/details/70154765)

```java_holder_method_tree
Exception in thread "main" com.jacob.com.ComFailException: Can't get object clsid from progid
	at com.jacob.com.Dispatch.createInstanceNative(Native Method)
	at com.jacob.com.Dispatch.<init>(Dispatch.java:99)
	at com.jacob.activeX.ActiveXComponent.<init>(ActiveXComponent.java:58)
	at jacob.Test.main(Test.java:10)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at com.intellij.rt.execution.application.AppMain.main(AppMain.java:147)
```
可能是没有装 word

