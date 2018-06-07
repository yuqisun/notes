redis-server.exe .\6379\redis.windows.conf
redis-server.exe .\6380\redis.windows.conf
redis-server.exe .\6381\redis.windows.conf

redis-server.exe .\26379\sentinel.conf --sentinel
redis-server.exe .\26380\sentinel.conf --sentinel
redis-server.exe .\26381\sentinel.conf --sentinel

