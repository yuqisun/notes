##### Redis讲 Redis keys是二进制安全的，什么是二进制安全

我总结一下还没有确认是否正确，因为计算机是二进制运行的，那任何在计算机上能打出的字符都属于可以转换成二进制的，
二进制安全即任何在计算机上能够使用的字符都可以作为Redis的key，包括字母、数字、符号(\,*,&,$...)、汉字都可以作为key。

##### NO.1
> A binary safe string is one that can consist of any characters (bytes).
  For example, many programming languages use the 0x00 character as an end-of-string marker, 
  so in that sense a binary safe string is one that can consist of these.
  
##### NO.2
> c中的strlen函数就不算是binary safe的，因为它依赖于特殊的字符'\0'来判断字符串是否结束，
  所以对于字符串str = "1234\0123"来说，strlen(str)=4
  而在php中，strlen函数是binary safe的，因为它不会对任何字符（包括'\0'）进行特殊解释，所以在php中，
  strlen(str)=8 所以，我理解的二进制安全的意思是：只关心二进制化的字符串,不关心具体格式.
  只会严格的按照二进制的数据存取。不会妄图已某种特殊格式解析数据。
  
##### NO.3
> redis内部保存的字符串数据结构是自己实现的，并不是沿用c语言的字符串数据结构。
  c语言的字符串默认是以'\0'结尾的，也就是说你保存的字符串内存在'\0'，c语言自会识别前面的数据，后面的就会被忽略掉，
  所以说是不安全的。而redis内部虽然也是以'\0'标示一个字符串的结束，但是该字符串的指针内还保存了len和free两个属性，
  len表示该字符串的实际内容所占长度，free表示分配给该字符串的全部空间－字符串实际内容长度，
  也就是free表示该字符串的空闲空间长度，所以你对该字符串取值时是通过len属性判断实际内容的长度，然后取的值。
  拼接字符串时是追加到free空间内中的。所以redis对字符串的求长度和更新内容等操作比c语言要快很多，
  因为求长度只需要返回该字符串的len属性值，c语言想要遍历整个字符串才会知道长度。
  拼接字符串“一般”也不需要在重新分配空间，拼接的字符串直接放在free内存中就可以了。
  
#### 引用
* [What is a binary safe string?](https://stackoverflow.com/questions/44377344/what-is-a-binary-safe-string)
* [二进制安全(binary safe)是什么意思？](https://www.zhihu.com/question/28705562)
* [Redis中的String二进制安全机制(binary safe)](http://blog.csdn.net/weixin_38399962/article/details/79408597)
* [Binary-safe](https://en.wikipedia.org/wiki/Binary-safe)
