同时请求过多，会 timeout  ->   
不是因为请求过多，可能是因为返回 connection，然后一直使用 connection的方式不对，不过
只发现读的时候有这个问题，写却没有，改用spring data redis后好了
```
java.net.ConnectException: Connection timed out: connect
	at java.net.DualStackPlainSocketImpl.connect0(Native Method)
	at java.net.DualStackPlainSocketImpl.socketConnect(DualStackPlainSocketImpl.java:79)
	at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
	at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
	at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
	at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:172)
	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
	at java.net.Socket.connect(Socket.java:589)
	at java.net.Socket.connect(Socket.java:538)
	at sun.net.NetworkClient.doConnect(NetworkClient.java:180)
	at sun.net.www.http.HttpClient.openServer(HttpClient.java:432)
	at sun.net.www.http.HttpClient.openServer(HttpClient.java:527)
	at sun.net.www.http.HttpClient.<init>(HttpClient.java:211)
	at sun.net.www.http.HttpClient.New(HttpClient.java:308)
	at sun.net.www.http.HttpClient.New(HttpClient.java:326)
	at sun.net.www.protocol.http.HttpURLConnection.getNewHttpClient(HttpURLConnection.java:1169)
	at sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1105)
	at sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:999)
	at sun.net.www.protocol.http.HttpURLConnection.connect(HttpURLConnection.java:933)
	at sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1513)
	at sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1441)
	at http.Test2.lambda$main$1(Test2.java:34)
	at java.lang.Thread.run(Thread.java:745)
```
