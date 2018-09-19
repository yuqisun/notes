分组排名  

```
create table staff(sid integer, name varchar(100), amount integer, score integer, quarter integer);
insert into staff values (1, 's1', 100, 10, 20181);
insert into staff values (1, 's1', 120, 12, 20181);
insert into staff values (2, 's2', 80, 8, 20181);
insert into staff values (3, 's3', 300, 30, 20181);
insert into staff values (1, 's1', 50, 5, 20182);
insert into staff values (2, 'ss', 120, 12, 20182);
insert into staff values (3, 's3', 200, 20, 20183);

select quarter, sid, name, amount, score, new_rank as rank
from (
    select quarter, sid, name, amount, score,
           if(@tmp=quarter, @rank:=22, @rank:=1) as new_rank,
           @tmp:=quarter as tmp
    from (
        select quarter, sid, name, sum(amount) amount, sum(score) score from staff group by quarter, sid, name
    ) a
    order by quarter, score desc
) b;

```

* https://jingyan.baidu.com/article/d8072ac48d2730ec94cefd43.html
* http://blog.chinaunix.net/uid-77311-id-5786109.html
