`<logger>`用来设置某一个包或者具体某一个类的日志打印级别、以及指定`<appender>`。 `<logger>`可以包含零个或者多个`<appender-ref>`元素，
标识这个appender将会添加到这个logger。`<logger>`仅有一个name属性、一个可选的level属性和一个可选的additivity属性。

`<root>`也是<logger>元素，但是它是根logger，只有一个level属性，因为它的name就是ROOT。

