### Accept
表示客户端期望服务器返回的媒体格式。客户端期望的资源类型服务器可能没有，所以客户端会期望多种类型，并且设置优先级，服务器根据优先级寻找相应的资源返回给客户端。
```
# 注意：先逗号分割类型，再分号分割属性
Accept: audio/*;q=0.2, audio/basic
```
表示 audio/basic 类型的资源优先，如果没有，就随便其它什么格式的 audio 资源都可以。
q 的取值范围是(0-1]，其具体值并没有意义，它仅用来排序优先级，如果没有 q，默认 q=1，也就是最高优先级。
***按照逗号分割，`audio/*;q=0.2`　是一组的，`audio/basic` 是一组的，等同于 `audio/basic;q=1`。***

### Accept-Charset
表示客户端期望服务器返回的内容的编码格式。它同 Accept 头一样，也可以指定多个编码，以 q 值代表优先级。
```
# 注意：先逗号分割类型，再分号分割属性
Accept-Charset: utf8, gbk; q=0.6
```
表示 utf8 编码优先，如果不行，就拿 gbk 编码返回.

### Content-Type
Content-Type 是服务器向客户端发送的头，代表内容的媒体类型和编码格式，是对 Accept 头和 Accept-Charset 头的统一应答。
```
Content-Type: text/html; charset=utf8
```
表示返回的 Body 是个 html 文本，编码为 utf8

### Accept-Language
表示客户端期望服务器返回的内容的语言。很多大型互联网公司是全球化的，它的技术文档一般有有多种语言，通过这个字段可以实现文档的本地化，对国内用户呈现简体中文文档，对英语系用户呈现英文文档。
```
Accept-Language:zh-CN,en-US;q=0.8,zh-TW;q=0.6
```
表示大陆简体中文优先，其次英语，再其次台湾繁体中文

### Content-Language
这个头字段内容是对 Accept-Language 的应答。服务器通过此字段告知客户端返回的 Body 信息的语言是什么。

### Allow
表示资源支持访问的 HTTP Method 类型。它是服务器对客户端的建议，告知对方请使用 Allow 中提到的 Method 来访问资源。
`Allow: GET, HEAD, PUT`


## 引用
* [鲜为人知的 HTTP 协议头字段详解大全「原创」](https://www.v2ex.com/t/441114)
* [What is q=0.5 in Accept* HTTP headers?](https://stackoverflow.com/questions/8552927/what-is-q-0-5-in-accept-http-headers)
* [Content-Type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type)
* [理解HTTP之Content-Type](https://segmentfault.com/a/1190000003002851)

