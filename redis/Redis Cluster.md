### Redis 集群的优势:
* 自动分割数据到不同的节点上
* 整个集群的部分节点失败或者不可达的情况下能够继续处理命令

### Redis 集群的数据分片
Redis 集群没有使用一致性hash, 而是引入了 哈希槽的概念.  
Redis 集群有16384(2的14次方)个哈希槽

### Redis 一致性保证
Redis 并不能保证数据的**强一致性**. 这意味这在实际中集群在特定的条件下可能会丢失写操作.

1. 第一个原因是因为集群是用了异步复制. 写操作过程:

* 客户端向主节点B写入一条命令.
* 主节点B向客户端回复命令状态.
* 主节点将写操作复制给他得从节点 B1, B2 和 B3.
主节点对命令的复制工作发生在返回命令回复之后， 因为如果每次处理命令请求都需要等待复制操作完成的话， 那么主节点处理命令请求的速度将极大地降低 —— 我们必须在性能和一致性之间做出权衡。 如果主节点在返回Client之后，写入从节点之前down掉，这部分写入就会丢失。注意：Redis 集群可能会在将来提供同步写的方法。 

2. Redis 集群另外一种可能会丢失命令的情况是集群出现了网络分区， 并且一个客户端与至少包括一个主节点在内的少数实例被孤立
举个例子 假设集群包含 A 、 B 、 C 、 A1 、 B1 、 C1 六个节点， 其中 A 、B 、C 为主节点， A1 、B1 、C1 为A，B，C的从节点， 还有一个客户端 Z1 假设集群中发生网络分区，那么集群可能会分为两方，大部分的一方包含节点 A 、C 、A1 、B1 和 C1 ，小部分的一方则包含节点 B 和客户端 Z1 .

Z1仍然能够向主节点B中写入, 如果网络分区发生时间较短,那么集群将会继续正常运作,如果分区的时间足够让大部分的一方将B1选举为新的master，那么Z1写入B中得数据便丢失了.

注意， 在网络分裂出现期间， 客户端 Z1 可以向主节点 B 发送写命令的最大时间是有限制的， 这一时间限制称为节点超时时间（node timeout）， 是 Redis 集群的一个重要的配置选项：
```
port 7000
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes
```

### 引用
* [Redis 集群教程](http://www.redis.cn/topics/cluster-tutorial.html)
* [Redis 集群规范](http://www.redis.cn/topics/cluster-spec.html)
* [Redis 学习笔记（十四）Redis Cluster介绍与搭建](https://blog.csdn.net/men_wen/article/details/72853078)
* [Redis集群官方推荐方案 Redis-Cluster](https://www.cnblogs.com/kerwinC/p/6611634.html)
* [redis cluster集群理解](https://www.cnblogs.com/yingchen/p/6763524.html)
* [Redis cluster tutorial](https://redis.io/topics/cluster-tutorial)
