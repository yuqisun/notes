[Pub/Sub](https://redis.io/topics/pubsub)

#### Pattern-matching subscriptions
Redis Pub/Sub 支持模式匹配，可以订阅符合pattern的所有channel。

例如：
```
Redis Pub/Sub

PUNSUBSCRIBE news.*
```

使用pattern matching接收到的消息的格式是不同的：message 的 type 是 pmessage。

##### Messages matching both a pattern and a channel subscription
在多个pattern匹配到一个channel或者pattern matching 和 channel matching 都匹配到一个 channel的时候，
客户端有可能同一条消息收到多次，例如：
```java_holder_method_tree
SUBSCRIBE foo
PSUBSCRIBE f*
```
上边的例子，如果一个 message 发送到channel foo，客户端将收到两条message，一条类型是message，一条类型是pmessage。

##### The meaning of the subscription count with pattern matching
在 subscribe, unsubscribe, psubscribe and punsubscribe message 类型中, 最后一个参数是依然active的subscriptions 
的count。这个数即是当前channel matching 和 pattern matching 订阅者的总数。因此只有当count变成 0的时候，client将推出 Pub/Sub 状态。

