##### TO_NUMBER 将字符转换为数字

| 格式值 | 含义                       |
| ------ | -------------------------- |
| 9      | 代表一个数字               |
| 0      | 强迫0显示                  |
| $      | 显示美元符号               |
| L      | 强制显示一个当地的货币符号 |
| .      | 显示一个小数点             |
| ,      | 显示一个千位分隔符号       |

###### "TO_NUMBER"(expr, fmt) 将字符按指定格式转换为数字

###### "TO_NUMBER"(str)  将字符转化为数字

```sql
-- 整数显示整数 小数会在最后一位数补0 不过最后又几个0 都补一个0
SELECT to_number('100') FROM dual;          -- 100
SELECT to_number('100.000') FROM dual;      -- 100
SELECT to_number('100.000050') FROM dual;   -- 100.000050
SELECT to_number('0.1') FROM dual;          -- 0.10
```

##### TRUNC 字符串截取

"TRUNC"(date, fmt)
"TRUNC"(n1, n2)



##### TO_CHAR转换字符

"TO_CHAR"(x)



##### REGEXP_REPLACE

"REGEXP_REPLACE"(source, pattern, replace_str)