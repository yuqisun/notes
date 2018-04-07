[Pub/Sub](https://redis.io/topics/pubsub)

#### Pattern-matching subscriptions
Redis Pub/Sub 支持模式匹配，可以订阅符合pattern的所有channel。

例如：
```
Redis Pub/Sub

PUNSUBSCRIBE news.*
```

