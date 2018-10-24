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

select quarter, user_id, real_name, hkje, hkxmdf, rank
from (
select quarter, user_id, real_name, hkje, hkxmdf, new_rank as rank
from (
		select quarter, user_id, real_name, hkje, hkxmdf,
					 if(@tmp=quarter, CASE WHEN @s=hkxmdf THEN @rank WHEN @s:=hkxmdf THEN @rank:=@rank+1 END, @rank:=1) as new_rank,
					 @tmp:=quarter as tmp,
					 @s:=hkxmdf
		from (
				select user_id, real_name, sum(hkje) hkje, sum(hkxmdf) hkxmdf, (year(endtime)*10+quarter(endtime)) quarter from t_khgrhk group by user_id, real_name, (year(endtime)*10+quarter(endtime))
		) a, (SELECT @tmp:=NULL,@s:=NULL,@rank:=0) rank --********
		order by quarter, hkxmdf desc
) b
) c where 1=1 and user_id = 1;

```

* https://jingyan.baidu.com/article/d8072ac48d2730ec94cefd43.html
* http://blog.chinaunix.net/uid-77311-id-5786109.html
