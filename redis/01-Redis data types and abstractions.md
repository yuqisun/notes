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
