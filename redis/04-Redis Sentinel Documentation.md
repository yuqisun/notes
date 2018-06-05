原文： [Redis Sentinel Documentation](https://redis.io/topics/sentinel)

Redis Sentinel为 Redis提供高可靠性，可以在没有人为介入的情况下处理一些故障。  
Sentinel也提供一些附属功能例如 monitoring, notifications和 客户端的配置提供者。  

* **Monitoring.** Sentinel不断检查 master 和 slave是否如期运行
* **Nofification.** Sentinel在监控到有实例故障后会发出通知
* **Automatic failover.** 自动故障转移 如果master没有按照预期运行，sentinel会开启故障转移把一个 slave升级成 master，其他 slave重新配置使用新的master，正在使用的 applications 会收到新的地址
* **Configuration provider.** 配置提供者 sentinel 扮演一个为客户端提供信息的角色。客户端连接到 sentinel 查询当前 redis master。如果发生了故障转移，sentinel 会报告新的地址

### Sentinel的分布式性质
Redis Sentinel是一个分布式系统：  
Sentinel 被设计成运行在多个Sentinel共同合作的配置中。  
多个Sentinel合作有几个好处：  
1. 由多个 Sentinel同意决定 master确实不在工作，降低误报率
2. 增加鲁棒性，有备用Sentinel。

### Quick Start
#### Sentinel的基本常识
1. 最少需要3个Sentinel实例
2. 3个 Sentinel在3个不同的机器上独立运行，防止同时 down
3. Sentinel + Redis分布式系统不能保证失败期间的写入
4. 需要客户端库支持 Sentinel
...
...

#### 配置Sentinel
最小配置：
```
sentinel monitor mymaster 127.0.0.1 6379 2
sentinel down-after-milliseconds mymaster 60000
sentinel failover-timeout mymaster 180000
sentinel parallel-syncs mymaster 1

sentinel monitor resque 192.168.1.3 6380 4
sentinel down-after-milliseconds resque 10000
sentinel failover-timeout resque 180000
sentinel parallel-syncs resque 5
```

`sentinel monitor <master-group-name> <ip> <port> <quorum>`  
quorum 是可以认定master不工作的 Sentinel数量，满足这个数只是能够认定故障，要想真正执行故障转移，还需要投票选举 leader来执行。例如一共有5个 Sentinel，quorum设置为2， 当有2个 sentinel 同意master不可能访问的时候，即可以认定master发生了故障，其中一个 sentinel会试图开始故障转移，这时候需要至少3个 Sentinel是可用的，因为这样才能投票给两个中的一个来选举出一个 leader，真正执行故障转移。


