原文： [Redis Sentinel Documentation](https://redis.io/topics/sentinel)

Redis Sentinel为 Redis提供高可靠性，可以在没有人为介入的情况下处理一些故障。  
Sentinel也提供一些附属功能例如 monitoring, notifications和 客户端的配置提供者。  

* **Monitoring.** Sentinel不断检查 master 和 slave是否如期运行
* **Nofification.** Sentinel在监控到有实例故障后会发出通知
* **Automatic failover.** 自动故障转移 如果master没有按照预期运行，sentinel会开启故障转移把一个 slave升级成 master，其他 slave重新配置使用新的master，正在使用的 applications 会收到新的地址
* **Configuration provider.** 配置提供者 sentinel 扮演一个为客户端提供信息的角色。客户端连接到 sentinel 查询当前 redis master。如果发生了故障转移，sentinel 会报告新的地址

