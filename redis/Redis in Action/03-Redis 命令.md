#### 字符串
Redis 中，字符串可以存储以下3种类型的值：
* 字符串 (byte string)
* 整数
* 浮点数

用户可以通过给定一个任意的数值，对存储着整数或浮点数的字符串执行自增或者自减操作，在有需要的时候，Redis 还会将整数转换成浮点数。

即使在设置键时输入的值为字符串，但只要这个值可以被解释为整数，我们就可以把它当作整数来处理。在尝试获取一个键的时候，命令将以字符串格式返回被存储的整数。

在使用 SETRANGE 或者 SETBIT 命令对字符串进行写入的时候，如果字符串当前的长度不能满足写入的要求，那么 Redis会
自动地使用空字节(null) 来将字符串扩展至所需的长度，然后才执行写入或者更新操作。在使用 GETRANGE读取字符串的时候，
超出字符串末尾的数据会被视为空串，而在使用 GETBIT读取二进制位串的时候，超出字符串末尾的二进制位会被视为是0.

Redis存储的二进制位是按照偏移量从高到低排列的。 001(32)0001(1) - 32+1=33 

#### 列表
Redis 中 RANGE的偏移量 start, end 的元素都是包含在其中的，例如 list 的 LRANGE，String 的 GETRANGE，不像 Java 是左闭右开的 [start, end)

#### 散列
从功能来说，Redis为散列提供了一些与字符串值相同的特性，使得散列非常适合用于将一些相关的数据存储在一起。可以把这种数据聚集看作是关系数据库里的行。

#### Pub/Sub
旧版本Redis 的 Pub/Sub 可能有两个问题：
1. 消息积压，耗费过多内存：  
   如果一个客户端订阅了某个或某些频道，但它读取消息额速度却不够快的话，那么不断积压的消息就会使得
   Redis输出缓冲区的体积变得越来越大，这可能会导致Redis的速度变慢，甚至直接崩溃。也可能导致Redis被
   操作系统强制杀死，甚至导致操作系统本身不可用。
   
   新版的Redis不会出现这种问题，因为它会自动断开不符合 client-output-buffer-limit pubsub配置
   选项要求的订阅客户端。
   
2. 如果客户端在执行订阅操作的过程中断线，那么客户端将丢失在断线期间发送的所有消息。

##### **client-output-buffer-limit**  
Redis客户端缓冲区配置在redis.conf文件，该配置项格式如下：  
`client-output-buffer-limit <class <hard limit <soft limit <soft seconds`

`<class>`：目前支持3种客户端：
1. normal = normal clients; 
2. slave clients and MONITOR clients; 
3. pubsub = clients subcribed to at least one pubsub channel or pattern
 
`<hard limit>`：若output buffer大小超过该值，Redis会立即关闭与对应client的连接  
`<soft limit> <soft seconds>`：若output buffer大小超过soft limit且这种情况的持续时间超过soft seconds，
则Redis会关闭与对应client的连接。

默认的配置如下：  
client-output-buffer-limit normal 0 0 0  
client-output-buffer-limit slave 256mb 64mb 60  
client-output-buffer-limit pubsub 32mb 8mb 60  

这些数值分别代表缓冲区软限制，硬限制和以秒为单位的超时（类似于复制缓冲区）。
当Redis终止连接时，这些值提供保护——不需要客户读取回复——当缓冲区尺寸达到a）软限制并且保持状态直到超时b）硬限制。将这些数值都设为0意味着关闭保护。

不过，和复制缓冲区不同的是客户端缓冲区来自Redis数据内存空间。可以通过maxmemory指令设置Redis的总内存值，达到极限后，Redis将应用其配置的驱逐策略（由maxmemory-policy 指令定义）。
因此，低性能的客户或大量的同时连接可能会因为数据集尺寸和客户端缓冲区达到内存限制导致Redis实例过早的驱逐键或禁止更新。

由于生命周期的相对性，一个客户端不需要降低性能就可能导致这种现象。因为RAM读取和网络读取存在着很大的速度差异，过多的客户端缓冲区很可能耗尽Redis内存，即使是在高性能的客户端和网络连接中。
例如，考虑下（万恶的）KEYS指令，这个指令触发后，Redis将会把整个键的名空间拷贝给客户端缓冲区。如果我们的数据库有很多键，这很可能导致驱逐。

#### Redis 的基本事务
Redis事务和关系数据库那种可以再执行的过程中回滚的事务不同，在Redis中，被MULTI和EXEC命令包围的所有命令会一个接一个的执行，
直到所有命令都执行完毕为止。

要在 Redis里面执行事务，我们首先要执行 MULTI命令，然后输入那些我们想要在事务里面执行的命令，最后执行 EXEC命令。
当Redis从一个客户端那里接收到 MULTI 命令时，Redis会将这个客户端之后发送的所有命令都放入到一个队列里面，直到这个客户端发送 EXEC命令为止，
然后Redis就会在不被打断的情况下，一个接一个的执行存储在队列里面的命令。

在Redis中使用流水线的另一个目的是提高性能，在执行一连串命令时，减少Redis与客户端之间的通信往返次数可以大幅降低客户端等待回复所需的时间。

#### 引用
* [Redis配置详解](https://blog.csdn.net/jiangguilong2000/article/details/38436941)

