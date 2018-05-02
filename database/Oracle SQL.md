#### decode
decode(条件,值1,返回值1,值2,返回值2,...值n,返回值n,缺省值)  
This example decodes the value warehouse_id. If warehouse_id is 1, then the function returns 'Southlake'; if warehouse_id is 2, then it returns 'San Francisco'; and so forth. If warehouse_id is not 1, 2, 3, or 4, then the function returns 'Non domestic'.
```
SELECT product_id,
DECODE (warehouse_id, 1, 'Southlake', 
                     2, 'San Francisco', 
                     3, 'New Jersey', 
                     4, 'Seattle',
                        'Non domestic') 
"Location of inventory" FROM inventories
WHERE product_id < 1775;
```

#### partition by
例如有一个表 stock_table，存放着每天的股票价格数据，每次股票更新，modified_date也跟着更新，那么想找出每天该股票的最新价格，就要把股票按照日期分组，然后找出日期时间最新的一个：  

|id |stock_name     |modified_date|price|
| - | :-----------: |:-----------:| ---:|
|1|A|2018-05-03 09:30|25|
|2|A|2018-05-03 09:40|24|
|3|A|2018-05-03 09:50|26|
|4|A|2018-05-02 10:30|27|
|5|A|2018-05-02 10:40|23|
|6|A|2018-05-02 11:00|21|
|7|A|2018-05-01 09:40|19|
|8|A|2018-05-01 10:30|22|
```
select datetime, price from (  
select price, to_char(dd, 'dd-MM-yyyy') datetime, dd, row_number() over (partition by to_char(dd, 'dd-MM-yyyy') order by dd desc) as row_flag   from (select modified_date dd, price from stock_table where stock_name = 'A')) where row_flag = 1  
order by datetime;
```
|datetime |price|
| ------- | ---:|
|2018-05-03 09:50|26|
|2018-05-02 11:00|21|
|2018-05-01 10:30|22|

### 引用
* [DECODE](https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions040.htm)
