##### [Intro to Jedis – the Java Redis Client Library](http://www.baeldung.com/jedis-java-redis-client-library)

### Maven Dependencies
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

默认连接本机默认端口，如果有修改端口或者连接远程机器，可以通过参数传入。

### Redis Data Structures
大多数命令都支持，并且和方法名相同。

##### Strings
Set
`jedis.set("events/city/rome", "32,15,223,828");`

Get
`String cachedResponse = jedis.get("events/city/rome");`

##### Lists

