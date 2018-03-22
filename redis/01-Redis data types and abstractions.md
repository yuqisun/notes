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
* 推荐加一个schema。例如 "object-type:id"，"user:1000"。点和横杠在多个词中经常使用，如`"comment:1234:reply.to"` 或者 `"comment:1234:reply-to"`。
* key最大的size是512M

> 关于key最大size的问题，找到两个链接，感觉意思是单个key和单个value的最大值都是512M，对于每个数据类型都是512M，还不清楚这个值是怎么制定的。
同时找到一个人用node-redis做的实验，
> * 当key的值为10的时候，写平均 1.24ms, 读平均 0.045ms
> * 当key的值为10000的时候，写平均1.24ms, 读平均 0.15ms
> #### 引用
> * [Max Key Size?](https://groups.google.com/forum/#!topic/redis-db/HH4z-8mHNLM)
> * [Redis Performance - Does key length matter?](http://adamnengland.com/2012/11/15/redis-performance-does-key-length-matter/)

### Redis Strings
`set mykey somevalue`
SET 会替代key中任何已经存在的值。
Value 的size不能超过 512M。

### Redis Lists
Redis lists 由链表实现。即使链表中已经有百万级元素，在头或尾新增一个元素只需常量时间。所以 LPUSH 时间复杂度是 O(1)，即向一个有10个元素的list中push和向一个10 000 000 元素的list中push 时间是一样的。

缺点就是，数组实现的list当用下标索引搜索元素的时候非常快(O(1))，链表实现的list就没那么快了，取决于该索引所占的元素总数的比例。比如要在10k个元素的list中找索引是500的就得一个一个查找到500了。

Redis lists用链表实现是因为数据库系统对于向长list快速追加元素的要求很高，因为数据库中原本很可能就已经存在很多元素了，必须保证每次添加保持常量复杂度，如果是数组实现，每次添加需要O(N)，即已经存在的元素个数，会导致数据越多存储越慢。另一个优势是Redis Lists可以在常量时间取得固定长度(LRANGE，去一定范围的list值)。

#### Common use cases for lists
* 记录用户向社交网络post的最新动态
* 进程间通信，用consumer-producer模式，生产者push进list，消费者consume。
> 例如：
> * Every time a user posts a new photo, we add its ID into a list with LPUSH
> * When users visit the home page, we use LRANGE 0 9 in order to get the latest 10 posted items.

#### Capped lists
list 保留最新的几条元素删除其他老元素可以用 LTRIM


LRANGE：

Time complexity: O(S+N) where S is the distance of start offset from HEAD for small lists, from nearest end (HEAD or TAIL) for large lists; and N is the number of elements in the specified range.

在offset距离head或者tail很近并且range比较小的时候，S 和 N 比较大就近似复杂度常量时间了。

#### Blocking operations on lists

* RPOPLPUSH
* BRPOPLPUSH

#### Automatic creation and removal of keys
Redis 会在list为空的时候自动删除key，在试图添加且list不存在的时候自动创建list。List，Set，Sorted Set，Hashes都如此。

三条rules：
 1. 当添加元素到聚合数据类型的时候，如果目标key不存在则在添加之前空数据类型会被创建
 2. 当我们从数据类型移出元素，如果值为空，则key被自动销毁
 3. 在调用 read-only 命令如LLEN，或者用于移除元素的写命令时，如果key为空，则返回结果与调用一个指向空value 的key是一样的
 

### Bitmaps
1 byte = 8 bits

因为字符串是二进制安全的并且最大size是512M(2^29 bytes)，即 2^29 * 8(bits) = 2^32(4G) 个不同的bits。

Bit 操作有两种：

 1. 常量时间操作，例如把1置成0，或者取值
 2. 对于bit 组的操作，例如count给定范围的bits的数量

Bitmaps 最大的优点就是节省存储信息所需要的空间。例如用一个bit来标记用户是否选择订阅 newsletter，1代表订阅，0代表不订阅，则用512M内存可以标记40亿(4G)个用户。

三个操作bits组的命令：
 1. BITOP
 2. BITCOUNT
 3. BITPOS

BITPOS 和 BITCOUNT 都可以对string 在字节范围内(byte range)操作，而不是对整个string长度。可能就是可以一点一点地读的意思吧。

### HyperLogLogs
HyperLogLog 是一个概率性数据结构，用于count unique things(用来估计set的基数)。不需要消耗很多内存去count基数，因为HyperLogLogs只包含一个状态不包括每一个元素，最坏情况下需要12k内存，如果元素比较少，则size远远小于这个数。

#### 引用
> * [redis数据结构HyperLogLog](https://www.cnblogs.com/ysuzhaixuefei/p/4052110.html)


