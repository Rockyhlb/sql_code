show tables;

drop tables if exists class02,class03,class04,temp2,emp;

create view view_emp_dep as select * from emp_dep;
select * from view_emp_dep;

select * from emp_dep;
select * from dept;
select * from student;
desc student;

# 四、函数
-- 1、字符串函数(concat,lower,upper,lpad,rpad,trim,substring)
-- 1.1、统一学生sNo为5位数,不足5位数的在前面补0，在后面补充同理（rpad）
set sql_safe_updates=0; -- 关闭安全更新模式
show variables;  	-- 显示变量
alter table student modify sNo int(8);  -- 更改字段类型位为字符串
update student set sNo=lpad(sNo,7,'202100');
-- 1.2、字符串拼接
select concat(sNo,'00') as cSNO,sName from student;
-- 1.3、字符串转大小写
select upper('hello world');
select lower('Hello WORLD');
-- 1.4、去除空格  --  句首句尾的空格
select trim(' hello world ');
-- 1.5、截取字符串
update student set sNo=substring(sNo,8,8);
select substring('hello world',1,5);

-- 2、数值函数(ceil,floor,mod,rand,round)
-- 2.1、向上（下）取整
select ceil(1.3);
select floor(1.3);
-- 2.2、取模
select mod(3,2);
-- 2.3、生成随机数
select rand()*10000;
-- 2.4、四舍五入
select round(23.6);
-- 2.5、随机生成六位数验证码(随机数->乘以1000000->四舍五入->不满6位向左填充)
select lpad(round(rand()*1000000),6,'0');

-- 3、日期函数(curdate,curtime,now,year,date_add,datediff)
-- 3.1、当前日期
select curdate();
-- 3.2、当前时间
select curtime();
-- 3.3、当前日期时间
select now();
-- 3.4、year,mouth,day:当前年月日
select year(now());
select mouth(now());
select day(now());
-- 3.5、增加指定的日期间隔
select date_add(now(),interval 20 year);
-- 3.6、查询emp_dep所有员工的入职天数，并根据入职天数降序排序
select id,name,age,job,datediff(curdate(),entrydate) 
as 'enterDays' from emp_dep order by enterDays desc;

-- 4、流程函数(if,ifnull,case when then else end)
-- 4.1、if(v1,v2,v3) -> 如果v1为true,则返回v2,否则返回v3
select if(false,'YES','NO');  -- NO
-- 4.2、ifnull(v1,v2)  ->  如果不为空则返回v1,否则返回v2
select ifnull('YES','NO');  -- YES  
select ifnull(null,'NO');   -- NO
-- 4.3、case when then else end (类似于switch语句)
-- 查询emp_dep表的员工id,姓名,年纪(高于60-->中老年，其他-->青年)
select id,name,( case floor(age/10) when 5 then '中老年' when 6 
then '中老年' when 7 then '中老年' when 8 then '中老年' when 9 
then '中老年'  else '青年' end ) as '群体' from emp_dep;
-- 精简版
select id,name,(case when age/10>=5 then '中老年' else '青年' 
end) as '群体' from emp_dep;




