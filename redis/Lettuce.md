Lettuce 线程安全,有同步，异步和reactive用法。支持高级 Redis 特性，如 Sentinel, Cluster, Pipelining, Auto-Reconnect and Redis data models.

### synchronous
##### Basic usage
Redis connections 被设计成长久存在并且线程安全的，连接丢失后会自动重新连接，直到调用 `close()`为止。Pending 的命令如果没有 timeout会在连接重新建立后重新发送执行。

所有连接默认从 RedisClient继承 timeout时间，默认是 60s。当非阻塞命令 fail to return result的时候会抛 `RedisException`。synchronous 方法会抛出 `RedisCommandExecutionException`以防Redis发生 Error。asynchronous连接当Redis发生 Error时不会抛出异常。



[高级的 Redis Java客户端 - Lettuce](https://mp.weixin.qq.com/s/juDp1WL8Vtc9Sm5KoUB7fQ)

[Introduction to Lettuce – the Java Redis Client](http://www.baeldung.com/java-redis-lettuce)

