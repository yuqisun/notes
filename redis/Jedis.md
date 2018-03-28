##### [Intro to Jedis – the Java Redis Client Library](http://www.baeldung.com/jedis-java-redis-client-library)

### Maven Dependencies
```xml
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>2.8.1</version>
</dependency>
```
最近版本检查 [Repository](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22redis.clients%22%20AND%20a%3A%22jedis%22)

#### Redis Installation
Redis 没有官方支持 Windows，[Github](https://github.com/MicrosoftArchive/redis)上有一个可以用。
启动之后可以`Jedis jedis = new Jedis();`连接 Redis了。

默认连接本机默认端口，如果有修改端口或者连接远程机器，可以通过参数传入。

### Redis Data Structures
大多数命令都支持，并且和方法名相同。

##### Strings
```
jedis.set("events/city/rome", "32,15,223,828");

String cachedResponse = jedis.get("events/city/rome");

```

##### Lists
```
jedis.lpush("queue#tasks", "firstTask");
jedis.lpush("queue#tasks", "secondTask");

String task = jedis.rpop("queue#tasks");
```

可以把对象序列化之后作为 string进行持久化，因此 queue中的消息可以携带更复杂的数据。


#### Sets
```java_holder_method_tree
jedis.sadd("nicknames", "nickname#1");
jedis.sadd("nicknames", "nickname#2");
jedis.sadd("nicknames", "nickname#1");
 
Set<String> nicknames = jedis.smembers("nicknames");
boolean exists = jedis.sismember("nicknames", "nickname#1");
```

#### Hashes
```java_holder_method_tree
jedis.hset("user#1", "name", "Peter");
jedis.hset("user#1", "job", "politician");
         
String name = jedis.hget("user#1", "name");
         
Map<String, String> fields = jedis.hgetAll("user#1");
String job = fields.get("job");
```

#### Sorted Sets
```java_holder_method_tree
Map<String, Double> scores = new HashMap<>();
 
scores.put("PlayerOne", 3000.0);
scores.put("PlayerTwo", 1500.0);
scores.put("PlayerThree", 8200.0);
 
scores.keySet().forEach(player -> {
    jedis.zadd("ranking", scores.get(player), player);
});
         
String player = jedis.zrevrange("ranking", 0, 1).iterator().next();
long rank = jedis.zrevrank("ranking", "PlayerOne");
```

The variable player will hold the value PlayerThree because we are retrieving
 the top 1 player and he is the one with the highest score. 
 The rank variable will have a value of 1 because PlayerOne is the second in the ranking 
 and the ranking is zero-based.
 
