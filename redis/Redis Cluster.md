### Redis 集群的优势:
* 自动分割数据到不同的节点上
* 整个集群的部分节点失败或者不可达的情况下能够继续处理命令

### Redis 集群的数据分片
Redis 集群没有使用一致性hash, 而是引入了 哈希槽的概念.  
Redis 集群有16384(2的14次方)个哈希槽


### 引用
* [Redis 集群教程](http://www.redis.cn/topics/cluster-tutorial.html)
* [Redis 集群规范](http://www.redis.cn/topics/cluster-spec.html)
* [Redis 学习笔记（十四）Redis Cluster介绍与搭建](https://blog.csdn.net/men_wen/article/details/72853078)
* [Redis集群官方推荐方案 Redis-Cluster](https://www.cnblogs.com/kerwinC/p/6611634.html)
* [redis cluster集群理解](https://www.cnblogs.com/yingchen/p/6763524.html)
* [Redis cluster tutorial](https://redis.io/topics/cluster-tutorial)
