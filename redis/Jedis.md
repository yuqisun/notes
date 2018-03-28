##### [Intro to Jedis – the Java Redis Client Library](http://www.baeldung.com/jedis-java-redis-client-library)

#### Maven Dependencies
```
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
