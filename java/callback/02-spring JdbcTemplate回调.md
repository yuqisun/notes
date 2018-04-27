在spring JdbcTemplate中就有回调的使用，就拿下边的方法来说，我们传入一个 sql给 spring，但是 spring在之前并不能知道这条 sql返回的数据是什么结构，有多少列，
是什么类型，谁知道这个问题呢，我们知道，所以 jdbcTemplate就要求我们传入一个处理这个结果的方法，这个地方虽然传入的是一个 Callback接口的实现，但实质就要调用
其中的方法，所以可以说是函数的传递。
```
public <T> T execute(String callString, CallableStatementCallback<T> action) throws DataAccessException {
  return execute(new SimpleCallableStatementCreator(callString), action);
}

public <T> T execute(CallableStatementCreator csc, CallableStatementCallback<T> action)
			throws DataAccessException {

		Assert.notNull(csc, "CallableStatementCreator must not be null");
		Assert.notNull(action, "Callback object must not be null");
		if (logger.isDebugEnabled()) {
			String sql = getSql(csc);
			logger.debug("Calling stored procedure" + (sql != null ? " [" + sql  + "]" : ""));
		}

		Connection con = DataSourceUtils.getConnection(getDataSource());
		CallableStatement cs = null;
		try {
			Connection conToUse = con;
			if (this.nativeJdbcExtractor != null) {
				conToUse = this.nativeJdbcExtractor.getNativeConnection(con);
			}
			cs = csc.createCallableStatement(conToUse);
			applyStatementSettings(cs);
			CallableStatement csToUse = cs;
			if (this.nativeJdbcExtractor != null) {
				csToUse = this.nativeJdbcExtractor.getNativeCallableStatement(cs);
			}
			T result = action.doInCallableStatement(csToUse);
			handleWarnings(cs);
			return result;
		}
    
    ...
    ...
```

举个例子：　　
比如说我们要打印数据结构中的东西，有一个打印方法。其中一个参数肯定是要传入要打印的东西，但是我们不知道调用方要怎么打印，所以干脆让调用者再传进来一个他想怎么
打印的方法好了。

```
public interface DataCallback<T> {
    void printData(T data);
}

public class DataTemplate<T> {
    public void execute(T data, DataCallback<T> dataCallback) {
        dataCallback.printData(data);
    }
}

public class TestDataCallback {
    public static void main(String... args) {
        Map<String, String> map = new HashMap<>();
        map.put("key1", "value1");
        map.put("key2", "value2");

        new DataTemplate<Map>().execute(map, data -> {
            System.out.println("This is for map:");
            Iterator entries = data.entrySet().iterator();
            while(entries.hasNext()) {
                Map.Entry entry = (Map.Entry) entries.next();
                System.out.println(entry.getKey() + " = " + entry.getValue());
            }
        });

        List<String> list = new ArrayList<>(asList("list value1", "list vlaue2", "list value3"));
        new DataTemplate<List>().execute(list, data -> {
            System.out.println("This is for list:");
            data.forEach(System.out::println);
        });
    }
}

```

这里我们看到，调用方如果传入的是一个 Map，则按照 key = value的方式打印，如果是 List就逐个打印。这里只是个例子，用 callback打印看起来没有必要，因为调用方完全可以
在自己的类里打印，但是想想传入 sql获取结果，就不是调用方自己能解决的了。

这就是回调的第二种应用场景：
* 一个是可以非阻塞式的执行分支(01-了解回调.md)，等到分支计算出结果后在告诉调用方
* 一个是在调用之前，被调用者不知道要怎么处理数据，需要调用方来提供一个处理数据的方式


