show databases;
use bigdata;
select * from student;
show create table student;
SET SQL_SAFE_UPDATES=0;  -- 关闭安全更新模式，不然如果没有where语句无法对数据进行修改或删除
update student set 学号=lpad(`学号`,6,'21');   -- 修改表中学号字段  通过字符串‘21’左填充至6位，右填充为rpad

-- Rand生成(0~1)随机数，乘以1000000，去掉小数部分，得到六位数随机Id 
insert into student value(round(rand()*1000000,0),"张三","男",17,78); 

delete from student where 学号="231107";
-- curddate 返回当前日期 curtime -->返回当前时间  now() --> 返回当前日期时间 
insert into student value(curtime(),"张三","男",17,78); 

show tables;






