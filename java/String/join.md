使用 StringJoiner 类，最后通过 toString() 方法中 `value.setLength(initialLength);`，把最后一位的分隔符砍掉，就得到字符串了。

```
@Override
public String toString() {
    if (value == null) {
        return emptyValue;
    } else {
        if (suffix.equals("")) {
            return value.toString();
        } else {
            int initialLength = value.length();
            String result = value.append(suffix).toString();
            // reset value to pre-append initialLength
            value.setLength(initialLength);
            return result;
        }
    }
}
```

