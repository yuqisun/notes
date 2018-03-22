*官网 [An introduction to Redis data types and abstractions](https://redis.io/topics/data-types-intro)*

# Redis 4.0.8

## Redis 数据结构

* Binary-safe strings ?? 什么是二进制安全的字符串
* Lists: 按照插入顺序排序的字符串集合，链表实现
* Sets: 无序无重复的字符串结合
* Sorted sets: 和Sets类似，并且每个字符串元素和一个被称为score的float数值关联，元素总是按照score排序
* Hashes: map，key和value都是字符串
* Bit arrays (or simply bitmaps): 可以像操作bit数组一样操作字符串值，例如可以设置或清除单独的位，统计所有为1的位，找到第一个被set或者unset的位
* HyperLogLogs: 概率性的数据结构，用于估计set的基数 **（没懂）**

### Redis Keys
Redis keys是二进制安全的，意味着可以用任何二进制的序列作为key。例如"foo"字符串或者一个JPEG文件的内容都是可以的。空字符串也可以。

作为key有几条规则：
* key 不要太长。例如一个1024 bytes 的key不仅消耗内存且查找key需要付出昂贵的key对比。即使在很长的key已经存在的情况下，用SHA1等算法将其hash是一个更好选择，尤其是从内存和带宽方面考虑。
* key 太短也不好，不易读。太长太短都不行，自己找平衡点。
* 推荐加一个schema。例如 "object-type:id"，"user:1000"。点和横杠在多个词中经常使用，如'comment:1234:reply.to' 或者 'comment:1234:reply-to'。
* key最大的size是512M

> 关于key最大size的问题，找到两个链接，感觉意思是单个key和单个value的最大值都是512M，对于每个数据类型都是512M，还不清楚这个值是怎么制定的。
同时找到一个人用node-redis做的实验，
> * 当key的值为10的时候，写平均 1.24ms, 读平均 0.045ms
> * 当key的值为10000的时候，写平均1.24ms, 读平均 0.15ms
> #### 引用
> * [Max Key Size?](https://groups.google.com/forum/#!topic/redis-db/HH4z-8mHNLM)
> * [Redis Performance - Does key length matter?](http://adamnengland.com/2012/11/15/redis-performance-does-key-length-matter/)

