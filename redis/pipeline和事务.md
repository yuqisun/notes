#### 事务
不同的提供商可能对于pipeline 和 事务的关系不同，就 python来说，事务是包装在 pipeline中的，
使用 `pipe = conn.pipeline()`默认就是开启事务，然后将这个客户端的命令都放入到一个队列中，
直到这个客户端发送 `EXEC`命令为止，然后 Redis就会在**不被打断**的情况下，一个接一个地执行存储在队列里的命令。

在执行大量命令的情况下，即使命令实际上并不需要事务，为了通过一次发送所有命令来减少通信次数并降低延迟，用户也可能会
将命令包裹在 MULTI 和 EXEC 里面执行。这样做的缺点是，开启一个不必要的事务，消耗资源，且可能会导致
其他重要的命令被延迟执行。

这时候需要用到 pipeline。

#### pipeline
pipeline不能保证原子性。

### 引用
* [Redis编程实践【pipeline和事务】](https://blog.csdn.net/bluetjs/article/details/53054830)

