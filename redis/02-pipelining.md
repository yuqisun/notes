*官网 [Using pipelining to speedup Redis queries](https://redis.io/topics/pipelining)*

### Request/Response protocols and RTT
Redis 是一个 TCP server，用 client-server模式，这就是所谓的 Request/Response 协议。

**RTT(Round Trip Time往返时间)**，即数据包从client到server，server的答复回到client的时间。

**Pipelining**，发送多条命令到server而无需等待返回，最终在一个步骤中读取回复。这样就不用为每次call花费时间，多个命令发送一次就可以了。

*IMPORTANT NOTE*：当client使用流水线发送命令的时候，server将会被强制要求把回复放进queue中(在内存中)。所以如果你需要用pipelining发送大量命令，最好以一个合理的数量批量发送，例如发10k命令，读取回复，然后再发10k命令。速度几乎是相同的，但节省下来的内存可以存放10k回复的队列。

### It's not just a matter of RTT
Pipelining 不止在RTT(往返时间上降低消耗)，在socket I/O 上也节省很多消耗。在不用pipelining的时候，每个command调用一次`read()`和`write()`系统调用，这需要从用户空间(user land)到内核空间(kernel land)，这上下文切换是一笔巨大的开销。

当使用pipelining的时候，多个命令只需要一次`read()`系统调用，多个回复只需要一次`write()`系统调用来传输。因此，每秒能处理的查询随着pipeline的长度成线性增长。最终达到不使用pipeline性能的10倍*（大概是这个意思）*。

