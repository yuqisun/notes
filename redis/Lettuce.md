Lettuce 线程安全,有同步，异步和reactive用法。支持高级 Redis 特性，如 Sentinel, Cluster, Pipelining, Auto-Reconnect and Redis data models.

### synchronous
##### Basic usage
Redis connections 被设计成长久存在并且线程安全的，连接丢失后会自动重新连接，直到调用 `close()`为止。Pending 的命令如果没有 timeout会在连接重新建立后重新发送执行。

所有连接默认从 RedisClient继承 timeout时间，默认是 60s。当非阻塞命令 fail to return result的时候会抛 `RedisException`。synchronous 方法会抛出 `RedisCommandExecutionException`以防Redis发生 Error。asynchronous连接当Redis发生 Error时不会抛出异常。

### Asynchronous API
##### Motivation
Asynchronous能够更好的使用系统资源而不是浪费线程等待在网络或者磁盘 I/O上。线程可以被充分利用在其他工作上。Lettuce的异步是从顶层netty(多线程，事件驱动I/O框架)开始的。所有的交流都是异步的。

### Impact of asynchronicity to the synchronous API
为避免副作用，以下情况不应在多线程间共享连接，
* 禁止flush-after-command来提高性能
* 使用阻塞操作时，如 `BLOPO`。
* 事务
* 使用多个数据库时



[高级的 Redis Java客户端 - Lettuce](https://mp.weixin.qq.com/s/juDp1WL8Vtc9Sm5KoUB7fQ)

[Introduction to Lettuce – the Java Redis Client](http://www.baeldung.com/java-redis-lettuce)

