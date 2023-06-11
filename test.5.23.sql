show databases;
use bigdata;
show tables;

drop table if exists emp;
create table emp( 
id int comment '编号', 
workno varchar(10) comment '工号', 
name varchar(10) comment '姓名', 
gender char(1) comment '性别', 
age tinyint unsigned comment '年龄', 
idcard char(18) comment '身份证号', 
workaddress varchar(50) comment '工作地址', 
entrydate date comment '入职时间' 
)charset=utf8,comment '员工表';

show create table emp;
desc emp;

# 插入数据
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (1, '00001', '柳岩666', '女', 20, '123456789012345678', '北京', '2000-01-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (2, '00002', '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (3, '00003', '韦一笑', '男', 38, '123456789712345670', '上海', '2005-08-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (4, '00004', '赵敏', '女', 18, '123456757123845670', '北京', '2009-12-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (5, '00005', '小昭', '女', 16, '123456769012345678', '上海', '2007-07-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (6, '00006', '杨逍', '男', 28, '12345678931234567X', '北京', '2006-01-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (7, '00007', '范瑶', '男', 40, '123456789212345670', '北京', '2005-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (8, '00008', '黛绮丝', '女', 38, '123456157123645670', '天津', '2015-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (9, '00009', '范凉凉', '女', 45, '123156789012345678', '北京', '2010-04-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (10, '00010', '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (11, '00011', '张士诚', '男', 55, '123567897123465670', '江苏', '2015-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (12, '00012', '常遇春', '男', 32, '123446757152345670', '北京', '2004-02-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (13, '00013', '张三丰', '男', 88, '123656789012345678', '江苏', '2020-11-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (14, '00014', '灭绝', '女', 65, '123456719012345670', '西安', '2019-05-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (15, '00015', '胡青牛', '男', 70, '12345674971234567X', '西安', '2018-04-01'); 
INSERT INTO emp (id, workno, name, gender, age, idcard, workaddress, entrydate) 
VALUES (16, '00016', '周芷若', '女', 18, null, '北京', '2012-06-01'); 


# 单表查询若干列  
--  *号代表查询所有字段，在实际开发中尽量少用（不直观、影响效率）
select * from emp;
select id,name from emp;

-- 查询所有员工的工作地址，as 取别名 -- as 可以省略
select workaddress as '工作地址' from emp;
-- 查询所有员工的工作地址，as 取别名，distinct去重 
select distinct workaddress as '工作地址' from emp; 


#  聚合函数查询 （count,sum,avg,max,min)
-- 当聚集函数遇到空值时，除count(*)外，都跳过空值而只处理非空值。
-- 只能用于select子句和group by中的having子句。
-- count(*) 统计数据中有多少行 
select count(*) from emp;

-- 查询最大年纪
select max(distinct(age)) from emp;
select * from emp where age = "88";

-- 查询平均年纪
select avg(age) from emp;

-- 查询西安地区员工的最大年龄
select max(distinct(age)) from emp where workaddress="西安";

-- distinct代表计算时去除重复值，all代表计算时不去除重复值，默认为all。
select count(distinct(workaddress)) from emp;


# 条件查询  （条件运算符, (not)between and, (not)in, (not)like, is (not) full, and,or,not）
-- 查询年纪为88的员工
select name from emp where age=88;

-- 查询年纪不为88的员工
select name from emp where age!=88;
select name from emp where age <> 88;

-- 查询年纪大于66
select * from emp where age > 66;student
-- 确定集合（in）(not in)
select * from emp where age not in (18,88) order by age asc;

-- 查询年纪为32到88的员工
select * from emp where age between 32 and 88 order by age asc;
select * from emp where age >= 32 and age <= 88 order by age asc;

-- 查询身份证号为null的员工
select * from emp where idcard is null;
-- 查询身份证号不为null的员工
select * from emp where idcard is not null;

# 模糊查询
-- 查询名字像两个字(三个字)的
select * from emp where name like '__'; 
select * from emp where name like '___';
-- 查询身份证号最后一位是‘X’的数据
select * from emp where idcard like '%X';


#  排序查询 
-- order by 语句用来给查询结果排序，ASC为升序排列，DESC为降序排列，默认值为升序
select * from emp order by age asc;







