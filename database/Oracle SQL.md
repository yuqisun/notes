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

